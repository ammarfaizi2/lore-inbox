Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262810AbRE0Q2u>; Sun, 27 May 2001 12:28:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262813AbRE0Q2k>; Sun, 27 May 2001 12:28:40 -0400
Received: from [213.128.193.148] ([213.128.193.148]:23054 "EHLO linuxhacker.ru")
	by vger.kernel.org with ESMTP id <S262810AbRE0Q2g>;
	Sun, 27 May 2001 12:28:36 -0400
Date: Sun, 27 May 2001 20:28:14 +0400
From: Oleg Drokin <green@linuxhacker.ru>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: vojtech@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: VIA IDE no go with 2.4.5-ac1
Message-ID: <20010527202814.A23079@linuxhacker.ru>
In-Reply-To: <20010527144337.A15235@linuxhacker.ru> <E1543FE-0001zX-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E1543FE-0001zX-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sun, May 27, 2001 at 05:18:20PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Sun, May 27, 2001 at 05:18:20PM +0100, Alan Cox wrote:
> >   Vanilla 2.4.5 boots ok, but 2.4.5-ac1 finishes kernel initialisation and
> >   starts to print "hda: lost interrupt", I guess this is related to VIA IDE
> >   updates in AC kernels. Config for vanilla and AC kernel is the same.
> >   Here are the kernel logs from 2.4.5 and 2.4.5-ac1 (collected with serial
> > ACPI: Core Subsystem version [20010208]
> > ACPI: Subsystem enabled
> > ACPI: Not using ACPI idle
> > ACPI: System firmware supports: S0 S1 S4 S5
> > hda: lost interrupt
> > hda: lost interrupt
> Does this still happen if you build without ACPI support. Also does
> 'noapic' have any impact ?
I will try this and report.
I received this patch from Carlos E Gorges <carlos@techlinux.com.br>,
that allows my box to boot, but DMA is not enabled by default
(and needs to be explicitly enabled by hdparm -d1 /dev/hda) regardless of
what is written at boot time.

--- drivers/ide/via82cxxx.c.orig	Sun May 27 08:10:47 2001
+++ drivers/ide/via82cxxx.c	Sun May 27 08:11:13 2001
@@ -105,7 +105,7 @@
 	{ "vt8233",	PCI_DEVICE_ID_VIA_8233_0,   0x00, 0x2f, VIA_UDMA_100 },
 	{ "vt8231",	PCI_DEVICE_ID_VIA_8231,     0x00, 0x2f, VIA_UDMA_66 },
 #endif
-	{ "vt82c686b",	PCI_DEVICE_ID_VIA_82C686,   0x40, 0x4f, VIA_UDMA_100 | VIA_BAD_PIO },
+	{ "vt82c686b",	PCI_DEVICE_ID_VIA_82C686,   0x40, 0x4f, VIA_UDMA_100 },
 	{ "vt82c686a",	PCI_DEVICE_ID_VIA_82C686,   0x10, 0x2f, VIA_UDMA_66 },
 	{ "vt82c686",	PCI_DEVICE_ID_VIA_82C686,   0x00, 0x0f, VIA_UDMA_33 | VIA_BAD_CLK66 },
 	{ "vt82c596b",	PCI_DEVICE_ID_VIA_82C596,   0x10, 0x2f, VIA_UDMA_66 },

Bye,
    Oleg
