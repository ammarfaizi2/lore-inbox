Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131665AbRDMULY>; Fri, 13 Apr 2001 16:11:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131643AbRDMULO>; Fri, 13 Apr 2001 16:11:14 -0400
Received: from cninexchsrv01.crane.navy.mil ([164.227.4.52]:35078 "EHLO
	cninexchsrv01.crane.navy.mil") by vger.kernel.org with ESMTP
	id <S131665AbRDMUK5>; Fri, 13 Apr 2001 16:10:57 -0400
Message-ID: <AF6E1CA59D6AD1119C3A00A0C9893C9A04F57121@cninexchsrv01.crane.navy.mil>
From: Friedrich Steven E CONT CNIN <friedrich_s@crane.navy.mil>
To: linux-kernel@vger.kernel.org
Subject: RE: device driver questions
Date: Fri, 13 Apr 2001 15:10:48 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

a couple questions below...



	-----Original Message-----
	From:	Alan Cox
	Sent:	Friday, April 13, 2001 14:47
	To:	Friedrich Steven E CONT CNIN
	Cc:	linux-kernel@vger.kernel.org
	Subject:	Re: device driver questions

	> My device shows up in /proc/iomem even before I load my device
driver,
	> indicating that the pci subsystem mapped it into the kernel pages.
But bar0

	Actually the addresses you see there are physical bus addresses not
neccessarily
	and on x86 quite likely not actually mapped.

	Oops, sorry about that.  I am using ioremap to create the kernel
pages


	> Why didn't the pci subsystem configure the device to appear on a
page
	> boundary?

	The device didnt ask to be on a page boundary

	Would seem like a good option to include on such a device, since
various OSes and platforms may have various requirements...

	> the user program?  I know I could create an ioctl call, but I
would think
	> there must be some other method already in place, since this would
affect
	> all pci devices.

	If you want to mmap the device then you really want to put the
device in its
	own 4K aligned 4K sized PCI window, otherwise adjacent devices will
become
	accessible too and that might not be desirable.

	How can I tell Linux to do this?  Will the pci subsystem do it?

	Or you could avoid providing mmap.

	It seems to me that a lot of trouble went into creating memory
mapped i/o devices on the PC platform, and I would like to retain this
capability.  Our app has real-time requirements, and we're trying to assess
if Linux can meet our requirements with/without real-time extensions.  We
are also willing to move some of the real-time functionality into
hardware...

	We've already developed our app under VxWorks.  We access our
devices with simple, quick pointers to structures.  So everything is a
*memory read* or *memory write*.   Minimal overhead.


	Alan
