Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261336AbVB0C7q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261336AbVB0C7q (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Feb 2005 21:59:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261338AbVB0C7q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Feb 2005 21:59:46 -0500
Received: from mail.upce.cz ([195.113.124.33]:28831 "EHLO mail.upce.cz")
	by vger.kernel.org with ESMTP id S261336AbVB0C71 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Feb 2005 21:59:27 -0500
Message-ID: <42213771.5060809@seznam.cz>
Date: Sun, 27 Feb 2005 03:58:57 +0100
From: "kern.petr@seznam.cz" <kern.petr@seznam.cz>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: jgarzik@pobox.com, B.Zolnierkiewicz@elka.pw.edu.pl, vojtech@suse.cz,
       giovanni@sudfr.com, andre@linux-ide.org, dake@staszic.waw.pl
Subject: Re: via 6420 pata/sata controller
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 >>Bartlomiej Zolnierkiewicz wrote:
 >>> On Tuesday 30 of March 2004 15:24, Zdenek Tlusty wrote:
 >>>
 >>>>Hello,
 >>>>
 >>>>I have problem with via 6420 controller under linux (I have 
mandrake 9.1
 >>>>with kernel 2.4.25 with libata patch version 16).
 >>>>This controller has two sata and one pata channels. Sata channel 
works fine
 >>>>with libata. My problem is with pata channel. I have pata hard disk 
on this
 >>>>controller. Bios of the controller detected this disk but linux did 
not.
 >>>>What is the current status of the driver for this controller?
 >>>>Thank you for your time.
 >>>
 >>>
 >>> There are some patches floating around adding support for VT6410
 >>> (not VT6420) to generic IDE PCI driver. This controller may also work
 >>> with generic IDE PCI driver (PCI VendorID/ProductID needs to be added
 >>> to drivers/ide/pci/generic.h and drivers/ide/pci/generic.c).
 >>
 >>VT 6420 should be added to via82cxxx.c, since it does the necessary bus
 >>setup and such. AFAICS it is programmed just like all the other VIA
 >>PATA controllers.
 >>
 >> BTW Does anybody has contacts in VIA?
 >>
 >>Sure... I'll check my VT 6420 cards as well. It should just be another
 >>PCI id added to via82cxxx.c.
 >>
 >> Jeff
 >>
 >
 >Hello,
 >
 >I tried to modify via82cxxx.c and .h, but was unsuccessful. Has anyone 
got it to work properly?
 >
 >Kamil Okac

* Per my message (last quoted line), the user should add the PCI ID to 
* drivers/ide/via82cxxx.[ch] and see what happens.
*
* 	Jeff



Hello,
i trying resurrect this discussion again for solve this problem successfuly.

My experiments:
I changed two files:

usr/src/linux-2.6.11-rc5/include/linux/pci_ids.h
--- cut here ---
#define PCI_DEVICE_ID_VIA_8703_51_0 0x3148
#define PCI_DEVICE_ID_VIA_8237_SATA 0x3149
#define PCI_DEVICE_ID_VIA_6420 0x4149                    ; <= this i was 
add
#define PCI_DEVICE_ID_VIA_XN266 0x3156
#define PCI_DEVICE_ID_VIA_8754C_0 0x3168
--- cut here ---

/use/src/linux-2.6.11-rc5/drivers/ide/pci/via82cxxx.c
--- cut here ---
{ "vt8233c", PCI_DEVICE_ID_VIA_8233C_0, 0x00, 0x2f, VIA_UDMA_100 },
{ "vt8233", PCI_DEVICE_ID_VIA_8233_0, 0x00, 0x2f, VIA_UDMA_100 },
{ "vt8231", PCI_DEVICE_ID_VIA_8231, 0x00, 0x2f, VIA_UDMA_100 },
{ "vt6420", PCI_DEVICE_ID_VIA_6420, 0x00, 0x2f, VIA_UDMA_100 },          
          ; <= this i was add
{ "vt82c686b", PCI_DEVICE_ID_VIA_82C686, 0x40, 0x4f, VIA_UDMA_100 },
{ "vt82c686a", PCI_DEVICE_ID_VIA_82C686, 0x10, 0x2f, VIA_UDMA_66 },
--- cut here ---

But i was not successful :'-(



Informations from my computer:
dmesg
--- cut here ---
Linux version 2.6.11-rc5 (root@linux) (gcc version 2.95.4 20011002 
(Debian prerelease)) #1 Sat Feb 26 02:18:02 CET 2005
.
.
.
SCSI subsystem initialized
libata version 1.10 loaded.
sata_via version 1.1
sata_via(0000:00:0f.0): routed to hard irq line 10
ata1: SATA max UDMA/133 cmd 0x6200 ctl 0x6302 bmdma 0x6600 irq 10
ata2: SATA max UDMA/133 cmd 0x6400 ctl 0x6502 bmdma 0x6608 irq 10
ata1: no device found (phy stat 00000000)
scsi0 : sata_via
ata2: no device found (phy stat 00000000)
scsi1 : sata_via
--- cut here ---

lspci
--- cut here ---
0000:00:0f.0 RAID bus controller: VIA Technologies, Inc. VIA VT6420 SATA 
RAID Controller (rev 50)
0000:00:0f.1 RAID bus controller: VIA Technologies, Inc.: Unknown device 
4149 (rev 80)
--- cut here ---

lspci -n
--- cut here ---
0000:00:0f.0 0104: 1106:3149 (rev 50)
0000:00:0f.1 0104: 1106:4149 (rev 80)
--- cut here ---

cat /proc/ioports
--- cut here ---
6200-6207 : 0000:00:0f.0
  6200-6207 : sata_via
6300-6303 : 0000:00:0f.0
  6300-6303 : sata_via
6400-6407 : 0000:00:0f.0
  6400-6407 : sata_via
6500-6503 : 0000:00:0f.0
  6500-6503 : sata_via
6600-660f : 0000:00:0f.0
  6600-660f : sata_via
6700-67ff : 0000:00:0f.0
  6700-67ff : sata_via
6800-6807 : 0000:00:0f.1
6900-6903 : 0000:00:0f.1
6a00-6a07 : 0000:00:0f.1
6b00-6b03 : 0000:00:0f.1
6c00-6c0f : 0000:00:0f.1
--- cut here ---


This controller talking about:
http://www.sunsway.com.hk/products/sata-ide.html
http://www.viatech.co.jp/en/Products/vt6420.jsp
http://www.via.com.tw/en/products/peripherals/serial-ata_raid/vt6420/

Forum where they talked about - linux talking:
http://www.ussg.iu.edu/hypermail/linux/kernel/0403.3/1565.html
http://www.ussg.iu.edu/hypermail/linux/kernel/0403.3/1814.html
http://www.ussg.iu.edu/hypermail/linux/kernel/0403.3/1821.html
_http://www.ussg.iu.edu/hypermail/linux/kernel/0404.2/0573.html_

Forum where they talked about - freebsd talking:
http://lists.freebsd.org/pipermail/freebsd-current/2004-January/017706.html
http://lists.freebsd.org/pipermail/freebsd-current/2004-January/017725.html


Your's Sincerely
Petr Novák
kern.petr@seznam.cz


