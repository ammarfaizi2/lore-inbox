Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270808AbTGPJc0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 05:32:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270810AbTGPJc0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 05:32:26 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:18663 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S270808AbTGPJcZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 05:32:25 -0400
Date: Wed, 16 Jul 2003 11:47:08 +0200 (MEST)
Message-Id: <200307160947.h6G9l8iW007259@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: andrew.grover@intel.com, hugh@veritas.com, len.brown@intel.com
Subject: RE: ACPI patches updated (20030714)
Cc: acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       marcelo@conectiva.com.br
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jul 2003 12:11:17 -0700, "Grover, Andrew" wrote:
>> From: Mikael Pettersson [mailto:mikpe@csd.uu.se] 
>> I would like to see HT_ONLY generalized to parsing the MADT for
>> I/O-APICs. The problem I have is that some mainboards, like my
>> i850 ASUS P4T-E, have I/O-APICs but no MP tables. The only way for
>> the Linux kernel to discover the I/O-APICs on these mainboard is
>> through MADT parsing.
>> 
>> However, this currently requires me to enable all of ACPI, which
>> I don't need or want for many reasons, including code bloat and
>> behavioural side-effects.
>> 
>> Replacing "HT_ONLY" with "MADT_PARSING_ONLY" would be ideal, IMO.
>
>This won't help you. If you have *no* MPS tables, then you need ACPI
>(and specifically the ability to execute the _PRT control methods) for
>interrupt routing information, in addition to ioapic and local apic
>(CPU) enumeration. If this wasn't the case, I'm sure someone would have
>implemented ioapic MADT enumeration code long ago.

:-(

>Also, nothing is going to fundamentally change the size of the ACPI code
>(but we do keep chipping away at it, as evidenced by the dynamic SDT
>patch, -Os, etc.) but I'd like to hear more about the behavioral
>side-effects you'd mentioned, with an eye towards fixing them.

The main side-effect _was_ seeing the interpreter being run.
I didn't know it was needed for figuring out IRQ routing.

Concerning code size, the 70K number in ACPI's Kconfig help is
out of date. A minimal ACPI (all user-selectable suboptions
disabled) adds 145K to my 2.6.0-test1 kernel.

/Mikael
