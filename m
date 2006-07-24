Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932226AbWGXRTr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932226AbWGXRTr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 13:19:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932231AbWGXRTr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 13:19:47 -0400
Received: from run.smurf.noris.de ([192.109.102.41]:32206 "EHLO smurf.noris.de")
	by vger.kernel.org with ESMTP id S932226AbWGXRTp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 13:19:45 -0400
Date: Mon, 24 Jul 2006 19:17:11 +0200
To: john stultz <johnstul@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, bunk@stusta.de, lethal@linux-sh.org,
       hirofumi@mail.parknet.co.jp, Andi Kleen <ak@muc.de>
Subject: Re: REGRESSION: the new i386 timer code fails to sync CPUs
Message-ID: <20060724171711.GA3662@kiste.smurf.noris.de>
References: <20060722233638.GC27566@kiste.smurf.noris.de> <20060722173649.952f909f.akpm@osdl.org> <20060723081604.GD27566@kiste.smurf.noris.de> <20060723044637.3857d428.akpm@osdl.org> <20060723120829.GA7776@kiste.smurf.noris.de> <20060723053755.0aaf9ce0.akpm@osdl.org> <1153756738.9440.14.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1153756738.9440.14.camel@localhost>
User-Agent: Mutt/1.5.11
From: Matthias Urlichs <smurf@smurf.noris.de>
X-Smurf-Whitelist: +relay_from_hosts
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

john stultz:
> I'll see what we can do to narrow it down, but its been assumed by both
> x86-64 and the new i386 code that the TSCs on Intel SMP boxes are
> synched, unless we're explicitly told they aren't (Summit, etc).
> 
Apparently not. :-/

> Andi: If this is a generic issue, and not specific to Matthias' box, we
> may need to re-think the assumption that Intel SMP is synced. You're
> thoughts?
> 
"Your". ;-)

You can probably assume that they're synced on systems with no more
than one dual-core / hyperthreaded CPU.

My system obviously has two of those.

> Matthias: "clock=pmtmr" is probably the best workaround in the short
> term. Could you send me your dmesg and dmidecode output? We'll try to
> find something to key off of so it will mark the tsc as unstable by
> default on your system.
> 
I'd assume that finding (and, possibly, being unable to correct) TSC skew 
is sufficient. Whether it's also necessary (in the mathematical sense ;-)
for the problem to exist is a question somebody else might want to answer
(or not).

Linux version 2.6.17-test-1.29 (root@kiste) (gcc version 4.0.3 (Ubuntu 4.0.3-1ubuntu5)) #2 SMP PREEMPT Sun Jul 23 09:00:44 CEST 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009b000 (usable)
 BIOS-e820: 000000000009b000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000ca000 - 00000000000cc000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000d7f70000 (usable)
 BIOS-e820: 00000000d7f70000 - 00000000d7f7b000 (ACPI data)
 BIOS-e820: 00000000d7f7b000 - 00000000d7f80000 (ACPI NVS)
 BIOS-e820: 00000000d7f80000 - 00000000d8000000 (reserved)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ff800000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fffffc00 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 0000000128000000 (usable)
Warning only 4GB will be used.
Use a PAE enabled kernel.
3200MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000f6700
On node 0 totalpages: 1048576
  DMA zone: 4096 pages, LIFO batch:0
  Normal zone: 225280 pages, LIFO batch:31
  HighMem zone: 819200 pages, LIFO batch:31
DMI present.
ACPI: RSDP (v000 PTLTD                                 ) @ 0x000f6750
ACPI: RSDT (v001 PTLTD    RSDT   0x06040000  LTP 0x00000000) @ 0xd7f75ea1
ACPI: FADT (v001 INTEL  TUMWATER 0x06040000 PTL  0x00000003) @ 0xd7f7ae35
ACPI: MADT (v001 PTLTD           APIC   0x06040000  LTP 0x00000000) @ 0xd7f7aea9ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x06040000  LTP 0x00000001) @ 0xd7f7af39
ACPI: MCFG (v001 PTLTD           Mcfg   0x06040000  LTP 0x00000000) @ 0xd7f7af61ACPI: ASF! (v016   CETP     CETP 0x06040000 PTL  0x00000001) @ 0xd7f7af9d
ACPI: SSDT (v001  PmRef    CpuPm 0x00003000 INTL 0x20030224) @ 0xd7f75edd
ACPI: DSDT (v001  Intel Lindhrst 0x06040000 MSFT 0x0100000e) @ 0x00000000
ACPI: PM-Timer IO Port: 0x1008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:4 APIC version 20
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x06] enabled)
Processor #6 15:4 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:4 APIC version 20
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x07] enabled)
Processor #7 15:4 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x03] address[0xfec10000] gsi_base[24])
IOAPIC[1]: apic_id 3, version 32, address 0xfec10000, GSI 24-47
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 2 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at f1000000 (gap: f0000000:0ec00000)
Detected 3000.267 MHz processor.
Built 1 zonelists.  Total pages: 1048576
Kernel command line: root=/dev/md1 ro break
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
mapped IOAPIC to ffffb000 (fec10000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 16384 bytes)
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 3483476k/4194304k available (1724k kernel code, 53692k reserved, 982k data, 204k init, 2620864k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 6004.95 BogoMIPS (lpj=12009910)Mount-cache hash table entries: 512
CPU: After generic identify, caps: bfebfbff 20100000 00000000 00000000 0000641d 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 20100000 00000000 00000000 0000641d 00000000 00000000
monitor/mwait feature present.
using mwait in idle threads.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU: Physical Processor ID: 0
CPU: After all inits, caps: bfebfbff 20100000 00000000 00000180 0000641d 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (24) available
Checking 'hlt' instruction... OK.
Freeing SMP alternatives: 12k freed
ACPI: Core revision 20060608
CPU0: Intel(R) Xeon(TM) CPU 3.00GHz stepping 03
Booting processor 1/1 eip 2000
Initializing CPU#1
Calibrating delay using timer specific routine.. 6000.69 BogoMIPS (lpj=12001383)CPU: After generic identify, caps: bfebfbff 20100000 00000000 00000000 0000641d 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 20100000 00000000 00000000 0000641d 00000000 00000000
monitor/mwait feature present.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU: Physical Processor ID: 0
CPU: After all inits, caps: bfebfbff 20100000 00000000 00000180 0000641d 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel P4/Xeon Extended MCE MSRs (24) available
CPU1: Intel(R) Xeon(TM) CPU 3.00GHz stepping 03
Booting processor 2/6 eip 2000
Initializing CPU#2
Calibrating delay using timer specific routine.. 5600.72 BogoMIPS (lpj=11201451)CPU: After generic identify, caps: bfebfbff 20100000 00000000 00000000 0000641d 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 20100000 00000000 00000000 0000641d 00000000 00000000
monitor/mwait feature present.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU: Physical Processor ID: 3
CPU: After all inits, caps: bfebfbff 20100000 00000000 00000180 0000641d 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#2.
CPU2: Intel P4/Xeon Extended MCE MSRs (24) available
CPU2: Intel(R) Xeon(TM) CPU 3.00GHz stepping 03
Booting processor 3/7 eip 2000
Initializing CPU#3
Calibrating delay using timer specific routine.. 5600.72 BogoMIPS (lpj=11201442)CPU: After generic identify, caps: bfebfbff 20100000 00000000 00000000 0000641d 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 20100000 00000000 00000000 0000641d 00000000 00000000
monitor/mwait feature present.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU: Physical Processor ID: 3
CPU: After all inits, caps: bfebfbff 20100000 00000000 00000180 0000641d 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#3.
CPU3: Intel P4/Xeon Extended MCE MSRs (24) available
CPU3: Intel(R) Xeon(TM) CPU 3.00GHz stepping 03
Total of 4 processors activated (23207.09 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
checking TSC synchronization across 4 CPUs:
CPU#0 had 748437 usecs TSC skew, fixed it up.
CPU#1 had 748437 usecs TSC skew, fixed it up.
CPU#2 had -748437 usecs TSC skew, fixed it up.
CPU#3 had -748437 usecs TSC skew, fixed it up.
Brought up 4 CPUs
migration_cost=85,1724
checking if image is initramfs... it is
Freeing initrd memory: 4192k freed
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using MMCONFIG
Setting up standard PCI resources
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI quirk: region 1000-107f claimed by ICH4 ACPI/GPIO/TCO
PCI quirk: region 1180-11bf claimed by ICH4 GPIO
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Boot video device is 0000:04:03.0
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIX._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 *5 6 7 10 11 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 11 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 *11 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 *11 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 4 5 6 7 10 11 14 15) *3
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 *10 11 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 4 5 6 7 *10 11 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Bridge: 0000:00:02.0
  IO window: disabled.
  MEM window: da100000-da1fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:03.0
  IO window: disabled.
  MEM window: da200000-da2fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.0
  IO window: 2000-2fff
  MEM window: da300000-da3fffff
  PREFETCH window: de000000-dfffffff
PCI: Bridge: 0000:05:04.0
  IO window: 4000-4fff
  MEM window: dc000000-dc0fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:04:02.0
  IO window: 4000-4fff
  MEM window: dc000000-dc0fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1e.0
  IO window: 3000-4fff
  MEM window: da400000-dc0fffff
  PREFETCH window: f1000000-f10fffff
ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:02.0 to 64
ACPI: PCI Interrupt 0000:00:03.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:03.0 to 64
PCI: Setting latency timer of device 0000:00:1e.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 131072 (order: 7, 524288 bytes)
TCP established hash table entries: 131072 (order: 9, 3145728 bytes)
TCP bind hash table entries: 65536 (order: 8, 1572864 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
Simple Boot Flag at 0x36 set to 0x1
Machine check exception polling timer started.
highmem bounce pool size: 64 pages
Initializing Cryptographic API
io scheduler noop registered
io scheduler cfq registered (default)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
PNP: No PS/2 controller found. Probing ports directly.
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
TCP bic registered
NET: Registered protocol family 1
Starting balanced_irq
Using IPI Shortcut mode
Freeing unused kernel memory: 204k freed
Time: tsc clocksource has been installed.
[ snip -- /sbin/init gets called here ]



# dmidecode 2.7
SMBIOS 2.33 present.
42 structures occupying 1394 bytes.
Table at 0x000EFC60.

Handle 0x0000, DMI type 0, 20 bytes.
BIOS Information
        Vendor: Phoenix Technologies LTD
        Version: 6.00
        Release Date: 09/29/2005
        Address: 0xE1C80
        Runtime Size: 123776 bytes
        ROM Size: 1024 kB
        Characteristics:
                ISA is supported
                PCI is supported
                PC Card (PCMCIA) is supported
                PNP is supported
                APM is supported
                BIOS is upgradeable
                BIOS shadowing is allowed
                ESCD support is available
                USB legacy is supported
                Smart battery is supported
                BIOS boot specification is supported

Handle 0x0001, DMI type 1, 25 bytes.
System Information
        Manufacturer: Intel Corporation
        Product Name: Nocona/Tumwater Customer Reference Board
        Version: Revision A0
        Serial Number: 0123456789
        UUID: 0A0A0A0A-0A0A-0A0A-0A0A-0A0A0A0A0A0A
        Wake-up Type: Power Switch

Handle 0x0002, DMI type 2, 8 bytes.
Base Board Information
        Manufacturer: Intel Corporation
        Product Name: TYAN Tiger-i7320-S5350
        Version: Revision A0
        Serial Number: 9876543210

Handle 0x0003, DMI type 3, 17 bytes.
Chassis Information
        Manufacturer: No Enclosure
        Type: Other
        Lock: Not Present
        Version: N/A
        Serial Number: None
        Asset Tag: No Asset Tag
        Boot-up State: Safe
        Power Supply State: Safe
        Thermal State: Safe
        Security Status: None
        OEM Information: 0x00001234

Handle 0x0004, DMI type 4, 35 bytes.
Processor Information
        Socket Designation: SOCKET603/604
        Type: Central Processor
        Family: Pentium 4
        Manufacturer: Intel
        ID: 43 0F 00 00 FF FB EB BF
        Signature: Type 0, Family 15, Model 4, Stepping 3
        Flags:
                FPU (Floating-point unit on-chip)
                VME (Virtual mode extension)
                DE (Debugging extension)
                PSE (Page size extension)
                TSC (Time stamp counter)
                MSR (Model specific registers)
                PAE (Physical address extension)
                MCE (Machine check exception)
                CX8 (CMPXCHG8 instruction supported)
                APIC (On-chip APIC hardware supported)
                SEP (Fast system call)
                MTRR (Memory type range registers)
                PGE (Page global enable)
                MCA (Machine check architecture)
                CMOV (Conditional move instruction supported)
                PAT (Page attribute table)
                PSE-36 (36-bit page size extension)
                CLFSH (CLFLUSH instruction supported)
                DS (Debug store)
                ACPI (ACPI supported)
                MMX (MMX technology supported)
                FXSR (Fast floating-point save and restore)
                SSE (Streaming SIMD extensions)
                SSE2 (Streaming SIMD extensions 2)
                SS (Self-snoop)
                HTT (Hyper-threading technology)
                TM (Thermal monitor supported)
                PBE (Pending break enabled)
        Version: A0
        Voltage: 1.4 V
        External Clock: Unknown
        Max Speed: 3600 MHz
        Current Speed: 3000 MHz
        Status: Populated, Enabled
        Upgrade: Slot 1
        L1 Cache Handle: 0x0005
        L2 Cache Handle: 0x0006
        L3 Cache Handle: Not Provided
        Serial Number: Not Specified
        Asset Tag: Not Specified
        Part Number: Not Specified

Handle 0x0005, DMI type 7, 19 bytes.
Cache Information
        Socket Designation: L1 Cache
        Configuration: Enabled, Socketed, Level 1
        Operational Mode: Write Back
        Location: Internal
        Installed Size: 16 KB
        Maximum Size: 16 KB
        Supported SRAM Types:
                Burst
                Pipeline Burst
                Asynchronous
        Installed SRAM Type: Asynchronous
        Speed: Unknown
        Error Correction Type: Unknown
        System Type: Unknown
        Associativity: Unknown

Handle 0x0006, DMI type 7, 19 bytes.
Cache Information
        Socket Designation: L2 Cache
        Configuration: Enabled, Socketed, Level 2
        Operational Mode: Write Back
        Location: Internal
        Installed Size: 2048 KB
        Maximum Size: 512 KB
        Supported SRAM Types:
                Burst
                Pipeline Burst
                Asynchronous
        Installed SRAM Type: Burst
        Speed: Unknown
        Error Correction Type: Unknown
        System Type: Unknown
        Associativity: Unknown

Handle 0x0007, DMI type 7, 19 bytes.
Cache Information
        Socket Designation: L3 Cache
        Configuration: Enabled, Socketed, Level 3
        Operational Mode: Write Back
        Location: Internal
        Installed Size: 2048 KB
        Maximum Size: 512 KB
        Supported SRAM Types:
                Burst
                Pipeline Burst
                Asynchronous
        Installed SRAM Type: Burst
        Speed: Unknown
        Error Correction Type: Unknown
        System Type: Unknown
        Associativity: Unknown

Handle 0x0008, DMI type 8, 9 bytes.
Port Connector Information
        Internal Reference Designator: J2A1
        Internal Connector Type: 9 Pin Dual Inline (pin 10 cut)
        External Reference Designator: COM 1
        External Connector Type: DB-9 male
        Port Type: Serial Port 16550A Compatible

Handle 0x0009, DMI type 8, 9 bytes.
Port Connector Information
        Internal Reference Designator: J3A1
        Internal Connector Type: 25 Pin Dual Inline (pin 26 cut)
        External Reference Designator: Parallel
        External Connector Type: DB-25 female
        Port Type: Parallel Port ECP/EPP

Handle 0x000A, DMI type 8, 9 bytes.
Port Connector Information
        Internal Reference Designator: J1A1
        Internal Connector Type: None
        External Reference Designator: Keyboard
        External Connector Type: Circular DIN-8 male
        Port Type: Keyboard Port

Handle 0x000B, DMI type 8, 9 bytes.
Port Connector Information
        Internal Reference Designator: J1A1
        Internal Connector Type: None
        External Reference Designator: PS/2 Mouse
        External Connector Type: Circular DIN-8 male
        Port Type: Keyboard Port

Handle 0x000C, DMI type 9, 13 bytes.
System Slot Information
        Designation: PCI/33 Slot #3 - J8B2
        Type: 32-bit PCI
        Current Usage: Unknown
        Length: Long
        ID: 0
        Characteristics:
                5.0 V is provided
                3.3 V is provided

Handle 0x000D, DMI type 10, 6 bytes.
On Board Device Information
        Type: Sound
        Status: Disabled
        Description: ADI1886

Handle 0x000E, DMI type 11, 5 bytes.
OEM Strings
        String 1: Intel Nocona/Lindenhurst
        String 2: CRB - ROADRUNNER

Handle 0x000F, DMI type 12, 5 bytes.
System Configuration Options
        Option 1: Jumper settings can be described here.

Handle 0x0010, DMI type 15, 29 bytes.
System Event Log
        Area Length: 32 bytes
        Header Start Offset: 0x0000
        Header Length: 16 bytes
        Data Start Offset: 0x0010
        Access Method: General-purpose non-volatile data functions
        Access Address: 0x0000
        Status: Invalid, Not Full
        Change Token: 0x00000001
        Header Format: Type 1
        Supported Log Type Descriptors: 3
        Descriptor 1: POST error
        Data Format 1: POST results bitmap
        Descriptor 2: Single-bit ECC memory error
        Data Format 2: Multiple-event
        Descriptor 3: Multi-bit ECC memory error
        Data Format 3: Multiple-event

Handle 0x0011, DMI type 16, 15 bytes.
Physical Memory Array
        Location: System Board Or Motherboard
        Use: System Memory
        Error Correction Type: None
        Maximum Capacity: 4 GB
        Error Information Handle: Not Provided
        Number Of Devices: 2

Handle 0x0012, DMI type 17, 27 bytes.
Memory Device
        Array Handle: 0x0011
        Error Information Handle: No Error
        Total Width: Unknown
        Data Width: Unknown
        Size: No Module Installed
        Form Factor: DIMM
        Set: 1
        Locator: J3B1
        Bank Locator: DIMM A1
        Type: DDR
        Type Detail: Synchronous
        Speed: 166 MHz (6.0 ns)
        Manufacturer: Not Specified
        Serial Number: Not Specified
        Asset Tag: Not Specified
        Part Number: Not Specified

Handle 0x0013, DMI type 17, 27 bytes.
Memory Device
        Array Handle: 0x0011
        Error Information Handle: No Error
        Total Width: Unknown
        Data Width: Unknown
        Size: No Module Installed
        Form Factor: DIMM
        Set: 1
        Locator: J3B3
        Bank Locator: DIMM A2
        Type: DDR
        Type Detail: Synchronous
        Speed: 166 MHz (6.0 ns)
        Manufacturer: Not Specified
        Serial Number: Not Specified
        Asset Tag: Not Specified
        Part Number: Not Specified

Handle 0x0014, DMI type 17, 27 bytes.
Memory Device
        Array Handle: 0x0011
        Error Information Handle: No Error
        Total Width: 72 bits
        Data Width: 64 bits
        Size: 1024 MB
        Form Factor: DIMM
        Set: 1
        Locator: J2B2
        Bank Locator: DIMM A3
        Type: DDR
        Type Detail: Synchronous
        Speed: 166 MHz (6.0 ns)
        Manufacturer: Not Specified
        Serial Number: Not Specified
        Asset Tag: Not Specified
        Part Number: Not Specified

Handle 0x0015, DMI type 17, 27 bytes.
Memory Device
        Array Handle: 0x0011
        Error Information Handle: No Error
        Total Width: 72 bits
        Data Width: 64 bits
        Size: 1024 MB
        Form Factor: DIMM
        Set: 1
        Locator: J2B4
        Bank Locator: DIMM A4
        Type: DDR
        Type Detail: Synchronous
        Speed: 166 MHz (6.0 ns)
        Manufacturer: Not Specified
        Serial Number: Not Specified
        Asset Tag: Not Specified
        Part Number: Not Specified

Handle 0x0016, DMI type 17, 27 bytes.
Memory Device
        Array Handle: 0x0011
        Error Information Handle: No Error
        Total Width: Unknown
        Data Width: Unknown
        Size: No Module Installed
        Form Factor: DIMM
        Set: 1
        Locator: J3B2
        Bank Locator: DIMM B1
        Type: DDR
        Type Detail: Synchronous
        Speed: 166 MHz (6.0 ns)
        Manufacturer: Not Specified
        Serial Number: Not Specified
        Asset Tag: Not Specified
        Part Number: Not Specified

Handle 0x0017, DMI type 17, 27 bytes.
Memory Device
        Array Handle: 0x0011
        Error Information Handle: No Error
        Total Width: Unknown
        Data Width: Unknown
        Size: No Module Installed
        Form Factor: DIMM
        Set: 1
        Locator: J2B1
        Bank Locator: DIMM B2
        Type: DDR
        Type Detail: Synchronous
        Speed: 166 MHz (6.0 ns)
        Manufacturer: Not Specified
        Serial Number: Not Specified
        Asset Tag: Not Specified
        Part Number: Not Specified

Handle 0x0018, DMI type 17, 27 bytes.
Memory Device
        Array Handle: 0x0011
        Error Information Handle: No Error
        Total Width: 72 bits
        Data Width: 64 bits
        Size: 1024 MB
        Form Factor: DIMM
        Set: 1
        Locator: J2B3
        Bank Locator: DIMM B3
        Type: DDR
        Type Detail: Synchronous
        Speed: 166 MHz (6.0 ns)
        Manufacturer: Not Specified
        Serial Number: Not Specified
        Asset Tag: Not Specified
        Part Number: Not Specified

Handle 0x0019, DMI type 17, 27 bytes.
Memory Device
        Array Handle: 0x0011
        Error Information Handle: No Error
        Total Width: 72 bits
        Data Width: 64 bits
        Size: 1024 MB
        Form Factor: DIMM
        Set: 1
        Locator: J1B1
        Bank Locator: DIMM B4
        Type: DDR
        Type Detail: Synchronous
        Speed: 166 MHz (6.0 ns)
        Manufacturer: Not Specified
        Serial Number: Not Specified
        Asset Tag: Not Specified
        Part Number: Not Specified

Handle 0x001A, DMI type 19, 15 bytes.
Memory Array Mapped Address
        Starting Address: 0x00000000000
        Ending Address: 0x000FFFFFFFF
        Range Size: 4 GB
        Physical Array Handle: 0x0011
        Partition Width: 0

Handle 0x001B, DMI type 20, 19 bytes.
Memory Device Mapped Address
        Starting Address: 0x00000000000
        Ending Address: 0x000000003FF
        Range Size: 1 kB
        Physical Device Handle: 0x0012
        Memory Array Mapped Address Handle: 0x001A
        Partition Row Position: Unknown
        Interleave Position: Unknown
        Interleaved Data Depth: Unknown

Handle 0x001C, DMI type 20, 19 bytes.
Memory Device Mapped Address
        Starting Address: 0x00000000000
        Ending Address: 0x000000003FF
        Range Size: 1 kB
        Physical Device Handle: 0x0013
        Memory Array Mapped Address Handle: 0x001A
        Partition Row Position: Unknown
        Interleave Position: Unknown
        Interleaved Data Depth: Unknown

Handle 0x001D, DMI type 23, 13 bytes.
System Reset
        Status: Enabled
        Watchdog Timer: Present
        Boot Option: Do Not Reboot
        Boot Option On Limit: Do Not Reboot
        Reset Count: Unknown
        Reset Limit: Unknown
        Timer Interval: Unknown
        Timeout: Unknown

Handle 0x001E, DMI type 24, 5 bytes.
Hardware Security
        Power-On Password Status: Disabled
        Keyboard Password Status: Unknown
        Administrator Password Status: Enabled
        Front Panel Reset Status: Unknown

Handle 0x001F, DMI type 25, 9 bytes.
        System Power Controls
        Next Scheduled Power-on: 12-31 23:59:59

Handle 0x0020, DMI type 26, 20 bytes.
Voltage Probe
        Description: Voltage Probe
        Location: Processor
        Status: OK
        Maximum Value: Unknown
        Minimum Value: Unknown
        Resolution: Unknown
        Tolerance: Unknown
        Accuracy: Unknown
        OEM-specific Information: 0x00000000

Handle 0x0021, DMI type 27, 12 bytes.
Cooling Device
        Temperature Probe Handle: 0x0022
        Type: Fan
        Status: OK
        OEM-specific Information: 0x00000000

Handle 0x0022, DMI type 28, 20 bytes.
Temperature Probe
        Description: Temperature Probe
        Location: Processor
        Status: OK
        Maximum Value: Unknown
        Minimum Value Unknown
        Resolution: Unknown
        Tolerance: Unknown
        Accuracy: Unknown
        OEM-specific Information: 0x00000000

Handle 0x0023, DMI type 29, 20 bytes.
Electrical Current Probe
        Description: Electrical Current Probe
        Location: Processor
        Status: OK
        Maximum Value: Unknown
        Minimum Value: Unknown
        Resolution: Unknown
        Tolerance: Unknown
        Accuracy: Unknown
        OEM-specific Information: 0x00000000

Handle 0x0024, DMI type 30, 6 bytes.
Out-of-band Remote Access
        Manufacturer Name: Intel
        Inbound Connection: Enabled
        Outbound Connection: Disabled

Handle 0x0025, DMI type 32, 20 bytes.
System Boot Information
        Status: <OUT OF SPEC>

Handle 0x0026, DMI type 126, 4 bytes.
Inactive

Handle 0x0027, DMI type 127, 4 bytes.
End Of Table

Handle 0x0028, DMI type 129, 28 bytes.
OEM-specific Type
        Header and Data:
                81 1C 28 00 01 01 02 01 00 00 00 01 00 00 10 01
                00 01 00 01 00 00 18 01 00 02 00 01
        Strings:
                Intel_ASF_001
                Intel_ASF_001

Handle 0x0029, DMI type 127, 4 bytes.
End Of Table


> thanks
> -john
> 
> 
-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
:recursion: n. See {recursion}. See also {tail recursion}.
