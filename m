Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270386AbRIFLdS>; Thu, 6 Sep 2001 07:33:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272450AbRIFLdJ>; Thu, 6 Sep 2001 07:33:09 -0400
Received: from NS.iNES.RO ([193.230.220.1]:26318 "EHLO smtp.ines.ro")
	by vger.kernel.org with ESMTP id <S270386AbRIFLc5>;
	Thu, 6 Sep 2001 07:32:57 -0400
Subject: Re: PNPBIOS: warning: >= 16 resources, overflow?
From: Dumitru Ciobarcianu <cioby@lnx.ro>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.13.99+cvs.2001.09.05.07.08 (Preview Release)
Date: 06 Sep 2001 14:32:46 +0300
Message-Id: <999775966.1963.7.camel@LNX.iNES.RO>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On J, 2001-09-06 at 11:42, Gerd Knorr wrote:
> lspnp (comes with pcmcia-cs) would be more intresting.  The pnpbios code
> fills a "struct pci_dev" for each device reported by the pnpbios, and it
> looks like your portable has one device with alot ressources, so the
> ressources array in struct pci_dev can't hold them all.  There is a
> #define in include/linux/pci.h for the array size ...
> 
>   Gerd
> 

Ok, I'll try to modify that array.

Here is the output of lspnp -vvv 

[root@LNX cioby]# lspnp -vvv >lspnp
00 PNP0c02 system peripheral: other
    flags: [no disable] [no config] [static]
    allocated resources:
	io 0x0080-0x0080 [16-bit decode]
	mem 0xfff80000-0xffffffff [8 bit] [r/o]

01 PNP0c01 memory controller: RAM
    flags: [no disable] [no config] [static]
    allocated resources:
	mem 0x00000000-0x0009ffff [8 bit] [r/w]
	mem 0x000e8000-0x000fffff [8 bit] [r/o] [shadow] [rom]
	mem 0x00100000-0x080fffff [8 bit] [r/o]

02 PNP0200 system peripheral: DMA controller
    flags: [no disable] [no config] [static]
    allocated resources:
	io 0x0000-0x000f [16-bit decode]
	io 0x0081-0x008f [16-bit decode]
	io 0x00c0-0x00df [16-bit decode]
	dma 4 [8/16 bit] [compat]

03 PNP0000 system peripheral: programmable interrupt controller
    flags: [no disable] [no config] [static]
    allocated resources:
	io 0x0020-0x0021 [16-bit decode]
	io 0x00a0-0x00a1 [16-bit decode]
	irq 2 [high edge]

04 PNP0100 system peripheral: system timer
    flags: [no disable] [no config] [static]
    allocated resources:
	io 0x0040-0x0043 [16-bit decode]
	irq 0 [high edge]

05 PNP0b00 system peripheral: real time clock
    flags: [no disable] [no config] [static]
    allocated resources:
	io 0x0070-0x0071 [16-bit decode]
	irq 8 [high edge]

06 PNP0303 input device: keyboard
    flags: [no disable] [no config] [static]
    allocated resources:
	io 0x0060-0x0060 [16-bit decode]
	io 0x0064-0x0064 [16-bit decode]
	irq 1 [high edge]

07 PNP0c04 reserved: other
    flags: [no disable] [no config] [static]
    allocated resources:
	io 0x00f0-0x00ff [16-bit decode]
	irq 13 [high edge]

08 PNP0800 multimedia controller: audio
    flags: [no disable] [no config] [static]
    allocated resources:
	io 0x0061-0x0061 [16-bit decode]

09 PNP0a03 bridge controller: PCI
    flags: [no disable] [no config] [static]
    allocated resources:
	io 0x0cf8-0x0cff [16-bit decode]

0a PNP0c02 bridge controller: ISA
    flags: [no disable] [no config] [static]
    allocated resources:
	io 0x04d0-0x04d1 [16-bit decode]
	io 0x1000-0x103f [16-bit decode]
	io 0x1040-0x104f [16-bit decode]
	io 0x0010-0x0018 [16-bit decode]
	io 0x001f-0x001f [16-bit decode]
	io 0x0024-0x0025 [16-bit decode]
	io 0x0028-0x0029 [16-bit decode]
	io 0x002c-0x002d [16-bit decode]
	io 0x0030-0x0031 [16-bit decode]
	io 0x0034-0x0035 [16-bit decode]
	io 0x0038-0x0039 [16-bit decode]
	io 0x003c-0x003d [16-bit decode]
	io 0x0050-0x0052 [16-bit decode]
	io 0x0072-0x0077 [16-bit decode]
	io 0x0090-0x009f [16-bit decode]
	io 0x00a4-0x00a5 [16-bit decode]
	io 0x00a8-0x00a9 [16-bit decode]
	io 0x00ac-0x00ad [16-bit decode]
	io 0x00b0-0x00bd [16-bit decode]

0b PNP0c02 memory controller: RAM
    flags: [no disable] [no config] [static]
    allocated resources:
	mem 0x000e4000-0x000e7fff [8 bit] [r/w]

0c PNP0c02 memory controller: RAM
    flags: [no disable] [no config] [static]
    allocated resources:
	mem disabled [8 bit] [r/o] [shadow]
	mem disabled [8 bit] [r/o] [shadow]
	mem disabled [8 bit] [r/o] [shadow]
	mem disabled [8 bit] [r/o] [shadow]
	mem disabled [8 bit] [r/o] [shadow]
	mem disabled [8 bit] [r/o] [shadow]

11 PNP0f13 input device: mouse
    flags: [input] [dynamic]
    allocated resources:
	irq 12 [high edge]
    possible resources:
	irq 12 [high edge]

15 PNP0700 mass storage device: floppy
    flags: [bootable] [dynamic]
    allocated resources:
	io 0x03f0-0x03f5 [16-bit decode]
	io 0x03f7-0x03f7 [16-bit decode]
	irq 6 [high edge]
	dma 2 [8 bit] [compat]
    possible resources:
	[start dep fn]
	io 0x03f0-0x03f5 [16-bit decode]
	io 0x03f7-0x03f7 [16-bit decode]
	irq 6 [high edge]
	dma 2 [8 bit] [compat]
	[start dep fn]
	io 0x0370-0x0375 [16-bit decode]
	io 0x0377-0x0377 [16-bit decode]
	irq 6 [high edge]
	dma 2 [8 bit] [compat]
	[end dep fn]

17 PNP0400 communications device: AT parallel port
    flags: [dynamic]
    allocated resources:
	io 0x0378-0x037f [16-bit decode]
	irq 7 [high edge]
    possible resources:
	[start dep fn]
	io 0x0378-0x037f [16-bit decode]
	irq 7 [high edge]
	[start dep fn]
	io 0x0278-0x027f [16-bit decode]
	irq 7 [high edge]
	[start dep fn]
	io 0x03bc-0x03bf [16-bit decode]
	irq 7 [high edge]
	[start dep fn]
	io 0x0378-0x037f [16-bit decode]
	irq 5 [high edge]
	[start dep fn]
	io 0x0278-0x027f [16-bit decode]
	irq 5 [high edge]
	[start dep fn]
	io 0x03bc-0x03bf [16-bit decode]
	irq 5 [high edge]
	[end dep fn]




