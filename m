Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264688AbUEEOPw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264688AbUEEOPw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 10:15:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264686AbUEEOPw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 10:15:52 -0400
Received: from atlrel7.hp.com ([156.153.255.213]:3761 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S264672AbUEEOPM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 10:15:12 -0400
Subject: RE: 2.6.6-rc3 MCA at bootup on rx2600
From: Alex Williamson <alex.williamson@hp.com>
To: "SEN,SOURAV (HP-India,ex2)" <sourav_sen@in2.exch.hp.com>
Cc: linux-ia64 <linux-ia64@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <A11077E28200D51182EA00D0B77552530E5DDE7F@xin02.india.hp.com>
References: <A11077E28200D51182EA00D0B77552530E5DDE7F@xin02.india.hp.com>
Content-Type: text/plain
Message-Id: <1083766509.5669.33.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 05 May 2004 08:15:10 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


   I reproduced it on my box too.  Removing just CONFIG_MDA_CONSOLE
support is sufficient, CONFIG_VGA_CONSOLE works fine.  Looks like mdacon
goes out and does some blind, unsafe poking of VGA space.  We should
probably just make this unselectable on ia64, based on the Kconfig
comment, I'm not sure it's worth fixing the driver.

	Alex

On Wed, 2004-05-05 at 07:05, SEN,SOURAV (HP-India,ex2) wrote:
> Okay, I commented out CONFIG_MDA_CONSOLE  and CONFIG_VGA_CONSOLE 
> and it boots up fine now.
> 
> Thanks
> Sourav
> HP-STS, Bangalore
> 
> 
> + -----Original Message-----
> + From: Sourav Sen [mailto:souravs@india.hp.com]On Behalf Of SEN,SOURAV
> + (HP-India,ex2)
> + Sent: Wednesday, May 05, 2004 6:30 PM
> + To: 'linux-ia64@vger.kernel.org'; 'linux-kernel@vger.kernel.org'
> + Subject: 2.6.6-rc3 MCA at bootup on rx2600
> + 
> + 
> + Hi,
> + 
> + I got MCA while booting 2.6.6-rc3 on a 2 cpu rx2600.
> + The following is the screen dump till it stops. 
> + 
> + =============== SOME MCA dump =====================
> + **** CPU Error Information, CPU00 ****
> + Time Stamp: 05/05/2004 at 14:13:10
> + 
> + 
> + PROCESSOR_SPECIFIC_DEVICE_INFO
> + VALIDATION_BITS               0x000000000110102f 
> + PROC_ERROR_MAP                0x0000000201006000 
> + Processor State Parameter     0xa8000000fff21330 
> + [...]
> + [...]
> + 
> + GRs NaT bits        0x0000000000000000 
> + PR (Predicates)     0x000000000000aa41 
> + BR0                 0xa000000100b07680 
> + RSC                 0x0000000000000003 
> + IIP                 0xa000000100b070f0 
> + IPSR                0x00001010085a6010 
> + IFS                 0x800000000000050b 
> + XIP                 0xa000000100b070c0 
> + XPSR                0x00001010085a6010 
> + XFS                 0x0000000000000000 
> + BR1                 0x0000000000000000 
> + 
> + [...]
> + 
> + [...]
> + 
> + 
> + ============ From System.map =================
> + For CPU0, the decoding the IIP and BR0:
> + 
> + IIP and BR0: 
> + 
> + a000000100b06f60 t mdacon_setup
> + a000000100b07060 t mda_detect
> + a000000100b073a0 t mda_initialize
> + a000000100b075a0 t mdacon_startup
> + a000000100b077a0 T mda_console_init
> + a000000100b07840 T fbmem_init
> + a000000100b07ac0 T video_setup
> + a000000100b07d00 t neo_init
> + a000000100b07d40 T neofb_setup
> + a000000100b07fa0 T neofb_init
> + a000000100b08040 T tdfxfb_init
> + 
> + 
> + Thanks
> + Sourav
> + 
> + 	
> + 
> + 
> + ELILO
> + Loading vmlinux...Loading Linux... ..done
> + Loading initrd root.bin.sys...done
> + Linux version 2.6.6-rc3 (souravs@erage1.india.hp.com) (gcc 
> + version 3.2.3 2003050
> + 2 (Red Hat Linux 3.2.3-24)) #7 SMP Wed May 5 13:56:37 IST 2004
> + EFI v1.10 by HP: SALsystab=0x3ff88000 ACPI 2.0=0x3fdf8000 
> + SMBIOS=0x3ff8a000 HCDP
> + =0x3fdf7000
> + booting generic kernel on platform hpzx1
> + ACPI: RSDP (v002     HP                                    ) 
> + @ 0x000000003fdf800
> + 0
> + ACPI: XSDT (v001     HP   rx2600 0x00000000 HP 0x00000000) @ 
> + 0x000000003fdf802c
> + ACPI: FADT (v003     HP   rx2600 0x00000000 HP 0x00000000) @ 
> + 0x000000003fdfe3f0
> + ACPI: SPCR (v001     HP   rx2600 0x00000000 HP 0x00000000) @ 
> + 0x000000003fdfe528
> + ACPI: DBGP (v001     HP   rx2600 0x00000000 HP 0x00000000) @ 
> + 0x000000003fdfe578
> + ACPI: MADT (v001     HP   rx2600 0x00000000 HP 0x00000000) @ 
> + 0x000000003fdfe638
> + A SPMI (v004     HP   rx2600 0x00000000 HP 0x00000000) @ 
> + 0x000000003fdfe5b0
> + ACPI: CPEP (v001     HP   rx2600 0x00000000 HP 0x000) @ 
> + 0x000000003fdfe600
> + ACPI: SSDT (v001     HP   rx2600 0x00000006 INTL 0x02012044) 
> + @ 0x000000003fdfc68
> + 0
> + ACPI: SSDT (v001     rx2600 0x00000006 INTL 0x02012044) @ 
> + 0x000000003fdfc740
> + ACPI: SSDT (v001     HP   rx2600 0x00000006 INTL 0x02012044) 
> + @ 0x000000fc970
> + ACPI: SSDT (v001     HP   rx2600 0x00000006 INTL 0x02012044) 
> + @ 0x000000003fdfcfe
> + 0
> + ACPI: SSDT (v001     HP   rx2600 0x000 INTL 0x02012044) @ 
> + 0x000000003fdfd650
> + ACPI: SSDT (v001     HP   rx2600 0x00000006 INTL 0x02012044) 
> + @ 0x000000003fdfdcc
> + 0
> + ACPI: (v001     HP   rx2600 0x00000006 INTL 0x02012044) @ 
> + 0x000000003fdfe330
> + ACPI: DSDT (v001     HP   rx2600 0x00000007 INTL 0x0201 @ 
> + 0x0000000000000000
> + Warning: acpi_table_parse(ACPI_SRAT) returned 0!
> + Warning: acpi_table_parse(ACPI_SLIT) returned 0!
> + efi.top: ignoring 4KB of memory at 0x0 due to granule hole at 0x0
> + efi.trim_top: ignoring 636KB of memory at 0x1000 due to granule ho 0x0
> + efi.trim_bottom: ignoring 15360KB of memory at 0x100000 due 
> + to granule hole at 0
> + x0
> + Initial ramdisk at: 0xe00000407cf9f00054432 bytes)
> + SAL 0.20: INTEL   MSL     REF     SAL      version 1.60
> + SAL: AP wakeup using external interrupt vector 0xff
> + ACPIal APIC address 0xc0000000fee00000
> + ACPI: LAPIC_ADDR_OVR (address[00000000fee00000])
> + ACPI: LSAPIC (acpi_id[0x00] lsapic_id[0x00pic_eid[0x00] enabled)
> + CPU 0 (0x0000) enabled (BSP)
> + ACPI: LSAPIC (acpi_id[0x01] lsapic_id[0x01] lsapic_eid[0x00] enabled)
> + CPUx0100) enabled
> + ACPI: IOSAPIC (id[0x0] global_irq_base[0x10] 
> + address[00000000fed20800])
> + ACPI: IOSAPIC (id[0x1] global_irq_base[ address[00000000fed22800])
> + ACPI: IOSAPIC (id[0x2] global_irq_base[0x26] 
> + address[00000000fed24800])
> + ACPI: IOSAPIC (id[0x3] glorq_base[0x31] address[00000000fed26800])
> + ACPI: IOSAPIC (id[0x4] global_irq_base[0x3c] 
> + address[00000000fed28800])
> + ACPI: IOSAPIC0x6] global_irq_base[0x47] address[00000000fed2c800])
> + ACPI: IOSAPIC (id[0x7] global_irq_base[0x52] 
> + address[00000000fed2e800])
> + 0x24(low,level) -> CPU 0x0000 vector 48
> + 2 CPUs available, 2 CPUs total
> + GSI 0x52(high,edge) -> CPU 0x0000 vector 49
> + MCA relatetialization done
> + Virtual mem_map starts at 0xa0007fffbf800000
> + On node 0 totalpages: 126648
> +   Normal zone: 0 pages, LIFO batch:1
> +   HighMem zone: 0 pages, LIFO batch:1
> + Built 1 zonelists
> + Kernel command line: BOOT_IMAGE0:\vmlinux  console=ttyS0 
> + root=100 ramdisk_size=3
> + 2768k
> + PID hash table entries: 4096 (order 12: 65536 bytes)
> + CPU 0: base freq=20MHz, ITC ratio=9/2, ITC freq=900.000MHz+/-450ppm
> + Console: colour VGA+ 80x25
> + Memory: 2013184k/2026368k available (9582k code, 28k 
> + reserved, 4147k data, 656k 
> + init)
> + Leaving McKinley Errata 9 workaround enabled
> + Calibrating delay loop... 1347.52 BogoMIPS
> + try cache hash table entries: 262144 (order: 7, 2097152 bytes)
> + Inode-cache hash table entries: 131072 (order: 6, 1048576 
> + bytes)unt-cache hash t
> + able entries: 1024 (order: 0, 16384 bytes)
> + POSIX conformance testing by UNIFIX
> + Boot processor id 0x0/0x0
> + taskation cache decay timeout: 10 msecs.
> + CPU 1: base freq=200.000MHz, ITC ratio=9/2, ITC 
> + freq=900.000MHz+/-450ppm
> + Calibrating delay loop... 1347.52 BogoMIPS
> + CPU 1: synchronized ITC with CPU 0 (last diff -6 cycles, 
> + maxerr 434 cycles)
> + Brought up 2 CPUs
> + Total of 2 processors activated (2694.04 BogoMIPS).
> + NET: Registered protocol family 16
> + ACPI: Subsystem revision 20040326
> + ACPI: Interpreter enabled
> + ACPI: Using IOSAPIC for interrupt routing
> + ACPI: PCI Root Bridge [PCI0] (00:00)
> + ACPI: PCI Root Bridge [PCI1] (00:20)
> + ACPI: PCI Root Bridge [PCI2] (00:40)
> + ACPI: PCI Root Bridge [PCI3] (00:60)
> + ACPI: PCI Root Bridge [PCI4] (00:80)
> + ACPI: PCI Root Bridge [PCI6] (00:c0)
> + ACPI: PCI Root Bridge [PCI7] (00:e0)
> + SCSI subsystem initialized
> + usbcore: registered new driver usbfs
> + usbcore: registered new driver hub
> + register_intr: changing vector 49 from IO-SAPIC-edge to IO-SAPIC-level
> + IOSAPIC: vector 50 -> CPU 0x0000, enabled
> + IOSAPIC: vector 51 -> CPU 0x0100, enabled
> + IOSAPIC: vector 52 -> CPU 0x0000, enabled
> + IOSAPIC: vector 53 -> CPU 0x0100, enabled
> + IOSAPIC: vector 54 -> CPU 0x0000, enabled
> + IOSAPIC: vector 55 -> CPU 0x0100, enabled
> + IOSAPIC: vector 56 -> CPU 0x0000, enabled
> + IOSAPIC: vector 57 -> CPU 0x0100, enabled
> + IOSAPIC: vector 49 -> CPU 0x0000, enabled
> + IOSAPIC: vector 49 -> CPU 0x0100, enabled
> + IOSAPIC: vector 74 -> CPU 0x0000, enabled
> + PCI: Using ACPI for IRQ routing
> + IOC: zx1 2.2 HPA 0xfed01000 IOVA space 1024Mb at 0x40000000
> + NET: Registered protocol family 23
> + PAL Information Facility v0.5
> + ikconfig 0.7 with /proc/config*
> + Total HugeTLB memory allocated, 0
> + udf: registering filesystem
> + Initializing Cryptographic API
> +                               PI: Processor [CPU0] (supports C1)
> + ACPI: Processor [CPU1] (supports C1)
> + 
> + ************* SYSTEM ALERT **************
> + SYSTEM NAME: lrage1g
> + 
> + 05 May 2004 13:30:09
> + Alert Level 7: Fatal
> + Keyword: Type-02 137001 1273857
> + Machine Check initiated
> + Logged by: SFW-redundant;  Sensor: Critical Interrupt 
> + Data2: OEM Code2: 0x00
> + 0xC14098EC61024000 003FA17000130300
> + 
> + A: ack read of this entry - X: Disable all future alert messages
> + Anything else skip redisplay the log entry
> + ->Choice:A
> + *****************************************
> + 
> + ************* SYSTEM ALERT **************
> + SYSTEM NAME: lrage1g
> + 
> + 05 May 2004 13:30:09
> + Alert Level 7: Fatal
> + Keyword: MC_INITIATED
> + Machine Check initiated
> + Logged by: System Firmware  0
> + Data: Implementation dependent data field
> + 0xF680009800E05AA5 0000000000000000
> + 
> + A: ack read of this entry - X: Disable all future alert messages
> + Anything else skip redisplay the log entry
> + ->Choice:A
> + *****************************************
> + 
> + ************* SYSTEM ALERT **************
> + SYSTEM NAME: lrage1g
> + 
> + 05 May 2004 13:30:10
> + Alert Level 7: Fatal
> + Keyword: Type-02 137001 1273857
> + Machine Check initiated
> + Logged by: SFW-redundant;  Sensor: Critical Interrupt 
> + Data2: OEM Code2: 0x01
> + 0xC14098EC62024000 013FA17000130300
> + 
> + A: ack read of this entry - X: Disable all future alert messages
> + Anything else skip redisplay the log entry
> + ->Choice:Timeout!
> + *****************************************
> + 
> + ************* SYSTEM ALERT **************
> + SYSTEM NAME: lrage1g
> + 
> + 05 May 2004 13:30:10
> + Alert Level 7: Fatal
> + Keyword: MC_INITIATED
> + Machine Check initiated
> + Logged by: System Firmware  1
> + Data: Implementation dependent data field
> + 0xF680009801E05AA5 0000000000000001
> + 
> + A: ack read of this entry - X: Disable all future alert messages
> + Anything else skip redisplay the log entry
> + ->Choice:
> + 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Alex Williamson                             HP Linux & Open Source Lab

