Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131614AbRDMTeN>; Fri, 13 Apr 2001 15:34:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131630AbRDMTeE>; Fri, 13 Apr 2001 15:34:04 -0400
Received: from cninexchsrv01.crane.navy.mil ([164.227.4.52]:20492 "EHLO
	cninexchsrv01.crane.navy.mil") by vger.kernel.org with ESMTP
	id <S131614AbRDMTdx>; Fri, 13 Apr 2001 15:33:53 -0400
Message-ID: <AF6E1CA59D6AD1119C3A00A0C9893C9A04F57120@cninexchsrv01.crane.navy.mil>
From: Friedrich Steven E CONT CNIN <friedrich_s@crane.navy.mil>
To: "Linux Kernel List (E-mail)" <linux-kernel@vger.kernel.org>
Subject: device driver questions
Date: Fri, 13 Apr 2001 14:33:38 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm running RedHat 7.0.91 (Wolverine) Kernel 2.4.1-0.1.9

I'm writing a device driver for Industry Pak modules that plug into an
Industry Pak carrier which plugs into the PCI bus.  I'm currently using an
Acromag APC8620 carrier which can take up to five IP modules.  The IP
modules I'm using are also Acromag; one IP440 (opto-isolated digital input),
two IP445 (opto-isolated digital output), and one IP480 (timer/counter).

I've been using a pre-release copy of Linux Device Drivers (O'Reilly), as
well as the 1st edition, and I've read the device driver chapter from
Professional Linux Programming (WROX).

The pre-release LDD doesn't have the chapter on PCI, USB, etc. but does
mention PCI issues throughout.  And my device driver is a loadable module,
and implements open, release, read, write, and mmap, so far.

The mmap file operation utilizes remap_page_range(), which requires a page
bounded physical address (4KB on x86).

My device shows up in /proc/iomem even before I load my device driver,
indicating that the pci subsystem mapped it into the kernel pages.  But bar0
is 0xfdeff800 and bar2 is 0xfdeffc00.  Neither is on a page boundary.  I
have one other pci device, an Intel eepro100, and it's bars are page
bounded.

Why didn't the pci subsystem configure the device to appear on a page
boundary?
My device driver knows the bar0 and bar2 addresses and can mask them to get
the offset the userland program will need, but how can I get that offset to
the user program?  I know I could create an ioctl call, but I would think
there must be some other method already in place, since this would affect
all pci devices.

Do man pages exist anywhere for:
remap_page_range, pci_register_driver, register_chrdev, request_mem_region,
etc.


Steven Friedrich
DynTel Corporation
Unit One, Box 611
Bldg 64 - NW Corner
Crane, IN  47522
