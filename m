Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750845AbWIRSa6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750845AbWIRSa6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 14:30:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751030AbWIRSa6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 14:30:58 -0400
Received: from proof.pobox.com ([207.106.133.28]:58538 "EHLO proof.pobox.com")
	by vger.kernel.org with ESMTP id S1750845AbWIRSa5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 14:30:57 -0400
Date: Mon, 18 Sep 2006 13:32:35 -0500
From: Jon Mason <jdmason@kudzu.us>
To: kautzy <kautzy@kautzy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Dual Core Opteron hangs, iommu Entries (x86_64)
Message-ID: <20060918183234.GA24163@kudzu.us>
References: <450E9B49.4030203@kautzy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <450E9B49.4030203@kautzy.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2006 at 03:12:41PM +0200, kautzy wrote:
> Since this is my first post on this list, I would like to say hello to 
> everyone!
> 
> I am experiencing problems with a 2x dual core opteron servers. every 
> 5-7 days the system hangs. while it still pings, it does not react on 
> console inputs, i can't login via ssh either. when that happens, the 
> only thing one can do is to reset the machine. there aren't any errors 
> logged.
> 
> i have checked the memory for errors, but it looks like it is ok.
> 
> I found a post on this list describing a problem which looks similar to 
> mine:
> 
> http://www.gatago.com/linux/kernel/13699679.html
> 
> as mentioned in the above post, a dmesg on my server also shows 
> following entries:
> 
> Allocating PCI resources starting at fb800000 (gap: fb000000:4780000)
> Checking aperture...
> CPU 0: aperture @ cc24000000 size 32 MB
> Aperture from northbridge cpu 0 too small (32 MB)
> No AGP bridge found
> Your BIOS doesn't leave a aperture memory hole
> Please enable the IOMMU option in the BIOS setup
> This costs you 64 MB of RAM
> Mapping aperture over 65536 KB of RAM @ 8000000
> Built 1 zonelists
> 
> can those entries have anything to do with the system crashes, and if, 
> can booting with iommu=memaper=3 help to solve the problem?
> 
> i am running kernel 2.6.17.11, sarge amd64 , the system has 6GB RAM
> 
> i appreciate any suggestions :)

Your problem is that you have more than 4GB of RAM and not enough room
in your IOMMU aperature to handle all of the pending DMA requests.
Dmesg suggests you go into your BIOS and increase your AGP aperature
from 32M to 64M, did you try that?  

Thanks,
Jon

> 
> 
> 
> chris
> 
> the full output of dmesg:
> 
> Bootdata ok (command line is root=/dev/sda8 ro console=tty0 )
> Linux version 2.6.17.11-mli1-opteron-v2 (root@mli1) (gcc version 3.3.5 
> (Debian 1:3.3.5-13)) #1 SMP Mon Sep 11 12:29:02 CEST 2006
> BIOS-provided physical RAM map:
> BIOS-e820: 0000000000000000 - 000000000009f400 (usable)
> BIOS-e820: 000000000009f400 - 00000000000a0000 (reserved)
> BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
> BIOS-e820: 0000000000100000 - 00000000faff0000 (usable)
> BIOS-e820: 00000000faff0000 - 00000000fafff000 (ACPI data)
> BIOS-e820: 00000000fafff000 - 00000000fb000000 (ACPI NVS)
> BIOS-e820: 00000000ff780000 - 0000000100000000 (reserved)
> BIOS-e820: 0000000100000000 - 0000000180000000 (usable)
> DMI 2.3 present.
> On node 0 totalpages: 1529283
>  DMA zone: 2459 pages, LIFO batch:0
>  DMA32 zone: 1009704 pages, LIFO batch:31
>  Normal zone: 517120 pages, LIFO batch:31
> Intel MultiProcessor Specification v1.1
>    Virtual Wire compatibility mode.
> OEM ID: TYAN     Product ID: S2882        APIC at: 0xFEE00000
> Processor #0 15:1 APIC version 16
> Processor #1 15:1 APIC version 16
> Processor #2 15:1 APIC version 16
> Processor #3 15:1 APIC version 16
> I/O APIC #4 Version 17 at 0xFEC00000.
> I/O APIC #5 Version 17 at 0xFEBFF000.
> I/O APIC #6 Version 17 at 0xFEBFE000.
> Setting APIC routing to flat
> Processors: 4
> Allocating PCI resources starting at fb800000 (gap: fb000000:4780000)
> Checking aperture...
> CPU 0: aperture @ cc24000000 size 32 MB
> Aperture from northbridge cpu 0 too small (32 MB)
> No AGP bridge found
> Your BIOS doesn't leave a aperture memory hole
> Please enable the IOMMU option in the BIOS setup
> This costs you 64 MB of RAM
> Mapping aperture over 65536 KB of RAM @ 8000000
> Built 1 zonelists
> Kernel command line: root=/dev/sda8 ro console=tty0
> Initializing CPU#0
> PID hash table entries: 4096 (order: 12, 32768 bytes)
> time.c: Using 1.193182 MHz WALL PIT GTOD PIT/TSC timer.
> time.c: Detected 2190.816 MHz processor.
> Console: colour VGA+ 80x25
> Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
> Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
> Memory: 6038612k/6291456k available (3002k kernel code, 170092k 
> reserved, 1269k data, 168k init)
> Calibrating delay using timer specific routine.. 4390.66 BogoMIPS 
> (lpj=8781339)
> Mount-cache hash table entries: 256
> CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
> CPU: L2 Cache: 1024K (64 bytes/line)
> Using IO-APIC 4
> Using IO-APIC 5
> Using IO-APIC 6
> GSI 18 sharing vector 0x89 and IRQ 18
> GSI 19 sharing vector 0x91 and IRQ 19
> GSI 24 sharing vector 0x99 and IRQ 24
> GSI 25 sharing vector 0xA1 and IRQ 25
> GSI 29 sharing vector 0xA9 and IRQ 29
> Using local APIC timer interrupts.
> result 12447820
> Detected 12.447 MHz APIC timer.
> Booting processor 1/4 APIC 0x1
> Initializing CPU#1
> Calibrating delay using timer specific routine.. 4381.80 BogoMIPS 
> (lpj=8763613)
> CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
> CPU: L2 Cache: 1024K (64 bytes/line)
> Dual Core AMD Opteron(tm) Processor 275 stepping 02
> CPU 1: Syncing TSC to CPU 0.
> CPU 1: synchronized TSC with CPU 0 (last diff 6 cycles, maxerr 627 cycles)
> Booting processor 2/4 APIC 0x2
> Initializing CPU#2
> Calibrating delay using timer specific routine.. 4381.88 BogoMIPS 
> (lpj=8763771)
> CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
> CPU: L2 Cache: 1024K (64 bytes/line)
> Dual Core AMD Opteron(tm) Processor 275 stepping 02
> CPU 2: Syncing TSC to CPU 0.
> CPU 2: synchronized TSC with CPU 0 (last diff 1 cycles, maxerr 876 cycles)
> Booting processor 3/4 APIC 0x3
> Initializing CPU#3
> Calibrating delay using timer specific routine.. 4381.92 BogoMIPS 
> (lpj=8763852)
> CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
> CPU: L2 Cache: 1024K (64 bytes/line)
> Dual Core AMD Opteron(tm) Processor 275 stepping 02
> CPU 3: Syncing TSC to CPU 0.
> CPU 3: synchronized TSC with CPU 0 (last diff 7 cycles, maxerr 864 cycles)
> Brought up 4 CPUs
> testing NMI watchdog ... OK.
> migration_cost=460
> NET: Registered protocol family 16
> PCI: Using configuration type 1
> SCSI subsystem initialized
> PCI: Probing PCI hardware
> PCI: Probing PCI hardware (bus 00)
> Boot video device is 0000:03:06.0
> PCI: Using IRQ router default [1022/746b] at 0000:00:07.3
> PCI->APIC IRQ transform: 0000:00:07.2[D] -> IRQ 19
> PCI->APIC IRQ transform: 0000:03:06.0[A] -> IRQ 18
> PCI->APIC IRQ transform: 0000:03:08.0[A] -> IRQ 18
> PCI->APIC IRQ transform: 0000:02:09.0[A] -> IRQ 24
> PCI->APIC IRQ transform: 0000:02:09.1[B] -> IRQ 25
> PCI->APIC IRQ transform: 0000:01:04.0[A] -> IRQ 29
> PCI-DMA: Disabling AGP.
> PCI-DMA: aperture base @ 8000000 size 65536 KB
> PCI-DMA: using GART IOMMU.
> PCI-DMA: Reserving 64MB of IOMMU area in the AGP aperture
> PCI: Bridge: 0000:00:06.0
>  IO window: 9000-bfff
>  MEM window: fca00000-feafffff
>  PREFETCH window: disabled.
> PCI: Bridge: 0000:00:0a.0
>  IO window: disabled.
>  MEM window: fc900000-fc9fffff
>  PREFETCH window: fc600000-fc6fffff
> PCI: Bridge: 0000:00:0b.0
>  IO window: 8000-8fff
>  MEM window: fc800000-fc8fffff
>  PREFETCH window: fb500000-fc5fffff
> NET: Registered protocol family 2
> IP route cache hash table entries: 262144 (order: 9, 2097152 bytes)
> TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
> TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
> TCP: Hash tables configured (established 262144 bind 65536)
> TCP reno registered
> IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
> Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
> Initializing Cryptographic API
> io scheduler noop registered
> io scheduler anticipatory registered
> io scheduler deadline registered (default)
> io scheduler cfq registered
> PCI: MSI quirk detected. PCI_BUS_FLAGS_NO_MSI set for subordinate bus.
> PCI: MSI quirk detected. PCI_BUS_FLAGS_NO_MSI set for subordinate bus.
> Real Time Clock Driver v1.12ac
> Linux agpgart interface v0.101 (c) Dave Jones
> Floppy drive(s): fd0 is 1.44M
> FDC 0 is a post-1991 82077
> loop: loaded (max 8 devices)
> Intel(R) PRO/1000 Network Driver - version 7.0.33-k2
> Copyright (c) 1999-2005 Intel Corporation.
> eepro100.c:v1.09j-t 9/29/99 Donald Becker 
> http://www.scyld.com/network/eepro100.html
> eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin 
> <saw@saw.sw.com.sg> and others
> eth0: 0000:03:08.0, 00:E0:81:32:F6:36, IRQ 18.
>  Board assembly 567812-052, Physical connectors present: RJ45
>  Primary interface chip i82555 PHY #1.
>  General self-test: passed.
>  Serial sub-system self-test: passed.
>  Internal registers self-test: passed.
>  ROM checksum self-test: passed (0xd0a6c714).
> e100: Intel(R) PRO/100 Network Driver, 3.5.10-k2-NAPI
> e100: Copyright(c) 1999-2005 Intel Corporation
> tg3.c:v3.59 (June 8, 2006)
> eth1: Tigon3 [partno(BCM95704A7) rev 2003 PHY(5704)] 
> (PCIX:100MHz:64-bit) 10/100/1000BaseT Ethernet 00:e0:81:32:f7:ac
> eth1: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] 
> TSOcap[1]
> eth1: dma_rwctrl[769f4000] dma_mask[64-bit]
> eth2: Tigon3 [partno(BCM95704A7) rev 2003 PHY(5704)] 
> (PCIX:100MHz:64-bit) 10/100/1000BaseT Ethernet 00:e0:81:32:f7:ad
> eth2: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] 
> TSOcap[1]
> eth2: dma_rwctrl[769f4000] dma_mask[64-bit]
> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> 3ware 9000 Storage Controller device driver for Linux v2.26.02.007.
> 3w-9xxx: scsi0: AEN: INFO (0x04:0x0055): Battery charging started:.
> 3w-9xxx: scsi0: AEN: INFO (0x04:0x0053): Battery capacity test is overdue:.
> scsi0 : 3ware 9000 Storage Controller
> 3w-9xxx: scsi0: Found a 3ware 9000 Storage Controller at 0xfc8ffc00, 
> IRQ: 29.
> 3w-9xxx: scsi0: Firmware FE9X 2.08.00.005, BIOS BE9X 2.03.01.052, Ports: 8.
>  Vendor: AMCC      Model: 9500S-8    DISK   Rev: 2.08
>  Type:   Direct-Access                      ANSI SCSI revision: 03
> SCSI device sda: 956884992 512-byte hdwr sectors (489925 MB)
> sda: Write Protect is off
> sda: Mode Sense: 23 00 00 00
> SCSI device sda: drive cache: write back, no read (daft)
> SCSI device sda: 956884992 512-byte hdwr sectors (489925 MB)
> sda: Write Protect is off
> sda: Mode Sense: 23 00 00 00
> SCSI device sda: drive cache: write back, no read (daft)
> sda: sda1 < sda5 sda6 sda7 sda8 sda9 sda10 > sda2 sda3
> sd 0:0:0:0: Attached scsi disk sda
> serio: i8042 AUX port at 0x60,0x64 irq 12
> serio: i8042 KBD port at 0x60,0x64 irq 1
> mice: PS/2 mouse device common for all mice
> TCP bic registered
> NET: Registered protocol family 1
> NET: Registered protocol family 10
> IPv6 over IPv4 tunneling driver
> NET: Registered protocol family 17
> NET: Registered protocol family 15
> 802.1Q VLAN Support v1.8 Ben Greear <greearb@candelatech.com>
> All bugs added by David S. Miller <davem@redhat.com>
> ReiserFS: sda8: found reiserfs format "3.6" with standard journal
> ReiserFS: sda8: using ordered data mode
> ReiserFS: sda8: journal params: device sda8, size 8192, journal first 
> block 18, max trans len 1024, max batch 900, max commit age 30, max 
> trans age 30
> ReiserFS: sda8: checking transaction log (sda8)
> input: AT Translated Set 2 keyboard as /class/input/input0
> ReiserFS: sda8: replayed 15 transactions in 1 seconds
> ReiserFS: sda8: Using r5 hash to sort names
> VFS: Mounted root (reiserfs filesystem) readonly.
> Freeing unused kernel memory: 168k freed
> Adding 1951856k swap on /dev/sda5.  Priority:-1 extents:1 across:1951856k
> Adding 1951856k swap on /dev/sda6.  Priority:-2 extents:1 across:1951856k
> Adding 1951792k swap on /dev/sda7.  Priority:-3 extents:1 across:1951792k
> ReiserFS: sda10: found reiserfs format "3.6" with standard journal
> ReiserFS: sda10: using ordered data mode
> ReiserFS: sda10: journal params: device sda10, size 8192, journal first 
> block 18, max trans len 1024, max batch 900, max commit age 30, max 
> trans age 30
> ReiserFS: sda10: checking transaction log (sda10)
> ReiserFS: sda10: Using r5 hash to sort names
> ReiserFS: sda10: Removing [30 40588 0x0 SD]..done
> ReiserFS: sda10: Removing [3 40583 0x0 SD]..done
> ReiserFS: sda10: Removing [3 40582 0x0 SD]..done
> ReiserFS: sda10: Removing [3 40579 0x0 SD]..done
> ReiserFS: sda10: There were 4 uncompleted unlinks/truncates. Completed
> ReiserFS: sda2: found reiserfs format "3.6" with standard journal
> ReiserFS: sda2: using ordered data mode
> ReiserFS: sda2: journal params: device sda2, size 8192, journal first 
> block 18, max trans len 1024, max batch 900, max commit age 30, max 
> trans age 30
> ReiserFS: sda2: checking transaction log (sda2)
> ReiserFS: sda2: Using r5 hash to sort names
> ReiserFS: sda2: Removing [1306 51393 0x0 SD]..done
> ReiserFS: sda2: Removing [1306 51193 0x0 SD]..done
> ReiserFS: sda2: There were 2 uncompleted unlinks/truncates. Completed
> ReiserFS: sda3: found reiserfs format "3.6" with standard journal
> ReiserFS: sda3: using ordered data mode
> ReiserFS: sda3: journal params: device sda3, size 8192, journal first 
> block 18, max trans len 1024, max batch 900, max commit age 30, max 
> trans age 30
> ReiserFS: sda3: checking transaction log (sda3)
> ReiserFS: sda3: Using r5 hash to sort names
> PM: Writing back config space on device 0000:02:09.1 at offset b (was 
> 164814e4, writing 164414e4)
> PM: Writing back config space on device 0000:02:09.1 at offset 3 (was 
> 804000, writing 804010)
> PM: Writing back config space on device 0000:02:09.1 at offset 2 (was 
> 2000000, writing 2000003)
> PM: Writing back config space on device 0000:02:09.1 at offset 1 (was 
> 2b00000, writing 2b00106)
> ADDRCONF(NETDEV_UP): eth2: link is not ready
> tg3: eth2: Link is up at 1000 Mbps, full duplex.
> tg3: eth2: Flow control is off for TX and off for RX.
> ADDRCONF(NETDEV_CHANGE): eth2: link becomes ready
> eth2: no IPv6 routers present
> 3w-9xxx: scsi0: AEN: INFO (0x04:0x0056): Battery charging completed:.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
