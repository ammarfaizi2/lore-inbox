Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129599AbRCHUNI>; Thu, 8 Mar 2001 15:13:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129602AbRCHUNA>; Thu, 8 Mar 2001 15:13:00 -0500
Received: from colorfullife.com ([216.156.138.34]:22285 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S129599AbRCHUMp>;
	Thu, 8 Mar 2001 15:12:45 -0500
Message-ID: <3AA7E7C4.4D89E280@colorfullife.com>
Date: Thu, 08 Mar 2001 21:12:52 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.2-ac5 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: linux-kernel@vger.kernel.org
Subject: Re: BUG? race between kswapd and ptrace (access_process_vm )
In-Reply-To: <Pine.LNX.4.33.0103071356140.1409-100000@duckman.distro.conectiva>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> 
> On Wed, 7 Mar 2001, Manfred Spraul wrote:
> 
> > Is kswapd now running without lock_kernel()?
> 
> Indeed ...
> 
> > Then there is a race between swapout and ptrace:
> > access_process_vm() accesses the page table entries, only protected with
> > the mmap_sem semaphore and lock_kernel().
> >
> > Isn't
> >
> >     spin_lock(&mm->page_table_lock);
> >
> > missing in access_one_page() [in linux/kernel/ptrace.c]?
> 
> You're probably right here ...
>

Fixing the bug is more difficult than I thought:

Initially I assumed it would be a two-liner (lock, unlock) but kmap()
can sleep.

Can I reuse a kmap_atomic() type or should I add a new type?

I could add local_irq_save() and (ab)use KMAP_BOUNCE_READ, but I'm not
sure if that's the Right Thing(tm)

--
	Manfred
