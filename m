Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264697AbSLLOCB>; Thu, 12 Dec 2002 09:02:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264686AbSLLOBS>; Thu, 12 Dec 2002 09:01:18 -0500
Received: from mailout04.sul.t-online.com ([194.25.134.18]:4037 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S264673AbSLLOBH>; Thu, 12 Dec 2002 09:01:07 -0500
Date: Thu, 12 Dec 2002 15:06:12 +0100
To: linux-kernel@vger.kernel.org
Subject: [PATCH] nforce2 dma enabled 
Message-ID: <20021212140612.GA543@Timekeeper>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="jI8keyz6grp/JLjh"
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: tstone@t-online.de (Tim Krieglstein)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi 
I just got a new toy an epox EP-8RDA. Since there is an nforce2 chipset
onboard and only support for the nforce (whithout 2) in the 2.4.20-ac2
kernel. I just concluded that the new ide driver should be pretty
similar to the old one. i had absolutly no documentation! so be
careful! Personally i did an full backup *before* fiddling with the ide
driver :)

The patch just adds the pci id of the nforce ide controller and added a
new information block to the ide_pci_device_t structure. Also i added an
entry to pci_device_id.

This is my first public patch so suggestions or other feedback is very
welcome. I would also like to know why the lspci command still tells me
this is an unknown device after applying my patch seen below. Also if
someone has a hint why the usb-devices have no interrupt assigned and
thus are not available is very welcome (probably disable acpi?).

However currently i am runing with following settings enabled (by hand):
/dev/hda:
 multcount    = 16 (on)
 IO_support   =  1 (32-bit)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  1 (on)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 15505/240/63, sectors = 234441648, start = 0

Have fun
Tim

PS: Please CC me since im am currently not subscribed to the list

--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="nforce2.patch"

diff -r -C 2 ../linux-2.4.20/drivers/ide/pci/nvidia.c ./drivers/ide/pci/nvidia.c
*** ../linux-2.4.20/drivers/ide/pci/nvidia.c	Thu Dec 12 14:22:55 2002
--- ./drivers/ide/pci/nvidia.c	Thu Dec 12 13:53:11 2002
***************
*** 342,345 ****
--- 342,346 ----
  static struct pci_device_id nforce_pci_tbl[] __devinitdata = {
  	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_IDE, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+ 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE2_IDE, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 1},
  	{ 0, },
  };
diff -r -C 2 ../linux-2.4.20/drivers/ide/pci/nvidia.h ./drivers/ide/pci/nvidia.h
*** ../linux-2.4.20/drivers/ide/pci/nvidia.h	Thu Dec 12 14:22:55 2002
--- ./drivers/ide/pci/nvidia.h	Thu Dec 12 13:55:06 2002
***************
*** 44,47 ****
--- 44,62 ----
  		bootable:	ON_BOARD,
  		extra:		0,
+ 	},
+ 
+ 	{
+ 		vendor:		PCI_VENDOR_ID_NVIDIA,
+ 		device:		PCI_DEVICE_ID_NVIDIA_NFORCE2_IDE,
+ 		name:		"NFORCE2",
+ 		init_chipset:	init_chipset_nforce,
+ 		init_iops:	NULL,
+ 		init_hwif:	init_hwif_nforce,
+ 		init_dma:	init_dma_nforce,
+ 		channels:	2,
+ 		autodma:	AUTODMA,
+ 		enablebits:	{{0x50,0x01,0x01}, {0x50,0x02,0x02}},
+ 		bootable:	ON_BOARD,
+ 		extra:		0,
  	}
  };
Only in ../linux-2.4.20/drivers/net/wan: hdlc.c
diff -r -C 2 ../linux-2.4.20/include/linux/pci_ids.h ./include/linux/pci_ids.h
*** ../linux-2.4.20/include/linux/pci_ids.h	Thu Dec 12 14:22:55 2002
--- ./include/linux/pci_ids.h	Thu Dec 12 13:38:56 2002
***************
*** 914,917 ****
--- 914,918 ----
  #define PCI_DEVICE_ID_NVIDIA_IGEFORCE2		0x01a0
  #define PCI_DEVICE_ID_NVIDIA_NFORCE_IDE		0x01bc
+ #define PCI_DEVICE_ID_NVIDIA_NFORCE2_IDE	0x0065
  #define PCI_DEVICE_ID_NVIDIA_GEFORCE3		0x0200
  #define PCI_DEVICE_ID_NVIDIA_GEFORCE3_1		0x0201

--jI8keyz6grp/JLjh--
