Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131630AbRDMTpE>; Fri, 13 Apr 2001 15:45:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131638AbRDMToz>; Fri, 13 Apr 2001 15:44:55 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:51725 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131630AbRDMTov>; Fri, 13 Apr 2001 15:44:51 -0400
Subject: Re: device driver questions
To: friedrich_s@crane.navy.mil (Friedrich Steven E CONT CNIN)
Date: Fri, 13 Apr 2001 20:46:58 +0100 (BST)
Cc: linux-kernel@vger.kernel.org ("Linux Kernel List (E-mail)")
In-Reply-To: <AF6E1CA59D6AD1119C3A00A0C9893C9A04F57120@cninexchsrv01.crane.navy.mil> from "Friedrich Steven E CONT CNIN" at Apr 13, 2001 02:33:38 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14o9X2-0003R0-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> My device shows up in /proc/iomem even before I load my device driver,
> indicating that the pci subsystem mapped it into the kernel pages.  But bar0

Actually the addresses you see there are physical bus addresses not neccessarily
and on x86 quite likely not actually mapped.

> Why didn't the pci subsystem configure the device to appear on a page
> boundary?

The device didnt ask to be on a page boundary

> the user program?  I know I could create an ioctl call, but I would think
> there must be some other method already in place, since this would affect
> all pci devices.

If you want to mmap the device then you really want to put the device in its
own 4K aligned 4K sized PCI window, otherwise adjacent devices will become
accessible too and that might not be desirable.

Or you could avoid providing mmap.

Alan

