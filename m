Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264434AbTKMWWS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 17:22:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264441AbTKMWWS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 17:22:18 -0500
Received: from fw.osdl.org ([65.172.181.6]:27290 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264434AbTKMWWR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 17:22:17 -0500
Date: Thu, 13 Nov 2003 14:21:12 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jochen Voss <voss@seehuhn.de>
cc: "Nakajima, Jun" <jun.nakajima@intel.com>, <linux-kernel@vger.kernel.org>
Subject: Re: invalid SMP mptable on Toshiba Satellite 2430-301
In-Reply-To: <20031113193043.GA1366@seehuhn.de>
Message-ID: <Pine.LNX.4.44.0311131408250.1861-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 13 Nov 2003, Jochen Voss wrote:
> 
> > In 2.6 we don't look at the MPS table if ACPI is
> > available. Or ACPI detection is failing?
>
> How do I check this?

Well, I just checked, and with my setup the IOAPIC and LAPIC information 
is all from ACPI.

In particular, if your ACPI tables have the information, you should have 
seen something like this:

	..
	ACPI: Local APIC address 0xfee00000
	ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
	Processor #0 15:2 APIC version 20
	ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
	Processor #1 15:2 APIC version 20
	ACPI: LAPIC_NMI (acpi_id[0x00] polarity[0x1] trigger[0x1] lint[0x1])
	ACPI: LAPIC_NMI (acpi_id[0x01] polarity[0x1] trigger[0x1] lint[0x1])
	ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
	...

and you shouldn't ever have gotten to the SMP table parsing, because the 
kernel doesn't need the information.

However, your dmesg doesn't have that. Which means that either you don't 
have the proper ACPI tables, or you don't ave CONFIG_ACPI_BOOT set.

Your .config file says you _do_ have CONFIG_ACPI_BOOT set, which would
imply that your BIOS tables really _are_ UP-only, even for ACPI.

Did they actually sell you the thing as being HT-enabled? It doesn't look 
like it is..

		Linus

