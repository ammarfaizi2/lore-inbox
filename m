Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293344AbSBQT7B>; Sun, 17 Feb 2002 14:59:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293352AbSBQT6w>; Sun, 17 Feb 2002 14:58:52 -0500
Received: from front2.mail.megapathdsl.net ([66.80.60.30]:54024 "EHLO
	front2.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S293344AbSBQT6m>; Sun, 17 Feb 2002 14:58:42 -0500
Subject: 2.5.5-pre1 -- Two weird problems:  my kernel log is incomplete and
	a usermode client problem
From: Miles Lane <miles@megapathdsl.net>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 17 Feb 2002 11:55:05 -0800
Message-Id: <1013975706.1862.15.camel@turbulence.megapathdsl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Problem #1

I have applied a host of patches in order to get a bootable
kernel with usable drivers.  Unfortunately, my kernel log
is corrupted.  Also, dmesg output is faulty.  During the boot
process, I appear to see all the correct information flash by.
As you can see from the included log snippet, there are a 
few errors that probably indicate a cause.  Specifically,
the line "Error seeking in /dev/kmem"looks bad.

Feb 17 11:00:09 turbulence syslogd 1.4.1: restart.
Feb 17 11:00:09 turbulence syslog: syslogd startup succeeded
Feb 17 11:00:09 turbulence kernel: klogd 1.4.1, log source = /proc/kmsg
started.
Feb 17 11:00:09 turbulence kernel: Inspecting
/boot/System.map-2.5.5-pre1
Feb 17 11:00:09 turbulence syslog: klogd startup succeeded
Feb 17 11:00:09 turbulence portmap: portmap startup succeeded
Feb 17 11:00:09 turbulence kernel: Loaded 20107 symbols from
/boot/System.map-2.5.5-pre1.
Feb 17 11:00:09 turbulence kernel: Symbols match kernel version 2.5.5.
Feb 17 11:00:09 turbulence kernel: Error seeking in /dev/kmem 
Feb 17 11:00:09 turbulence kernel: Symbol #floppy, value d98c6000 
Feb 17 11:00:09 turbulence kernel: Error adding kernel module table
entry. 
Feb 17 11:00:09 turbulence kernel: bled, EHCI rev 0.95
Feb 17 11:00:09 turbulence kernel: hcd.c: 00:11.2 root hub device
address 1
Feb 17 11:00:09 turbulence kernel: usb.c: kmalloc IF cfd6a880, numif 1

First, these patches from GregKH:
usb.c.patch
usb-hpusbscsi-2.5.5-pre1.patch
usb-alloc_urb-1-2.5.5-pre1
usb-alloc_urb-2-2.5.5-pre1
usb-alloc_urb-3-2.5.5-pre1
usb-alloc_urb-4-2.5.5-pre1
usb-alloc_urb-5-2.5.5-pre1
usb-ohci-hcd-2.5.5-pre1.patch
usb-storage-debug.patch
usb-vicam-2.5.5-pre1.patch
usb1.patch
usb2.patch
usb3.patch
usb4.patch

aha152x.patch
patch-2.5.4-do_iso_mmap
alsa.patch
patch-2.5.5-pre1
inode.patch
vesafb.patch
videodev-patch-2.5.5-pre1

Problem #2

I run Evolution (Ximian's E-Mail, Calendar, etc. client).  
I find that when I run Evolution under 2.5.5-pre1, whenever I
try to access the Contacts list, the client locks up.  I have
run it under gdb, but see no crash.  If I break into the 
debugger, I see nothing suspicious.  Thinking about this some
more, I am wondering if this could be due to the fact that
I use ipchains when I boot my 2.4 kernel.  Since the 2.5 kernel
doesn't have ipchains support, ipchains doesn't start up.
Could this have something to do with it?  I really don't
know how to proceed with debugging this problem.

Thanks,
	Miles

