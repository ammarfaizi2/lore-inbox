Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132517AbRCZR5N>; Mon, 26 Mar 2001 12:57:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132527AbRCZR4y>; Mon, 26 Mar 2001 12:56:54 -0500
Received: from front7m.grolier.fr ([195.36.216.57]:63995 "EHLO
	front7m.grolier.fr") by vger.kernel.org with ESMTP
	id <S132517AbRCZR4n> convert rfc822-to-8bit; Mon, 26 Mar 2001 12:56:43 -0500
Date: Mon, 26 Mar 2001 16:45:09 +0200 (CEST)
From: Gérard Roudier <groudier@club-internet.fr>
To: LA Walsh <law@sgi.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: NCR53c8xx driver and multiple controllers...(not new prob)
In-Reply-To: <3ABE71B9.9FAA232B@sgi.com>
Message-ID: <Pine.LNX.4.10.10103261628550.1252-100000@linux.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 25 Mar 2001, LA Walsh wrote:

> Here is the 'alternate' output when the ncr53c8xx driver is
> compiled in:
> 
> SCSI subsystem driver Revision: 1.00
> scsi-ncr53c7,8xx : at PCI bus 0, device 8, function 0
> scsi-ncr53c7,8xx : warning : revision of 35 is greater than 2.
> scsi-ncr53c7,8xx : NCR53c810 at memory 0xfa101000, io 0x2000, irq 58
> scsi0 : burst length 16
> scsi0 : NCR code relocated to 0x37d6c610 (virt 0xf7d6c610)
> scsi0 : test 1 started
> scsi0 : NCR53c{7,8}xx (rel 17)
> request_module[block-major-8]: Root fs not mounted
> VFS: Cannot open root device "807" or 08:07
> Please append a correct "root=" boot option
> Kernel panic: VFS: Unable to mount root fs on 08:07
> -----

The 53c7,8xx driver is a different driver that hasn't been updated for the
support of the 53C896. I figure out that you already have been replied
upon this point.

For your machine configuration you want to use either the NCR53C8XX driver
or the SYM53C8XX driver. The SYM53C8XX driver has a better support for the
896 as it handles phase mismatch from SCRIPTS. The both drivers share the
same kernel config options for simplicity (in fact the SYM53C8XX driver
just steals the NCR53C8XX config options).

Go to the SCSI low-level configuration form under make menuconfig for
example and configure the SYM53C8XX driver as 'Y' and the NCR53C8XX driver
as 'N'. Btw, also configure 'N' the 53c7,8xx driver to avoid conflicts.

You may also have a look at the help entries for these drivers and at the 
file linux/drivers/scsi/README.ncr53c8xx (also applies to SYM53C8XX).

A driver named SYM-2 that replaces both the NCR53C8XX and the SYM53C8XX
drivers also exists. This driver is multi-platform and for now has been 
added support for Linux, FreeBSD and NetBSD. It is intended to replace the
NCR53C8XX and the SYM53C8XX. It is not included in Linux for now since we
only have _stable_ kernels at the moment and the NCR+SYM driver pair is
the current _stable_ support for SYMBIOS 53C8XX controllers. 
If you want to try SYM-2: ftp://ftp.tux.org/roudier/README-drivers-linux

  Gérard.

