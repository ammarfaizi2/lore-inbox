Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932318AbWETVAB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932318AbWETVAB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 May 2006 17:00:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932325AbWETVAA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 May 2006 17:00:00 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27620 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932318AbWETU77 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 May 2006 16:59:59 -0400
Date: Sat, 20 May 2006 13:59:22 -0700
From: Andrew Morton <akpm@osdl.org>
To: Mel Gorman <mel@csn.ul.ie>
Cc: davej@codemonkey.org.uk, tony.luck@intel.com, mel@csn.ul.ie, ak@suse.de,
       bob.picco@hp.com, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
       linux-mm@kvack.org
Subject: Re: [PATCH 4/6] Have x86_64 use add_active_range() and
 free_area_init_nodes
Message-Id: <20060520135922.129a481d.akpm@osdl.org>
In-Reply-To: <20060508141151.26912.15976.sendpatchset@skynet>
References: <20060508141030.26912.93090.sendpatchset@skynet>
	<20060508141151.26912.15976.sendpatchset@skynet>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mel Gorman <mel@csn.ul.ie> wrote:
>
> 
> Size zones and holes in an architecture independent manner for x86_64.
> 
> 

I found a .config which triggers the cant-map-acpitables problem.


With that .config, and without this patch:

Linux version 2.6.17-rc4-mm2 (akpm@box) (gcc version 4.1.0 20060304 (Red Hat 4.6
BIOS-provided physical RAM map:                                                
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000ca605000 (usable)  
 BIOS-e820: 00000000ca605000 - 00000000ca680000 (ACPI NVS)
 BIOS-e820: 00000000ca680000 - 00000000cb5ef000 (usable)  
 BIOS-e820: 00000000cb5ef000 - 00000000cb5fc000 (reserved)
 BIOS-e820: 00000000cb5fc000 - 00000000cb6a2000 (usable)  
 BIOS-e820: 00000000cb6a2000 - 00000000cb6eb000 (ACPI NVS)
 BIOS-e820: 00000000cb6eb000 - 00000000cb6ef000 (usable)  
 BIOS-e820: 00000000cb6ef000 - 00000000cb6ff000 (ACPI data)
 BIOS-e820: 00000000cb6ff000 - 00000000cb700000 (usable)   
 BIOS-e820: 00000000cb700000 - 00000000cc000000 (reserved)
 BIOS-e820: 00000000ffe00000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 0000000130000000 (usable)  
DMI 2.4 present.                                        
ACPI: PM-Timer IO Port: 0x408
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 6:15 APIC version 20                 
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 6:15 APIC version 20                 
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x82] disabled)
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x83] disabled)
ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])  
ACPI: LAPIC_NMI (acpi_id[0x02] dfl dfl lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)      


With that .config, and with this patch:

Bootdata ok (command line is ro root=LABEL=/ earlyprintk=serial,ttyS0,9600,keep netconsole=4444@192.168.2.4/eth0,5147@192.168.2.33/00:0D:56:C6:C6:CC)
Linux version 2.6.17-rc4-mm2 (akpm@box) (gcc version 4.1.0 20060304 (Red Hat 4.1.0-3)) #33 SMP Sat May 20 12:08:03 PDT 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000ca605000 (usable)
 BIOS-e820: 00000000ca605000 - 00000000ca680000 (ACPI NVS)
 BIOS-e820: 00000000ca680000 - 00000000cb5ef000 (usable)
 BIOS-e820: 00000000cb5ef000 - 00000000cb5fc000 (reserved)
 BIOS-e820: 00000000cb5fc000 - 00000000cb6a2000 (usable)
 BIOS-e820: 00000000cb6a2000 - 00000000cb6eb000 (ACPI NVS)
 BIOS-e820: 00000000cb6eb000 - 00000000cb6ef000 (usable)
 BIOS-e820: 00000000cb6ef000 - 00000000cb6ff000 (ACPI data)
 BIOS-e820: 00000000cb6ff000 - 00000000cb700000 (usable)
 BIOS-e820: 00000000cb700000 - 00000000cc000000 (reserved)
 BIOS-e820: 00000000ffe00000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 0000000130000000 (usable)
Too many memory regions, truncating
Too many memory regions, truncating
Too many memory regions, truncating
DMI 2.4 present.
ACPI: Unable to map RSDT header
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID:  Product ID:  APIC at: 0xFEE00000


ACPI disables itself.

Good .config: http://www.zip.com.au/~akpm/linux/patches/stuff/config-good
Bad .config: http://www.zip.com.au/~akpm/linux/patches/stuff/config-bad


The handling of MAX_ACTIVE_REGIONS is unpleasing, sorry.  In my setup it is
5.  But we _really_ only support 4 regions.  So for a start it is misnamed.
The maximum number of regions we support is actually MAX_ACTIVE_REGIONS-1.
And this is a config option too!  So the user must specify
CONFIG_MAX_ACTIVE_REGIONS as the number of active regions plus one, for the
terminating region which has end_pfn=0.  It's weird.

I would not consider this code to be adequately commented.  Please raise a
patch which comments the major functions - what they do, why they do it,
any caveats or implementations details.  A few lines each - don't overdo
it.  Details such as whether the various end_pfn's are inclusive or
exclusive are important, as is a description of the return value.

Anyway, I just don't get how this code can work.  We have an e820 map with
up to 128 entries (this machine has ten) and we're trying to scrunch that
all into the four-entry early_node_map[].

With config-good we're set up for NUMA, CONFIG_NODES_SHIFT=6.  So
MAX_ACTIVE_REGIONS is enormous.  But it's quite wrong that we're using
number-of-zones*number-of-nodes to size a data structure which has to
accommodate all the entries in the e820 map.  These things aren't related.


On my little x86 PC:

BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009bc00 (usable)
 BIOS-e820: 000000000009bc00 - 000000000009c000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000ffc0000 (usable)
 BIOS-e820: 000000000ffc0000 - 000000000fff8000 (ACPI data)
 BIOS-e820: 000000000fff8000 - 0000000010000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffb80000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
255MB LOWMEM available.
found SMP MP-table at 000ff780
Range (nid 0) 0 -> 65472, max 4
On node 0 totalpages: 65472
  DMA zone: 4096 pages, LIFO batch:0
  Normal zone: 61376 pages, LIFO batch:15

So here, the architecture code only called add_active_range() the once, for
the entire memory map.  But on the x86_64 add_active_range() was called
once per e820 entry.  I'm dimly starting to realise that this is perhaps
the problem - the weird-looking definition of MAX_ACTIVE_REGIONS _expects_
the architecture to call add_active_range() with a start_pfn/end_pfn which
describes the entire range of pfns for each zone in each node.  Even if
that span includes not-present pfns.  Would that be correct?  I didn't see
a comment in there describing this design (I do go on).

If so, perhaps the bug is that the x86_64 code isn't doing that.  And that
x86 isn't doing it for some people either.

Anyway.  From the implementation I can see what the code is doing.  But I
see no description of what it is _supposed_ to be doing.  (The process of
finding differences between these two things is known as "debugging").  I
could kludge things by setting MAX_ACTIVE_REGIONS to 1000000, but enough. 
I look forward to the next version ;)
