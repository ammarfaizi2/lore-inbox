Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262603AbUAUWaX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 17:30:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264141AbUAUWaX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 17:30:23 -0500
Received: from dsl-213-023-011-163.arcor-ip.net ([213.23.11.163]:36751 "EHLO
	fusebox.fsfeurope.org") by vger.kernel.org with ESMTP
	id S262603AbUAUWaN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 17:30:13 -0500
To: "Nakajima, Jun" <jun.nakajima@intel.com>
Cc: "Martin Loschwitz" <madkiss@madkiss.org>, <linux-kernel@vger.kernel.org>,
       "Brown, Len" <len.brown@intel.com>, <acpi-devel@lists.sourceforge.net>
Subject: Re: PROBLEM: ACPI freezes 2.6.1 on boot
References: <7F740D512C7C1046AB53446D3720017361885C@scsmsx402.sc.intel.com>
	<m3u12pgfpr.fsf@reason.gnu-hamburg>
From: "Georg C. F. Greve" <greve@gnu.org>
Organisation: Free Software Foundation Europe - GNU Project
X-PGP-Fingerprint: 2D68 D553 70E5 CCF9 75F4 9CC9 6EF8 AFC2 8657 4ACA
X-PGP-Affinity: will accept encrypted messages for GNU Privacy Guard
X-Home-Page: http://gnuhh.org
X-Accept-Language: en, de
Date: Wed, 21 Jan 2004 23:29:51 +0100
In-Reply-To: <m3u12pgfpr.fsf@reason.gnu-hamburg> (Georg C. F. Greve's
 message of "Wed, 21 Jan 2004 22:21:52 +0100")
Message-ID: <m3ptddgckg.fsf@reason.gnu-hamburg>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

UPDATE:

Out of curiosity and because it seemed to be the interrupt handling
that was problematic, I disabled "Local APIC support on uniprocessors."

That convinced the machine to boot with ACPI.

Here is an excerpt from dmesg regarding ACPI only:

[...]
ACPI: RSDP (v000 ACPIAM                                    ) @ 0x000f4b60
ACPI: RSDT (v001 A M I  OEMRSDT  0x06000310 MSFT 0x00000097) @ 0x1f740000
ACPI: FADT (v002 A M I  OEMFACP  0x06000310 MSFT 0x00000097) @ 0x1f740200
ACPI: OEMB (v001 A M I  OEMBIOS  0x06000310 MSFT 0x00000097) @ 0x1f750040
ACPI: DSDT (v001  0ABBD 0ABBD001 0x00000001 MSFT 0x0100000d) @ 0x00000000
[...]
ACPI: Subsystem revision 20031002
ACPI: IRQ 9 was Edge Triggered, setting to Level Triggerd
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
[...]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
ACPI: Embedded Controller [EC0] (gpe 28)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 *5 6 7 11 12)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 12)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 12)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 6 7 12)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 12)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 12)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 12)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 *4 5 6 7 12)
ACPI: Power Resource [GFAN] (off)
[...]
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 4
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 5
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
[...]
speedstep-centrino: found "Intel(R) Pentium(R) M processor 1600MHz": max frequency: 1600000kHz
[...]
ACPI: AC Adapter [AC0] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Lid Switch [LID]
ACPI: Fan [FN00] (off)
ACPI: Processor [CPU1] (supports C1 C2 C3, 8 throttling states)
ACPI: Thermal Zone [THRM] (54 C)
Asus Laptop ACPI Extras version 0.26
  M2N model detected, supported
[...]
Resume Machine: resuming from /dev/hda8
Resuming from device hda8
Resume Machine: This is normal swap space
PM: Reading pmdisk image.
PM: Resume from disk failed.
ACPI: (supports S0 S1 S3 S4 S5)
[...]


This looks pretty good, I think. Already checked some
funcionality. Suspend to RAM seems to work, although the display
remains dark on restart (but normal shutdown works, so the machine is
definitely back up).

So the problem we've been seeing seems to be related to the
interaction between local APIC support and ACPI.

I hope this helps tracking it down...

Regards,
Georg


P.S. Martin? Can you reproduce this?

-- 
Georg C. F. Greve                                       <greve@gnu.org>
Free Software Foundation Europe	                 (http://fsfeurope.org)
Brave GNU World	                           (http://brave-gnu-world.org)
