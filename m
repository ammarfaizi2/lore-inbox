Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131396AbRCSM6b>; Mon, 19 Mar 2001 07:58:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131461AbRCSM6V>; Mon, 19 Mar 2001 07:58:21 -0500
Received: from zeus.kernel.org ([209.10.41.242]:17353 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S131396AbRCSM6E>;
	Mon, 19 Mar 2001 07:58:04 -0500
Date: Mon, 19 Mar 2001 12:54:51 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org,
        "Stephen C. Tweedie" <sct@redhat.com>
Subject: Re: changing mm->mmap_sem  (was: Re: system call for process information?)
Message-ID: <20010319125451.B952@redhat.com>
In-Reply-To: <001701c0af8e$bd590ac0$5517fea9@local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <001701c0af8e$bd590ac0$5517fea9@local>; from manfred@colorfullife.com on Sun, Mar 18, 2001 at 10:34:38AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Mar 18, 2001 at 10:34:38AM +0100, Manfred Spraul wrote:

> > The problem is that mmap_sem seems to be protecting the list
> > of VMAs, so taking _only_ the page_table_lock could let a VMA
> > change under us while a page fault is underway ...
> 
> No, that can't happen.

It can.  Page faults often need to block, so they have to be able to
drop the page_table_lock.  Holding the mmap_sem is all that keeps the
vma intact until the IO is complete.

Cheers,
 Stephen
