Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263046AbVG3K2K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263046AbVG3K2K (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 06:28:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263040AbVG3K2K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 06:28:10 -0400
Received: from tim.rpsys.net ([194.106.48.114]:10430 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S263049AbVG3K16 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 06:27:58 -0400
Subject: Re: 2.6.13-rc3-mm3
From: Richard Purdie <rpurdie@rpsys.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050728025840.0596b9cb.akpm@osdl.org>
References: <20050728025840.0596b9cb.akpm@osdl.org>
Content-Type: text/plain
Date: Sat, 30 Jul 2005 11:27:46 +0100
Message-Id: <1122719266.7650.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-07-28 at 02:58 -0700, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13-rc3/2.6.13-rc3-mm3/
> 
> - There's a pretty large x86_64 update here which naughty maintainer wants
>   in 2.6.13.  Extra testing, please.
>
> +x86_64-switch-to-the-interrupt-stack-when-running-a.patch

The above patch causes the BUG below on the Zaurus (arm pxa255 with
preempt enabled). This can only be due to the suspicious looking changes
to kernel/softirq.c in that patch...

Richard

kernel BUG at kernel/sched.c:2988!
kernel BUG at kernel/sched.c:2988!
Unable to handle kernel NULL pointer dereference at virtual address 00000000
pgd = c0004000
[00000000] *pgd=00000000
Internal error: Oops: 8f5 [#1]
Modules linked in:
CPU: 0
PC is at __bug+0x40/0x54
LR is at 0x60000013
pc : [<c0021290>]    lr : [<60000013>]    Not tainted
sp : c3c0dc6c  ip : 00000001  fp : c3c0dc7c
r10: fffff920  r9 : c3c0c000  r8 : 00000000
r7 : 00000000  r6 : c0271a00  r5 : f2d00000  r4 : 00000000
r3 : 00000000  r2 : 00000000  r1 : 00000026  r0 : 00000001
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  Segment kernel
Control: 397F  Table: A0004000  DAC: 00000017
Process khelper (pid: 94, stack limit = 0xc3c0c194)
Backtrace:
[<c0021250>] (__bug+0x0/0x54) from [<c01f01a8>] (preempt_schedule_irq+0x84/0x8c)
 r4 = C3C0C000
[<c01f0124>] (preempt_schedule_irq+0x0/0x8c) from [<c001ba3c>] (svc_preempt+0x28/0x4c)
 r4 = FFFFFFFF
[<c0037618>] (release_console_sem+0x0/0x27c) from [<c0037a48>] (vprintk+0x1b4/0x344)
[<c0037894>] (vprintk+0x0/0x344) from [<c0037bf4>] (printk+0x1c/0x20)
[<c0037bd8>] (printk+0x0/0x20) from [<c002128c>] (__bug+0x3c/0x54)
 r3 = C022716C  r2 = 00000000  r1 = 00000000  r0 = C02043C8
[<c0021250>] (__bug+0x0/0x54) from [<c01f01a8>] (preempt_schedule_irq+0x84/0x8c)
 r4 = C3C0C000
[<c01f0124>] (preempt_schedule_irq+0x0/0x8c) from [<c001ba3c>] (svc_preempt+0x28/0x4c)
 r4 = FFFFFFFF
[<c0098ee8>] (dput+0x0/0x308) from [<c008e9ec>] (__link_path_walk+0xc00/0x1280)
 r6 = 00000000  r5 = C022EA7E  r4 = FFFFFFFE
[<c008ddec>] (__link_path_walk+0x0/0x1280) from [<c008f118>] (link_path_walk+0xac/0x1dc)
[<c008f06c>] (link_path_walk+0x0/0x1dc) from [<c008f334>] (path_lookup+0xec/0x260)
 r7 = 00000000  r6 = C3C0DEEC  r5 = C3C0C000  r4 = C03327FC
[<c008f248>] (path_lookup+0x0/0x260) from [<c0089f24>] (open_exec+0x2c/0xe0)
 r8 = C034FE78  r7 = 00000001  r6 = C3C0DEEC  r5 = C3C0AA20
 r4 = C022EA78
[<c0089ef8>] (open_exec+0x0/0xe0) from [<c008b224>] (do_execve+0x48/0x1f4)
 r7 = FFFFFFF4  r6 = C3C08E00  r5 = C3C0AA20  r4 = C022EA78
[<c008b1dc>] (do_execve+0x0/0x1f4) from [<c0020bfc>] (execve+0x40/0x88)
[<c0020bbc>] (execve+0x0/0x88) from [<c004938c>] (____call_usermodehelper+0xa8/0xb4)
 r7 = 00000000  r6 = 00000000  r5 = C034FE14  r4 = C3C0C000
[<c00492e4>] (____call_usermodehelper+0x0/0xb4) from [<c0039604>] (do_exit+0x0/0xd90)
 r6 = 00000000  r5 = 00000000  r4 = 00000000
Code: 1b005a54 e59f0014 eb005a52 e3a03000 (e5833000)


