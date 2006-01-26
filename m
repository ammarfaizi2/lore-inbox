Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751083AbWAZIex@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751083AbWAZIex (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 03:34:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751049AbWAZIex
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 03:34:53 -0500
Received: from dsl092-035-012.lax1.dsl.speakeasy.net ([66.92.35.12]:32950 "EHLO
	arrau.morison.org") by vger.kernel.org with ESMTP id S1750770AbWAZIew
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 03:34:52 -0500
Message-ID: <20060126003451.8iqpklyyv6as88cg@webmail.morison.biz>
Date: Thu, 26 Jan 2006 00:34:51 -0800
From: Rod Morison <rod@morison.biz>
To: linux-kernel@vger.kernel.org
Subject: mptable irq info wrong on Tyan S5112, need advice
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	DelSp="Yes";
	format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
User-Agent: Internet Messaging Program (IMP) H3 (4.2-cvs)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm diagnosing a PCI IRQ problem on a Tyan S5112 motherboard. I pushed  
it back to where the kernel builds it's IRQ maps in  
arch/i386/kernel/mpparse.c (2.4.32 kernel). (The Tyan S5112 has a  
seperate IO APIC for it's PCI-X bus.)

What I found was for a board on the PCI-X bus the MP data read in  
mpparse.c says that the board has IRQ 16 on APIC #2. By trial and  
error I've determined that in fact the board is on IRQ 3 on APIC #3.  
(APIC IDs are the physical IDs reported from the APIC registers: #2 ==  
first APIC, #3 == second APIC.)

Questions/advice:

1. I infer that the motherboard bios has a bug in it's irq map build.  
Is this a reasonable conclusion?

2. I see various hacks in pci-irq.c to patch up erroneous IRQ  
assignments. However, it's not clear to me that the code in  
pci-irq.c:pcibios_lookup_irq() will work with IO APICs enabled. What's  
the best way to write a patch for this motherboard, to do the IRQ  
remapping discovered above? A pointer to an example in the kernel  
source would be helpful; I haven't stumble on such yet.

3. The board I'm debugging has several distinct functions and  
associated drivers and IRQ service routines. The interrupts for the  
different functions are asserted on different PCI pins: A, B & C. Yet,  
all the interrupts come in on the same IRQ I discovered above, namely  
IRQ 3 on APIC #3. Is this board just or-ing all the interrupt pins  
together, or do IO APICs handle this situation differently? (I've not  
found any good docs or refs on PCI pin mapping for IO APIC based  
boards.)

Any help/advice/links are appreciated.

Rod
rod@morison.biz

