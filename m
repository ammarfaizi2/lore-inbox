Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263352AbVGOUsM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263352AbVGOUsM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 16:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263360AbVGOUsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 16:48:12 -0400
Received: from taxbrain.com ([64.162.14.3]:28761 "EHLO petzent.com")
	by vger.kernel.org with ESMTP id S263352AbVGOUsL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 16:48:11 -0400
Message-ID: <08e001c5897e$7f162710$4b010059@petzent.com>
From: "karl malbrain" <karl@petzent.com>
To: "Russell King" <rmk+lkml@arm.linux.org.uk>
Cc: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
References: <20050715082859.B23102@flint.arm.linux.org.uk> <NDBBKFNEMLJBNHKPPFILKEAKCEAA.karl@petzent.com> <20050715213201.C23709@flint.arm.linux.org.uk>
Subject: Re: 2.6.9: serial_core: uart_open
Date: Fri, 15 Jul 2005 13:48:02 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
X-Spam-Processed: petzent.com, Fri, 15 Jul 2005 13:44:19 -0700
	(not processed: message from valid local sender)
X-Return-Path: karl@petzent.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
X-MDAV-Processed: petzent.com, Fri, 15 Jul 2005 13:44:21 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message ----- 
From: "Russell King" <rmk+lkml@arm.linux.org.uk>
To: "karl malbrain" <karl@petzent.com>
Cc: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Sent: Friday, July 15, 2005 1:32 PM
Subject: Re: 2.6.9: serial_core: uart_open


> On Fri, Jul 15, 2005 at 09:02:48AM -0700, karl malbrain wrote:
> > > -----Original Message-----
> > > From: Russell King
> > > Sent: Friday, July 15, 2005 12:29 AM
> > > To: karl malbrain
> > > Cc: Linux-Kernel@Vger. Kernel. Org
> > > Subject: Re: 2.6.9: serial_core: uart_open
> > >
> > >
> > > On Thu, Jul 14, 2005 at 03:35:07PM -0700, karl malbrain wrote:
> > > > AT LAST I HAVE SOME DATA!!!
> > > >
> > > > The problem is that ALL SYSTEM CALLS to open "/dev/tty" are
> > > blocking!! even
> > > > with O_NDELAY set and even from completely disjoint sessions.
> > > I discovered
> > > > this via issuing "strace sh".  That's why the new xterm windows
froze.
> > > >
> > > > The original process doing the open("/dev/ttyS1", O_RDWR) is
> > > listed in the
> > > > ps aux listing as status S+.
> > >
> > > Ok, 'S' means it's sleeping.
> > >
> > > Can you enable Magic SYSRQ, and ensure that you have a large kernel
> > > log buffer (the LOG_BUF_SHIFT configuration symbol).  Ensure that
> > > /proc/sys/kernel/sysrq is 1, and re-run your test such that you have
> > > something else waiting (eg, the strace sh).  Then hit Alt-SysRQ-T.
> > >
> > > You can then read the kernel messages with dmesg - you may need the
> > > -s argument to capture the entire kernel buffer.
> > >
> > > This will tell us where all processes are sleeping.
> >
> >
> >  sh            D 00000006  3036  5341   5252                     (NOTLB)
> > d0408eb0 00000086 c01c14d7 00000006 d0408e94 000f4fa5 c0d38f81 000039a0
> >        df461240 df4613cc c035ff00 00000246 d0408ecc df461240 c0300e33
> > 00000001
> >        df461240 c011c856 c035ff20 c035ff20 d0408000 00000001 c035abe0
> > d0408000
> > Call Trace:
> >  [<c01c14d7>] inode_has_perm+0x4c/0x54
> >  [<c0300e33>] __down+0x103/0x1fe
> >  [<c011c856>] default_wake_function+0x0/0xc
> >  [<c0301180>] __down_failed+0x8/0xc
> >  [<c021a4d0>] .text.lock.tty_io+0x87/0x10f
> >  [<c016d78c>] chrdev_open+0x325/0x3b9
>
> This seems to imply that there's a lock being taken in tty_open().  The
> 2.6.9 source contains no such thing.  Are you sure you're using an
> unpatched 2.6.9 kernel?
>
> >  [<c016256f>] dentry_open+0xbd/0x180
> >  [<c01624ac>] filp_open+0x36/0x3c
> >  [<c01da502>] direct_strncpy_from_user+0x46/0x5d
> >  [<c0162970>] sys_open+0x31/0x7d
> >  [<c03036f3>] syscall_call+0x7/0xb
>

The system is red-hat 4.6.9-11EL.  There is a patch to tty_io but it doesn't
mention locking anything.  karl m



