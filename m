Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262544AbUBYA2a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 19:28:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262550AbUBYA2a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 19:28:30 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:54681 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262544AbUBYA0z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 19:26:55 -0500
Subject: 2.6.3-mm3 hangs on  boot x440 (scsi?)
From: john stultz <johnstul@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20040222172200.1d6bdfae.akpm@osdl.org>
References: <20040222172200.1d6bdfae.akpm@osdl.org>
Content-Type: multipart/mixed; boundary="=-p/OKEMwiXPLE1u62B8Z/"
Message-Id: <1077668801.2857.63.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 24 Feb 2004 16:26:42 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-p/OKEMwiXPLE1u62B8Z/
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Andrew,
	Booting 2.6.3-mm3 on an x440 hangs the box during the SCSI probe after
the following:
 
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
        <Adaptec aic7899 Ultra160 SCSI adapter>                 
        aic7899: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs
                                                                

I went back to 2.6.3-mm1 (as it was a smaller diff) and the problem was
there as well. 

The problem is not seen using 2.6.3-bk.current

Additionally the problem does not occur on an x445 (which uses
MPT-Fusion, rather then AIC7xxx) w/ -mm1 or -mm3.

Attached is the boot log and .config (from -mm1).

Let me know if there is any additional  debug info you'd like.

thanks
-john

--=-p/OKEMwiXPLE1u62B8Z/
Content-Disposition: attachment; filename=log.mm1-broke
Content-Type: text/plain; name=log.mm1-broke; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

Linux version 2.6.3-mm1 (jstultz@elm3b59) (gcc version 3.2.3 20030502 (Red Hat Linux 3.2.3-24)) #2 SMP Tue Feb 24 18:39:54 EST 2004
BIOS-provided physical RAM map:                    
 BIOS-e820: 0000000000000000 - 000000000009dc00 (usable)
 BIOS-e820: 000000000009dc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000dffb6ec0 (usable)  
 BIOS-e820: 00000000dffb6ec0 - 00000000dffbf800 (ACPI data)
 BIOS-e820: 00000000dffbf800 - 00000000e0000000 (reserved) 
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 0000000220000000 (usable)  
get_memcfg_from_srat: assigning address to rsdp         
RSD PTR  v0 [IBM   ]                           
Begin SRAT table scan....
CPU 0x00 in proximity domain 0x00
CPU 0x02 in proximity domain 0x00
CPU 0x10 in proximity domain 0x00
CPU 0x12 in proximity domain 0x00
CPU 0x20 in proximity domain 0x01
CPU 0x22 in proximity domain 0x01
CPU 0x30 in proximity domain 0x01
CPU 0x32 in proximity domain 0x01
CPU 0x01 in proximity domain 0x00
CPU 0x03 in proximity domain 0x00
CPU 0x11 in proximity domain 0x00
CPU 0x13 in proximity domain 0x00
CPU 0x21 in proximity domain 0x01
CPU 0x23 in proximity domain 0x01
CPU 0x31 in proximity domain 0x01
CPU 0x33 in proximity domain 0x01
Memory range 0x0 to 0xE0000 (type 0x1) in proximity domain 0x00 enabled
Memory range 0x100000 to 0x120000 (type 0x1) in proximity domain 0x00 enabled
Memory range 0x120000 to 0x220000 (type 0x1) in proximity domain 0x01 enabled
acpi20_parse_srat: Entry length value is zero; can't parse any further!      
pxm bitmap: 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
Number of logical nodes in system = 2
Number of memory chunks in system = 3
chunk 0 nid 0 start_pfn 00000000 end_pfn 000e0000
chunk 1 nid 0 start_pfn 00100000 end_pfn 00120000
chunk 2 nid 1 start_pfn 00120000 end_pfn 00220000
Reserving 10752 pages of KVA for lmem_map of node 1
Shrinking node 1 from 2228224 pages to 2217472 pages
Reserving total of 10752 pages for numa KVA remap   
7808MB HIGHMEM available.                        
854MB LOWMEM available.  
min_low_pfn = 1356, max_low_pfn = 218624, highstart_pfn = 229376
Low memory ends at vaddr f5600000                               
node 0 will remap to vaddr f8000000 - f8000000
node 1 will remap to vaddr f5600000 - f8000000
High memory starts at vaddr f8000000          
found SMP MP-table at 0009dd40      
On node 0 totalpages: 1048576 
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 214528 pages, LIFO batch:16
  HighMem zone: 829952 pages, LIFO batch:16
BUG: wrong zone alignment, it will crash   
On node 1 totalpages: 1037824           
  DMA zone: 0 pages, LIFO batch:1
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 1037824 pages, LIFO batch:16
DMI 2.3 present.                            
IBM machine detected. Enabling interrupts during APM calls.
IBM machine detected. Disabling SMBus accesses.            
IBM eserver xSeries 440 detected: force use of acpi=ht
ACPI: RSDP (v000 IBM                                       ) @ 0x000fdba0
ACPI: RSDT (v001 IBM    SERVIGIL 0x00001000 IBM  0x45444f43) @ 0xdffbf780
ACPI: FADT (v001 IBM    SERVIGIL 0x00001000 IBM  0x45444f43) @ 0xdffbf700
ACPI: MADT (v001 IBM    SERVIGIL 0x00001000 IBM  0x45444f43) @ 0xdffbf580
ACPI: SRAT (v001 IBM    SERVIGIL 0x00001000 IBM  0x45444f43) @ 0xdffbf3c0
ACPI: DSDT (v001 IBM    SERVIGIL 0x00001000 INTL 0x02002025) @ 0x00000000
ACPI: Local APIC address 0xfee00000                                      
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:1 APIC version 20                 
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x02] enabled)
Processor #2 15:1 APIC version 20                 
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x10] enabled)
Processor #16 15:1 APIC version 20                
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x12] enabled)
Processor #18 15:1 APIC version 20                
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x20] enabled)
Processor #32 15:1 APIC version 20                
ACPI: LAPIC (acpi_id[0x05] lapic_id[0x22] enabled)
Processor #34 15:1 APIC version 20                
ACPI: LAPIC (acpi_id[0x06] lapic_id[0x30] enabled)
Processor #48 15:1 APIC version 20                
ACPI: LAPIC (acpi_id[0x07] lapic_id[0x32] enabled)
Processor #50 15:1 APIC version 20                
ACPI: LAPIC (acpi_id[0x08] lapic_id[0x01] enabled)
Processor #1 15:1 APIC version 20                 
ACPI: LAPIC (acpi_id[0x09] lapic_id[0x03] enabled)
Processor #3 15:1 APIC version 20                 
ACPI: LAPIC (acpi_id[0x0a] lapic_id[0x11] enabled)
Processor #17 15:1 APIC version 20                
ACPI: LAPIC (acpi_id[0x0b] lapic_id[0x13] enabled)
Processor #19 15:1 APIC version 20                
ACPI: LAPIC (acpi_id[0x0c] lapic_id[0x21] enabled)
Processor #33 15:1 APIC version 20                
ACPI: LAPIC (acpi_id[0x0d] lapic_id[0x23] enabled)
Processor #35 15:1 APIC version 20                
ACPI: LAPIC (acpi_id[0x0e] lapic_id[0x31] enabled)
Processor #49 15:1 APIC version 20                
ACPI: LAPIC (acpi_id[0x0f] lapic_id[0x33] enabled)
Processor #51 15:1 APIC version 20                
ACPI: LAPIC_NMI (acpi_id[0x00] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x03] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x04] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x05] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x06] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x07] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x08] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x09] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x0a] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x0b] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x0c] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x0d] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x0e] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x0f] dfl dfl lint[0x1])
ACPI: IOAPIC (id[0x0e] address[0xfec00000] global_irq_base[0x0])
IOAPIC[0]: Assigned apic_id 14                                  
IOAPIC[0]: apic_id 14, version 17, address 0xfec00000, IRQ 0-50
ACPI: IOAPIC (id[0x0d] address[0xfec01000] global_irq_base[0x33])
IOAPIC[1]: Assigned apic_id 13                                   
IOAPIC[1]: apic_id 13, version 17, address 0xfec01000, IRQ 51-101
ACPI: INT_SRC_OVR (bus 0 bus_irq 8 global_irq 8 low edge)        
ACPI: INT_SRC_OVR (bus 0 bus_irq 14 global_irq 14 high dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 36 dfl dfl)  
ACPI BALANCE SET                                         
Enabling APIC mode:  Summit.  Using 2 I/O APICs
Using ACPI (MADT) for SMP configuration information
Built 2 zonelists                                  
Initializing CPU#0
Kernel command line: ro root=/dev/sda2 console=ttyS0,115200 console=tty0
PID hash table entries: 4096 (order 12: 32768 bytes)                    
Summit chipset: Starting Cyclone Counter.           
Detected 1501.936 MHz processor.         
Using cyclone for high-res timesource
Console: colour VGA+ 80x25           
Initializing highpages for node 0
Initializing highpages for node 1
Memory: 8292392k/8912896k available (2748k kernel code, 51436k reserved, 1019k data, 300k init, 7470808k highmem)
Calibrating delay loop... 193.53 BogoMIPS
Dentry cache hash table entries: 1048576 (order: 10, 4194304 bytes)
Inode-cache hash table entries: 1048576 (order: 10, 4194304 bytes) 
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)        
CPU: Trace cache: 12K uops, L1 D cache: 8K                
CPU: L2 cache: 256K                       
CPU: L3 cache: 512K
CPU: Physical Processor ID: 0
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.                    
POSIX conformance testing by UNIFIX
CPU0: Intel(R) Genuine CPU 1.50GHz stepping 01
per-CPU timeslice cutoff: 731.51 usecs.       
task migration cache decay timeout: 1 msecs.
enabled ExtINT on CPU#0                     
Leaving ESR disabled.  
Mapping cpu 0 to node 0
Booting processor 1/2 eip 2000
Initializing CPU#1            
masked ExtINT on CPU#1
Leaving ESR disabled. 
Mapping cpu 1 to node 0
Calibrating delay loop... 199.16 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 256K                       
CPU: L3 cache: 512K
CPU: Physical Processor ID: 1
CPU1: Intel(R) Genuine CPU 1.50GHz stepping 01
Booting processor 2/16 eip 2000               
Initializing CPU#2             
masked ExtINT on CPU#2
Leaving ESR disabled. 
Mapping cpu 2 to node 0
Calibrating delay loop... 199.68 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 256K                       
CPU: L3 cache: 512K
CPU: Physical Processor ID: 8
CPU2: Intel(R) Genuine CPU 1.50GHz stepping 01
Booting processor 3/18 eip 2000               
Initializing CPU#3             
masked ExtINT on CPU#3
Leaving ESR disabled. 
Mapping cpu 3 to node 0
Calibrating delay loop... 199.16 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 256K                       
CPU: L3 cache: 512K
CPU: Physical Processor ID: 9
CPU3: Intel(R) Genuine CPU 1.50GHz stepping 01
Booting processor 4/32 eip 2000               
Initializing CPU#4             
masked ExtINT on CPU#4
Leaving ESR disabled. 
Mapping cpu 4 to node 1
Calibrating delay loop... 199.16 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 256K                       
CPU: L3 cache: 512K
CPU: Physical Processor ID: 16
CPU4: Intel(R) Genuine CPU 1.50GHz stepping 01
Booting processor 5/34 eip 2000               
Initializing CPU#5             
masked ExtINT on CPU#5
Leaving ESR disabled. 
Mapping cpu 5 to node 1
Calibrating delay loop... 198.65 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 256K                       
CPU: L3 cache: 512K
CPU: Physical Processor ID: 17
CPU5: Intel(R) Genuine CPU 1.50GHz stepping 01
Booting processor 6/48 eip 2000               
Initializing CPU#6             
masked ExtINT on CPU#6
Leaving ESR disabled. 
Mapping cpu 6 to node 1
Calibrating delay loop... 199.16 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 256K                       
CPU: L3 cache: 512K
CPU: Physical Processor ID: 24
CPU6: Intel(R) Genuine CPU 1.50GHz stepping 01
Booting processor 7/50 eip 2000               
Initializing CPU#7             
masked ExtINT on CPU#7
Leaving ESR disabled. 
Mapping cpu 7 to node 1
Calibrating delay loop... 199.16 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 256K                       
CPU: L3 cache: 512K
CPU: Physical Processor ID: 25
CPU7: Intel(R) Genuine CPU 1.50GHz stepping 01
Booting processor 8/1 eip 2000                
Initializing CPU#8            
masked ExtINT on CPU#8
Leaving ESR disabled. 
Mapping cpu 8 to node 0
Calibrating delay loop... 199.16 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 256K                       
CPU: L3 cache: 512K
CPU: Physical Processor ID: 0
CPU8: Intel(R) Genuine CPU 1.50GHz stepping 01
Booting processor 9/3 eip 2000                
Initializing CPU#9            
masked ExtINT on CPU#9
Leaving ESR disabled. 
Mapping cpu 9 to node 0
Calibrating delay loop... 199.16 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 256K                       
CPU: L3 cache: 512K
CPU: Physical Processor ID: 1
CPU9: Intel(R) Genuine CPU 1.50GHz stepping 01
Booting processor 10/17 eip 2000              
Initializing CPU#10             
masked ExtINT on CPU#10
Leaving ESR disabled.  
Mapping cpu 10 to node 0
Calibrating delay loop... 199.68 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 256K                       
CPU: L3 cache: 512K
CPU: Physical Processor ID: 8
CPU10: Intel(R) Genuine CPU 1.50GHz stepping 01
Booting processor 11/19 eip 2000               
Initializing CPU#11             
masked ExtINT on CPU#11
Leaving ESR disabled.  
Mapping cpu 11 to node 0
Calibrating delay loop... 199.16 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 256K                       
CPU: L3 cache: 512K
CPU: Physical Processor ID: 9
CPU11: Intel(R) Genuine CPU 1.50GHz stepping 01
Booting processor 12/33 eip 2000               
Initializing CPU#12             
masked ExtINT on CPU#12
Leaving ESR disabled.  
Mapping cpu 12 to node 1
Calibrating delay loop... 199.16 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 256K                       
CPU: L3 cache: 512K
CPU: Physical Processor ID: 16
CPU12: Intel(R) Genuine CPU 1.50GHz stepping 01
Booting processor 13/35 eip 2000               
Initializing CPU#13             
masked ExtINT on CPU#13
Leaving ESR disabled.  
Mapping cpu 13 to node 1
Calibrating delay loop... 199.16 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 256K                       
CPU: L3 cache: 512K
CPU: Physical Processor ID: 17
CPU13: Intel(R) Genuine CPU 1.50GHz stepping 01
Booting processor 14/49 eip 2000               
Initializing CPU#14             
masked ExtINT on CPU#14
Leaving ESR disabled.  
Mapping cpu 14 to node 1
Calibrating delay loop... 198.65 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 256K                       
CPU: L3 cache: 512K
CPU: Physical Processor ID: 24
CPU14: Intel(R) Genuine CPU 1.50GHz stepping 01
Booting processor 15/51 eip 2000               
Initializing CPU#15             
masked ExtINT on CPU#15
Leaving ESR disabled.  
Mapping cpu 15 to node 1
Calibrating delay loop... 199.16 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 256K                       
CPU: L3 cache: 512K
CPU: Physical Processor ID: 25
CPU15: Intel(R) Genuine CPU 1.50GHz stepping 01
Total of 16 processors activated (3181.05 BogoMIPS).
ENABLING IO-APIC IRQs                               
..TIMER: vector=0x31 pin1=0 pin2=-1
Using local APIC timer interrupts. 
calibrating APIC timer ...        
..... CPU clock speed is 1920.0193 MHz.
..... host bus clock speed is 128.0012 MHz.
checking TSC synchronization across 16 CPUs: 
BIOS BUG: CPU#0 improperly initialized, has 7188724 usecs TSC skew! FIXED.
BIOS BUG: CPU#1 improperly initialized, has 7188733 usecs TSC skew! FIXED.
BIOS BUG: CPU#2 improperly initialized, has 7188728 usecs TSC skew! FIXED.
BIOS BUG: CPU#3 improperly initialized, has 7188726 usecs TSC skew! FIXED.
BIOS BUG: CPU#4 improperly initialized, has -7188732 usecs TSC skew! FIXED.
BIOS BUG: CPU#5 improperly initialized, has -7188732 usecs TSC skew! FIXED.
BIOS BUG: CPU#6 improperly initialized, has -7188720 usecs TSC skew! FIXED.
BIOS BUG: CPU#7 improperly initialized, has -7188731 usecs TSC skew! FIXED.
BIOS BUG: CPU#8 improperly initialized, has 7188727 usecs TSC skew! FIXED. 
BIOS BUG: CPU#9 improperly initialized, has 7188733 usecs TSC skew! FIXED.
BIOS BUG: CPU#10 improperly initialized, has 7188728 usecs TSC skew! FIXED.
BIOS BUG: CPU#11 improperly initialized, has 7188726 usecs TSC skew! FIXED.
BIOS BUG: CPU#12 improperly initialized, has -7188732 usecs TSC skew! FIXED.
BIOS BUG: CPU#13 improperly initialized, has -7188732 usecs TSC skew! FIXED.
BIOS BUG: CPU#14 improperly initialized, has -7188730 usecs TSC skew! FIXED.
BIOS BUG: CPU#15 improperly initialized, has -7188714 usecs TSC skew! FIXED.
Brought up 15 CPUs                                                          
zapping low mappings.
NET: Registered protocol family 16
EISA bus registered               
PCI: PCI BIOS revision 2.10 entry at 0xfd30d, last bus=11
PCI: Using configuration type 1                          
mtrr: v2.0 (20020519)          
ACPI: Subsystem revision 20040211
ACPI: Interpreter disabled.      
SCSI subsystem initialized 
ACPI: ACPI tables contain no PCI IRQ routing entries
PCI: Invalid ACPI-PCI IRQ routing table             
PCI: Probing PCI hardware              
PCI: Probing PCI hardware (bus 00)
PCI: Discovered peer bus 01       
PCI: Discovered peer bus 02
PCI: Discovered peer bus 05
PCI: Discovered peer bus 07
PCI: Discovered peer bus 09
PCI BIOS passed nonexistent PCI bus 0!
PCI BIOS passed nonexistent PCI bus 0!
PCI BIOS passed nonexistent PCI bus 0!
PCI BIOS passed nonexistent PCI bus 0!
PCI BIOS passed nonexistent PCI bus 1!
PCI BIOS passed nonexistent PCI bus 1!
PCI BIOS passed nonexistent PCI bus 1!
PCI BIOS passed nonexistent PCI bus 5!
Starting balanced_irq                 
highmem bounce pool size: 64 pages
VFS: Disk quotas dquot_6.5.1      
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
PCI: Enabling Via external APIC routing                 
Real Time Clock Driver v1.12           
Linux agpgart interface v0.100 (c) Dave Jones
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A                                 
Using anticipatory io scheduler         
Floppy drive(s): fd0 is 1.44M  
reset set in interrupt, calling c0289a08
floppy0: no floppy controllers found    
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)                                         
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://www.scyld.com/network/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
eth0: OEM i82557/i82558 10/100 Ethernet, 00:02:55:64:FF:38, IRQ 3.
  Board assembly 729857-009, Physical connectors present: RJ45    
  Primary interface chip i82555 PHY #1.                       
  General self-test: passed.           
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
tg3.c:v2.6 (February 3, 2004)                 
eth1: Tigon3 [partno(BCM95700A6) rev 7102 PHY(5401)] (PCI:66MHz:64-bit) 10/100/1000BaseT Ethernet 00:02:55:dc:09:34
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:05.1                            
VP_IDE: chipset revision 6                     
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci0000:00:05.1   
    ide0: BM-DMA at 0x0700-0x0707, BIOS settings: hda:pio, hdb:pio      
    ide1: BM-DMA at 0x0708-0x070f, BIOS settings: hdc:pio, hdd:pio
hda: LG CD-ROM CRN-8245B, ATAPI CD/DVD-ROM drive                  
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14             
hda: ATAPI 24X CD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20              
ide-floppy driver 0.99.newide       
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
        <Adaptec aic7899 Ultra160 SCSI adapter>                 
        aic7899: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs
                                                                


--=-p/OKEMwiXPLE1u62B8Z/
Content-Disposition: attachment; filename=config.mm1-broke
Content-Type: text/plain; name=config.mm1-broke; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

#
# Automatically generated make config: don't edit
#
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
CONFIG_CLEAN_COMPILE=y
CONFIG_STANDALONE=y

#
# General setup
#
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT=17
# CONFIG_IKCONFIG is not set
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set

#
# Loadable module support
#
# CONFIG_MODULES is not set

#
# Processor type and features
#
# CONFIG_X86_PC is not set
# CONFIG_X86_ELAN is not set
# CONFIG_X86_VOYAGER is not set
# CONFIG_X86_NUMAQ is not set
CONFIG_X86_SUMMIT=y
# CONFIG_X86_BIGSMP is not set
# CONFIG_X86_VISWS is not set
# CONFIG_X86_GENERICARCH is not set
# CONFIG_X86_ES7000 is not set
CONFIG_ACPI_SRAT=y
CONFIG_X86_SUMMIT_NUMA=y
CONFIG_X86_CYCLONE_TIMER=y
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUMM is not set
CONFIG_MPENTIUM4=y
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MELAN is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=7
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
# CONFIG_X86_4G is not set
# CONFIG_X86_SWITCH_PAGETABLES is not set
# CONFIG_X86_4G_VM_LAYOUT is not set
# CONFIG_X86_UACCESS_INDIRECT is not set
# CONFIG_X86_HIGH_ENTRY is not set
# CONFIG_HPET_TIMER is not set
# CONFIG_HPET_EMULATE_RTC is not set
CONFIG_SMP=y
CONFIG_NR_CPUS=32
# CONFIG_SCHED_SMT is not set
CONFIG_PREEMPT=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_TSC=y
# CONFIG_X86_MCE is not set
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set
# CONFIG_EDD is not set
# CONFIG_NOHIGHMEM is not set
# CONFIG_HIGHMEM4G is not set
CONFIG_HIGHMEM64G=y
CONFIG_HIGHMEM=y
CONFIG_X86_PAE=y
CONFIG_NUMA=y
CONFIG_DISCONTIGMEM=y
CONFIG_HAVE_ARCH_BOOTMEM_NODE=y
# CONFIG_HIGHPTE is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
# CONFIG_EFI is not set
CONFIG_IRQBALANCE=y
CONFIG_HAVE_DEC_LOCK=y
CONFIG_BOOT_IOREMAP=y
# CONFIG_REGPARM is not set

#
# Power management options (ACPI, APM)
#
# CONFIG_PM is not set

#
# ACPI (Advanced Configuration and Power Interface) Support
#
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
# CONFIG_ACPI_THERMAL is not set
CONFIG_ACPI_ASUS=y
CONFIG_ACPI_TOSHIBA=y
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_BUS=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
# CONFIG_ACPI_RELAXED_AML is not set
# CONFIG_X86_PM_TIMER is not set

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
# CONFIG_PCI_USE_VECTOR is not set
# CONFIG_PCI_LEGACY_PROC is not set
CONFIG_PCI_NAMES=y
CONFIG_ISA=y
CONFIG_EISA=y
CONFIG_EISA_PCI_EISA=y
CONFIG_EISA_NAMES=y
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set
CONFIG_HOTPLUG=y

#
# PCMCIA/CardBus support
#
# CONFIG_PCMCIA is not set
CONFIG_PCMCIA_PROBE=y

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
# CONFIG_BINFMT_AOUT is not set
# CONFIG_BINFMT_MISC is not set

#
# Device Drivers
#

#
# Generic Driver Options
#
# CONFIG_FW_LOADER is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
# CONFIG_PARPORT is not set

#
# Plug and Play support
#
# CONFIG_PNP is not set

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
# CONFIG_BLK_DEV_XD is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=y
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_NBD is not set
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y
# CONFIG_LBD is not set

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
# CONFIG_IDEDISK_STROKE is not set
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
CONFIG_BLK_DEV_IDEFLOPPY=y
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_IDE_TASK_IOCTL is not set
CONFIG_IDE_TASKFILE_IO=y

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=y
CONFIG_BLK_DEV_CMD640=y
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_GENERIC is not set
# CONFIG_BLK_DEV_OPTI621 is not set
CONFIG_BLK_DEV_RZ1000=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_ADMA=y
CONFIG_BLK_DEV_AEC62XX=y
CONFIG_BLK_DEV_ALI15X3=y
# CONFIG_WDC_ALI15X3 is not set
CONFIG_BLK_DEV_AMD74XX=y
CONFIG_BLK_DEV_CMD64X=y
# CONFIG_BLK_DEV_TRIFLEX is not set
CONFIG_BLK_DEV_CY82C693=y
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_CS5530 is not set
CONFIG_BLK_DEV_HPT34X=y
# CONFIG_HPT34X_AUTODMA is not set
CONFIG_BLK_DEV_HPT366=y
# CONFIG_BLK_DEV_SC1200 is not set
CONFIG_BLK_DEV_PIIX=y
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
CONFIG_BLK_DEV_SVWKS=y
# CONFIG_BLK_DEV_SIIMAGE is not set
CONFIG_BLK_DEV_SIS5513=y
CONFIG_BLK_DEV_SLC90E66=y
# CONFIG_BLK_DEV_TRM290 is not set
CONFIG_BLK_DEV_VIA82CXXX=y
# CONFIG_IDE_CHIPSETS is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_DMA_NONPCI is not set
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
CONFIG_SCSI=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
CONFIG_MAX_SD_DISKS=256
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=y
CONFIG_BLK_DEV_SR_VENDOR=y
# CONFIG_CHR_DEV_SG is not set

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
# CONFIG_SCSI_MULTI_LUN is not set
# CONFIG_SCSI_REPORT_LUNS is not set
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_7000FASST is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
# CONFIG_SCSI_AHA1542 is not set
# CONFIG_SCSI_AHA1740 is not set
# CONFIG_SCSI_AACRAID is not set
CONFIG_SCSI_AIC7XXX=y
CONFIG_AIC7XXX_CMDS_PER_DEVICE=253
CONFIG_AIC7XXX_RESET_DELAY_MS=15000
# CONFIG_AIC7XXX_PROBE_EISA_VL is not set
# CONFIG_AIC7XXX_BUILD_FIRMWARE is not set
CONFIG_AIC7XXX_DEBUG_ENABLE=y
CONFIG_AIC7XXX_DEBUG_MASK=0
CONFIG_AIC7XXX_REG_PRETTY_PRINT=y
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_SCSI_MEGARAID is not set
# CONFIG_SCSI_SATA is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_CPQFCTS is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_DTC3280 is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_GENERIC_NCR5380_MMIO is not set
CONFIG_SCSI_IPS=y
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_PAS16 is not set
# CONFIG_SCSI_PSI240I is not set
# CONFIG_SCSI_QLOGIC_FAS is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
CONFIG_SCSI_QLA2XXX=y
# CONFIG_SCSI_QLA21XX is not set
# CONFIG_SCSI_QLA22XX is not set
# CONFIG_SCSI_QLA2300 is not set
# CONFIG_SCSI_QLA2322 is not set
# CONFIG_SCSI_QLA6312 is not set
# CONFIG_SCSI_QLA6322 is not set
# CONFIG_SCSI_SIM710 is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set

#
# Fusion MPT device support
#
CONFIG_FUSION=y
CONFIG_FUSION_BOOT=y
CONFIG_FUSION_MAX_SGE=40

#
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set

#
# Macintosh device drivers
#

#
# Networking support
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_NETLINK_DEV=y
CONFIG_UNIX=y
# CONFIG_NET_KEY is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_FWMARK=y
CONFIG_IP_ROUTE_NAT=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_TOS=y
CONFIG_IP_ROUTE_VERBOSE=y
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
CONFIG_IP_MROUTE=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
# CONFIG_ARPD is not set
CONFIG_INET_ECN=y
CONFIG_SYN_COOKIES=y
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set

#
# IP: Virtual Server Configuration
#
# CONFIG_IP_VS is not set
# CONFIG_IPV6 is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set

#
# IP: Netfilter Configuration
#
# CONFIG_IP_NF_CONNTRACK is not set
# CONFIG_IP_NF_QUEUE is not set
# CONFIG_IP_NF_IPTABLES is not set
CONFIG_IP_NF_NAT_NEEDED=y
# CONFIG_IP_NF_ARPTABLES is not set
CONFIG_IP_NF_COMPAT_IPCHAINS=y

#
# SCTP Configuration (EXPERIMENTAL)
#
CONFIG_IPV6_SCTP__=y
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
CONFIG_NET_SCHED=y
CONFIG_NET_SCH_CBQ=y
# CONFIG_NET_SCH_HTB is not set
# CONFIG_NET_SCH_HFSC is not set
CONFIG_NET_SCH_CSZ=y
CONFIG_NET_SCH_PRIO=y
CONFIG_NET_SCH_RED=y
CONFIG_NET_SCH_SFQ=y
CONFIG_NET_SCH_TEQL=y
CONFIG_NET_SCH_TBF=y
CONFIG_NET_SCH_GRED=y
CONFIG_NET_SCH_DSMARK=y
CONFIG_NET_SCH_INGRESS=y
CONFIG_NET_QOS=y
CONFIG_NET_ESTIMATOR=y
CONFIG_NET_CLS=y
CONFIG_NET_CLS_TCINDEX=y
CONFIG_NET_CLS_ROUTE4=y
CONFIG_NET_CLS_ROUTE=y
CONFIG_NET_CLS_FW=y
CONFIG_NET_CLS_U32=y
CONFIG_NET_CLS_RSVP=y
CONFIG_NET_CLS_RSVP6=y
CONFIG_NET_CLS_POLICE=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
CONFIG_DUMMY=y
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_ETHERTAP is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
CONFIG_MII=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set

#
# Tulip family network device support
#
# CONFIG_NET_TULIP is not set
# CONFIG_AT1700 is not set
# CONFIG_DEPCA is not set
# CONFIG_HP100 is not set
# CONFIG_NET_ISA is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_AMD8111_ETH is not set
CONFIG_ADAPTEC_STARFIRE=y
# CONFIG_ADAPTEC_STARFIRE_NAPI is not set
# CONFIG_AC3200 is not set
# CONFIG_APRICOT is not set
CONFIG_B44=y
# CONFIG_FORCEDETH is not set
# CONFIG_CS89x0 is not set
# CONFIG_DGRS is not set
CONFIG_EEPRO100=y
# CONFIG_EEPRO100_PIO is not set
# CONFIG_E100 is not set
# CONFIG_LNE390 is not set
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_NE3210 is not set
# CONFIG_ES3210 is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SIS190 is not set
# CONFIG_SK98LIN is not set
CONFIG_TIGON3=y

#
# Ethernet (10000 Mbit)
#
# CONFIG_IXGB is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set
# CONFIG_NET_FC is not set
# CONFIG_RCPCI is not set
# CONFIG_SHAPER is not set
# CONFIG_NETCONSOLE is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
# CONFIG_IRDA is not set

#
# Bluetooth support
#
# CONFIG_BT is not set
# CONFIG_KGDBOE is not set
# CONFIG_NETPOLL is not set
# CONFIG_NETPOLL_RX is not set
# CONFIG_NETPOLL_TRAP is not set
# CONFIG_NET_POLL_CONTROLLER is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

#
# Input I/O drivers
#
# CONFIG_GAMEPORT is not set
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PCIPS2 is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_INPORT is not set
# CONFIG_MOUSE_LOGIBM is not set
# CONFIG_MOUSE_PC110PAD is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
# CONFIG_SERIAL_8250_ACPI is not set
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
# CONFIG_SERIAL_8250_MANY_PORTS is not set
# CONFIG_SERIAL_8250_SHARE_IRQ is not set
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
# CONFIG_SERIAL_8250_MULTIPORT is not set
# CONFIG_SERIAL_8250_RSA is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
# CONFIG_QIC02_TAPE is not set

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_HW_RANDOM is not set
# CONFIG_NVRAM is not set
CONFIG_RTC=y
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
CONFIG_AGP=y
CONFIG_AGP_ALI=y
# CONFIG_AGP_ATI is not set
CONFIG_AGP_AMD=y
# CONFIG_AGP_AMD64 is not set
CONFIG_AGP_INTEL=y
# CONFIG_AGP_NVIDIA is not set
CONFIG_AGP_SIS=y
CONFIG_AGP_SWORKS=y
CONFIG_AGP_VIA=y
# CONFIG_DRM is not set
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set
# CONFIG_HANGCHECK_TIMER is not set

#
# I2C support
#
# CONFIG_I2C is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set

#
# Graphics support
#
# CONFIG_FB is not set
CONFIG_VIDEO_SELECT=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y

#
# Sound
#
# CONFIG_SOUND is not set

#
# USB support
#
# CONFIG_USB is not set

#
# USB Gadget Support
#
# CONFIG_USB_GADGET is not set

#
# File systems
#
CONFIG_EXT2_FS=y
# CONFIG_EXT2_FS_XATTR is not set
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
# CONFIG_EXT3_FS_POSIX_ACL is not set
# CONFIG_EXT3_FS_SECURITY is not set
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=y
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
# CONFIG_JFS_FS is not set
# CONFIG_XFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_QUOTA=y
# CONFIG_QFMT_V1 is not set
# CONFIG_QFMT_V2 is not set
CONFIG_QUOTACTL=y
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
# CONFIG_ZISOFS is not set
# CONFIG_UDF_FS is not set

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=y
# CONFIG_MSDOS_FS is not set
CONFIG_VFAT_FS=y
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_SYSFS=y
# CONFIG_DEVFS_FS is not set
# CONFIG_DEVPTS_FS_XATTR is not set
CONFIG_TMPFS=y
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=y

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
# CONFIG_NFS_V4 is not set
# CONFIG_NFS_DIRECTIO is not set
CONFIG_NFSD=y
CONFIG_NFSD_V3=y
# CONFIG_NFSD_V4 is not set
# CONFIG_NFSD_TCP is not set
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=y
CONFIG_SUNRPC=y
# CONFIG_SUNRPC_GSS is not set
CONFIG_SMB_FS=y
# CONFIG_SMB_NLS_DEFAULT is not set
# CONFIG_CIFS is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_OSF_PARTITION is not set
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
# CONFIG_MAC_PARTITION is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
# CONFIG_MINIX_SUBPARTITION is not set
# CONFIG_SOLARIS_X86_PARTITION is not set
# CONFIG_UNIXWARE_DISKLABEL is not set
# CONFIG_LDM_PARTITION is not set
# CONFIG_NEC98_PARTITION is not set
# CONFIG_SGI_PARTITION is not set
# CONFIG_ULTRIX_PARTITION is not set
# CONFIG_SUN_PARTITION is not set
# CONFIG_EFI_PARTITION is not set

#
# Native Language Support
#
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
# CONFIG_NLS_CODEPAGE_437 is not set
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ISO8859_1=y
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_UTF8 is not set

#
# Profiling support
#
# CONFIG_PROFILING is not set

#
# Kernel hacking
#
CONFIG_DEBUG_KERNEL=y
CONFIG_EARLY_PRINTK=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
# CONFIG_DEBUG_SLAB is not set
# CONFIG_DEBUG_IOVIRT is not set
CONFIG_MAGIC_SYSRQ=y
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_SPINLINE is not set
# CONFIG_DEBUG_HIGHMEM is not set
# CONFIG_DEBUG_INFO is not set
# CONFIG_LOCKMETER is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_KGDB is not set
# CONFIG_FRAME_POINTER is not set
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y

#
# Security options
#
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
# CONFIG_CRYPTO is not set

#
# Library routines
#
CONFIG_CRC32=y
CONFIG_X86_SMP=y
CONFIG_X86_HT=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_X86_TRAMPOLINE=y
CONFIG_PC=y

--=-p/OKEMwiXPLE1u62B8Z/--

