Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267937AbRHMUXJ>; Mon, 13 Aug 2001 16:23:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267923AbRHMUXA>; Mon, 13 Aug 2001 16:23:00 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:54537 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S267937AbRHMUWv>; Mon, 13 Aug 2001 16:22:51 -0400
Subject: Re: PCMCIA PCI interrupt problem with Medion 9888 / TI 1131
To: Juergen.Stuber@loria.fr (Juergen Stuber)
Date: Mon, 13 Aug 2001 21:24:57 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <871ymf6aa9.fsf@loria.fr> from "Juergen Stuber" at Aug 13, 2001 09:15:58 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15WOGf-0008AJ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Hi,
> 
> I have a problem getting 2.4.x kernels running, it seems that
> there is a problem with PCI interrupt allocation.
> The machine is a Medion 9888 (Aldi notebook of christmas 1998),
> which is basically a Twinhead EX2.
> The following is copied by hand from a photo
> (it didn't make it to the log for obvious reasons):
> 
> Starting PCMCIA services: modulesLinux PCMCIA Card Services 3.1.28
>   kernel build: 2.4.8 #1 Sun Aug 12 19:06:35 CEST 2001
>   options: [pci] [cardbus] [apm]
> Intel PCIC probe: <6>PCI: Assigned IRQ 13 for device 00:0a.0
> PCI: Assigned IRQ 14 for device 00:0a.1
> 
>   TI 1131 rev 01 PCI-to-CardBus at slot 00:0a, mem 0x10000000=20
>     host opts [0]: [ring] [clkrun irq 12] [pci + serial irq] [pci irq 1=
> 3] [lat 168/176] [bus 1/4]
>     host opts [1]: [ring] [clkrun irq 12] [pci + serial irq] [pci irq 1=
> 4] [lat 168/176] [bus 5/8]
>     PCI irq test 13 failed
>     ISA irqs (scanned) =3D 3,4,7,10,11,15 status change on irq 15
>  cardmgr.
> 
> ide_dmaproc: chipset supported ide_dma_lostirq func only: 13
> hda: lost interrupt
> ide_dmaproc: chipset supported ide_dma_lostirq func only: 13
> hda: lost interrupt
> ide_dmaproc: chipset supported ide_dma_lostirq func only: 13
> hda: lost interrupt
> 
> 
> The problem exists at least since 2.4.6 and pcmcia-cs-3.1.26.
> and it for the yenta driver in the kernel as well as the i82365
> in pcmcia-cs.
> 
> It works for 2.2.19 with pcmcia-cs 3.1.x, there the interrupts
> for the slots are disabled:
> 
> Aug 13 13:05:32 localhost kernel: Linux PCMCIA Card Services 3.1.26
> Aug 13 13:05:32 localhost kernel:   kernel build: 2.2.19 unknown
> Aug 13 13:05:32 localhost kernel:   options:  [pci] [cardbus] [apm]
> Aug 13 13:05:32 localhost kernel: PCI routing table version 1.0 at 0xfd=
> f90
> Aug 13 13:05:32 localhost kernel: Intel PCIC probe:=20
> Aug 13 13:05:32 localhost kernel:   TI 1131 rev 01 PCI-to-CardBus at sl=
> ot 00:0a, mem 0x68000000
> Aug 13 13:05:32 localhost kernel:     host opts [0]: [ring] [clkrun irq=
>  12] [pci + serial irq] [no pci irq] [lat 168/176] [bus 32/34]
> Aug 13 13:05:32 localhost kernel:     host opts [1]: [ring] [clkrun irq=
>  12] [pci + serial irq] [no pci irq] [lat 168/176] [bus 35/37]
> Aug 13 13:05:32 localhost kernel:     ISA irqs (scanned) =3D 3,4,7,10,1=
> 1,15 polling interval =3D 1000 ms
> Aug 13 13:05:32 localhost cardmgr[198]: starting, version is 3.1.28
> Aug 13 13:05:32 localhost cardmgr[198]: watching 2 sockets
> Aug 13 13:05:32 localhost cardmgr[198]: Card Services release does not =
> match
> Aug 13 13:05:32 localhost cardmgr[198]: initializing socket 1
> Aug 13 13:05:32 localhost kernel: cs: memory probe 0xa0000000-0xa0fffff=
> f: clean.
> Aug 13 13:05:32 localhost cardmgr[198]: socket 1: D-Link DE-660 Etherne=
> t
> Aug 13 13:05:33 localhost cardmgr[198]: executing: 'modprobe 8390'
> Aug 13 13:05:33 localhost cardmgr[198]: executing: 'modprobe pcnet_cs'
> Aug 13 13:05:33 localhost kernel: cs: IO port probe 0x0100-0x04ff: excl=
> uding 0x300-0x307 0x378-0x37f 0x388-0x38f 0x398-0x39f 0x4d0-0x4d7
> Aug 13 13:05:33 localhost kernel: cs: IO port probe 0x0308-0x0377: clea=
> n.
> Aug 13 13:05:33 localhost kernel: cs: IO port probe 0x0380-0x0387: clea=
> n.
> Aug 13 13:05:33 localhost kernel: cs: IO port probe 0x0390-0x0397: clea=
> n.
> Aug 13 13:05:33 localhost kernel: cs: IO port probe 0x03a0-0x04cf: clea=
> n.
> Aug 13 13:05:33 localhost kernel: cs: IO port probe 0x04d8-0x04ff: clea=
> n.
> Aug 13 13:05:33 localhost kernel: cs: IO port probe 0x0800-0x08ff: excl=
> uding 0x800-0x807
> Aug 13 13:05:33 localhost kernel: cs: IO port probe 0x0a00-0x0aff: clea=
> n.
> Aug 13 13:05:33 localhost kernel: cs: IO port probe 0x0c00-0x0cff: excl=
> uding 0xcf8-0xcff
> Aug 13 13:05:33 localhost kernel: eth0: NE2000 Compatible: io 0x320, ir=
> q 10, hw_addr 00:80:C8:8F:08:60
> 
> I tried to disable the interrupts using module options,
> but this seems to be possible only for the card change interrupt,
> and that one is not the problem.
> 
> Any hints?
> 
> J=FCrgen
> 
> --=20
> J=FCrgen Stuber <stuber@loria.fr>
> http://www.loria.fr/~stuber/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
>  in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

