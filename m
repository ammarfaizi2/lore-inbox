Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264330AbTH1WwU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 18:52:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264320AbTH1WwT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 18:52:19 -0400
Received: from 204.Red-213-96-224.pooles.rima-tde.net ([213.96.224.204]:519
	"EHLO betawl.net") by vger.kernel.org with ESMTP id S264330AbTH1WwN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 18:52:13 -0400
Date: Fri, 29 Aug 2003 00:52:04 +0200
From: Santiago Garcia Mantinan <manty@manty.net>
To: linux-kernel@vger.kernel.org
Cc: acpi-devel@sourceforge.net
Subject: ACPI in 2.4.22 breaking several systems
Message-ID: <20030828225204.GA5669@man.beta.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I don't know if this could be expected, for what I see most of the problems
are caused by the changes in the interrupt routing in rc3 or rc4, on my
first upgrades out of 5 different machines 4 had this kind of problem, for
all this systems, the pci=noacpi recipe solved the problem, hopefully this
is sugested on the kernel messages, however I think that maybe a warning in
the ACPI kernel doc or config should be in place.

What seems really weird to me is that at least on some of this systems, the
irq routing problem doesn't exist on 2.6.0test4 and it seems to be using the
same ACPI version :-???

The other failures I found was on old Pentium MMX with Intel 430TX chipset
based motherboards. The machines were working perfectly with ACPI as of
2.4.21, powering off correctly as power button was pressed, ... when
switching to 2.4.22 the first thing I got was a hang when loading the sound
card drivers, irq routing problem that was solved using pci=noacpi, then I
tried powering off using halt and it worked, but then I tried powering off
pushing the power button and I got hang with an error that started like
this:

process swapper
Unable to handle kernel NULL pointer dereference at virtual address 00000008
 printing eip:
c016a52b

I have just tested 2.6.0test4 on this machine and I got the same problem as
with 2.4.22.

This is the dmesg|grep -i acpi for 2.4.21 on that machine:

 BIOS-e820: 0000000003ffd000 - 0000000003ffd800 (ACPI NVS)
 BIOS-e820: 0000000003ffd800 - 0000000003fff400 (ACPI data)
ACPI: Core Subsystem version [20011018]
    ACPI-0349: *** Warning: Zero GPEs are defined in the FADT
ACPI: Subsystem enabled
ACPI: System firmware supports S0 S1 S5
ACPI: Power Button (FF) found

And this is for 2.4.22:

 BIOS-e820: 0000000003ffd000 - 0000000003ffd800 (ACPI NVS)
 BIOS-e820: 0000000003ffd800 - 0000000003fff400 (ACPI data)
ACPI: have wakeup address 0xc0001000
ACPI: RSDP (v000                                           ) @ 0x000f6880
ACPI: RSDT (v001                 0x00000000  0x00000000) @ 0x03ffd800
ACPI: FADT (v001                 0x00000000  0x00000000) @ 0x03ffd840
ACPI: DSDT (v001  AWARD AWRDACPI 0x00001000 MSFT 0x01000000) @ 0x00000000
Kernel command line: auto BOOT_IMAGE=Linux ro root=302 pci=noacpi
ACPI: Subsystem revision 20030813
    ACPI-0888: *** Info: There are no GPE blocks defined in the FADT
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: System [ACPI] (supports S0 S1 S4bios S5)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Root Bridge [PCI0] (00:00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: Power Button (FF) [PWRF]

One weird thing was that this system was not detected as an old bios and
thus the ACPI code was not turned off, while the only machine that I have
tried on which new ACPI works perfectly, a more modern PII machine, had the
ACPI set to off because its BIOS was too old.

Well, I suppose this won't tell much about the problem, so I'm offering for
gathering the info that may be needed to fix this, just tell me what to do.

Regards...
-- 
Manty/BestiaTester -> http://manty.net
