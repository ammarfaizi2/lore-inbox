Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318305AbSGYCrm>; Wed, 24 Jul 2002 22:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318306AbSGYCrm>; Wed, 24 Jul 2002 22:47:42 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:46599 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S318305AbSGYCrl>; Wed, 24 Jul 2002 22:47:41 -0400
Date: Wed, 24 Jul 2002 22:57:33 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Daniel Tschan <tschan+linux-kernel@devzone.ch>
Cc: linux-kernel@vger.kernel.org, <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.4.19-rc3 incorrectly detects PDC20276 in ATA mode as raid
 controller
In-Reply-To: <32816.80.218.9.155.1027506858.squirrel@www.devzone.ch>
Message-ID: <Pine.LNX.4.44.0207242256450.31740-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 24 Jul 2002, Daniel Tschan wrote:

> This works, thank you. This option didn't get my attention at first
> because its named Special FastTrak Feature in xconfig. Perhaps this should
> be changed.

Yes. The behaviour should be as previous kernels (work with the kernel
driver by default).

The following patch should fix it.

diff -Naur -X /home/marcelo/lib/dontdiff linux.orig/drivers/ide/ide-pci.c linux/drivers/ide/ide-pci.c
--- linux.orig/drivers/ide/ide-pci.c	2002-07-24 02:50:59.000000000 +0000
+++ linux/drivers/ide/ide-pci.c	2002-07-24 02:51:43.000000000 +0000
@@ -402,7 +402,7 @@
 	{DEVID_VIA_IDE,	"VIA_IDE",	NULL,		NULL,		NULL,		NULL,		{{0x00,0x00,0x00}, {0x00,0x00,0x00}},	ON_BOARD,	0 },
 	{DEVID_MR_IDE,	"VP_IDE",	PCI_VIA82CXXX,	ATA66_VIA82CXXX,INIT_VIA82CXXX,	DMA_VIA82CXXX,	{{0x40,0x02,0x02}, {0x40,0x01,0x01}}, 	ON_BOARD,	0 },
 	{DEVID_VP_IDE,	"VP_IDE",	PCI_VIA82CXXX,	ATA66_VIA82CXXX,INIT_VIA82CXXX,	DMA_VIA82CXXX,	{{0x40,0x02,0x02}, {0x40,0x01,0x01}}, 	ON_BOARD,	0 },
-#ifdef CONFIG_PDC202XX_FORCE
+#ifndef CONFIG_PDC202XX_FORCE
         {DEVID_PDC20246,"PDC20246",	PCI_PDC202XX,	NULL,		INIT_PDC202XX,	NULL,		{{0x00,0x00,0x00}, {0x00,0x00,0x00}},	OFF_BOARD,	16 },
         {DEVID_PDC20262,"PDC20262",	PCI_PDC202XX,	ATA66_PDC202XX,	INIT_PDC202XX,	NULL,		{{0x00,0x00,0x00}, {0x00,0x00,0x00}},	OFF_BOARD,	48 },
         {DEVID_PDC20265,"PDC20265",	PCI_PDC202XX,	ATA66_PDC202XX,	INIT_PDC202XX,	NULL,		{{0x00,0x00,0x00}, {0x00,0x00,0x00}},	ON_BOARD,	48 },
@@ -669,7 +669,7 @@
 	 */
 	pciirq = dev->irq;

-#ifndef CONFIG_PDC202XX_FORCE
+#ifdef CONFIG_PDC202XX_FORCE
 	if (dev->class >> 8 == PCI_CLASS_STORAGE_RAID) {
 		/*
 		 * By rights we want to ignore Promise FastTrak and SuperTrak

