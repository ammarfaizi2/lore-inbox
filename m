Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750776AbWBBSsn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750776AbWBBSsn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 13:48:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750833AbWBBSsn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 13:48:43 -0500
Received: from mail.ccur.com ([66.10.65.12]:12455 "EHLO mail.ccur.com")
	by vger.kernel.org with ESMTP id S1750776AbWBBSsn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 13:48:43 -0500
Message-ID: <43E25407.5030506@ccur.com>
Date: Thu, 02 Feb 2006 13:48:39 -0500
From: John Blackwood <john.blackwood@ccur.com>
Reply-To: john.blackwood@ccur.com
Organization: Concurrent Computer Corporation
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.4) Gecko/20050318 Red Hat/1.4.4-1.3.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: linux-kernel@vger.kernel.org, bugsy@ccur.com
Subject: Re: CONFIG_K8_NUMA x86_64 no-memory node bug
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Feb 2006 18:48:39.0823 (UTC) FILETIME=[484A31F0:01C62829]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi,

Sorry for my ignorance about using earlyprintk.  Here's the output,
as you requested.  The 3rd cpu of 4 cpus has no memory.  Looks like the
zonelists are the problem..

Thanks again for looking at this.


grub> boot 

Bootdata ok (command line is root=/dev/sda2 console=ttyS0,115200 
earlyprintk=serial,ttyS0,115200 numa=noacpi)
Linux version 2.6.15.2 (johnb@kong) (gcc version 3.4.4 20050721 (Red Hat 
3.4.4-2)) #3 SMP PREEMPT Thu Feb 2 13:23:40 EST 2006
BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009ac00 (usable)
  BIOS-e820: 000000000009ac00 - 00000000000a0000 (reserved)
  BIOS-e820: 00000000000ce000 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 00000000bff70000 (usable)
  BIOS-e820: 00000000bff70000 - 00000000bff7f000 (ACPI data)
  BIOS-e820: 00000000bff7f000 - 00000000bff80000 (ACPI NVS)
  BIOS-e820: 00000000bff80000 - 00000000d0000000 (reserved)
  BIOS-e820: 00000000fec00000 - 00000000fec00400 (reserved)
  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
  BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
  BIOS-e820: 0000000100000000 - 0000000180000000 (usable)
kernel direct mapping tables upto ffff810180000000 @ 8000-f000
Scanning NUMA topology in Northbridge 24
Number of nodes 4
Node 0 MemBase 0000000000000000 Limit 0000000040000000
Node 1 MemBase 0000000040000000 Limit 0000000080000000
Skipping disabled node 2
Node 3 MemBase 0000000080000000 Limit 0000000180000000
Using node hash shift of 30
Bootmem setup node 0 0000000000000000-0000000040000000
Bootmem setup node 1 0000000040000000-0000000080000000
Bootmem setup node 3 0000000080000000-0000000180000000
ACPI: PM-Timer IO Port: 0xc008
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:5 APIC version 16
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 15:5 APIC version 16
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x02] enabled)
Processor #2 15:5 APIC version 16
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x03] enabled)
Processor #3 15:5 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
ACPI: IOAPIC (id[0x04] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 4, version 17, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x05] address[0xee200000] gsi_base[24])
IOAPIC[1]: apic_id 5, version 17, address 0xee200000, GSI 24-27
ACPI: IOAPIC (id[0x06] address[0xee201000] gsi_base[28])
IOAPIC[2]: apic_id 6, version 17, address 0xee201000, GSI 28-31
ACPI: IOAPIC (id[0x07] address[0xee203000] gsi_base[32])
IOAPIC[3]: apic_id 7, version 17, address 0xee203000, GSI 32-35
ACPI: IOAPIC (id[0x08] address[0xee205000] gsi_base[36])
IOAPIC[4]: apic_id 8, version 17, address 0xee205000, GSI 36-39
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
Setting APIC routing to flat
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at d4000000 (gap: d0000000:2ec00000)
Checking aperture...
CPU 0: aperture @ c0000000 size 256 MB
CPU 1: aperture @ c0000000 size 256 MB
CPU 2: aperture @ c0000000 size 256 MB
CPU 3: aperture @ c0000000 size 256 MB
PANIC: early exception rip ffffffff808a68f9 error 0 cr2 8b8

Call Trace:<ffffffff808a68f9>{build_all_zonelists+646} 
<ffffffff8012d21f>{init_idle+114}
        <ffffffff80892668>{start_kernel+80} 
<ffffffff80892276>{_sinittext+630}



