Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751068AbWGaOvb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751068AbWGaOvb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 10:51:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751136AbWGaOvb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 10:51:31 -0400
Received: from smtp.ono.com ([62.42.230.12]:56007 "EHLO resmta04.ono.com")
	by vger.kernel.org with ESMTP id S1751068AbWGaOva (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 10:51:30 -0400
Date: Mon, 31 Jul 2006 16:51:22 +0200
From: "J.A. =?UTF-8?B?TWFnYWxsw7Nu?=" <jamagallon@ono.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Linux-Kernel, " <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.18-rc1-mm2] libata: DMA speed too slow for cdrecord
Message-ID: <20060731165122.08ac464e@werewolf.auna.net>
In-Reply-To: <1154344141.7230.18.camel@localhost.localdomain>
References: <20060729235431.322ea6d3@werewolf.auna.net>
	<1154344141.7230.18.camel@localhost.localdomain>
X-Mailer: Sylpheed-Claws 2.4.0 (GTK+ 2.10.1; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jul 2006 12:09:01 +0100, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> Ar Sad, 2006-07-29 am 23:54 +0200, ysgrifennodd J.A. Magallón:
> > ata1: PATA max UDMA/100 cmd 0x1F0 ctl 0x3F6 bmdma 0xF000 irq 14
> 
> Chip configuration reports OK
> > scsi0 : ata_piix
> > ata1.00: ATAPI, max UDMA/33
> > ata1.01: ATAPI, max MWDMA0, CDB intr
> > ata1.00: configured for PIO3
> > ata1.01: configured for PIO3
> 
> Your tree appears to have the old speed setting code in it not the new
> speed setting code. As a result of this it tries to set both to MWDMA0
> which isn't available on the ICH chips and so falls back to PIO3.
> 

Oops, sorry for the mix...
I was posting 2 separate bug reports, and mixed the relase numbers.
Where this really happens is on -rc1-mm2.
As you say, -rc1-mm2 gives:

ata_piix 0000:00:1f.1: version 2.00ac6
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1f.1 to 64
ata1: PATA max UDMA/100 cmd 0x1F0 ctl 0x3F6 bmdma 0xF000 irq 14
scsi0 : ata_piix
ata1.00: ATAPI, max UDMA/33
ata1.01: ATAPI, max MWDMA0, CDB intr
ata1.00: configured for PIO3
ata1.01: configured for PIO3

whereas -rc2-mm1 says:

ata_piix 0000:00:1f.1: version 2.00ac6
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1f.1 to 64
ata1: PATA max UDMA/100 cmd 0x1F0 ctl 0x3F6 bmdma 0xF000 irq 14
scsi0 : ata_piix
ata1.00: ATAPI, max UDMA/33 
ata1.01: ATAPI, max MWDMA0, CDB intr
ata1.00: configured for UDMA/33
ata1.01: configured for PIO3

So I see that rc2-mm1 should work. But my problem is the other bug report,
this latest kernel does not show the second ide channel on the host.

What file is the new speed selection code in ? libata-core.c, ata-piix.c ?
I can try to get the old kernel patched...

Or is there any patch available ?

I think i will have to unplug the zip drive till this is resolved ;).

TIA

--
J.A. Magallon <jamagallon()ono!com>     \               Software is like sex:
                                         \         It's better when it's free
Mandriva Linux release 2007.0 (Cooker) for i586
Linux 2.6.17-jam04 (gcc 4.1.1 20060724 (prerelease) (4.1.1-3mdk)) #1 SMP PREEMPT
