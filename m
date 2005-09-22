Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965201AbVIVBc7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965201AbVIVBc7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 21:32:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965202AbVIVBc7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 21:32:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:36757 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965201AbVIVBc7 (ORCPT
	<rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Wed, 21 Sep 2005 21:32:59 -0400
Date: Wed, 21 Sep 2005 18:31:38 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: ncunningham@cyclades.com, shaohua.li@intel.com, vatsa@in.ibm.com,
       Linux-Kernel@vger.kernel.org, spyro@f2s.com
Subject: Re: [PATCH 2.6.14-rc1-git5] sched: disable preempt in idle tasks
Message-Id: <20050921183138.52bcdf27.akpm@osdl.org>
In-Reply-To: <43317F3E.9090207@yahoo.com.au>
References: <43317F3E.9090207@yahoo.com.au>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>
> This patch should hopefully fix Nigel's bug.
> 
>  Split out from sched-resched-opt.patch. Tested on i386 with acpi idle
>  and poll idle (previous iterations tested on various other architectures).

This makes the emt64 machine reboot itself, which iirc was the behaviour in
the failing patch from which this one was split out.

The machine is using acpi_processor_idle().


Wed Sep 21 16:15:07 PDT 2005                                                 
Bootdata ok (command line is ro root=/dev/sda3 console=ttyS0)                
Linux version 2.6.14-rc2-mm1 (akpm@x) (gcc version 3.4.2 20041017 (Red Hat 3.4.5
BIOS-provided physical RAM map:                                                
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)                     
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)                   
 BIOS-e820: 00000000000ebbd0 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007ffd0000 (usable)  
 BIOS-e820: 000000007ffd0000 - 000000007ffdf000 (ACPI data)
 BIOS-e820: 000000007ffdf000 - 0000000080000000 (ACPI NVS) 
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000ffc00000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 0000000180000000 (usable)  
ACPI: PM-Timer IO Port: 0x408                           
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:3 APIC version 20                 
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x06] enabled)
Processor #6 15:3 APIC version 20                 
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x01] enabled)
Processor #1 15:3 APIC version 20                 
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x07] enabled)
Processor #7 15:3 APIC version 20                 
ACPI: IOAPIC (id[0x08] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 8, version 32, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x09] address[0xfec81000] gsi_base[24])      
IOAPIC[1]: apic_id 9, version 32, address 0xfec81000, GSI 24-47
ACPI: IOAPIC (id[0x0a] address[0xfec81400] gsi_base[48])       
IOAPIC[2]: apic_id 10, version 32, address 0xfec81400, GSI 48-71
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)        
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Setting APIC routing to flat                               
ACPI: HPET id: 0x8086a202 base: 0xfed00000
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 88000000 (gap: 80000000:60000000)
Checking aperture...                                                  
Built 1 zonelists   
Initializing CPU#0
Kernel command line: ro root=/dev/sda3 console=ttyS0
PID hash table entries: 4096 (order: 12, 131072 bytes)
time.c: Using 3.579545 MHz PM timer.                  
time.c: Detected 3400.276 MHz processor.
Console: colour VGA+ 80x25              
Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)  
Placing software IO TLB between 0x6a81000 - 0xaa81000           
Memory: 4029344k/6291456k available (3009k kernel code, 164152k reserved, 1758k)
Calibrating delay using timer specific routine.. 6810.03 BogoMIPS (lpj=13620075)
Mount-cache hash table entries: 256                                            
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K                       
using mwait in idle threads.
CPU: Physical Processor ID: 0
CPU0: Thermal monitoring enabled (TM1)
mtrr: v2.0 (20020519)                 
 tbxface-0109 [02] load_tables           : ACPI Tables successfully acquired
Parsing all Control Methods:....................................................
Table [DSDT](id 0005) - 461 Objects with 50 Devices 130 Methods 11 Regions     
ACPI Namespace successfully loaded at root ffffffff806078c0               
evxfevnt-0091 [03] enable                : Transition to ACPI mode successful
Using local APIC timer interrupts.                                           
Detected 12.500 MHz APIC timer.   
setup_APIC_timer               
done            
softlockup thread 0 started up.
Booting processor 1/4 APIC 0x6 
                             

