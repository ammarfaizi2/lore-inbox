Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751636AbVLAIW0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751636AbVLAIW0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 03:22:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751605AbVLAIW0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 03:22:26 -0500
Received: from fmr16.intel.com ([192.55.52.70]:20371 "EHLO
	fmsfmr006.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751396AbVLAIWZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 03:22:25 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: ACPI: PCI Interrupt Link [LNKA] (IRQs *7)
Date: Thu, 1 Dec 2005 03:22:15 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B300549CFDB@hdsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: ACPI: PCI Interrupt Link [LNKA] (IRQs *7)
Thread-Index: AcX2BmygJkVPKwWfSJyd8NfV2dSw4AASFccQ
From: "Brown, Len" <len.brown@intel.com>
To: "JaniD++" <djani22@dynamicweb.hu>,
       =?iso-8859-1?Q?Carlos_Mart=EDn?= <carlosmn@gmail.com>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 01 Dec 2005 08:22:18.0921 (UTC) FILETIME=[584D6190:01C5F650]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ACPI: PCI Interrupt Link [LNKG](IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
> ACPI: PCI Interrupt Link [LNKH](IRQs 3 4 5 6 7 *10 11 12 14 15)

ACPI PCI Interrupt Links are a way to connect device interrupt
wires to (an assortment of) interrupt controller IRQ inputs.

The "disabled" simply means that particular link
isn't being used -- likely because the link is used
only in another mode (eg. PIC vs APIC mode), or because
there is nothing attached to that interrupt wire.

The kernel will complain loudly if a device references
a disabled link, as it would be a BIOS bug.

The '*' is the IRQ that the link is currently using.

Later on in the dmesg you will be able to see
at device probe time which links are used by
which devices.

In PIC mode we don't balance the IRQs between
links -- though you could enable it with "acpi_irq_balance".
The reason we don't is because too many legacy BIOSs
fail when we do.

In IOAPIC mode, acpi_irq_balance is enabled by default.

This process assigns devices to IRQs, and the idea of
'balance' here is to minimize sharing of the same IRQ
wire between multiple devices.

This has nothing to do with the run-time balancing
to target a given IRQ at a specific CPU.

cheers,
-Len
