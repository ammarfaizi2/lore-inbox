Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268302AbTBMVOg>; Thu, 13 Feb 2003 16:14:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268303AbTBMVOf>; Thu, 13 Feb 2003 16:14:35 -0500
Received: from packet.digeo.com ([12.110.80.53]:58793 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S268302AbTBMVOe>;
	Thu, 13 Feb 2003 16:14:34 -0500
Date: Thu, 13 Feb 2003 13:23:00 -0800
From: Andrew Morton <akpm@digeo.com>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.60-bk pdflush oops.
Message-Id: <20030213132300.065c33d0.akpm@digeo.com>
In-Reply-To: <20030213205608.GB24109@codemonkey.org.uk>
References: <20030213205608.GB24109@codemonkey.org.uk>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Feb 2003 21:24:19.0285 (UTC) FILETIME=[44D84050:01C2D3A6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@codemonkey.org.uk> wrote:
>
> Bitkeeper pull from ~5 hrs ago.
> 
> Something went splat just after booting.
> I think this may have happened as I mounted an NFS mount.
> Hard to tell, but the box booted at 20:30, this happened
> at 20:37, and I started NFS testing at 20:40 which was
> when I noticed it.

There is missing text here as well.

        if (address < PAGE_SIZE)
                printk(KERN_ALERT "Unable to handle kernel NULL pointer dereference");
        else
                printk(KERN_ALERT "Unable to handle kernel paging request");
        printk(" at virtual address %08lx\n",address);
        printk(" printing eip:\n");

> Feb 13 20:37:41 mesh kernel:  printing eip:
> Feb 13 20:37:41 mesh kernel: c012e276
> Feb 13 20:37:41 mesh kernel: Oops: 0002
> Feb 13 20:37:41 mesh kernel: CPU:    0
> Feb 13 20:37:41 mesh kernel: EIP:    0060:[<c012e276>]    Not tainted
> Feb 13 20:37:41 mesh kernel: EFLAGS: 00010046
> Feb 13 20:37:41 mesh kernel: EIP is at mod_timer+0x96/0x7e0
> Feb 13 20:37:41 mesh kernel: eax: 00000000   ebx: c0147440   ecx: 00000007   edx: 00001388
> Feb 13 20:37:41 mesh kernel: esi: 850fc085   edi: c06436c0   ebp: c11c7ed0   esp: c11c7ea0
> Feb 13 20:37:41 mesh kernel: ds: 007b   es: 007b   ss: 0068
> Feb 13 20:37:41 mesh kernel: Process pdflush (pid: 5, threadinfo=c11c6000 task=c113d980)
> Feb 13 20:37:41 mesh kernel: Stack: c11c7ec0 c0146229 c11c7f04 00000000 00000080 c0147320 c11c7ee4 00000000 
> Feb 13 20:37:41 mesh kernel:        00000297 000733cf c11c7ee4 00000000 c11c7f90 c0147426 c06436c0 000733cf 
> Feb 13 20:37:41 mesh kernel:        0006ab17 00000000 00000000 c11c7ee0 00000000 00000001 00000000 00000001 
> Feb 13 20:37:41 mesh kernel: Call Trace:
> Feb 13 20:37:41 mesh kernel:  [<c0146229>] __get_page_state+0x29/0x90
> Feb 13 20:37:41 mesh kernel:  [<c0147320>] wb_kupdate+0x0/0x120

That is a statically stored timer.  It would appear that some other timer
from some other random part of the kernel has got itself scribbled on.

Maybe networking?  
