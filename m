Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265725AbUFXVc5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265725AbUFXVc5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 17:32:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265701AbUFXVbd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 17:31:33 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:25067 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S265676AbUFXV3U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 17:29:20 -0400
From: "R. J. Wysocki" <rjwysocki@sisk.pl>
Organization: SiSK
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.7-mm2
Date: Thu, 24 Jun 2004 23:38:00 +0200
User-Agent: KMail/1.5
Cc: ak@muc.de, linux-kernel@vger.kernel.org
References: <20040624014655.5d2a4bfb.akpm@osdl.org> <200406242257.03397.rjwysocki@sisk.pl>
In-Reply-To: <200406242257.03397.rjwysocki@sisk.pl>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_4m02AiovGyOZfwi"
Message-Id: <200406242338.00105.rjwysocki@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_4m02AiovGyOZfwi
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday 24 of June 2004 22:57, R. J. Wysocki wrote:
> On Thursday 24 of June 2004 10:46, Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7/2.6.7
> >-m m2/
>
> Well, I have alarmingly many problems with this patch (my system is a dual
> Opteron - full config log attached):
>
> 1) There is an Oops at early boot time, caused probably by earlyprintk,
> which makes the serial console stop working (the call trace goes too fast
> to read and of course it does not go to the serial console ...).

I have reversed:

+reduce-tlb-flushing-during-process-migration-2.patch

and it cured this Oops, though it has nothing in common with the console, 
obviously.

The serial console just does not work for me at all (earlyprintk apparently 
does).   Attached is what I get from the earlyprintk.  Ther rest of kernel 
messages goes to the local console (tty0), although it is not even present in 
the kernel command line (sigh).

Yours,
rjw

----------------------------
For a successful technology, reality must take precedence over public 
relations, for nature cannot be fooled.
					-- Richard P. Feynman
--Boundary-00=_4m02AiovGyOZfwi
Content-Type: text/x-log;
  charset="iso-8859-2";
  name="2.6.7-mm2-earlyprintk.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="2.6.7-mm2-earlyprintk.log"

Bootdata ok (command line is root=/dev/sdc3 vga=792 earlyprintk=serial,ttyS0,115200 console=ttyS0,115200 hdc=ide-scsi)
Linux version 2.6.7-mm2 (rafael@chimera) (gcc version 3.3.3 (SuSE Linux)) #2 SMP Thu Jun 24 22:00:43 CEST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
 BIOS-e820: 000000003fff0000 - 000000003ffff000 (ACPI data)
 BIOS-e820: 000000003ffff000 - 0000000040000000 (ACPI NVS)
 BIOS-e820: 00000000ff7c0000 - 0000000100000000 (reserved)
kernel direct mapping tables upto 10100000000 @ 8000-c000
Scanning NUMA topology in Northbridge 24
Number of nodes 2 (10010)
Node 0 MemBase 0000000000000000 Limit 000000001fffffff
Node 1 MemBase 0000000020000000 Limit 000000003fff0000
Using node hash shift of 24
Bootmem setup node 0 0000000000000000-000000001fffffff
Bootmem setup node 1 0000000020000000-000000003fff0000
No mptable found.
On node 0 totalpages: 131071
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126975 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
On node 1 totalpages: 131056
  DMA zone: 0 pages, LIFO batch:1
  Normal zone: 131056 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
ACPI: RSDP (v000 ACPIAM                                    ) @ 0x00000000000f66f0
ACPI: RSDT (v001 A M I  OEMRSDT  0x10000302 MSFT 0x00000097) @ 0x000000003fff0000
ACPI: FADT (v001 A M I  OEMFACP  0x10000302 MSFT 0x00000097) @ 0x000000003fff0200
ACPI: MADT (v001 A M I  OEMAPIC  0x10000302 MSFT 0x00000097) @ 0x000000003fff0380
ACPI: OEMB (v001 A M I  OEMBIOS  0x10000302 MSFT 0x00000097) @ 0x000000003ffff040
ACPI: SRAT (v001 A M I  OEMSRAT  0x10000302 MSFT 0x00000097) @ 0x000000003fff39f0
ACPI: ASF! (v001 AMIASF AMDSTRET 0x00000001 INTL 0x02002026) @ 0x000000003fff3ae0
ACPI: DSDT (v001  0ABCF 0ABCF007 0x00000007 INTL 0x02002026) @ 0x0000000000000000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:5 APIC version 16
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:5 APIC version 16
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: Assigned apic_id 2
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x03] address[0xfc9fe000] gsi_base[24])
IOAPIC[1]: Assigned apic_id 3
IOAPIC[1]: apic_id 3, version 17, address 0xfc9fe000, GSI 24-27
ACPI: IOAPIC (id[0x04] address[0xfc9ff000] gsi_base[28])
IOAPIC[2]: Assigned apic_id 4
IOAPIC[2]: apic_id 4, version 17, address 0xfc9ff000, GSI 28-31
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
Using ACPI (MADT) for SMP configuration information
Checking aperture...
CPU 0: aperture @ f0000000 size 128 MB
CPU 1: aperture @ f0000000 size 128 MB
Built 2 zonelists
Initializing CPU#0
Kernel command line: root=/dev/sdc3 vga=792 earlyprintk=serial,ttyS0,115200 console=ttyS0,115200 hdc=ide-scsi
PID hash table entries: 16 (order 4: 256 bytes)
time.c: Using 1.193182 MHz PIT timer.
time.c: Detected 1387.535 MHz processor.
disabling early console
Bootdata ok (command line is root=/dev/sdc3 vga=792 earlyprintk=serial,ttyS0,115200 console=ttyS0,115200 hdc=ide-scsi)
Linux version 2.6.7-mm2 (rafael@chimera) (gcc version 3.3.3 (SuSE Linux)) #3 SMP Thu Jun 24 23:17:21 CEST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
 BIOS-e820: 000000003fff0000 - 000000003ffff000 (ACPI data)
 BIOS-e820: 000000003ffff000 - 0000000040000000 (ACPI NVS)
 BIOS-e820: 00000000ff7c0000 - 0000000100000000 (reserved)
kernel direct mapping tables upto 10100000000 @ 8000-c000
Scanning NUMA topology in Northbridge 24
Number of nodes 2 (10010)
Node 0 MemBase 0000000000000000 Limit 000000001fffffff
Node 1 MemBase 0000000020000000 Limit 000000003fff0000
Using node hash shift of 24
Bootmem setup node 0 0000000000000000-000000001fffffff
Bootmem setup node 1 0000000020000000-000000003fff0000
No mptable found.
On node 0 totalpages: 131071
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126975 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
On node 1 totalpages: 131056
  DMA zone: 0 pages, LIFO batch:1
  Normal zone: 131056 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
ACPI: RSDP (v000 ACPIAM                                    ) @ 0x00000000000f66f0
ACPI: RSDT (v001 A M I  OEMRSDT  0x10000302 MSFT 0x00000097) @ 0x000000003fff0000
ACPI: FADT (v001 A M I  OEMFACP  0x10000302 MSFT 0x00000097) @ 0x000000003fff0200
ACPI: MADT (v001 A M I  OEMAPIC  0x10000302 MSFT 0x00000097) @ 0x000000003fff0380
ACPI: OEMB (v001 A M I  OEMBIOS  0x10000302 MSFT 0x00000097) @ 0x000000003ffff040
ACPI: SRAT (v001 A M I  OEMSRAT  0x10000302 MSFT 0x00000097) @ 0x000000003fff39f0
ACPI: ASF! (v001 AMIASF AMDSTRET 0x00000001 INTL 0x02002026) @ 0x000000003fff3ae0
ACPI: DSDT (v001  0ABCF 0ABCF007 0x00000007 INTL 0x02002026) @ 0x0000000000000000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:5 APIC version 16
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:5 APIC version 16
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: Assigned apic_id 2
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x03] address[0xfc9fe000] gsi_base[24])
IOAPIC[1]: Assigned apic_id 3
IOAPIC[1]: apic_id 3, version 17, address 0xfc9fe000, GSI 24-27
ACPI: IOAPIC (id[0x04] address[0xfc9ff000] gsi_base[28])
IOAPIC[2]: Assigned apic_id 4
IOAPIC[2]: apic_id 4, version 17, address 0xfc9ff000, GSI 28-31
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
Using ACPI (MADT) for SMP configuration information
Checking aperture...
CPU 0: aperture @ f0000000 size 128 MB
CPU 1: aperture @ f0000000 size 128 MB
Built 2 zonelists
Initializing CPU#0
Kernel command line: root=/dev/sdc3 vga=792 earlyprintk=serial,ttyS0,115200 console=ttyS0,115200 hdc=ide-scsi
PID hash table entries: 16 (order 4: 256 bytes)
time.c: Using 1.193182 MHz PIT timer.
time.c: Detected 1387.567 MHz processor.
disabling early console
Bootdata ok (command line is root=/dev/sdc3 vga=792 earlyprintk=serial,ttyS0,115200 console=ttyS0,115200 hdc=ide-scsi)
Linux version 2.6.7-mm2 (rafael@chimera) (gcc version 3.3.3 (SuSE Linux)) #3 SMP Thu Jun 24 23:17:21 CEST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
 BIOS-e820: 000000003fff0000 - 000000003ffff000 (ACPI data)
 BIOS-e820: 000000003ffff000 - 0000000040000000 (ACPI NVS)
 BIOS-e820: 00000000ff7c0000 - 0000000100000000 (reserved)
kernel direct mapping tables upto 10100000000 @ 8000-c000
Scanning NUMA topology in Northbridge 24
Number of nodes 2 (10010)
Node 0 MemBase 0000000000000000 Limit 000000001fffffff
Node 1 MemBase 0000000020000000 Limit 000000003fff0000
Using node hash shift of 24
Bootmem setup node 0 0000000000000000-000000001fffffff
Bootmem setup node 1 0000000020000000-000000003fff0000
No mptable found.
On node 0 totalpages: 131071
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126975 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
On node 1 totalpages: 131056
  DMA zone: 0 pages, LIFO batch:1
  Normal zone: 131056 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
ACPI: RSDP (v000 ACPIAM                                    ) @ 0x00000000000f66f0
ACPI: RSDT (v001 A M I  OEMRSDT  0x10000302 MSFT 0x00000097) @ 0x000000003fff0000
ACPI: FADT (v001 A M I  OEMFACP  0x10000302 MSFT 0x00000097) @ 0x000000003fff0200
ACPI: MADT (v001 A M I  OEMAPIC  0x10000302 MSFT 0x00000097) @ 0x000000003fff0380
ACPI: OEMB (v001 A M I  OEMBIOS  0x10000302 MSFT 0x00000097) @ 0x000000003ffff040
ACPI: SRAT (v001 A M I  OEMSRAT  0x10000302 MSFT 0x00000097) @ 0x000000003fff39f0
ACPI: ASF! (v001 AMIASF AMDSTRET 0x00000001 INTL 0x02002026) @ 0x000000003fff3ae0
ACPI: DSDT (v001  0ABCF 0ABCF007 0x00000007 INTL 0x02002026) @ 0x0000000000000000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:5 APIC version 16
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:5 APIC version 16
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: Assigned apic_id 2
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x03] address[0xfc9fe000] gsi_base[24])
IOAPIC[1]: Assigned apic_id 3
IOAPIC[1]: apic_id 3, version 17, address 0xfc9fe000, GSI 24-27
ACPI: IOAPIC (id[0x04] address[0xfc9ff000] gsi_base[28])
IOAPIC[2]: Assigned apic_id 4
IOAPIC[2]: apic_id 4, version 17, address 0xfc9ff000, GSI 28-31
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
Using ACPI (MADT) for SMP configuration information
Checking aperture...
CPU 0: aperture @ f0000000 size 128 MB
CPU 1: aperture @ f0000000 size 128 MB
Built 2 zonelists
Initializing CPU#0
Kernel command line: root=/dev/sdc3 vga=792 earlyprintk=serial,ttyS0,115200 console=ttyS0,115200 hdc=ide-scsi
PID hash table entries: 16 (order 4: 256 bytes)
time.c: Using 1.193182 MHz PIT timer.
time.c: Detected 1387.537 MHz processor.
disabling early console


--Boundary-00=_4m02AiovGyOZfwi--

