Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261645AbSKTJrN>; Wed, 20 Nov 2002 04:47:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263188AbSKTJrN>; Wed, 20 Nov 2002 04:47:13 -0500
Received: from elin.scali.no ([62.70.89.10]:40208 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S261645AbSKTJrK>;
	Wed, 20 Nov 2002 04:47:10 -0500
Date: Wed, 20 Nov 2002 10:56:37 +0100 (CET)
From: Steffen Persvold <sp@scali.com>
X-X-Sender: sp@sp-laptop.isdn.scali.no
To: Hugh Dickins <hugh@veritas.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG?] Xeon with HyperThreading and linux-2.4.20-rc2
In-Reply-To: <Pine.LNX.4.44.0211192131530.6987-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0211201036170.13494-100000@sp-laptop.isdn.scali.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Nov 2002, Hugh Dickins wrote:

> On Tue, 19 Nov 2002, Steffen Persvold wrote:
> > 
> > I've two boxes with Dual Xeons 1.8 GHz and HT option enabled in BIOS. When 
> > I boot 2.4.20-rc2 with default arguments the kernel detects 4 processors and 
> > also reports 4 processors in /proc/cpuinfo wiht the "ht" feature.
> > 
> > However, if I boot with the "noht" option (wich I believed turned off HT 
> > and therefore only two processors should be available), the kernel still 
> > detects 4 processors, _but_ now the "ht" feature in /proc/cpuinfo is not 
> > there. Is this the intention of the "noht" option ?
> 
> No, the intention of the "noht" option is as you believed, and it used to
> work that way.  I looked at latest sourcec, didn't see anything obviously
> wrong.  Sorry, but I don't have a suitable HT machine to check at present.
> 
> > If so, are there any 
> > options available to turn off HT support in the kernel completely, so that 
> > I don't have to go into the BIOS to turn it off ?
> > 
> > If you want to I can provide the dmesg output and .config.
> > 
> > I think this issue is not just related to 2.4.20-rc2, but earlier kernels 
> > aswell.
> 
> Could others check and report if 2.4.20-rc2 "noht" works for them or not?
> 

Thanks for your reply Hugh,

After digging into it a bit, I _think_ I know what happens. When the 
machine is bootet with default parameters, the processors are detected in 
the ACPI table, and the MP table search is skipped :

Linux version 2.4.20-rc2 (root@puma1.office.scali.no) (gcc version 3.2 20020903 (Red Hat Linux 8.0 3.2-7)) #4 SMP Sat Nov 16 14:06:13 CET 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f400 (usable)
 BIOS-e820: 000000000009f400 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d8000 - 00000000000e0000 (reserved)
 BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fef0000 (usable)
 BIOS-e820: 000000003fef0000 - 000000003fefc000 (ACPI data)
 BIOS-e820: 000000003fefc000 - 000000003ff00000 (ACPI NVS)
 BIOS-e820: 000000003ff00000 - 000000003ff80000 (usable)
 BIOS-e820: 000000003ff80000 - 0000000040000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ff800000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000f7030
hm, page 000f7000 reserved twice.
hm, page 000f8000 reserved twice.
hm, page 0009f000 reserved twice.
hm, page 000a0000 reserved twice.
On node 0 totalpages: 262016
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 32640 pages.
ACPI: Searched entire block, no RSDP was found.
ACPI: RSDP located at physical address c00f7090
RSD PTR  v0 [PTLTD ]
__va_range(0x3fef84e0, 0x68): idx=8 mapped at ffff6000
ACPI table found: RSDT v1 [PTLTD    RSDT   1540.0]
__va_range(0x3fefbe78, 0x24): idx=8 mapped at ffff6000
__va_range(0x3fefbe78, 0x74): idx=8 mapped at ffff6000
ACPI table found: FACP v1 [INTEL  K_CANYON 1540.0]
__va_range(0x3fefbeec, 0x24): idx=8 mapped at ffff6000
__va_range(0x3fefbeec, 0x9c): idx=8 mapped at ffff6000
ACPI table found: APIC v1 [PTLTD         APIC   1540.0]
__va_range(0x3fefbeec, 0x9c): idx=8 mapped at ffff6000
LAPIC (acpi_id[0x0000] id[0x0] enabled[1])
CPU 0 (0x0000) enabledProcessor #0 Pentium 4(tm) XEON(tm) APIC version 16

LAPIC (acpi_id[0x0001] id[0x6] enabled[1])
CPU 1 (0x0600) enabledProcessor #6 Pentium 4(tm) XEON(tm) APIC version 16

LAPIC (acpi_id[0x0002] id[0x1] enabled[1])
CPU 2 (0x0100) enabledProcessor #1 Pentium 4(tm) XEON(tm) APIC version 16

LAPIC (acpi_id[0x0003] id[0x7] enabled[1])
CPU 3 (0x0700) enabledProcessor #7 Pentium 4(tm) XEON(tm) APIC version 16

IOAPIC (id[0x2] address[0xfec00000] global_irq_base[0x0])
IOAPIC (id[0x3] address[0xfec80000] global_irq_base[0x18])
IOAPIC (id[0x4] address[0xfec80400] global_irq_base[0x30])
INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] polarity[0x1] trigger[0x1])
INT_SRC_OVR (bus[0] irq[0x9] global_irq[0x9] polarity[0x1] trigger[0x3])
LAPIC_NMI (acpi_id[0x0000] polarity[0x1] trigger[0x1] lint[0x1])
LAPIC_NMI (acpi_id[0x0001] polarity[0x1] trigger[0x1] lint[0x1])
LAPIC_NMI (acpi_id[0x0002] polarity[0x1] trigger[0x1] lint[0x1])
LAPIC_NMI (acpi_id[0x0003] polarity[0x1] trigger[0x1] lint[0x1])
4 CPUs total
Local APIC address fee00000
__va_range(0x3fefbf88, 0x24): idx=8 mapped at ffff6000
__va_range(0x3fefbf88, 0x28): idx=8 mapped at ffff6000
ACPI table found: BOOT v1 [PTLTD  $SBFTBL$ 1540.0]
__va_range(0x3fefbfb0, 0x24): idx=8 mapped at ffff6000
__va_range(0x3fefbfb0, 0x50): idx=8 mapped at ffff6000
ACPI table found: SPCR v1 [PTLTD  $UCRTBL$ 1540.0]
Enabling the CPU's according to the ACPI table
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID:   Product ID: Kings Canyon APIC at: 0xFEE00000
I/O APIC #2 Version 32 at 0xFEC00000.
I/O APIC #3 Version 32 at 0xFEC80000.
I/O APIC #4 Version 32 at 0xFEC80400.
Processors: 4
Kernel command line: ro root=LABEL=/ console=ttyS0,9600n8 nmi_watchdog=1
[snip]


However, when I boot the machine with the "noht" option the ACPI table 
search is skipped, _but_ it still finds 4 processors in the MP table :

Linux version 2.4.20-rc2 (root@puma1.office.scali.no) (gcc version 3.2 20020903 (Red Hat Linux 8.0 3.2-7)) #4 SMP Sat Nov 16 14:06:13 CET 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f400 (usable)
 BIOS-e820: 000000000009f400 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d8000 - 00000000000e0000 (reserved)
 BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fef0000 (usable)
 BIOS-e820: 000000003fef0000 - 000000003fefc000 (ACPI data)
 BIOS-e820: 000000003fefc000 - 000000003ff00000 (ACPI NVS)
 BIOS-e820: 000000003ff00000 - 000000003ff80000 (usable)
 BIOS-e820: 000000003ff80000 - 0000000040000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ff800000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000f7030
hm, page 000f7000 reserved twice.
hm, page 000f8000 reserved twice.
hm, page 0009f000 reserved twice.
hm, page 000a0000 reserved twice.
On node 0 totalpages: 262016
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 32640 pages.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID:   Product ID: Kings Canyon APIC at: 0xFEE00000
Processor #0 Pentium 4(tm) XEON(tm) APIC version 20
Processor #6 Pentium 4(tm) XEON(tm) APIC version 20
Processor #1 Pentium 4(tm) XEON(tm) APIC version 20
Processor #7 Pentium 4(tm) XEON(tm) APIC version 20
I/O APIC #2 Version 32 at 0xFEC00000.
I/O APIC #3 Version 32 at 0xFEC80000.
I/O APIC #4 Version 32 at 0xFEC80400.
Processors: 4
Kernel command line: ro root=LABEL=/ console=ttyS0,9600n8 nmi_watchdog=1 noht

Since the HT feature is enabled in the BIOS it seems normal to me that 4 
processors are reported both in the MP table and in the ACPI table. 
Shouldn't the 'noht' option handle this ?

I have two of these machines and can assist in testing out patches etc.

Regards,
-- 
  Steffen Persvold   |       Scali AS      
 mailto:sp@scali.com |  http://www.scali.com
Tel: (+47) 2262 8950 |   Olaf Helsets vei 6
Fax: (+47) 2262 8951 |   N0621 Oslo, NORWAY

