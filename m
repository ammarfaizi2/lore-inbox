Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261506AbVFMWIJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261506AbVFMWIJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 18:08:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261505AbVFMWGx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 18:06:53 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:17837 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S261503AbVFMWFP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 18:05:15 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Markus Becker <mab@comnets.uni-bremen.de>
Subject: Re: Yenta TI. PCI interrupt probing fails. TI PCI1420. Unknown device.
Date: Mon, 13 Jun 2005 16:05:05 -0600
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org, Yu Ran <yuran@uni-bremen.de>
References: <Pine.LNX.4.21.0506131629440.32627-100000@bugs.comnets.uni-bremen.de>
In-Reply-To: <Pine.LNX.4.21.0506131629440.32627-100000@bugs.comnets.uni-bremen.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506131605.05505.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 June 2005 9:03 am, Markus Becker wrote:
> we're having problems with a special device 'Em104P-PCM/2' which is a
> PCMCIA stackable card with PC/104-form factor. It uses a TI PCI1420 chip.
> 
> It seems that the probing of PCI interrupts fails. We tried 2.4.27 and
> 2.6.11 debian stock kernels with several boot options such as irq_mode=0
> and p2cclk=0.

Does booting with "pci=routeirq" make any difference?  I've had a
couple reports of PCMCIA IRQ problems related to that.  Unfortunately
I don't understand enough about PCMCIA to suggest more than just
trying this.

> *****dmesg*****
> [...]
> Linux Kernel Card Services
>   options:  [pci] [cardbus] [pm]
> PCI: Found IRQ 5 for device 0000:00:0b.0
> PCI: Sharing IRQ 5 with 0000:00:07.2
> PCI: Sharing IRQ 5 with 0000:00:07.3
> Yenta: CardBus bridge found at 0000:00:0b.0 [3412:7856]
> Yenta: Enabling burst memory read transactions
> Yenta: Using CSCINT to route CSC interrupts to PCI
> Yenta: Routing CardBus interrupts to PCI
> Yenta TI: socket 0000:00:0b.0, mfunc 0x00001000, devctl 0x62
> Yenta TI: socket 0000:00:0b.0 probing PCI interrupt failed, trying to fix
> Yenta TI: socket 0000:00:0b.0 no PCI interrupts. Fish. Please report.
> Yenta: ISA IRQ mask 0x0000, PCI irq 0
> Socket status: 30000006
> PCI: Found IRQ 10 for device 0000:00:0b.1
> PCI: Sharing IRQ 10 with 0000:00:08.0
> PCI: Sharing IRQ 10 with 0000:00:0c.0
> Yenta: CardBus bridge found at 0000:00:0b.1 [3412:7856]
> Yenta: Using CSCINT to route CSC interrupts to PCI
> Yenta: Routing CardBus interrupts to PCI
> Yenta TI: socket 0000:00:0b.1, mfunc 0x00001000, devctl 0x62
> Yenta TI: socket 0000:00:0b.1 probing PCI interrupt failed, trying to fix
> Yenta TI: socket 0000:00:0b.1 no PCI interrupts. Fish. Please report.
> Yenta: ISA IRQ mask 0x0000, PCI irq 0
> Socket status: 30000006
> [...]
> 
> 
> *****lspci*****
> [...]
> 0000:00:0b.0 CardBus bridge: Texas Instruments PCI1420
> 	Subsystem: Unknown device 3412:7856
> 	Flags: bus master, medium devsel, latency 168, IRQ 5
> 	Memory at e4100000 (32-bit, non-prefetchable) [size=4K]
> 	Bus: primary=00, secondary=01, subordinate=04, sec-latency=176
> 	Memory window 0: e4101000-e4102000 (prefetchable)
> 	Memory window 1: e4103000-e4104000
> 	I/O window 0: 0000cc00-0000d003
> 	I/O window 1: 0000d400-0000d803
> 	16-bit legacy interface ports at 0001
> 
> 0000:00:0b.1 CardBus bridge: Texas Instruments PCI1420
> 	Subsystem: Unknown device 3412:7856
> 	Flags: bus master, medium devsel, latency 168, IRQ 10
> 	Memory at e4105000 (32-bit, non-prefetchable) [size=4K]
> 	Bus: primary=00, secondary=05, subordinate=08, sec-latency=176
> 	Memory window 0: e4106000-e4107000 (prefetchable)
> 	Memory window 1: e4108000-e4109000
> 	I/O window 0: 0000dc00-0000e003
> 	I/O window 1: 0000e400-0000e803
> 	16-bit legacy interface ports at 0001
> [...]
> 
> *****/proc/interrupts*****
>            CPU0       
>   0:     388035          XT-PIC  timer
>   1:       1261          XT-PIC  i8042
>   2:          0          XT-PIC  cascade
>   5:          0          XT-PIC  uhci_hcd, uhci_hcd
>   7:          0          XT-PIC  parport0
>  10:        112          XT-PIC  eth0
>  12:          0          XT-PIC  via82cxxx
>  15:     104336          XT-PIC  ide1
> NMI:          0 
> LOC:          0 
> ERR:          0
> MIS:          0
> 
> *****uname -a*****
> Linux pc104-1 2.6.11-1-386 #1 Fri May 20 06:15:52 UTC 2005 i686 GNU/Linux
> 
> *****lsmod*****
> Module                  Size  Used by
> [...]
> pcmcia                 23432  4 
> yenta_socket           20616  2 
> rsrc_nonstatic          9856  1 yenta_socket
> pcmcia_core            44848  3 pcmcia,yenta_socket,rsrc_nonstatic
> [...]
> 
> *****cardctl*****
> Socket 0:
>   no card
> Socket 1:
>   no card
> 
> Please cc me, when replying. Thanks for any hints in advance.
> 
> Best regards,
> Markus Becker
> 
> ---
> Dipl.-Ing. Markus Becker   | web: http://www.comnets.uni-bremen.de/~mab/
> Communication Networks     | mailto: mab@comnets.uni-bremen.de
> University Bremen, Germany | telephone: +49 421 218 2287
> 
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
