Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261466AbULTTqp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261466AbULTTqp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 14:46:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbULTTqp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 14:46:45 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:11255 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261466AbULTTqU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 14:46:20 -0500
Message-ID: <41C72C07.3080702@mvista.com>
Date: Mon, 20 Dec 2004 11:46:15 -0800
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sumit Pandya <sumit@elitecore.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.26 date and hwclock
References: <HGEFKOBCHAIJDIEJLAKDOEOACAAA.sumit@elitecore.com>
In-Reply-To: <HGEFKOBCHAIJDIEJLAKDOEOACAAA.sumit@elitecore.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A few comments:
First could you pin down the HZ value.  I assume it is 100.  If it is other than 
that, the following is MORE of an issue.

You are comparing two independent clocks run from different "rocks".  If I were 
a hardware designer, I would set up the run time clock to keep the "best" time 
when the machine was warm, i.e. running and the hwclock to keep the "best" time 
when the machine was cold, i.e. off.  One should expect "some" drift between 
these two.

You might want do do a detailed read of the hwclock man page.  Here is a quote:
       The  Hardware Clock is usually not very accurate.  However, much of its
        inaccuracy is completely predictable -  it  gains  or  loses  the  same
        amount  of time every day.  This is called systematic drift.  hwclock's
        "adjust" function lets you make systematic corrections to  correct  the
        systematic drift.


It is possible to use ntp to correct small errors of this sort.  As per the man 
page, this will also adjust the hardware clock.

George

Sumit Pandya wrote:
> All,
> 	we have seen a strange timer problem with running kernel-2.4.26 on many
> different machines. After few hours of uptime both date and hwclock shows
> different time in output. I'm sending few out of those observations
> System 1
> uptime ; date ; /sbin/hwclock
>   7:58pm  up 2 days,  5:39,  2 users,  load average: 0.00, 0.02, 0.07
> Mon Dec 20 19:58:19 IST 2004
> Mon Dec 20 19:58:32 2004  -0.606892 seconds
> 
> System 2
> uptime ; date ; /sbin/hwclock
>   8:02pm  up 4 days, 47 min,  1 user,  load average: 0.00, 0.00, 0.00
> Mon Dec 20 20:02:05 IST 2004
> Mon Dec 20 20:02:30 2004  -0.885209 seconds
> 
> System 3
> uptime ; date ; /sbin/hwclock
>   8:13pm  up 5 days,  9:38,  2 users,  load average: 0.01, 0.05, 0.07
> Mon Dec 20 20:13:02 IST 2004
> Mon Dec 20 20:13:32 2004  -0.229820 seconds
> 
> 	Seems have fix skew of 6 seconds in a day (24-hour). Is it a known problem
> and already fixed? In last of mail you can find dmesg of last 2 systems.
> 
> 	This kernel is downloaded from http://www.kernel.org and having few
> networking patches applied namely, br-nf, imq, netfilter patch-o-matic.
> 
> Please CC to me. Thankx
> -- Sumit
> 
> 
> System 2 (dmesg)
> 
> 000.
> Enabling APIC mode: Flat.       Using 1 I/O APICs
> Processors: 1
> Kernel command line: auto BOOT_IMAGE=linux-up ro root=305
> BOOT_FILE=/boot/vmlinuz-2.4.26-3 acpi=off console=ttyS0
> Initializing CPU#0
> Detected 2261.051 MHz processor.
> Console: colour VGA+ 80x25
> Calibrating delay loop... 4508.87 BogoMIPS
> Memory: 498676k/507068k available (1202k kernel code, 8004k reserved, 484k
> data, 108k init, 0k highmem)
> Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
> Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
> Mount cache hash table entries: 512 (order: 0, 4096 bytes)
> Buffer cache hash table entries: 32768 (order: 5, 131072 bytes)
> Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
> CPU: Trace cache: 12K uops, L1 D cache: 8K
> CPU: L2 cache: 512K
> Intel machine check architecture supported.
> Intel machine check reporting enabled on CPU#0.
> CPU:     After generic, caps: bfebfbff 00000000 00000000 00000000
> CPU:             Common caps: bfebfbff 00000000 00000000 00000000
> CPU: Intel(R) Pentium(R) 4 CPU 2.26GHz stepping 09
> Enabling fast FPU save and restore... done.
> Enabling unmasked SIMD FPU exception support... done.
> Checking 'hlt' instruction... OK.
> POSIX conformance testing by UNIFIX
> enabled ExtINT on CPU#0
> ESR value before enabling vector: 00000000
> ESR value after enabling vector: 00000000
> ENABLING IO-APIC IRQs
> Setting 1 in the phys_id_present_map
> ...changing IO-APIC physical APIC ID to 1 ... ok.
> init IO_APIC IRQs
>  IO-APIC (apicid-pin) 1-0, 1-22 not connected.
> ..TIMER: vector=0x31 pin1=2 pin2=0
> number of MP IRQ sources: 25.
> number of IO-APIC #1 registers: 24.
> testing the IO APIC.......................
> 
> IO APIC #1......
> .... register #00: 01000000
> .......    : physical APIC id: 01
> .......    : Delivery Type: 0
> .......    : LTS          : 0
> .... register #01: 00178020
> .......     : max redirection entries: 0017
> .......     : PRQ implemented: 1
> .......     : IO APIC version: 0020
> .... IRQ redirection table:
>  NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
>  00 0ED 0D  1    0    0   0   0    0    2    84
>  01 001 01  0    0    0   0   0    1    1    39
>  02 001 01  0    0    0   0   0    1    1    31
>  03 001 01  0    0    0   0   0    1    1    41
>  04 001 01  0    0    0   0   0    1    1    49
>  05 001 01  0    0    0   0   0    1    1    51
>  06 001 01  0    0    0   0   0    1    1    59
>  07 001 01  0    0    0   0   0    1    1    61
>  08 001 01  0    0    0   0   0    1    1    69
>  09 001 01  1    1    0   0   0    1    1    71
>  0a 001 01  0    0    0   0   0    1    1    79
>  0b 001 01  0    0    0   0   0    1    1    81
>  0c 001 01  0    0    0   0   0    1    1    89
>  0d 001 01  0    0    0   0   0    1    1    91
>  0e 001 01  0    0    0   0   0    1    1    99
>  0f 001 01  0    0    0   0   0    1    1    A1
>  10 001 01  1    1    0   1   0    1    1    A9
>  11 001 01  1    1    0   1   0    1    1    B1
>  12 001 01  1    1    0   1   0    1    1    B9
>  13 001 01  1    1    0   1   0    1    1    C1
>  14 001 01  1    1    0   1   0    1    1    C9
>  15 001 01  1    1    0   1   0    1    1    D1
>  16 000 00  1    0    0   0   0    0    0    00
>  17 001 01  1    1    0   1   0    1    1    D9
> IRQ to pin mappings:
> IRQ0 -> 0:2
> IRQ1 -> 0:1
> IRQ3 -> 0:3
> IRQ4 -> 0:4
> IRQ5 -> 0:5
> IRQ6 -> 0:6
> IRQ7 -> 0:7
> IRQ8 -> 0:8
> IRQ9 -> 0:9
> IRQ10 -> 0:10
> IRQ11 -> 0:11
> IRQ12 -> 0:12
> IRQ13 -> 0:13
> IRQ14 -> 0:14
> IRQ15 -> 0:15
> IRQ16 -> 0:16
> IRQ17 -> 0:17
> IRQ18 -> 0:18
> IRQ19 -> 0:19
> IRQ20 -> 0:20
> IRQ21 -> 0:21
> IRQ23 -> 0:23
> .................................... done.
> Using local APIC timer interrupts.
> calibrating APIC timer ...
> ..... CPU clock speed is 2260.9938 MHz.
> ..... host bus clock speed is 132.9995 MHz.
> cpu: 0, clocks: 1329995, slice: 664997
> CPU0<T0:1329984,T1:664976,D:11,S:664997,C:1329995>
> ACPI: Subsystem revision 20040326
> ACPI: Interpreter disabled.
> PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=1
> PCI: Using configuration type 1
> PCI: Probing PCI hardware
> PCI: ACPI tables contain no PCI IRQ routing entries
> PCI: Probing PCI hardware (bus 00)
> PCI: Ignoring BAR0-3 of IDE controller 00:1f.1
> Transparent bridge - Intel Corp. 82801BA/CA/DB/EB PCI Bridge
> PCI: Using IRQ router PIIX/ICH [8086/24d0] at 00:1f.0
> PCI->APIC IRQ transform: (B0,I2,P0) -> 16
> PCI->APIC IRQ transform: (B0,I29,P0) -> 16
> PCI->APIC IRQ transform: (B0,I29,P1) -> 19
> PCI->APIC IRQ transform: (B0,I29,P2) -> 18
> PCI->APIC IRQ transform: (B0,I29,P0) -> 16
> PCI->APIC IRQ transform: (B0,I29,P3) -> 23
> PCI->APIC IRQ transform: (B0,I31,P0) -> 18
> PCI->APIC IRQ transform: (B0,I31,P1) -> 17
> PCI->APIC IRQ transform: (B0,I31,P1) -> 17
> PCI->APIC IRQ transform: (B1,I0,P0) -> 21
> PCI->APIC IRQ transform: (B1,I8,P0) -> 20
> isapnp: Scanning for PnP cards...
> isapnp: No Plug & Play device found
> Linux NET4.0 for Linux 2.4
> Based upon Swansea University Computer Society NET3.039
> Initializing RT netlink socket
> Starting kswapd
> VFS: Disk quotas vdquot_6.5.1
> pty: 512 Unix98 ptys configured
> Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
> SERIAL_PCI ISAPNP enabled
> ttyS00 at 0x03f8 (irq = 4) is a 16550A
> Real Time Clock Driver v1.10f
> <snip>
> 
> 
> System 3 (dmesg)
> 
> Linux version 2.4.26-3 (root@development) (Elitecore gcc 3.0.1) #27 Wed Oct
> 20 13:53:39 IST 2004
> BIOS-provided physical RAM map:
>  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
>  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
>  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
>  BIOS-e820: 0000000000100000 - 000000001fe40000 (usable)
>  BIOS-e820: 000000001fe40000 - 000000001fe50000 (ACPI data)
>  BIOS-e820: 000000001fe50000 - 000000001ff00000 (ACPI NVS)
> 0MB HIGHMEM available.
> 510MB LOWMEM available.
> On node 0 totalpages: 130624
> zone(0): 4096 pages.
> zone(1): 126528 pages.
> zone(2): 0 pages.
> Kernel command line: auto BOOT_IMAGE=linux-up ro root=305
> BOOT_FILE=/boot/vmlinuz-2.4.26-3 acpi=off
> Found and enabled local APIC!
> Initializing CPU#0
> Detected 1699.990 MHz processor.
> Console: colour VGA+ 80x25
> Calibrating delay loop... 3394.76 BogoMIPS
> Memory: 513836k/522496k available (1254k kernel code, 8272k reserved, 508k
> data, 120k init, 0k highmem)
> Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
> Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
> Mount cache hash table entries: 512 (order: 0, 4096 bytes)
> Buffer cache hash table entries: 32768 (order: 5, 131072 bytes)
> Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
> CPU: Trace cache: 12K uops, L1 D cache: 8K
> CPU: L2 cache: 256K
> Intel machine check architecture supported.
> Intel machine check reporting enabled on CPU#0.
> CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
> CPU:             Common caps: 3febfbff 00000000 00000000 00000000
> CPU: Intel(R) Pentium(R) 4 CPU 1.70GHz stepping 03
> Enabling fast FPU save and restore... done.
> Enabling unmasked SIMD FPU exception support... done.
> Checking 'hlt' instruction... OK.
> POSIX conformance testing by UNIFIX
> enabled ExtINT on CPU#0
> ESR value before enabling vector: 00000000
> ESR value after enabling vector: 00000000
> Using local APIC timer interrupts.
> calibrating APIC timer ...
> ..... CPU clock speed is 1699.9595 MHz.
> ..... host bus clock speed is 99.9974 MHz.
> cpu: 0, clocks: 999974, slice: 499987
> CPU0<T0:999968,T1:499968,D:13,S:499987,C:999974>
> ACPI: Subsystem revision 20040326
> ACPI: Interpreter disabled.
> PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=1
> PCI: Using configuration type 1
> PCI: Probing PCI hardware
> PCI: ACPI tables contain no PCI IRQ routing entries
> PCI: Probing PCI hardware (bus 00)
> PCI: Ignoring BAR0-3 of IDE controller 00:1f.1
> Transparent bridge - Intel Corp. 82801BA/CA/DB/EB PCI Bridge
> PCI: Using IRQ router PIIX/ICH [8086/24c0] at 00:1f.0
> PCI: Found IRQ 10 for device 00:1f.1
> PCI: Sharing IRQ 10 with 00:1d.2
> PCI: Sharing IRQ 10 with 01:02.0
> isapnp: Scanning for PnP cards...
> isapnp: No Plug & Play device found
> Linux NET4.0 for Linux 2.4
> Based upon Swansea University Computer Society NET3.039
> Initializing RT netlink socket
> Starting kswapd
> VFS: Disk quotas vdquot_6.5.1
> pty: 512 Unix98 ptys configured
> Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
> SERIAL_PCI ISAPNP enabled
> ttyS00 at 0x03f8 (irq = 4) is a 16550A
> ttyS01 at 0x02f8 (irq = 3) is a 16550A
> Real Time Clock Driver v1.10f
> <snip>
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/

