Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262190AbTKCTvf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 14:51:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262196AbTKCTvf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 14:51:35 -0500
Received: from ale.atd.ucar.edu ([128.117.80.15]:57514 "EHLO ale.atd.ucar.edu")
	by vger.kernel.org with ESMTP id S262190AbTKCTu7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 14:50:59 -0500
From: "Charles Martin" <martinc@ucar.edu>
To: <linux-kernel@vger.kernel.org>
Cc: <martinc@atd.ucar.edu>
Subject: RE: interrupts across  PCI bridge(s) not handled
Date: Mon, 3 Nov 2003 12:50:51 -0700
Message-ID: <004f01c3a243$ccbaf960$c3507580@atdsputnik>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
In-Reply-To: <Pine.LNX.4.44.0311030859190.20373-100000@home.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Linus Torvalds [mailto:torvalds@osdl.org] 
> Sent: Monday, November 03, 2003 10:04 AM
> To: Charles Martin
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: interrupts across PCI bridge(s) not handled
> 
> 
> 
> On Mon, 3 Nov 2003, Charles Martin wrote:
> >
> > I have a pci backplane extender, with 4 cards
> > (named piraq) in it. The cards are detected by 
> > the PCI system, and irqs 92-95 are assigned, 
> > as shown in /var/log/messages:
> > 
> > kernel: PCI->APIC IRQ transform: (B6,I4,P0) -> 93
> > kernel: PCI->APIC IRQ transform: (B6,I6,P0) -> 95 
> > kernel: PCI->APIC IRQ transform: (B6,I7,P0) -> 92
> > kernel: PCI->APIC IRQ transform: (B6,I9,P0) -> 94
> 
> Can you enable APIC_DEBUG debugging in 
> "include/asm-i386/apic.h", and make 
> sure that you build the kernel with a big printk buffer. 
> Then, in case 
> your distribution comes with a broken "dmesg" binary that 
> doesn't show 
> more than about 20kB of data, compile this trivial program and run it 
> after bootup, and send the whole log out..
> 
> It would be a pity to have to boot with "noapic", since this 
> is exactly 
> the kind of situation where you _want_ the extra interrupts.
> 
> 		Linus
> 
> - stupid-dmesg.c -
> #include <sys/klog.h>
> 
> int main(int argc, char **argv)
> {
> 	static char buffer[128*1024];
> 	int i;
> 
> 	i = klogctl(3, buffer, sizeof(buffer));
> 	if (i > 0)
> 		write(1, buffer, i);
> }
> 
> 

I enabled APIC_DEBUG, and here is the dmesg output.

Thanks,
Charlie

<4>Linux version 2.4.22smp (root@dyn80-25.atd.ucar.edu) (gcc version
3.2.2 20030222 (Red Hat Linux 3.2.2-5)) #24 SMP Mon Nov 3 13:22:46 CST
2003
<6>BIOS-provided physical RAM map:
<4> BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
<4> BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
<4> BIOS-e820: 0000000000100000 - 000000007ff75000 (usable)
<4> BIOS-e820: 000000007ff75000 - 000000007ff77000 (ACPI NVS)
<4> BIOS-e820: 000000007ff77000 - 000000007ff98000 (ACPI data)
<4> BIOS-e820: 000000007ff98000 - 0000000080000000 (reserved)
<4> BIOS-e820: 00000000fec00000 - 00000000fec90000 (reserved)
<4> BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
<4> BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
<5>1151MB HIGHMEM available.
<5>896MB LOWMEM available.
<4>Scan SMP from c0000000 for 1024 bytes.
<4>Scan SMP from c009fc00 for 1024 bytes.
<4>Scan SMP from c00f0000 for 65536 bytes.
<4>found SMP MP-table at 000fe710
<4>hm, page 000fe000 reserved twice.
<4>hm, page 000ff000 reserved twice.
<4>hm, page 000f0000 reserved twice.
<4>On node 0 totalpages: 524149
<4>zone(0): 4096 pages.
<4>zone(1): 225280 pages.
<4>zone(2): 294773 pages.
<4>Intel MultiProcessor Specification v1.4
<4>    Virtual Wire compatibility mode.
<4>OEM ID: DELL     Product ID: WS 650       APIC at: 0xFEE00000
<4>Processor #0 Pentium 4(tm) XEON(tm) APIC version 20
<4>    Floating point unit present.
<4>    Machine Exception supported.
<4>    64 bit compare & exchange supported.
<4>    Internal APIC present.
<4>    SEP present.
<4>    MTRR  present.
<4>    PGE  present.
<4>    MCA  present.
<4>    CMOV  present.
<4>    PAT  present.
<4>    PSE  present.
<4>    Cache Line Flush Instruction present.
<4>    Debug Trace and EMON Store present.
<4>    ACPI Thermal Throttle Registers  present.
<4>    MMX  present.
<4>    FXSR  present.
<4>    XMM  present.
<4>    Willamette New Instructions  present.
<4>    Self Snoop  present.
<4>    HT  present.
<4>    Thermal Monitor present.
<4>    Bootup CPU
<4>Processor #6 Pentium 4(tm) XEON(tm) APIC version 20
<4>    Floating point unit present.
<4>    Machine Exception supported.
<4>    64 bit compare & exchange supported.
<4>    Internal APIC present.
<4>    SEP present.
<4>    MTRR  present.
<4>    PGE  present.
<4>    MCA  present.
<4>    CMOV  present.
<4>    PAT  present.
<4>    PSE  present.
<4>    Cache Line Flush Instruction present.
<4>    Debug Trace and EMON Store present.
<4>    ACPI Thermal Throttle Registers  present.
<4>    MMX  present.
<4>    FXSR  present.
<4>    XMM  present.
<4>    Willamette New Instructions  present.
<4>    Self Snoop  present.
<4>    HT  present.
<4>    Thermal Monitor present.
<4>Bus #0 is PCI   
<4>Bus #1 is PCI   
<4>Bus #2 is PCI   
<4>Bus #3 is PCI   
<4>Bus #4 is PCI   
<4>Bus #5 is PCI   
<4>Bus #6 is PCI   
<4>Bus #7 is PCI   
<4>Bus #8 is ISA   
<4>I/O APIC #8 Version 32 at 0xFEC00000.
<4>I/O APIC #10 Version 32 at 0xFEC80000.
<4>I/O APIC #9 Version 32 at 0xFEC80800.
<4>Int: type 3, pol 1, trig 1, bus 8, IRQ 00, APIC ID 8, APIC INT 00
<4>Int: type 0, pol 0, trig 0, bus 8, IRQ 01, APIC ID 8, APIC INT 01
<4>Int: type 0, pol 0, trig 0, bus 8, IRQ 00, APIC ID 8, APIC INT 02
<4>Int: type 0, pol 0, trig 0, bus 8, IRQ 03, APIC ID 8, APIC INT 03
<4>Int: type 0, pol 0, trig 0, bus 8, IRQ 04, APIC ID 8, APIC INT 04
<4>Int: type 0, pol 0, trig 0, bus 8, IRQ 05, APIC ID 8, APIC INT 05
<4>Int: type 0, pol 0, trig 0, bus 8, IRQ 06, APIC ID 8, APIC INT 06
<4>Int: type 0, pol 0, trig 0, bus 8, IRQ 07, APIC ID 8, APIC INT 07
<4>Int: type 0, pol 0, trig 0, bus 8, IRQ 08, APIC ID 8, APIC INT 08
<4>Int: type 0, pol 0, trig 0, bus 8, IRQ 09, APIC ID 8, APIC INT 09
<4>Int: type 0, pol 0, trig 0, bus 8, IRQ 0a, APIC ID 8, APIC INT 0a
<4>Int: type 0, pol 0, trig 0, bus 8, IRQ 0b, APIC ID 8, APIC INT 0b
<4>Int: type 0, pol 0, trig 0, bus 8, IRQ 0c, APIC ID 8, APIC INT 0c
<4>Int: type 0, pol 0, trig 0, bus 8, IRQ 0e, APIC ID 8, APIC INT 0e
<4>Int: type 0, pol 0, trig 0, bus 8, IRQ 0f, APIC ID 8, APIC INT 0f
<4>Int: type 0, pol 0, trig 0, bus 0, IRQ 74, APIC ID 8, APIC INT 10
<4>Int: type 0, pol 0, trig 0, bus 1, IRQ 00, APIC ID 8, APIC INT 10
<4>Int: type 0, pol 0, trig 0, bus 0, IRQ 7d, APIC ID 8, APIC INT 11
<4>Int: type 0, pol 0, trig 0, bus 1, IRQ 01, APIC ID 8, APIC INT 11
<4>Int: type 0, pol 0, trig 0, bus 0, IRQ 7c, APIC ID 8, APIC INT 12
<4>Int: type 0, pol 0, trig 0, bus 0, IRQ 76, APIC ID 8, APIC INT 12
<4>Int: type 0, pol 0, trig 0, bus 0, IRQ 75, APIC ID 8, APIC INT 13
<4>Int: type 0, pol 0, trig 0, bus 7, IRQ 30, APIC ID 8, APIC INT 14
<4>Int: type 0, pol 0, trig 0, bus 7, IRQ 37, APIC ID 8, APIC INT 14
<4>Int: type 0, pol 0, trig 0, bus 7, IRQ 3a, APIC ID 8, APIC INT 14
<4>Int: type 0, pol 0, trig 0, bus 6, IRQ 1c, APIC ID 0, APIC INT 14
<4>Int: type 0, pol 0, trig 0, bus 7, IRQ 34, APIC ID 8, APIC INT 15
<4>Int: type 0, pol 0, trig 0, bus 7, IRQ 3b, APIC ID 8, APIC INT 15
<4>Int: type 0, pol 0, trig 0, bus 6, IRQ 10, APIC ID 0, APIC INT 15
<4>Int: type 0, pol 0, trig 0, bus 7, IRQ 35, APIC ID 8, APIC INT 16
<4>Int: type 0, pol 0, trig 0, bus 7, IRQ 38, APIC ID 8, APIC INT 16
<4>Int: type 0, pol 0, trig 0, bus 6, IRQ 24, APIC ID 0, APIC INT 16
<4>Int: type 0, pol 0, trig 0, bus 0, IRQ 77, APIC ID 8, APIC INT 17
<4>Int: type 0, pol 0, trig 0, bus 7, IRQ 36, APIC ID 8, APIC INT 17
<4>Int: type 0, pol 0, trig 0, bus 7, IRQ 39, APIC ID 8, APIC INT 17
<4>Int: type 0, pol 0, trig 0, bus 6, IRQ 18, APIC ID 0, APIC INT 17
<4>Int: type 0, pol 0, trig 0, bus 3, IRQ 38, APIC ID a, APIC INT 00
<4>Int: type 0, pol 0, trig 0, bus 6, IRQ 1c, APIC ID 0, APIC INT 00
<4>Int: type 0, pol 0, trig 0, bus 3, IRQ 30, APIC ID a, APIC INT 01
<4>Int: type 0, pol 0, trig 0, bus 6, IRQ 10, APIC ID 0, APIC INT 01
<4>Int: type 0, pol 0, trig 0, bus 3, IRQ 31, APIC ID a, APIC INT 02
<4>Int: type 0, pol 0, trig 0, bus 6, IRQ 24, APIC ID 0, APIC INT 02
<4>Int: type 0, pol 0, trig 0, bus 3, IRQ 32, APIC ID a, APIC INT 03
<4>Int: type 0, pol 0, trig 0, bus 6, IRQ 18, APIC ID 0, APIC INT 03
<4>Int: type 0, pol 0, trig 0, bus 3, IRQ 33, APIC ID a, APIC INT 04
<4>Int: type 0, pol 0, trig 0, bus 3, IRQ 34, APIC ID a, APIC INT 05
<4>Int: type 0, pol 0, trig 0, bus 3, IRQ 35, APIC ID a, APIC INT 06
<4>Int: type 0, pol 0, trig 0, bus 3, IRQ 36, APIC ID a, APIC INT 07
<4>Int: type 0, pol 0, trig 0, bus 3, IRQ 37, APIC ID a, APIC INT 08
<4>Int: type 0, pol 0, trig 0, bus 4, IRQ 34, APIC ID 9, APIC INT 00
<4>Int: type 0, pol 0, trig 0, bus 6, IRQ 1c, APIC ID 0, APIC INT 00
<4>Int: type 0, pol 0, trig 0, bus 4, IRQ 35, APIC ID 9, APIC INT 01
<4>Int: type 0, pol 0, trig 0, bus 6, IRQ 10, APIC ID 0, APIC INT 01
<4>Int: type 0, pol 0, trig 0, bus 4, IRQ 38, APIC ID 9, APIC INT 02
<4>Int: type 0, pol 0, trig 0, bus 4, IRQ 36, APIC ID 9, APIC INT 02
<4>Int: type 0, pol 0, trig 0, bus 6, IRQ 24, APIC ID 0, APIC INT 02
<4>Int: type 0, pol 0, trig 0, bus 4, IRQ 37, APIC ID 9, APIC INT 03
<4>Int: type 0, pol 0, trig 0, bus 6, IRQ 18, APIC ID 0, APIC INT 03
<4>Lint: type 3, pol 1, trig 1, bus 8, IRQ 00, APIC ID ff, APIC LINT 00
<4>Lint: type 1, pol 1, trig 1, bus 8, IRQ 00, APIC ID ff, APIC LINT 01
<4>Enabling APIC mode: Flat.	Using 3 I/O APICs
<4>Processors: 2
<4>Kernel command line: ro root=LABEL=/ apic
<4>mapped APIC to ffffe000 (fee00000)
<4>mapped IOAPIC to ffffd000 (fec00000)
<4>mapped IOAPIC to ffffc000 (fec80000)
<4>mapped IOAPIC to ffffb000 (fec80800)
<6>Initializing CPU#0
<4>Detected 2392.343 MHz processor.
<4>Console: colour VGA+ 80x25
<4>Calibrating delay loop... 4771.02 BogoMIPS
<6>Memory: 2065960k/2096596k available (3174k kernel code, 30252k
reserved, 1150k data, 392k init, 1179092k highmem)
<6>Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
<6>Inode cache hash table entries: 131072 (order: 8, 1048576 bytes)
<6>Mount cache hash table entries: 512 (order: 0, 4096 bytes)
<6>Buffer cache hash table entries: 131072 (order: 7, 524288 bytes)
<4>Page-cache hash table entries: 524288 (order: 9, 2097152 bytes)
<6>CPU: Trace cache: 12K uops, L1 D cache: 8K
<6>CPU: L2 cache: 512K
<6>CPU: Physical Processor ID: 0
<6>Intel machine check architecture supported.
<6>Intel machine check reporting enabled on CPU#0.
<7>CPU:     After generic, caps: bfebfbff 00000000 00000000 00000000
<7>CPU:             Common caps: bfebfbff 00000000 00000000 00000000
<6>Enabling fast FPU save and restore... done.
<6>Enabling unmasked SIMD FPU exception support... done.
<6>Checking 'hlt' instruction... OK.
<4>POSIX conformance testing by UNIFIX
<4>mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
<4>mtrr: detected mtrr type: Intel
<6>CPU: Trace cache: 12K uops, L1 D cache: 8K
<6>CPU: L2 cache: 512K
<6>CPU: Physical Processor ID: 0
<6>Intel machine check reporting enabled on CPU#0.
<7>CPU:     After generic, caps: bfebfbff 00000000 00000000 00000000
<7>CPU:             Common caps: bfebfbff 00000000 00000000 00000000
<4>CPU0: Intel(R) Xeon(TM) CPU 2.40GHz stepping 09
<4>per-CPU timeslice cutoff: 1462.89 usecs.
<4>Getting VERSION: 50014
<4>Getting VERSION: 50014
<4>Getting ID: 0
<4>Getting ID: f000000
<4>Getting LVT0: 700
<4>Getting LVT1: 400
<4>enabled ExtINT on CPU#0
<4>ESR value before enabling vector: 00000040
<4>ESR value after enabling vector: 00000000
<4>CPU present map: 41
<4>Booting processor 1/6 eip 2000
<4>Setting warm reset code and vector.
<4>1.
<4>2.
<4>3.
<4>Asserting INIT.
<4>Waiting for send to finish...
<4>+Deasserting INIT.
<4>Waiting for send to finish...
<4>+#startup loops: 2.
<4>Sending STARTUP #1.
<4>After apic_write.
<6>Initializing CPU#1
<4>CPU#1 (phys ID: 6) waiting for CALLOUT
<4>Startup point 1.
<4>Waiting for send to finish...
<4>+Sending STARTUP #2.
<4>After apic_write.
<4>Startup point 1.
<4>Waiting for send to finish...
<4>+After Startup.
<4>Before Callout 1.
<4>After Callout 1.
<4>CALLIN, before setup_local_APIC().
<4>masked ExtINT on CPU#1
<4>ESR value before enabling vector: 00000000
<4>ESR value after enabling vector: 00000000
<4>Calibrating delay loop... 4784.12 BogoMIPS
<4>Stack at about f7ffbfb0
<6>CPU: Trace cache: 12K uops, L1 D cache: 8K
<6>CPU: L2 cache: 512K
<6>CPU: Physical Processor ID: 3
<6>Intel machine check reporting enabled on CPU#1.
<7>CPU:     After generic, caps: bfebfbff 00000000 00000000 00000000
<7>CPU:             Common caps: bfebfbff 00000000 00000000 00000000
<4>OK.
<4>CPU1: Intel(R) Xeon(TM) CPU 2.40GHz stepping 09
<4>CPU has booted.
<4>Before bogomips.
<6>Total of 2 processors activated (9555.14 BogoMIPS).
<4>Before bogocount - setting activated=1.
<4>Boot done.
<4>WARNING: No sibling found for CPU 0.
<4>WARNING: No sibling found for CPU 1.
<4>ENABLING IO-APIC IRQs
<4>Setting 8 in the phys_id_present_map
<6>...changing IO-APIC physical APIC ID to 8 ... ok.
<4>Setting 10 in the phys_id_present_map
<6>...changing IO-APIC physical APIC ID to 10 ... ok.
<4>Setting 9 in the phys_id_present_map
<6>...changing IO-APIC physical APIC ID to 9 ... ok.
<4>Synchronizing Arb IDs.
<7>init IO_APIC IRQs
<7> IO-APIC (apicid-pin) 8-0, 8-13, 10-9, 10-10, 10-11, 10-12, 10-13,
10-14, 10-15, 10-16, 10-17, 10-18, 10-19, 10-20, 10-21, 10-22, 10-23,
9-4, 9-5, 9-6, 9-7, 9-8, 9-9, 9-10, 9-11, 9-12, 9-13, 9-14, 9-15, 9-16,
9-17, 9-18, 9-19, 9-20, 9-21, 9-22, 9-23 not connected.
<6>..TIMER: vector=0x31 pin1=2 pin2=0
<7>number of MP IRQ sources: 58.
<7>number of IO-APIC #8 registers: 24.
<7>number of IO-APIC #10 registers: 24.
<7>number of IO-APIC #9 registers: 24.
<6>testing the IO APIC.......................
<4>
<7>IO APIC #8......
<7>.... register #00: 08000000
<7>.......    : physical APIC id: 08
<7>.......    : Delivery Type: 0
<7>.......    : LTS          : 0
<7>.... register #01: 00178020
<7>.......     : max redirection entries: 0017
<7>.......     : PRQ implemented: 1
<7>.......     : IO APIC version: 0020
<7>.... register #02: 00000000
<7>.......     : arbitration: 00
<7>.... register #03: 00000001
<7>.......     : Boot DT    : 1
<7>.... IRQ redirection table:
<7> NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
<7> 00 000 00  1    0    0   0   0    0    0    00
<7> 01 003 03  0    0    0   0   0    1    1    39
<7> 02 003 03  0    0    0   0   0    1    1    31
<7> 03 003 03  0    0    0   0   0    1    1    41
<7> 04 003 03  0    0    0   0   0    1    1    49
<7> 05 003 03  0    0    0   0   0    1    1    51
<7> 06 003 03  0    0    0   0   0    1    1    59
<7> 07 003 03  0    0    0   0   0    1    1    61
<7> 08 003 03  0    0    0   0   0    1    1    69
<7> 09 003 03  0    0    0   0   0    1    1    71
<7> 0a 003 03  0    0    0   0   0    1    1    79
<7> 0b 003 03  0    0    0   0   0    1    1    81
<7> 0c 003 03  0    0    0   0   0    1    1    89
<7> 0d 000 00  1    0    0   0   0    0    0    00
<7> 0e 003 03  0    0    0   0   0    1    1    91
<7> 0f 003 03  0    0    0   0   0    1    1    99
<7> 10 003 03  1    1    0   1   0    1    1    A1
<7> 11 003 03  1    1    0   1   0    1    1    A9
<7> 12 003 03  1    1    0   1   0    1    1    B1
<7> 13 003 03  1    1    0   1   0    1    1    B9
<7> 14 003 03  1    1    0   1   0    1    1    C1
<7> 15 003 03  1    1    0   1   0    1    1    C9
<7> 16 003 03  1    1    0   1   0    1    1    D1
<7> 17 003 03  1    1    0   1   0    1    1    D9
<4>
<7>IO APIC #10......
<7>.... register #00: 0A000000
<7>.......    : physical APIC id: 0A
<7>.......    : Delivery Type: 0
<7>.......    : LTS          : 0
<7>.... register #01: 00178020
<7>.......     : max redirection entries: 0017
<7>.......     : PRQ implemented: 1
<7>.......     : IO APIC version: 0020
<7>.... register #02: 0A000000
<7>.......     : arbitration: 0A
<7>.... register #03: 00000001
<7>.......     : Boot DT    : 1
<7>.... IRQ redirection table:
<7> NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
<7> 00 003 03  1    1    0   1   0    1    1    E1
<7> 01 003 03  1    1    0   1   0    1    1    E9
<7> 02 003 03  1    1    0   1   0    1    1    32
<7> 03 003 03  1    1    0   1   0    1    1    3A
<7> 04 003 03  1    1    0   1   0    1    1    42
<7> 05 003 03  1    1    0   1   0    1    1    4A
<7> 06 003 03  1    1    0   1   0    1    1    52
<7> 07 003 03  1    1    0   1   0    1    1    5A
<7> 08 003 03  1    1    0   1   0    1    1    62
<7> 09 000 00  1    0    0   0   0    0    0    00
<7> 0a 000 00  1    0    0   0   0    0    0    00
<7> 0b 000 00  1    0    0   0   0    0    0    00
<7> 0c 000 00  1    0    0   0   0    0    0    00
<7> 0d 000 00  1    0    0   0   0    0    0    00
<7> 0e 000 00  1    0    0   0   0    0    0    00
<7> 0f 000 00  1    0    0   0   0    0    0    00
<7> 10 000 00  1    0    0   0   0    0    0    00
<7> 11 000 00  1    0    0   0   0    0    0    00
<7> 12 000 00  1    0    0   0   0    0    0    00
<7> 13 000 00  1    0    0   0   0    0    0    00
<7> 14 000 00  1    0    0   0   0    0    0    00
<7> 15 000 00  1    0    0   0   0    0    0    00
<7> 16 000 00  1    0    0   0   0    0    0    00
<7> 17 000 00  1    0    0   0   0    0    0    00
<4>
<7>IO APIC #9......
<7>.... register #00: 09000000
<7>.......    : physical APIC id: 09
<7>.......    : Delivery Type: 0
<7>.......    : LTS          : 0
<7>.... register #01: 00178020
<7>.......     : max redirection entries: 0017
<7>.......     : PRQ implemented: 1
<7>.......     : IO APIC version: 0020
<7>.... register #02: 09000000
<7>.......     : arbitration: 09
<7>.... register #03: 00000001
<7>.......     : Boot DT    : 1
<7>.... IRQ redirection table:
<7> NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
<7> 00 003 03  1    1    0   1   0    1    1    6A
<7> 01 003 03  1    1    0   1   0    1    1    72
<7> 02 003 03  1    1    0   1   0    1    1    7A
<7> 03 003 03  1    1    0   1   0    1    1    82
<7> 04 000 00  1    0    0   0   0    0    0    00
<7> 05 000 00  1    0    0   0   0    0    0    00
<7> 06 000 00  1    0    0   0   0    0    0    00
<7> 07 000 00  1    0    0   0   0    0    0    00
<7> 08 000 00  1    0    0   0   0    0    0    00
<7> 09 000 00  1    0    0   0   0    0    0    00
<7> 0a 000 00  1    0    0   0   0    0    0    00
<7> 0b 000 00  1    0    0   0   0    0    0    00
<7> 0c 000 00  1    0    0   0   0    0    0    00
<7> 0d 000 00  1    0    0   0   0    0    0    00
<7> 0e 000 00  1    0    0   0   0    0    0    00
<7> 0f 000 00  1    0    0   0   0    0    0    00
<7> 10 000 00  1    0    0   0   0    0    0    00
<7> 11 000 00  1    0    0   0   0    0    0    00
<7> 12 000 00  1    0    0   0   0    0    0    00
<7> 13 000 00  1    0    0   0   0    0    0    00
<7> 14 000 00  1    0    0   0   0    0    0    00
<7> 15 000 00  1    0    0   0   0    0    0    00
<7> 16 000 00  1    0    0   0   0    0    0    00
<7> 17 000 00  1    0    0   0   0    0    0    00
<7>IRQ to pin mappings:
<7>IRQ0 -> 0:2
<7>IRQ1 -> 0:1
<7>IRQ3 -> 0:3
<7>IRQ4 -> 0:4
<7>IRQ5 -> 0:5
<7>IRQ6 -> 0:6
<7>IRQ7 -> 0:7
<7>IRQ8 -> 0:8
<7>IRQ9 -> 0:9
<7>IRQ10 -> 0:10
<7>IRQ11 -> 0:11
<7>IRQ12 -> 0:12
<7>IRQ14 -> 0:14
<7>IRQ15 -> 0:15
<7>IRQ16 -> 0:16
<7>IRQ17 -> 0:17
<7>IRQ18 -> 0:18
<7>IRQ19 -> 0:19
<7>IRQ20 -> 0:20
<7>IRQ21 -> 0:21
<7>IRQ22 -> 0:22
<7>IRQ23 -> 0:23
<7>IRQ24 -> 1:0
<7>IRQ25 -> 1:1
<7>IRQ26 -> 1:2
<7>IRQ27 -> 1:3
<7>IRQ28 -> 1:4
<7>IRQ29 -> 1:5
<7>IRQ30 -> 1:6
<7>IRQ31 -> 1:7
<7>IRQ32 -> 1:8
<7>IRQ48 -> 2:0
<7>IRQ49 -> 2:1
<7>IRQ50 -> 2:2
<7>IRQ51 -> 2:3
<6>.................................... done.
<4>Using local APIC timer interrupts.
<4>calibrating APIC timer ...
<4>..... CPU clock speed is 2392.2463 MHz.
<4>..... host bus clock speed is 132.9025 MHz.
<4>cpu: 0, clocks: 1329025, slice: 443008
<4>CPU0<T0:1329024,T1:886016,D:0,S:443008,C:1329025>
<4>cpu: 1, clocks: 1329025, slice: 443008
<4>CPU1<T0:1329024,T1:443008,D:0,S:443008,C:1329025>
<4>checking TSC synchronization across CPUs: passed.
<4>Setting commenced=1, go go go
<4>Waiting on wait_init_idle (map = 0x2)
<4>All processors have done init_idle
<6>PCI: PCI BIOS revision 2.10 entry at 0xfbdd5, last bus=7
<6>PCI: Using configuration type 1
<6>PCI: Probing PCI hardware
<4>PCI: Probing PCI hardware (bus 00)
<6>PCI: Ignoring BAR0-3 of IDE controller 00:1f.1
<4>Transparent bridge - Intel Corp. 82801BA/CA/DB/EB PCI Bridge
<6>PCI: Using IRQ router PIIX [8086/24c0] at 00:1f.0
<4>querying PCI -> IRQ mapping bus:0, slot:29, pin:0.
<6>PCI->APIC IRQ transform: (B0,I29,P0) -> 16
<4>querying PCI -> IRQ mapping bus:0, slot:29, pin:1.
<6>PCI->APIC IRQ transform: (B0,I29,P1) -> 19
<4>querying PCI -> IRQ mapping bus:0, slot:29, pin:2.
<6>PCI->APIC IRQ transform: (B0,I29,P2) -> 18
<4>querying PCI -> IRQ mapping bus:0, slot:29, pin:3.
<6>PCI->APIC IRQ transform: (B0,I29,P3) -> 23
<4>querying PCI -> IRQ mapping bus:0, slot:31, pin:0.
<6>PCI->APIC IRQ transform: (B0,I31,P0) -> 18
<4>querying PCI -> IRQ mapping bus:0, slot:31, pin:1.
<6>PCI->APIC IRQ transform: (B0,I31,P1) -> 17
<4>querying PCI -> IRQ mapping bus:0, slot:31, pin:1.
<6>PCI->APIC IRQ transform: (B0,I31,P1) -> 17
<4>querying PCI -> IRQ mapping bus:1, slot:0, pin:0.
<6>PCI->APIC IRQ transform: (B1,I0,P0) -> 16
<4>querying PCI -> IRQ mapping bus:3, slot:12, pin:0.
<6>PCI->APIC IRQ transform: (B3,I12,P0) -> 25
<4>querying PCI -> IRQ mapping bus:3, slot:12, pin:1.
<6>PCI->APIC IRQ transform: (B3,I12,P1) -> 26
<4>querying PCI -> IRQ mapping bus:3, slot:14, pin:0.
<6>PCI->APIC IRQ transform: (B3,I14,P0) -> 24
<4>querying PCI -> IRQ mapping bus:4, slot:14, pin:0.
<6>PCI->APIC IRQ transform: (B4,I14,P0) -> 50
<4>querying PCI -> IRQ mapping bus:6, slot:4, pin:0.
<6>PCI->APIC IRQ transform: (B6,I4,P0) -> 93
<4>querying PCI -> IRQ mapping bus:6, slot:6, pin:0.
<6>PCI->APIC IRQ transform: (B6,I6,P0) -> 95
<4>querying PCI -> IRQ mapping bus:6, slot:7, pin:0.
<6>PCI->APIC IRQ transform: (B6,I7,P0) -> 92
<4>querying PCI -> IRQ mapping bus:6, slot:9, pin:0.
<6>PCI->APIC IRQ transform: (B6,I9,P0) -> 94
<4>querying PCI -> IRQ mapping bus:7, slot:12, pin:0.
<6>PCI->APIC IRQ transform: (B7,I12,P0) -> 20
<6>isapnp: Scanning for PnP cards...
<6>isapnp: No Plug & Play device found
<6>Linux NET4.0 for Linux 2.4
<6>Based upon Swansea University Computer Society NET3.039
<4>Initializing RT netlink socket
<6>IA-32 Microcode Update Driver: v1.11 <tigran@veritas.com>
<4>Starting kswapd
<4>allocated 32 pages and 32 bhs reserved for the highmem bounces
<6>Journalled Block Device driver loaded
<6>Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
<6>i2c-core.o: i2c core module
<4>pty: 256 Unix98 ptys configured
<6>Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
SERIAL_PCI ISAPNP enabled
<6>ttyS00 at 0x03f8 (irq = 4) is a 16550A
<6>ttyS01 at 0x02f8 (irq = 3) is a 16550A
<6>Real Time Clock Driver v1.10e
<6>Floppy drive(s): fd0 is 1.44M
<6>FDC 0 is a post-1991 82077
<6>0 3c515 cards found.
<4>RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
<6>loop: loaded (max 8 devices)
<6>Intel(R) PRO/1000 Network Driver - version 5.1.13-k1
<6>Copyright (c) 1999-2003 Intel Corporation.
<6>eth0: Intel(R) PRO/1000 Network Connection
<6>Linux agpgart interface v0.99 (c) Jeff Hartmann
<6>agpgart: Maximum main memory to use for agp memory: 1919M
<3>agpgart: Unsupported Intel chipset (device id: 2550), you might want
to try agp_try_unsupported=1.
<7>agpgart: no supported devices found.
<6>[drm] Initialized tdfx 1.0.0 20010216 on minor 0
<6>[drm] Initialized radeon 1.1.1 20010405 on minor 1
<3>[drm:drm_init] *ERROR* Cannot initialize the agpgart module.
<6>Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
<6>ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
<6>ICH4: IDE controller at PCI slot 00:1f.1
<4>PCI: Enabling device 00:1f.1 (0005 -> 0007)
<6>ICH4: chipset revision 1
<6>ICH4: not 100% native mode: will probe irqs later
<6>    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
<4>hdc: Lite-On LTN486S 48x Max, ATAPI CD/DVD-ROM drive
<4>ide1 at 0x170-0x177,0x376 on irq 15
<4>hdc: attached ide-cdrom driver.
<6>hdc: ATAPI 48X CD-ROM drive, 120kB Cache, UDMA(33)
<6>Uniform CD-ROM driver Revision: 3.12
<6>SCSI subsystem driver Revision: 1.00
<3>kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2
<3>kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2
<3>kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2
<6>Fusion MPT base driver 2.05.05+
<6>Copyright (c) 1999-2002 LSI Logic Corporation
<6>mptbase: Initiating ioc0 bringup
<6>ioc0: 53C1030: Capabilities={Initiator}
<6>mptbase: Initiating ioc1 bringup
<6>ioc1: 53C1030: Capabilities={Initiator}
<6>mptbase: Initiating ioc2 bringup
<6>ioc2: 53C1030: Capabilities={Initiator}
<6>mptbase: 3 MPT adapters found, 3 installed.
<6>Fusion MPT SCSI Host driver 2.05.05+
<6>scsi0 : ioc0: LSI53C1030, FwRev=01011800h, Ports=1, MaxQ=222, IRQ=25
<6>scsi1 : ioc1: LSI53C1030, FwRev=01011800h, Ports=1, MaxQ=222, IRQ=26
<6>scsi2 : ioc2: LSI53C1030, FwRev=01011800h, Ports=1, MaxQ=222, IRQ=50
<4>blk: queue c28d741c, I/O limit 4294967295Mb (mask 0xffffffffffffffff)
<4>  Vendor: SEAGATE   Model: ST3146807LW       Rev: DS08
<4>  Type:   Direct-Access                      ANSI SCSI revision: 03
<4>blk: queue c29d461c, I/O limit 4294967295Mb (mask 0xffffffffffffffff)
<4>  Vendor: SEAGATE   Model: ST3146807LW       Rev: DS08
<4>  Type:   Direct-Access                      ANSI SCSI revision: 03
<4>blk: queue c29d401c, I/O limit 4294967295Mb (mask 0xffffffffffffffff)
<4>  Vendor: SEAGATE   Model: ST3146807LW       Rev: DS08
<4>  Type:   Direct-Access                      ANSI SCSI revision: 03
<4>blk: queue c29baa1c, I/O limit 4294967295Mb (mask 0xffffffffffffffff)
<6>mptscsih: ioc2: scsi2: Id=0 Lun=0: Queue depth=31
<6>mptscsih: ioc2: scsi2: Id=1 Lun=0: Queue depth=31
<6>mptscsih: ioc2: scsi2: Id=2 Lun=0: Queue depth=31
<4>Attached scsi disk sda at scsi2, channel 0, id 0, lun 0
<4>Attached scsi disk sdb at scsi2, channel 0, id 1, lun 0
<4>Attached scsi disk sdc at scsi2, channel 0, id 2, lun 0
<4>SCSI device sda: 286749480 512-byte hdwr sectors (146816 MB)
<6>Partition check:
<6> sda: sda1 sda2 sda3 sda4 < sda5 sda6 >
<4>SCSI device sdb: 286749480 512-byte hdwr sectors (146816 MB)
<6> sdb: unknown partition table
<4>SCSI device sdc: 286749480 512-byte hdwr sectors (146816 MB)
<6> sdc: unknown partition table
<6>ohci1394: $Rev: 1010 $ Ben Collins <bcollins@debian.org>
<6>ohci1394_0: OHCI-1394 1.1 (PCI): IRQ=[20]  MMIO=[fd1ff800-fd1fffff]
Max Packet=[2048]
<6>video1394: Installed video1394 module
<6>raw1394: /dev/raw1394 device initialized
<6>sbp2: $Rev: 1010 $ Ben Collins <bcollins@debian.org>
<6>es1371: version v0.32 time 12:56:23 Nov  3 2003
<6>usb.c: registered new driver usbdevfs
<6>usb.c: registered new driver hub
<7>PCI: Setting latency timer of device 00:1d.7 to 64
<6>ehci_hcd 00:1d.7: Intel Corp. 82801DB USB2
<6>ehci_hcd 00:1d.7: irq 23, pci mem f8829800
<6>usb.c: new USB bus registered, assigned bus number 1
<6>ehci_hcd 00:1d.7: enabled 64bit PCI DMA
<4>PCI: 00:1d.7 PCI cache line size set incorrectly (0 bytes) by
BIOS/FW.
<4>PCI: 00:1d.7 PCI cache line size corrected to 32.
<6>ehci_hcd 00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2003-Jun-19/2.4
<6>hub.c: USB hub found
<6>hub.c: 6 ports detected
<7>ieee1394: Host added: ID:BUS[0-00:1023]  GUID[83ffffffffffff00]
<6>host/uhci.c: USB Universal Host Controller Interface driver v1.1
<7>PCI: Setting latency timer of device 00:1d.0 to 64
<6>host/uhci.c: USB UHCI at I/O 0xff80, IRQ 16
<6>usb.c: new USB bus registered, assigned bus number 2
<6>hub.c: USB hub found
<6>hub.c: 2 ports detected
<7>PCI: Setting latency timer of device 00:1d.1 to 64
<6>host/uhci.c: USB UHCI at I/O 0xff60, IRQ 19
<6>usb.c: new USB bus registered, assigned bus number 3
<6>hub.c: USB hub found
<6>hub.c: 2 ports detected
<7>PCI: Setting latency timer of device 00:1d.2 to 64
<6>host/uhci.c: USB UHCI at I/O 0xff40, IRQ 18
<6>usb.c: new USB bus registered, assigned bus number 4
<6>hub.c: USB hub found
<6>hub.c: 2 ports detected
<6>usb.c: registered new driver hiddev
<6>usb.c: registered new driver hid
<6>hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
<6>hid-core.c: USB HID support drivers
<6>usb.c: registered new driver usblp
<6>printer.c: v0.11: USB Printer Device Class driver
<6>bluetooth.c: USB Bluetooth support registered
<6>usb.c: registered new driver bluetty
<6>bluetooth.c: USB Bluetooth tty driver v0.13
<6>usb.c: registered new driver serial
<6>usbserial.c: USB Serial support registered for Generic
<6>usbserial.c: USB Serial Driver core v1.4
<6>usbserial.c: USB Serial support registered for Handspring Visor /
Treo / Palm 4.0 / Clié 4.x
<6>usbserial.c: USB Serial support registered for Sony Clié 3.5
<6>visor.c: USB HandSpring Visor, Palm m50x, Treo, Sony Clié driver v1.7
<6>ipaq.c: USB PocketPC PDA driver v0.5
<6>usbserial.c: USB Serial support registered for PocketPC PDA
<6>usbserial.c: USB Serial support registered for Connect Tech -
WhiteHEAT - (prerenumeration)
<6>usbserial.c: USB Serial support registered for Connect Tech -
WhiteHEAT
<6>whiteheat.c: USB ConnectTech WhiteHEAT driver v1.2
<7>ftdi_sio.c: ftdi_init
<6>usbserial.c: USB Serial support registered for FTDI SIO
<6>usbserial.c: USB Serial support registered for FTDI 8U232AM
Compatible
<6>usbserial.c: USB Serial support registered for FTDI FT232BM
Compatible
<6>usbserial.c: USB Serial support registered for USB-UIRT Infrared
Receiver/Transmitter
<6>usbserial.c: USB Serial support registered for Home-Electronics
TIRA-1 IR Transceiver
<6>ftdi_sio.c: v1.3.4:USB FTDI Serial Converters Driver
<6>usbserial.c: USB Serial support registered for Keyspan PDA
<6>usbserial.c: USB Serial support registered for Keyspan PDA -
(prerenumeration)
<6>usbserial.c: USB Serial support registered for Xircom / Entregra PGS
- (prerenumeration)
<6>keyspan_pda.c: USB Keyspan PDA Converter driver v1.1
<6>usbserial.c: USB Serial support registered for Keyspan - (without
firmware)
<6>usbserial.c: USB Serial support registered for Keyspan 1 port adapter
<6>usbserial.c: USB Serial support registered for Keyspan 2 port adapter
<6>usbserial.c: USB Serial support registered for Keyspan 4 port adapter
<6>keyspan.c: v1.1.4:Keyspan USB to Serial Converter Driver
<6>usbserial.c: USB Serial support registered for ZyXEL - omni.net lcd
plus usb
<6>omninet.c: v1.1:USB ZyXEL omni.net LCD PLUS Driver
<6>usbserial.c: USB Serial support registered for Digi USB
<6>usbserial.c: USB Serial support registered for Digi USB
<6>digi_acceleport.c: v1.80.1.2:Digi AccelePort USB-2/USB-4 Serial
Converter driver
<6>usbserial.c: USB Serial support registered for Belkin / Peracom /
GoHubs USB Serial Adapter
<6>belkin_sa.c: USB Belkin Serial converter driver v1.2
<6>usbserial.c: USB Serial support registered for Empeg
<6>empeg.c: v1.2:USB Empeg Mark I/II Driver
<6>usbserial.c: USB Serial support registered for Magic Control
Technology USB-RS232
<6>mct_u232.c: Magic Control Technology USB-RS232 converter driver v1.1
<6>usbserial.c: USB Serial support registered for Edgeport 1 port
adapter
<6>usbserial.c: USB Serial support registered for Edgeport 2 port
adapter
<6>usbserial.c: USB Serial support registered for Edgeport 4 port
adapter
<6>usbserial.c: USB Serial support registered for Edgeport 8 port
adapter
<6>io_edgeport.c: Edgeport USB Serial Driver v2.3
<6>usbserial.c: USB Serial support registered for Edgeport TI 1 port
adapter
<6>usbserial.c: USB Serial support registered for Edgeport TI 2 port
adapter
<6>io_ti.c: Edgeport USB Serial Driver v0.2
<6>usbserial.c: USB Serial support registered for PL-2303
<6>pl2303.c: Prolific PL2303 USB to serial adaptor driver v0.9
<6>usbserial.c: USB Serial support registered for Reiner SCT Cyberjack
USB card reader
<6>cyberjack.c: v1.0 Matthias Bruestle
<6>cyberjack.c: REINER SCT cyberJack pinpad/e-com USB Chipcard Reader
Driver
<6>usbserial.c: USB Serial support registered for IR Dongle
<6>ir-usb.c: USB IR Dongle driver v0.4
<6>usbserial.c: USB Serial support registered for KL5KUSB105D /
PalmConnect
<6>kl5kusb105.c: KLSI KL5KUSB105 chipset USB->Serial Converter driver
v0.3a
<6>usbserial.c: USB Serial support registered for KOBIL USB smart card
terminal
<6>kobil_sct.c: 12/03/2002 KOBIL Systems GmbH - http://www.kobil.com
<6>kobil_sct.c: KOBIL USB Smart Card Terminal Driver (experimental)
<6>Initializing USB Mass Storage driver...
<6>usb.c: registered new driver usb-storage
<6>USB Mass Storage support registered.
<6>mice: PS/2 mouse device common for all mice
<6>md: linear personality registered as nr 1
<6>md: raid0 personality registered as nr 2
<6>md: raid1 personality registered as nr 3
<6>md: raid5 personality registered as nr 4
<6>raid5: measuring checksumming speed
<4>   8regs     :  2767.200 MB/sec
<4>   32regs    :  1710.800 MB/sec
<4>   pIII_sse  :  3091.200 MB/sec
<4>   pII_mmx   :  2801.200 MB/sec
<4>   p5_mmx    :  2780.000 MB/sec
<4>raid5: using function: pIII_sse (3091.200 MB/sec)
<6>md: multipath personality registered as nr 7
<6>md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
<6>md: Autodetecting RAID arrays.
<6>md: autorun ...
<6>md: ... autorun DONE.
<6>LVM version 1.0.5+(22/07/2002)
<6>NET4: Linux TCP/IP 1.0 for NET4.0
<6>IP Protocols: ICMP, UDP, TCP, IGMP
<6>IP: routing cache hash table of 8192 buckets, 128Kbytes
<6>TCP: Hash tables configured (established 131072 bind 43690)
<6>IPv4 over IPv4 tunneling driver
<6>GRE over IPv4 tunneling driver
<6>Linux IP multicast router 0.06 plus PIM-SM
<4>ip_conntrack version 2.1 (8192 buckets, 65536 max) - 292 bytes per
conntrack
<4>ip_tables: (C) 2000-2002 Netfilter core team
<6>ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>.
http://snowman.net/projects/ipt_recent/
<4>arp_tables: (C) 2002 David S. Miller
<6>NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
<6>NET4: Linux IPX 0.47 for NET4.0
<6>IPX Portions Copyright (c) 1995 Caldera, Inc.
<6>IPX Portions Copyright (c) 2000, 2001 Conectiva, Inc.
<5>RAMDISK: Compressed image found at block 0
<6>Freeing initrd memory: 223k freed
<4>VFS: Mounted root (ext2 filesystem).
<6>kjournald starting.  Commit interval 5 seconds
<6>EXT3-fs: mounted filesystem with ordered data mode.
<6>Freeing unused kernel memory: 392k freed
<6>EXT3 FS 2.4-0.9.19, 19 August 2002 on sd(8,5), internal journal
<6>Adding Swap: 2040212k swap-space (priority -1)
<6>kjournald starting.  Commit interval 5 seconds
<6>EXT3 FS 2.4-0.9.19, 19 August 2002 on sd(8,3), internal journal
<6>EXT3-fs: mounted filesystem with ordered data mode.
<6>kjournald starting.  Commit interval 5 seconds
<6>EXT3 FS 2.4-0.9.19, 19 August 2002 on lvm(58,0), internal journal
<6>EXT3-fs: mounted filesystem with ordered data mode.
<6>hdc: DMA disabled
<3>microcode: CPU0 no microcode found! (sig=f29, pflags=2)
<3>microcode: CPU1 no microcode found! (sig=f29, pflags=2)
<4>i2c-core.o: adapter Smbus i8254x at 03:0e.0 Int registered as adapter
0.
<4>i2c-core.o: adapter Smbus i8254x at 03:0e.0 Ext registered as adapter
1.
<4>Loading i8254x SMBus driver. Version 3.0.9
<6>e1000: eth0 NIC Link is Up 100 Mbps Full Duplex
<7>usbserial.c: serial_open
<7>usbserial.c: serial_open
<7>usbserial.c: serial_open
<7>usbserial.c: serial_open
<7>usbserial.c: serial_open
<7>usbserial.c: serial_open
<7>usbserial.c: serial_open
<7>usbserial.c: serial_open
<7>usbserial.c: serial_open
<7>usbserial.c: serial_open
<7>usbserial.c: serial_open
<7>usbserial.c: serial_open
<7>usbserial.c: serial_open
<7>usbserial.c: serial_open
<7>usbserial.c: serial_open
<7>usbserial.c: serial_open
<4>calling pci_register_driver
<4>entering piraqProbe
<4>current number of piraqs: 0
<4>before pci_enable_device
<4>Piraq 1 located at bus 6, device/function 0x20
<4>   pci configuration space:
<4>
<4>   0x00: e8 10 20 59 03 01 80 02 00 00 00 09 00 00 00 00 
<4>   0x10: 81 dc 00 00 00 00 ae fd 00 fc ad fd 00 f8 ad fd 
<4>   0x20: 00 00 a0 fd 00 00 00 00 00 00 00 00 00 00 00 00 
<4>   0x30: 00 00 00 00 00 00 00 00 00 00 00 00 09 01 00 00 
<4>   silicon version 0
<4>   interrupt line 9
<4>   interrupt pin  1
<4>   irq 93
<4>   Base address[0]: I/O  0x0000dc80  0x00000080 128
<4>   Base address[1]: MEM  0xfdae0000  0x00020000 131072
<4>   Base address[2]: MEM  0xfdadfc00  0x00000040 64
<4>   Base address[3]: MEM  0xfdadf800  0x00000010 16
<4>   Base address[4]: MEM  0xfda00000  0x00080000 524288
<4>   Base address[5]:      0x00000000  0x00000000 0
<4>piraq count now at 1
<4>entering piraqProbe
<4>current number of piraqs: 1
<4>before pci_enable_device
<4>Piraq 2 located at bus 6, device/function 0x30
<4>   pci configuration space:
<4>
<4>   0x00: e8 10 20 59 03 01 80 02 00 00 00 09 00 00 00 00 
<4>   0x10: 01 dc 00 00 00 00 aa fd 00 f4 ad fd 00 f0 ad fd 
<4>   0x20: 00 00 98 fd 00 00 00 00 00 00 00 00 00 00 00 00 
<4>   0x30: 00 00 00 00 00 00 00 00 00 00 00 00 09 01 00 00 
<4>   silicon version 0
<4>   interrupt line 9
<4>   interrupt pin  1
<4>   irq 95
<4>   Base address[0]: I/O  0x0000dc00  0x00000080 128
<4>   Base address[1]: MEM  0xfdaa0000  0x00020000 131072
<4>   Base address[2]: MEM  0xfdadf400  0x00000040 64
<4>   Base address[3]: MEM  0xfdadf000  0x00000010 16
<4>   Base address[4]: MEM  0xfd980000  0x00080000 524288
<4>   Base address[5]:      0x00000000  0x00000000 0
<4>piraq count now at 2
<4>entering piraqProbe
<4>current number of piraqs: 2
<4>before pci_enable_device
<4>Piraq 3 located at bus 6, device/function 0x38
<4>   pci configuration space:
<4>
<4>   0x00: e8 10 20 59 03 01 80 02 00 00 00 09 00 00 00 00 
<4>   0x10: 81 d8 00 00 00 00 a8 fd 00 ec ad fd 00 e8 ad fd 
<4>   0x20: 00 00 90 fd 00 00 00 00 00 00 00 00 00 00 00 00 
<4>   0x30: 00 00 00 00 00 00 00 00 00 00 00 00 09 01 00 00 
<4>   silicon version 0
<4>   interrupt line 9
<4>   interrupt pin  1
<4>   irq 92
<4>   Base address[0]: I/O  0x0000d880  0x00000080 128
<4>   Base address[1]: MEM  0xfda80000  0x00020000 131072
<4>   Base address[2]: MEM  0xfdadec00  0x00000040 64
<4>   Base address[3]: MEM  0xfdade800  0x00000010 16
<4>   Base address[4]: MEM  0xfd900000  0x00080000 524288
<4>   Base address[5]:      0x00000000  0x00000000 0
<4>piraq count now at 3
<4>entering piraqProbe
<4>current number of piraqs: 3
<4>before pci_enable_device
<4>Piraq 4 located at bus 6, device/function 0x48
<4>   pci configuration space:
<4>
<4>   0x00: e8 10 20 59 03 01 80 02 00 00 00 09 00 00 00 00 
<4>   0x10: 01 d8 00 00 00 00 8e fd 00 e4 ad fd 00 e0 ad fd 
<4>   0x20: 00 00 80 fd 00 00 00 00 00 00 00 00 00 00 00 00 
<4>   0x30: 00 00 00 00 00 00 00 00 00 00 00 00 09 01 00 00 
<4>   silicon version 0
<4>   interrupt line 9
<4>   interrupt pin  1
<4>   irq 94
<4>   Base address[0]: I/O  0x0000d800  0x00000080 128
<4>   Base address[1]: MEM  0xfd8e0000  0x00020000 131072
<4>   Base address[2]: MEM  0xfdade400  0x00000040 64
<4>   Base address[3]: MEM  0xfdade000  0x00000010 16
<4>   Base address[4]: MEM  0xfd800000  0x00080000 524288
<4>   Base address[5]:      0x00000000  0x00000000 0
<4>piraq count now at 4
<4>after pci_register_driver
<4>initializing state for board 0, dsp 0
<4>initializing state for board 0, dsp 1
<4>initializing state for board 1, dsp 0
<4>initializing state for board 1, dsp 1
<4>initializing state for board 2, dsp 0
<4>initializing state for board 2, dsp 1
<4>initializing state for board 3, dsp 0
<4>initializing state for board 3, dsp 1
<4>allocating memory for piraq 0, dsp 0
<4>allocating memory for piraq 0, dsp 1
<4>allocating memory for piraq 1, dsp 0
<4>allocating memory for piraq 1, dsp 1
<4>allocating memory for piraq 2, dsp 0
<4>allocating memory for piraq 2, dsp 1
<4>allocating memory for piraq 3, dsp 0
<4>allocating memory for piraq 3, dsp 1
<4>piraq debugging at after allocateMemory
<4>calling piraqPciSetup
<4>piraq debugging at entering piraqPciSetup
<4>piraq debugging at --------------------------------------------
<4>piraq debugging at getting pci resources for next piraq
<4>piraq debugging at remapping memory areas
<4>      wave remapped from 0xfda00000 to 0xfad21000
<4>   dsp dpr remapped from 0xfdae0000 to 0xfada2000
<4>   dsp0 pDprComm is      0xfada2100
<4>   dsp0 intPending is    0xfada2100
<4>   dsp1 pDprComm is      0xfadb2100
<4>   dsp1 intPending is    0xfadb2100
<4>   status remapped to    0xfad1f800
<4>   counter remapped to   0xfadc3c00
<4>   addint clear is       0xfadc3c20
<4>   mailbox size(words)   0x00002805
<4>   free dpr begins at    0x00002845
<4>   free dpr len(words)   0x000017bb
<4>piraq debugging at calling piraq_boardReset
<4>dsp 0a counters set to zero
<4>dsp 0b counters set to zero
<4>piraq debugging at after piraq_boardReset
<4>piraq debugging at --------------------------------------------
<4>piraq debugging at getting pci resources for next piraq
<4>piraq debugging at remapping memory areas
<4>      wave remapped from 0xfd980000 to 0xfadc7000
<4>   dsp dpr remapped from 0xfdaa0000 to 0xfae48000
<4>   dsp0 pDprComm is      0xfae48100
<4>   dsp0 intPending is    0xfae48100
<4>   dsp1 pDprComm is      0xfae58100
<4>   dsp1 intPending is    0xfae58100
<4>   status remapped to    0xfadc5000
<4>   counter remapped to   0xfae69400
<4>   addint clear is       0xfae69420
<4>   mailbox size(words)   0x00002805
<4>   free dpr begins at    0x00002845
<4>   free dpr len(words)   0x000017bb
<4>piraq debugging at calling piraq_boardReset
<4>dsp 1a counters set to zero
<4>dsp 1b counters set to zero
<4>piraq debugging at after piraq_boardReset
<4>piraq debugging at --------------------------------------------
<4>piraq debugging at getting pci resources for next piraq
<4>piraq debugging at remapping memory areas
<4>      wave remapped from 0xfd900000 to 0xfae6d000
<4>   dsp dpr remapped from 0xfda80000 to 0xfaeee000
<4>   dsp0 pDprComm is      0xfaeee100
<4>   dsp0 intPending is    0xfaeee100
<4>   dsp1 pDprComm is      0xfaefe100
<4>   dsp1 intPending is    0xfaefe100
<4>   status remapped to    0xfae6b800
<4>   counter remapped to   0xfaf0fc00
<4>   addint clear is       0xfaf0fc20
<4>   mailbox size(words)   0x00002805
<4>   free dpr begins at    0x00002845
<4>   free dpr len(words)   0x000017bb
<4>piraq debugging at calling piraq_boardReset
<4>dsp 2a counters set to zero
<4>dsp 2b counters set to zero
<4>piraq debugging at after piraq_boardReset
<4>piraq debugging at --------------------------------------------
<4>piraq debugging at getting pci resources for next piraq
<4>piraq debugging at remapping memory areas
<4>      wave remapped from 0xfd800000 to 0xfaf13000
<4>   dsp dpr remapped from 0xfd8e0000 to 0xfaf94000
<4>   dsp0 pDprComm is      0xfaf94100
<4>   dsp0 intPending is    0xfaf94100
<4>   dsp1 pDprComm is      0xfafa4100
<4>   dsp1 intPending is    0xfafa4100
<4>   status remapped to    0xfaf11000
<4>   counter remapped to   0xfafb5400
<4>   addint clear is       0xfafb5420
<4>   mailbox size(words)   0x00002805
<4>   free dpr begins at    0x00002845
<4>   free dpr len(words)   0x000017bb
<4>piraq debugging at calling piraq_boardReset
<4>dsp 3a counters set to zero
<4>dsp 3b counters set to zero
<4>piraq debugging at after piraq_boardReset
<4>piraq debugging at leaving pciSetup
<4>piraq debugging at after piraqPciSetup
<4>piraq debugging at requesting interrupt
<4>   irq 93 registered for piraq #0
<4>   irq 95 registered for piraq #1
<4>   irq 92 registered for piraq #2
<4>   irq 94 registered for piraq #3
<4>piraq debugging at calling register_chrdev for piraq
<4>piraq debugging at calling register_chrdev for dsp
<4>piraq debugging at calling procfs_init
<4>piraq registration succesful for 4 cards

 

