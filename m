Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964812AbVHOQb7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964812AbVHOQb7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 12:31:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964824AbVHOQb6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 12:31:58 -0400
Received: from mail23.syd.optusnet.com.au ([211.29.133.164]:8686 "EHLO
	mail23.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S964812AbVHOQb6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 12:31:58 -0400
From: Con Kolivas <kernel@kolivas.org>
To: vatsa@in.ibm.com
Subject: Re: [ck] [PATCH] dynamic-tick patch modified for SMP
Date: Tue, 16 Aug 2005 02:30:51 +1000
User-Agent: KMail/1.8.2
Cc: tony@atomide.com, tuukka.tikkanen@elektrobit.com, akpm@osdl.org,
       johnstul@us.ibm.com, linux-kernel@vger.kernel.org, ak@muc.de,
       george@mvista.com
References: <20050812201946.GA5327@in.ibm.com> <200508141018.29668.kernel@kolivas.org> <20050815153541.GA4731@in.ibm.com>
In-Reply-To: <20050815153541.GA4731@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508160230.52860.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Aug 2005 01:35, Srivatsa Vaddagiri wrote:
> On Sun, Aug 14, 2005 at 10:18:28AM +1000, Con Kolivas wrote:
> > timers that made no progress until interrupts drove the timers on again.
> > I built in both PIT and APIC dyntick mode into the kernel and the default
> > in the way I modified the patch is for APIC mode to be used if it's built
> > in. After that I modified the values using the sysfs interface at
> > /sys/devices/system/dyn_tick/dyn_tick0/. In APIC mode it seems to run
> > close to
>
> Con,
> 	I am observing the reverse problem - my patch does not work in APIC
> mode. I am thinking it has to do something with disabling PIT interrupts.
>
> Have you enabled CONFIG_DYN_TICK_USE_APIC in my patch? 

yes I already said I tried apic mode, that's the one that works "best" but I 
suspect that's reflecting the fact that I hardly ever go below 300Hz on this 
machine except in init 1. Time definitely was lost the longer the machine was 
running.

> What does 
> /sys/.../dyn_tick0/state show when my patch is working (in APIC mode for
> you)? 

suitable:       1
enabled:        1
apic suitable:  1
using APIC:     1
(remember I wrote the sysfs portion ;) )

> Can you disable CONFIG_DYN_TICK_USE_APIC with my patch and check if 
> it works? 

You mean disable it at runtime or not compile it in at all? Disabling it at 
runtime caused what I described to you as PIT mode (long stalls etc).

> Also can you send me 'dmesg | grep APIC' (want to know if your 
> hardware has local APIC that is enabled by the kernel).

ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 15:2 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
Enabling APIC mode:  Flat.  Using 1 I/O APICs
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
ENABLING IO-APIC IRQs
ACPI: Using IOAPIC for interrupt routing

Cheers,
Con
