Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263728AbTLJRIV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 12:08:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263762AbTLJRIV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 12:08:21 -0500
Received: from jurand.ds.pg.gda.pl ([153.19.208.2]:54668 "EHLO
	jurand.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S263728AbTLJRIR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 12:08:17 -0500
Date: Wed, 10 Dec 2003 17:06:31 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ross Dickson <ross@datscreative.com.au>
Cc: linux-kernel@vger.kernel.org, AMartin@nvidia.com, kernel@kolivas.org,
       Ian Kumlien <pomac@vapor.com>
Subject: Re: Fixes for nforce2 hard lockup, apic, io-apic, udma133 covered
In-Reply-To: <200312101543.39597.ross@datscreative.com.au>
Message-ID: <Pine.LNX.4.55.0312101653490.31543@jurand.ds.pg.gda.pl>
References: <200312072312.01013.ross@datscreative.com.au>
 <Pine.LNX.4.55.0312091610320.20948@jurand.ds.pg.gda.pl>
 <200312101543.39597.ross@datscreative.com.au>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Dec 2003, Ross Dickson wrote:

> Relevant dmesg output from Albatron KM18G Pro ( this is different MOBO (same type) but 
> this time has a barton core 2500 XP cpu).
> 
> enabled ExtINT on CPU#0
> ESR value before enabling vector: 00000000
> ESR value after enabling vector: 00000000
> ENABLING IO-APIC IRQs
> init IO_APIC IRQs
>  IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 not connected.
> ..TIMER: vector=0x31 pin1=2 pin2=-1
> ..MP-BIOS bug: 8254 timer not connected to IO-APIC pin2
> ..TIMER: Is timer irq0 connected to IOAPIC Pin0? ...
> IOAPIC[0]: Set PCI routing entry (2-0 -> 0x31 -> IRQ 0 Mode:0 Active:0)
> ..TIMER check 8259 ints disabled, imr1:ff, imr2:ff
> ..TIMER: works OK on apic pin0 irq0
> Using local APIC timer interrupts.
> calibrating APIC timer ...
> ..... CPU clock speed is 1829.0708 MHz.
> ..... host bus clock speed is 332.0674 MHz.
> cpu: 0, clocks: 332674, slice: 166337
> CPU0<T0:332672,T1:166320,D:15,S:166337,C:332674>

 Hmm, while this is different from what is documented in the MP Spec, it
looks like the 8254 IRQ is connected to INTIN0 indeed.  We can handle such
a setup if the BIOS reports routing correctly.  Since you invoke
io_apic_set_pci_routing() I assume you use ACPI for IRQ routing
information.  Can you please rebuild the kernel with APIC_DEBUG set to 1
in include/asm-i386/apic.h and send me the bootstrap log?  Can you please
send me the output of a tool called `mptable' as well, so that I can
compare the results?

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
