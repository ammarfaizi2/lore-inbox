Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270464AbRIFMMo>; Thu, 6 Sep 2001 08:12:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270467AbRIFMMe>; Thu, 6 Sep 2001 08:12:34 -0400
Received: from NS.iNES.RO ([193.230.220.1]:40405 "EHLO smtp.ines.ro")
	by vger.kernel.org with ESMTP id <S270464AbRIFMMb>;
	Thu, 6 Sep 2001 08:12:31 -0400
Subject: Re: PNPBIOS: warning: >= 16 resources, overflow? - SOLVED
From: Dumitru Ciobarcianu <cioby@lnx.ro>
To: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <999775966.1963.7.camel@LNX.iNES.RO>
In-Reply-To: <999775966.1963.7.camel@LNX.iNES.RO>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.13.99+cvs.2001.09.05.07.08 (Preview Release)
Date: 06 Sep 2001 15:12:20 +0300
Message-Id: <999778340.1175.8.camel@LNX.iNES.RO>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




On J, 2001-09-06 at 14:32, Dumitru Ciobarcianu wrote:
> On J, 2001-09-06 at 11:42, Gerd Knorr wrote:
> > lspnp (comes with pcmcia-cs) would be more intresting.  The pnpbios code
> > fills a "struct pci_dev" for each device reported by the pnpbios, and it
> > looks like your portable has one device with alot ressources, so the
> > ressources array in struct pci_dev can't hold them all.  There is a
> > #define in include/linux/pci.h for the array size ...
> > 
> >   Gerd
> > 

That solved the warning.

The current pnp boot messages:

PnP: PNP BIOS installation structure at 0xc00f7470
PnP: PNP BIOS version 1.0, entry at f0000:a905, dseg at 400
PnP: 15 devices detected total
PNPBIOS: request ports [PNP0c01]:
PNPBIOS: request ports [PNP0c02]: 0x4d0-0x4d2 0x1000-0x1040
0x1040-0x1050
PNPBIOS: request ports [PNP0c02]:
PNPBIOS: request ports [PNP0c02]:

What is strange is that PNPBIOS reports 15 devices detected, and lspnp
detects 18 (00 - 17):

[root@LNX /root]# lspnp
00 PNP0c02 system peripheral: other
01 PNP0c01 memory controller: RAM
02 PNP0200 system peripheral: DMA controller
03 PNP0000 system peripheral: programmable interrupt controller
04 PNP0100 system peripheral: system timer
05 PNP0b00 system peripheral: real time clock
06 PNP0303 input device: keyboard
07 PNP0c04 reserved: other
08 PNP0800 multimedia controller: audio
09 PNP0a03 bridge controller: PCI
0a PNP0c02 bridge controller: ISA
0b PNP0c02 memory controller: RAM
0c PNP0c02 memory controller: RAM
11 PNP0f13 input device: mouse
15 PNP0700 mass storage device: floppy
17 PNP0400 communications device: AT parallel port


Trivial patch below (for the warning):

--- pci-orig.h	Thu Sep  6 14:59:00 2001
+++ pci.h	Thu Sep  6 15:09:45 2001
@@ -317,7 +317,7 @@
 #define DEVICE_COUNT_COMPATIBLE	4
 #define DEVICE_COUNT_IRQ	2
 #define DEVICE_COUNT_DMA	2
-#define DEVICE_COUNT_RESOURCE	16
+#define DEVICE_COUNT_RESOURCE	32
 
 #define PCI_ANY_ID (~0)
 



//Cioby


