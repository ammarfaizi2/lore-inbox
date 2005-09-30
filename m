Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030329AbVI3P6a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030329AbVI3P6a (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 11:58:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030349AbVI3P63
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 11:58:29 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:39057 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1030329AbVI3P62 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 11:58:28 -0400
Date: Fri, 30 Sep 2005 08:57:57 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: "Bryan O'Sullivan" <bos@serpentine.com>
cc: Ravikiran G Thirumalai <kiran@scalex86.org>, Andrew Morton <akpm@osdl.org>,
       vandrove@vc.cvut.cz, alokk@calsoftinc.com, linux-kernel@vger.kernel.org,
       manfred@colorfullife.com, shai@scalex86.org, ananth@in.ibm.com,
       ak@suse.de
Subject: Re: 2.6.14-rc1-git-now still dying in mm/slab - this time line 1849
In-Reply-To: <1128093382.10913.92.camel@serpentine.pathscale.com>
Message-ID: <Pine.LNX.4.62.0509300853520.29202@schroedinger.engr.sgi.com>
References: <20050919112912.18daf2eb.akpm@osdl.org> 
 <Pine.LNX.4.62.0509191141380.26105@schroedinger.engr.sgi.com> 
 <20050919122847.4322df95.akpm@osdl.org>  <Pine.LNX.4.62.0509191351440.26388@schroedinger.engr.sgi.com>
  <20050919221614.6c01c2d1.akpm@osdl.org> <43301578.8040305@vc.cvut.cz> 
 <20050928210245.GA3760@localhost.localdomain> <433C1999.2060201@vc.cvut.cz>
  <20050930054556.GA3599@localhost.localdomain>  <20050929230540.6a8651fa.akpm@osdl.org>
  <20050930062853.GB3599@localhost.localdomain> <1128093382.10913.92.camel@serpentine.pathscale.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Sep 2005, Bryan O'Sullivan wrote:

> Kiran, your patch works for me, too.  I can boot 2.6.14-rc2 with your
> patch, but not without it.

The patch is not in rc2-mm2 right? I can now reproduce it on a AMD64 
single processor with numa emulation (numa=fake=2). So all x86_64 NUMA 
systems will throw these same stacktraces for rc2-mm2?



Bootdata ok (command line is root=/dev/sda2 console=tty0 
console=ttyS0,38400n8 numa=fake=2)
Linux version 2.6.14-rc2-mm2 (christoph@qirst.com) (gcc version 3.3.5 
(Debian 1:3.3.5-13)) #2 SMP Fri Sep 30 15:49:50 UTC 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
 BIOS-e820: 000000003fff0000 - 000000003fff3000 (ACPI NVS)
 BIOS-e820: 000000003fff3000 - 0000000040000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fef00000 (reserved)
 BIOS-e820: 00000000fefffc00 - 00000000ff000000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
Faking node 0 at 0000000000000000-000000000fffffff (255MB)
Faking node 1 at 0000000010000000-000000003fff0000 (767MB)
Bootmem setup node 0 0000000000000000-000000000fffffff
Bootmem setup node 1 0000000010000000-000000003fff0000
Nvidia board detected. Ignoring ACPI timer override.
ACPI: PM-Timer IO Port: 0x4008
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:12 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: BIOS IRQ0 pin2 override ignored.
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: INT_SRC_OVR (bus 0 bus_irq 14 global_irq 14 high edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 15 global_irq 15 high edge)
Setting APIC routing to flat
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 50000000 (gap: 40000000:bec00000)
Built 2 zonelists
Initializing CPU#0
Kernel command line: root=/dev/sda2 console=tty0 console=ttyS0,38400n8 
numa=fake=2
PID hash table entries: 4096 (order: 12, 131072 bytes)
time.c: Using 3.579545 MHz PM timer.
time.c: Detected 2210.110 MHz processor.

...

powernow-k8: Found 1 AMD Athlon 64 / Opteron processors (version 1.50.3)
powernow-k8:    0 : fid 0xe (2200 MHz), vid 0x2 (1500 mV)
powernow-k8:    1 : fid 0xc (2000 MHz), vid 0x6 (1400 mV)
powernow-k8:    2 : fid 0xa (1800 MHz), vid 0xa (1300 mV)
powernow-k8:    3 : fid 0x2 (1000 MHz), vid 0x12 (1100 mV)
cpu_init done, current fid 0xe, vid 0x2
Badness in cache_alloc_refill at mm/slab.c:2424

Call Trace:<ffffffff80164f8a>{cache_alloc_refill+458} 
<ffffffff80165858>{kmem_cache_alloc+136}
       <ffffffff8019f41e>{alloc_vfsmnt+30} 
<ffffffff801893d2>{do_kern_mount+82}
       <ffffffff8018fd5f>{getname+31} <ffffffff801a07ef>{do_new_mount+143}
       <ffffffff801a0f5b>{do_mount+363} <ffffffff8018fd5f>{getname+31}
       <ffffffff8015ee60>{__get_free_pages+16} 
<ffffffff801a134b>{sys_mount+139}
       <ffffffff8010b4ae>{name_to_dev_t+62} 
<ffffffff80514e70>{prepare_namespace+80}
       <ffffffff8010b16a>{init+250} <ffffffff8010ed2e>{child_rip+8}
       <ffffffff8010b070>{init+0} <ffffffff8010ed26>{child_rip+0}

Badness in cache_alloc_refill at mm/slab.c:2424

Call Trace:<ffffffff80164f8a>{cache_alloc_refill+458} 
<ffffffff80165858>{kmem_cache_alloc+136}
       <ffffffff8019f41e>{alloc_vfsmnt+30} 
<ffffffff801893d2>{do_kern_mount+82}
       <ffffffff8018fd5f>{getname+31} <ffffffff801a07ef>{do_new_mount+143}
       <ffffffff801a0f5b>{do_mount+363} <ffffffff8018fd5f>{getname+31}
       <ffffffff8015ee60>{__get_free_pages+16} 
<ffffffff801a134b>{sys_mount+139}
       <ffffffff8010b4ae>{name_to_dev_t+62} 
<ffffffff80514e70>{prepare_namespace+80}
       <ffffffff8010b16a>{init+250} <ffffffff8010ed2e>{child_rip+8}
       <ffffffff8010b070>{init+0} <ffffffff8010ed26>{child_rip+0}

Badness in cache_alloc_refill at mm/slab.c:2424


