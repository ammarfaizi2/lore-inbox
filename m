Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261900AbVGOQU7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261900AbVGOQU7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 12:20:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263322AbVGOQU6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 12:20:58 -0400
Received: from taxbrain.com ([64.162.14.3]:21840 "EHLO petzent.com")
	by vger.kernel.org with ESMTP id S261900AbVGOQU5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 12:20:57 -0400
From: "karl malbrain" <karl@petzent.com>
To: "Russell King" <rmk+lkml@arm.linux.org.uk>
Cc: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: RE: 2.6.9: serial_core: uart_open
Date: Fri, 15 Jul 2005 09:20:51 -0700
Message-ID: <NDBBKFNEMLJBNHKPPFILOEAKCEAA.karl@petzent.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Importance: Normal
In-Reply-To: <20050715082859.B23102@flint.arm.linux.org.uk>
X-Spam-Processed: petzent.com, Fri, 15 Jul 2005 09:17:05 -0700
	(not processed: message from valid local sender)
X-Return-Path: karl@petzent.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
X-MDAV-Processed: petzent.com, Fri, 15 Jul 2005 09:17:07 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Russell King
> Sent: Friday, July 15, 2005 12:29 AM
> To: karl malbrain
> Cc: Linux-Kernel@Vger. Kernel. Org
> Subject: Re: 2.6.9: serial_core: uart_open
>
>
> On Thu, Jul 14, 2005 at 03:35:07PM -0700, karl malbrain wrote:
> > AT LAST I HAVE SOME DATA!!!
> >
> > The problem is that ALL SYSTEM CALLS to open "/dev/tty" are
> blocking!! even
> > with O_NDELAY set and even from completely disjoint sessions.
> I discovered
> > this via issuing "strace sh".  That's why the new xterm windows froze.
> >
> > The original process doing the open("/dev/ttyS1", O_RDWR) is
> listed in the
> > ps aux listing as status S+.
>
> Ok, 'S' means it's sleeping.
>
> Can you enable Magic SYSRQ, and ensure that you have a large kernel
> log buffer (the LOG_BUF_SHIFT configuration symbol).  Ensure that
> /proc/sys/kernel/sysrq is 1, and re-run your test such that you have
> something else waiting (eg, the strace sh).  Then hit Alt-SysRQ-T.
>
> You can then read the kernel messages with dmesg - you may need the
> -s argument to capture the entire kernel buffer.
>
> This will tell us where all processes are sleeping.

Here is the dump of the original process that's waiting for the
open("/dev/ttyS1", O_RDWR) to return:

test5         S C023B673  3036  5399   5224                     (NOTLB)
d0fb6e88 00000086 d3462ea0 c023b673 04000000 001123f9 3949e4f7 00003b4e
       d204e170 d204e2fc dfee9658 dfd4ec60 c0422448 dfee9640 c02390c0
d1f22940
       00000000 d204e170 c011c856 00000000 00000000 c0236d4c 00000000
dfee9640
Call Trace:
 [<c023b673>] serial8250_interrupt+0x0/0x200
 [<c02390c0>] uart_block_til_ready+0x198/0x224
 [<c011c856>] default_wake_function+0x0/0xc
 [<c0236d4c>] uart_startup+0xb6/0x1d8
 [<c011c856>] default_wake_function+0x0/0xc
 [<c023980b>] uart_change_pm+0x1c/0x24
 [<c023938a>] uart_open+0xd1/0x105
 [<c0218226>] tty_open+0x18f/0x3b8
 [<c016d78c>] chrdev_open+0x325/0x3b9
 [<c016256f>] dentry_open+0xbd/0x180
 [<c01624ac>] filp_open+0x36/0x3c
 [<c0301e98>] __cond_resched+0x14/0x3b
 [<c01da4fa>] direct_strncpy_from_user+0x3e/0x5d
 [<c0162970>] sys_open+0x31/0x7d
 [<c03036f3>] syscall_call+0x7/0xb

Hope this helps, karl m



