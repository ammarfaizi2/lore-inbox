Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264628AbTBTOzI>; Thu, 20 Feb 2003 09:55:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264915AbTBTOzI>; Thu, 20 Feb 2003 09:55:08 -0500
Received: from ip64-48-93-2.z93-48-64.customer.algx.net ([64.48.93.2]:61057
	"EHLO ns1.limegroup.com") by vger.kernel.org with ESMTP
	id <S264628AbTBTOzG>; Thu, 20 Feb 2003 09:55:06 -0500
Date: Thu, 20 Feb 2003 10:05:06 -0500 (EST)
From: Ion Badulescu <ionut@badula.org>
X-X-Sender: ion@guppy.limebrokerage.com
To: linux-kernel@vger.kernel.org
Subject: UP local APIC is deadly on SMP Athlon
Message-ID: <Pine.LNX.4.44.0302191458160.29393-100000@guppy.limebrokerage.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A UP kernel compiled with CONFIG_X86_LOCAL_APIC=y dies a very horrible
death on an SMP Athlon motherboard (Tyan S2462 and S2468), flooding the
console with the following messages:

...
masked ExtINT on CPU#0
ESR value before enabling vector: 00000008
ESR value afteC error on CPU8(08)
<6>APIC <6>APIC error PU0: 08(08)
<6C error on CP08(08)
<6>APICor on CPU0: 08
<6>APIC erro CPU0: 08(08)
PIC error on0: 08(08)
<6>Aerror on CPU0:08)
<6>APIC e on CPU0: 08(06>APIC error oU0: 08(08)
<6C error on CPU8(08)
...

[this is a serial console, and the errors are produced faster than the 
console can print them]

The kernel is 2.4.21-pre4, but any recent 2.4/2.5 kernels produce the same 
results: 2.4.20, 2.5.62, and Red Hat's 2.4.18-{18.24}. It's not a 
machine-specific problem, because it shows up on at least 5 different 
machines (all of them dual Athlon, using Tyan MB's). The error message is 
always "APIC error on CPU0: 08(08)".

A bit of binary searching between kernel versions shows that the problem 
was introduced in 2.4.10-pre12.

The IO-APIC option (CONFIG_X86_UP_IOAPIC) does not matter, only the local 
APIC option does. The kernel is compiled for an Athlon (CONFIG_MK7=y and 
everything that implies).

Ideas?

Thanks,
Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.





