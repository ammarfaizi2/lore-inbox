Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261460AbTLHTmJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 14:42:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261506AbTLHTmJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 14:42:09 -0500
Received: from fmr04.intel.com ([143.183.121.6]:24008 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S261460AbTLHTki (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 14:40:38 -0500
Subject: Re: irq again
From: Len Brown <len.brown@intel.com>
To: Jing Xu <xujing_cn2001@yahoo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <BF1FE1855350A0479097B3A0D2A80EE00184D63D@hdsmsx402.hd.intel.com>
References: <BF1FE1855350A0479097B3A0D2A80EE00184D63D@hdsmsx402.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1070912434.2408.50.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 08 Dec 2003 14:40:34 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If the Dell has an IO-APIC, you want to build support for it into the
kernel -- doing so may free up some additional interrupt lines.

If you can upgrade to the 2.4.23 kernel and run in ACPI mode, then there
are a couple of knobs that might be able to help you.

        acpi_irq_balance        ACPI will balance active IRQs
        acpi_irq_nobalance      ACPI will not move active IRQs
        acpi_irq_pci=   If irq_balance, Clear listed IRQs for use by PCI
        acpi_irq_isa=   If irq_balance, Mark listed IRQs used by ISA

acpi_irq_balance is default in IOAPIC mode
acpi_irq_nobalance is default in PIC mode
the acpi_irq_[pci, isa] are to list specify IRQs that should, and should
not be used for PCI interrupts, respectively.

cheers,
-Len

ps. Might also try to disable USB in the BIOS and use a PS/2 keyboard to
free up the IRQs?

On Mon, 2003-12-08 at 13:58, Jing Xu wrote:
> Hi, guys,
> 
> I have been stuct on this problem for a long time. Any
> suggestion on this will be highly appreciated.
> 
> I'm running linux 2.4.20 and rtai 24.1.11. My linux
> kernel module needs to use IRQ 9 10 11 for AGP graphic
> card, sound card and PCI-Dio24 IO card. These irqs are
> also shared by USB controllers. My module hangs when
> it tries to request one of the above irqs that is used
> by USB keyboard.
> 
> I am using DELL machine, and its bios cannot reserve
> irq's.
> 
> I also tried to set boot paramter "pci=irqmask=0xf1ef"
> to reserve irqs 9 10 11 4 for my driver, and it hasn't
> had any effect - those irqs are still used by usb
> controllers on initialization.
> 
> How to solve this irq confliction problem?
> 
> Thanks in advance,
> 
> jing
> 
> __________________________________
> Do you Yahoo!?
> New Yahoo! Photos - easier uploading and sharing.
> http://photos.yahoo.com/
> -
> To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 

