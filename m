Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132228AbRCYWeU>; Sun, 25 Mar 2001 17:34:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132229AbRCYWeJ>; Sun, 25 Mar 2001 17:34:09 -0500
Received: from deliverator.sgi.com ([204.94.214.10]:49935 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S132228AbRCYWdx>; Sun, 25 Mar 2001 17:33:53 -0500
Message-ID: <3ABE71B9.9FAA232B@sgi.com>
Date: Sun, 25 Mar 2001 14:31:21 -0800
From: LA Walsh <law@sgi.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en, en-US, en-GB, fr
MIME-Version: 1.0
To: Gérard Roudier <groudier@club-internet.fr>
CC: linux-kernel@vger.kernel.org
Subject: Re: NCR53c8xx driver and multiple controllers...(not new prob)
In-Reply-To: <Pine.LNX.4.10.10103241647530.601-100000@linux.local>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the 'alternate' output when the ncr53c8xx driver is
compiled in:

SCSI subsystem driver Revision: 1.00
scsi-ncr53c7,8xx : at PCI bus 0, device 8, function 0
scsi-ncr53c7,8xx : warning : revision of 35 is greater than 2.
scsi-ncr53c7,8xx : NCR53c810 at memory 0xfa101000, io 0x2000, irq 58
scsi0 : burst length 16
scsi0 : NCR code relocated to 0x37d6c610 (virt 0xf7d6c610)
scsi0 : test 1 started
scsi0 : NCR53c{7,8}xx (rel 17)
request_module[block-major-8]: Root fs not mounted
VFS: Cannot open root device "807" or 08:07
Please append a correct "root=" boot option
Kernel panic: VFS: Unable to mount root fs on 08:07
-----
Note how this compares to the case where the driver is a module:

(note scsi0 was an IDE emulation in this setup -- something also removed in
the above setup)
ncr53c8xx: at PCI bus 0, device 8, function 0
ncr53c8xx: 53c810a detected
ncr53c8xx: at PCI bus 1, device 3, function 0
ncr53c8xx: 53c896 detected
ncr53c8xx: at PCI bus 1, device 3, function 1
ncr53c8xx: 53c896 detected
ncr53c810a-0: rev=0x23, base=0xfa101000, io_port=0x2000, irq=58
ncr53c810a-0: ID 7, Fast-10, Parity Checking
ncr53c810a-0: restart (scsi reset).
ncr53c896-1: rev=0x01, base=0xfe004000, io_port=0x3000, irq=57
ncr53c896-1: ID 7, Fast-40, Parity Checking
ncr53c896-1: on-chip RAM at 0xfe000000
ncr53c896-1: restart (scsi reset).
ncr53c896-1: Downloading SCSI SCRIPTS.
ncr53c896-2: rev=0x01, base=0xfe004400, io_port=0x3400, irq=56
ncr53c896-2: ID 7, Fast-40, Parity Checking
ncr53c896-2: on-chip RAM at 0xfe002000
ncr53c896-2: restart (scsi reset).
ncr53c896-2: Downloading SCSI SCRIPTS.
scsi1 : ncr53c8xx - version 3.2a-2
scsi2 : ncr53c8xx - version 3.2a-2
scsi3 : ncr53c8xx - version 3.2a-2
scsi : 4 hosts.
  Vendor: SEAGATE   Model: ST318203LC        Rev: 0002
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sda at scsi2, channel 0, id 1, lun 0
  Vendor: SGI       Model: SEAGATE ST318203  Rev: 2710
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sdb at scsi2, channel 0, id 2, lun 0
  Vendor: SGI       Model: SEAGATE ST336704  Rev: 2742

--------
	This is on a 4x550 PIII(Xeon) system.  The 2nd two 
controllers are on pci bus 1.  The boot disk is sda, which is off of
scsi2 in the working example, or scsi1 in the non-working example.

	It seems that compiling it in somehow causes controllers
1 and 2 (which are off of the 2nd pci bus, "1", to get missed during 
scsi initialization.  Is there a parameter I need to pass to the 
ncr53c8xx driver to get it to scan the 2nd bus?
