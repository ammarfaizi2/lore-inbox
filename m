Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275506AbRJBPrn>; Tue, 2 Oct 2001 11:47:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275389AbRJBPr1>; Tue, 2 Oct 2001 11:47:27 -0400
Received: from colorfullife.com ([216.156.138.34]:48656 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S275485AbRJBPqi>;
	Tue, 2 Oct 2001 11:46:38 -0400
Message-ID: <3BB9E161.E936100@colorfullife.com>
Date: Tue, 02 Oct 2001 17:46:41 +0200
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.10 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: efocht@ess.nec.de
CC: linux-kernel@vger.kernel.org, linux-ia64@linuxia64.org
Subject: Re: deadlock in crashed multithreaded job
In-Reply-To: <Pine.LNX.4.21.0110021052430.26281-100000@sx6.ess.nec.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erich Focht wrote:
> 
> The question that remains is how to deal with nested locks on the same
> resource that can lead to deadlocks. Is there any (un)written rule that
> one should avoid them in the Linux Kernel? Or are there any approaches to
> deal with them (which are not yet included in the Kernel)?
>

Yes, semaphores and spinlocks are not recursive. There is one exception
for rw spinlocks, they can recurse on read. I'm not aware that there are
any plans to change that.

My patch avoids calling copy_from_user in elf_core_dump, Andrea adds a 
limited recursion support and uses that to prevent the deadlock.
With his patch you can recurse on on down_read() if you pass special
parameters.

But full recursion support is not planned.

--
	Manfred
