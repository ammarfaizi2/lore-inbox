Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262116AbRFGRPP>; Thu, 7 Jun 2001 13:15:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262168AbRFGRPF>; Thu, 7 Jun 2001 13:15:05 -0400
Received: from dubb05h09-0.dplanet.ch ([212.35.36.9]:48656 "EHLO
	dubb05h09-0.dplanet.ch") by vger.kernel.org with ESMTP
	id <S262116AbRFGROu>; Thu, 7 Jun 2001 13:14:50 -0400
Message-Id: <200106071714.TAA21695@dubb05h09-0.dplanet.ch>
Date: Thu, 07 Jun 2001 19:14:46 +0200
From: Andreas Tscharner <starfire@dplanet.ch>
To: "Linux Kernel Mailinglist" <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.4.5 ISA DMA hang on ALI 15x3
Reply-To: starfire@dplanet.ch
X-Mailer: Spruce 0.7.4 for X11 w/smtpio 0.8.2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello World,

This little patch enables the workaround for the ISA DMA bug on ALi15x3
chipsets with the PCI-ISA bridge.

CHANGES:
Changed file: $KERNELROOT/drivers/pci/quirks.c

There is a DMA bug in the PCI-ISA host bridge of the ALi15x3 chipset.
The use of this DMA causes a hang.

The OSS and ALSA modules for the OPL3/SA2 and OPL3/SAx sound chip use
this DMA which causes a complete hang.

This combination of chipset and soundchip is found in the whole Acer
Extensa laptop series.

The patch adds the chipset mentioned above to the main table of quirks.

The patch was originally written by Angelo Di Filippo
<adifilip@ubiquity.it> as a patch for Kernel 2.3.45. I adapted it to
Kernel 2.4.5


PATCH:
--- drivers/pci/quirks.c.orig	Thu May 31 22:32:12 2001
+++ drivers/pci/quirks.c	Thu May 31 22:36:08 2001
@@ -344,6 +344,7 @@
 	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C586_0,	quirk_isa_dma_hangs },
 	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C596,	quirk_isa_dma_hangs },
 	{ PCI_FIXUP_FINAL,      PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_82371SB_0,  quirk_isa_dma_hangs },
+	{ PCI_FIXUP_FINAL,      PCI_VENDOR_ID_AL,       PCI_DEVICE_ID_AL_M1533,         quirk_isa_dma_hangs },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_S3,	PCI_DEVICE_ID_S3_868,		quirk_s3_64M },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_S3,	PCI_DEVICE_ID_S3_968,		quirk_s3_64M },
 	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_INTEL, 	PCI_DEVICE_ID_INTEL_82437, 	quirk_triton }, 


Have a nice day.

Regards
	Andreas
-- 
Andreas Tscharner                                     starfire@dplanet.ch
-------------------------------------------------------------------------
"Programming today is a race between software engineers striving to build 
bigger and better idiot-proof programs, and the Universe trying to produce 
bigger and better idiots. So far, the Universe is winning." -- Rich Cook 

