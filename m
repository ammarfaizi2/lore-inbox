Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131113AbQL1L0I>; Thu, 28 Dec 2000 06:26:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131114AbQL1LZ6>; Thu, 28 Dec 2000 06:25:58 -0500
Received: from oboe.it.uc3m.es ([163.117.139.101]:8979 "EHLO oboe.it.uc3m.es")
	by vger.kernel.org with ESMTP id <S131113AbQL1LZs>;
	Thu, 28 Dec 2000 06:25:48 -0500
From: "Peter T. Breuer" <ptb@oboe.it.uc3m.es>
Message-Id: <200012281055.eBSAtJo04295@oboe.it.uc3m.es>
Subject: wild gettimeofday on smp under 2.2.18
To: linux-kernel@vger.kernel.org
Date: Thu, 28 Dec 2000 11:55:19 +0100 (MET)
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm running an asus board with a pair of PIII 550s. gettimeofday is
varying wildly on the scale of a few seconds but is accurate over about
a minute, and sleep and hwclock are accurate.

#include <sys/time.h>
#include <unistd.h>
main() {
  while(1) {
    struct timeval tv;
    gettimeofday(&tv,NULL);
    printf("%lu\n",tv.tv_sec);
    sleep(5);
  }
}

output:

977997637
977997642
977997647
977997659
977997656
977997668
977997673
...

Any clues? The machine is scsi, with onboard adaptec. All works well
except that kde 2 that I just installed freezes after a few seconds for
"invalid time" on a getmouseblah call. kde 1.1 was fine. Running debian
potato and all up to date. I'm just looking for a quick fix. Yes .. I
probably could robustify the code a little.

Peter

Linux version 2.2.18pre18-SMP (root@barney) (gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #29 SMP Tue Nov 21 21:25:18 CET 2000
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
Processor #1 Pentium(tm) Pro APIC version 17
Processor #0 Pentium(tm) Pro APIC version 17
I/O APIC #2 Version 17 at 0xFEC00000.
Processors: 2
mapped APIC to ffffe000 (fee00000)
mapped IOAPIC to ffffd000 (fec00000)
Detected 551261 kHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1101.00 BogoMIPS
Memory: 257128k/262080k available (1424k kernel code, 424k reserved, 3028k data, 76k init)
Dentry hash table entries: 32768 (order 6, 256k)
Buffer cache hash table entries: 262144 (order 8, 1024k)
Page cache hash table entries: 65536 (order 6, 256k)
Checking 386/387 coupling... OK, FPU using exception 16 error reporting.
Checking 'hlt' instruction... OK.
Checking for popad bug... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.35a (19990819) Richard Gooch (rgooch@atnf.csiro.au)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
per-CPU timeslice cutoff: 99.98 usecs.
CPU1: Intel Pentium III (Katmai) stepping 03
calibrating APIC timer ... 
..... CPU clock speed is 551.2744 MHz.
..... system bus clock speed is 100.2315 MHz.
Booting processor 0 eip 2000
Calibrating delay loop... 1202.58 BogoMIPS
Intel machine check reporting enabled on CPU#0.
OK.
CPU0: Intel Pentium III (Coppermine) stepping 01
Total of 2 processors activated (2303.59 BogoMIPS).
enabling symmetric IO mode... ...done.
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-5, 2-10, 2-11, 2-13, 2-18, 2-20, 2-21, 2-22, 2-23 not connected.
number of MP IRQ sources: 16.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.... register #01: 00170011
.......     : max redirection entries: 0017
.......     : IO APIC version: 0011
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 000 00  0    0    0   0   0    1    1    59
 02 0FF 0F  0    0    0   0   0    1    1    51
 03 000 00  0    0    0   0   0    1    1    61
 04 000 00  0    0    0   0   0    1    1    69
 05 000 00  1    0    0   0   0    0    0    00
 06 000 00  0    0    0   0   0    1    1    71
 07 000 00  0    0    0   0   0    1    1    79
 08 000 00  0    0    0   0   0    1    1    81
 09 000 00  0    0    0   0   0    1    1    89
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 000 00  0    0    0   0   0    1    1    91
 0d 000 00  1    0    0   0   0    0    0    00
 0e 000 00  0    0    0   0   0    1    1    99
 0f 000 00  0    0    0   0   0    1    1    A1
 10 0FF 0F  1    1    0   1   0    1    1    A9
 11 0FF 0F  1    1    0   1   0    1    1    B1
 12 000 00  1    0    0   0   0    0    0    00
 13 0FF 0F  1    1    0   1   0    1    1    B9
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 2
IRQ1 -> 1
IRQ3 -> 3
IRQ4 -> 4
IRQ6 -> 6
IRQ7 -> 7
IRQ8 -> 8
IRQ9 -> 9
IRQ12 -> 12
IRQ14 -> 14
IRQ15 -> 15
IRQ16 -> 16
IRQ17 -> 17
IRQ19 -> 19
.................................... done.
PCI: PCI BIOS revision 2.10 entry at 0xf0730
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI->APIC IRQ transform: (B0,I4,P3) -> 19
PCI->APIC IRQ transform: (B0,I6,P0) -> 19
PCI->APIC IRQ transform: (B0,I11,P0) -> 17
PCI->APIC IRQ transform: (B1,I0,P0) -> 16

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
