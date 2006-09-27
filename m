Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964862AbWI0Eae@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964862AbWI0Eae (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 00:30:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964863AbWI0Eae
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 00:30:34 -0400
Received: from mail.kroah.org ([69.55.234.183]:10628 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964862AbWI0Ead (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 00:30:33 -0400
Date: Tue, 26 Sep 2006 20:29:21 -0700
From: Greg KH <gregkh@suse.de>
To: Valdis.Kletnieks@vt.edu
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc7-mm1  - gregkh-driver-pcmcia-device.patch breaks orinoco card
Message-ID: <20060927032921.GI31633@suse.de>
References: <20060919012848.4482666d.akpm@osdl.org> <200609231103.k8NB3RiF004703@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200609231103.k8NB3RiF004703@turing-police.cc.vt.edu>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 23, 2006 at 07:03:26AM -0400, Valdis.Kletnieks@vt.edu wrote:
> orinoco 0.15 (David Gibson <hermes@gibson.dropbear.id.au>, Pavel Roskin <proski@gnu.org>, et al)
> orinoco_cs 0.15 (David Gibson <hermes@gibson.dropbear.id.au>, Pavel Roskin <proski@gnu.org>, et al)
> pcmcia: request for exclusive IRQ could not be fulfilled.
> pcmcia: the driver needs updating to supported shared IRQ lines.
> cs: IO port probe 0x100-0x3af: excluding 0x370-0x37f
> cs: IO port probe 0x3e0-0x4ff: clean.
> cs: IO port probe 0x820-0x8ff: clean.
> cs: IO port probe 0xc00-0xcf7: clean.
> cs: IO port probe 0xa00-0xaff: clean.
> cs: IO port probe 0x100-0x3af: excluding 0x370-0x37f
> cs: IO port probe 0x3e0-0x4ff: clean.
> cs: IO port probe 0x820-0x8ff: clean.
> cs: IO port probe 0xc00-0xcf7: clean.
> cs: IO port probe 0xa00-0xaff: clean.
> cs: IO port probe 0x100-0x3af: excluding 0x370-0x37f
> cs: IO port probe 0x3e0-0x4ff: clean.
> cs: IO port probe 0x820-0x8ff: clean.
> cs: IO port probe 0xc00-0xcf7: clean.
> cs: IO port probe 0xa00-0xaff: clean.
> eth2: Hardware identity 0005:0004:0005:0000
> eth2: Station identity  001f:0001:0008:000a
> eth2: Firmware determined as Lucent/Agere 8.10
> eth2: Ad-hoc demo mode supported
> eth2: IEEE standard IBSS ad-hoc mode supported
> eth2: WEP supported, 104-bit key
> eth2: MAC address 00:02:2D:5C:11:48
> eth2: Station name "HERMES I"
> eth2: ready
> eth2: orinoco_cs at 2.0, irq 11, io 0xe100-0xe13f
> [rename_device:1295]: Changing netdevice name from [eth2] to [eth5]
> Non-volatile memory driver v1.2
> 
> and under -rc7-mm1, I see:
> 
> pccard: CardBus card inserted into slot 0
> PCI: Enabling device 0000:03:00.0 (0000 -> 0003)
> ACPI: PCI Interrupt 0000:03:00.0[A] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
> PCI: Setting latency timer of device 0000:03:00.0 to 64
> eth1: Xircom cardbus revision 3 at irq 11 
> PCI: Enabling device 0000:03:00.1 (0000 -> 0003)
> ACPI: PCI Interrupt 0000:03:00.1[A] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
> 0000:03:00.1: ttyS1 at I/O 0xe080 (irq = 11) is a 16550A
> pccard: PCMCIA card inserted into slot 2
> ohci1394: fw-host0: AT dma reset ctx=0, aborting transmission
> ieee1394: Current remote IRM is not 1394a-2000 compliant, resetting...
> ieee1394: Host added: ID:BUS[0-00:1023]  GUID[374fc0002a71c021]
> Non-volatile memory driver v1.2
> 
> Hmm.. a lot quieter...

So, you have a pcmcia or cardbus card here?  I've tried this with a
cardbus card and it worked fine.

Are you sure you have the latest userspace tools, I didn't think that cs
was needed anymore, but again, without a pcmcia device to test this
with, I really am not sure :(

thanks,

greg k-h
