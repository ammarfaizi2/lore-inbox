Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932240AbWEWSBU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932240AbWEWSBU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 14:01:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932241AbWEWSBU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 14:01:20 -0400
Received: from holly.csn.ul.ie ([193.1.99.76]:21158 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S932240AbWEWSBT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 14:01:19 -0400
Date: Tue, 23 May 2006 19:01:15 +0100 (IST)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet.skynet.ie
To: Andrew Morton <akpm@osdl.org>
Cc: davej@codemonkey.org.uk, tony.luck@intel.com, ak@suse.de, bob.picco@hp.com,
       linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
       linux-mm@kvack.org
Subject: Re: [PATCH 4/6] Have x86_64 use add_active_range() and free_area_init_nodes
In-Reply-To: <20060520135922.129a481d.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0605231853410.8660@skynet.skynet.ie>
References: <20060508141030.26912.93090.sendpatchset@skynet>
 <20060508141151.26912.15976.sendpatchset@skynet> <20060520135922.129a481d.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 May 2006, Andrew Morton wrote:

> Mel Gorman <mel@csn.ul.ie> wrote:
>>
>>
>> Size zones and holes in an architecture independent manner for x86_64.
>>
>>
>
> I found a .config which triggers the cant-map-acpitables problem.
>
>
> With that .config, and without this patch:
>
> Linux version 2.6.17-rc4-mm2 (akpm@box) (gcc version 4.1.0 20060304 (Red Hat 4.6
> BIOS-provided physical RAM map:
> BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
> BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
> BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
> BIOS-e820: 0000000000100000 - 00000000ca605000 (usable)
> BIOS-e820: 00000000ca605000 - 00000000ca680000 (ACPI NVS)
> BIOS-e820: 00000000ca680000 - 00000000cb5ef000 (usable)
> BIOS-e820: 00000000cb5ef000 - 00000000cb5fc000 (reserved)
> BIOS-e820: 00000000cb5fc000 - 00000000cb6a2000 (usable)
> BIOS-e820: 00000000cb6a2000 - 00000000cb6eb000 (ACPI NVS)
> BIOS-e820: 00000000cb6eb000 - 00000000cb6ef000 (usable)
> BIOS-e820: 00000000cb6ef000 - 00000000cb6ff000 (ACPI data)
> BIOS-e820: 00000000cb6ff000 - 00000000cb700000 (usable)
> BIOS-e820: 00000000cb700000 - 00000000cc000000 (reserved)
> BIOS-e820: 00000000ffe00000 - 0000000100000000 (reserved)
> BIOS-e820: 0000000100000000 - 0000000130000000 (usable)
> DMI 2.4 present.
> ACPI: PM-Timer IO Port: 0x408
> ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
> Processor #0 6:15 APIC version 20
> ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
> Processor #1 6:15 APIC version 20
> ACPI: LAPIC (acpi_id[0x03] lapic_id[0x82] disabled)
> ACPI: LAPIC (acpi_id[0x04] lapic_id[0x83] disabled)
> ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
> ACPI: LAPIC_NMI (acpi_id[0x02] dfl dfl lint[0x1])
> ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
> IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
> ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
>
>
> With that .config, and with this patch:
>
> Bootdata ok (command line is ro root=LABEL=/ earlyprintk=serial,ttyS0,9600,keep netconsole=4444@192.168.2.4/eth0,5147@192.168.2.33/00:0D:56:C6:C6:CC)
> Linux version 2.6.17-rc4-mm2 (akpm@box) (gcc version 4.1.0 20060304 (Red Hat 4.1.0-3)) #33 SMP Sat May 20 12:08:03 PDT 2006
> BIOS-provided physical RAM map:
> BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
> BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
> BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
> BIOS-e820: 0000000000100000 - 00000000ca605000 (usable)
> BIOS-e820: 00000000ca605000 - 00000000ca680000 (ACPI NVS)
> BIOS-e820: 00000000ca680000 - 00000000cb5ef000 (usable)
> BIOS-e820: 00000000cb5ef000 - 00000000cb5fc000 (reserved)
> BIOS-e820: 00000000cb5fc000 - 00000000cb6a2000 (usable)
> BIOS-e820: 00000000cb6a2000 - 00000000cb6eb000 (ACPI NVS)
> BIOS-e820: 00000000cb6eb000 - 00000000cb6ef000 (usable)
> BIOS-e820: 00000000cb6ef000 - 00000000cb6ff000 (ACPI data)
> BIOS-e820: 00000000cb6ff000 - 00000000cb700000 (usable)
> BIOS-e820: 00000000cb700000 - 00000000cc000000 (reserved)
> BIOS-e820: 00000000ffe00000 - 0000000100000000 (reserved)
> BIOS-e820: 0000000100000000 - 0000000130000000 (usable)
> Too many memory regions, truncating
> Too many memory regions, truncating
> Too many memory regions, truncating
> DMI 2.4 present.
> ACPI: Unable to map RSDT header
> Intel MultiProcessor Specification v1.4
>    Virtual Wire compatibility mode.
> OEM ID:  Product ID:  APIC at: 0xFEE00000
>

I think I have figured out what went wrong here.

arch/i386/kernel/acpi/boot.c has a __acpi_map_table() function which uses 
a variable end_pfn_map variable defined in arch/x86_64/kernel/e820.c . 
Part of the arch-independent-zone-sizing patch calculates end_pfn_map from 
early_node_map[] which only contains information on real RAM regions.

On Christian's machine, there is no usable region after the ACPI table 
data so early_node_map[] finishes just before the ACPI tables. This 
results in the wrong value for end_pfn_map and the table fails to be 
mapped. In Andrew's machines case, the regions got truncated and nothing 
after ACPI NVS was recorded, including ACPI data which is why it fails to 
boot.

Am not ready to release another set of patches, but I think this was the 
cause of magic failures on x86_64.

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
