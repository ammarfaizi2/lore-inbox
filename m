Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262550AbRFBMl5>; Sat, 2 Jun 2001 08:41:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262557AbRFBMlh>; Sat, 2 Jun 2001 08:41:37 -0400
Received: from host213-123-127-165.btopenworld.com ([213.123.127.165]:19980
	"EHLO argo.dyndns.org") by vger.kernel.org with ESMTP
	id <S262550AbRFBMla>; Sat, 2 Jun 2001 08:41:30 -0400
X-test: X
To: linux-kernel@vger.kernel.org
From: lk@mailandnews.com
Subject: Re: CUV4X-D lockup on boot
In-Reply-To: <m31yp3qlt5.fsf@fork.man2.dom>
Date: 02 Jun 2001 13:41:28 +0100
In-Reply-To: lk@mailandnews.com's message of "02 Jun 2001 10:21:26 +0100"
Message-ID: <m3y9rboxzb.fsf@fork.man2.dom>
X-Mailer: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Further information:

I inserted some printk()s in arch/i386/kernel/smpboot.c 
  320   static void __init synchronize_tsc_ap (void)
  321   {
  322           int i;
  323
  324           /*
  325            * smp_num_cpus is not necessarily known at the time
  326            * this gets called, so we first wait for the BP to
  327            * finish SMP initialization:
  328            */
  329   printk("ap %d\n", __LINE__);
  330           while (!atomic_read(&tsc_start_flag)) mb();
  331   printk("ap %d\n", __LINE__);
  332
  333           for (i = 0; i < NR_LOOPS; i++) {
  334                   atomic_inc(&tsc_count_start);
  335   printk("ap %d\n", __LINE__);
...

When the kernel locks up it does so after line 329 is printk'd

However, on a successful boot it behaves as follows:
...
Intel machine check reporting enabled on CPU#1.
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
ap 329
OK.
CPU1: Intel Pentium III (Coppermine) stepping 06
CPU has booted.
Before bogomips.
Total of 2 processors activated (3742.10 BogoMIPS).
Before bogocount - setting activated=1.
Boot done.
ENABLING IO-APIC IRQs
...changing IO-APIC physical APIC ID to 2 ... ok.
Synchronizing Arb IDs.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-10, 2-13, 2-20, 2-21, 2-22, 2-23 not connected.
..TIMER: vector=49 pin1=2 pin2=0
activating NMI Watchdog ... done.
number of MP IRQ sources: 21.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.... register #01: 00178011
.......     : max redirection entries: 0017
.......     : IO APIC version: 0011
 WARNING: unexpected IO-APIC, please mail
          to linux-smp@vger.kernel.org
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
 00 003 03  0    1    1   1   1    1    1    31
 01 003 03  0    0    0   0   0    1    1    39
 02 003 03  0    0    0   0   0    1    1    31
 03 003 03  0    0    0   0   0    1    1    41
 04 003 03  0    0    0   0   0    1    1    49
 05 003 03  0    0    0   0   0    1    1    51
 06 003 03  0    0    0   0   0    1    1    59
 07 003 03  0    0    0   0   0    1    1    61
 08 003 03  0    0    0   0   0    1    1    69
 09 003 03  0    0    0   0   0    1    1    71
 0a 000 00  1    0    0   0   0    0    0    00
 0b 003 03  0    0    0   0   0    1    1    79
 0c 003 03  0    0    0   0   0    1    1    81
 0d 000 00  1    0    0   0   0    0    0    00
 0e 003 03  0    0    0   0   0    1    1    89
 0f 003 03  0    0    0   0   0    1    1    91
 10 003 03  1    1    0   1   0    1    1    99
 11 003 03  1    1    0   1   0    1    1    A1
 12 003 03  1    1    0   1   0    1    1    A9
 13 003 03  1    1    0   1   0    1    1    B1
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 0-> 2
IRQ1 -> 1
IRQ3 -> 3
IRQ4 -> 4
IRQ5 -> 5
IRQ6 -> 6
IRQ7 -> 7
IRQ8 -> 8
IRQ9 -> 9
IRQ11 -> 11
IRQ12 -> 12
IRQ14 -> 14
IRQ15 -> 15
IRQ16 -> 16
IRQ17 -> 17
IRQ18 -> 18
IRQ19 -> 19
.................................... done.
calibrating APIC timer ...
..... CPU clock speed is 937.5342 MHz.
..... host bus clock speed is 133.9332 MHz.
cpu: 0, clocks: 1339332, slice: 446444
CPU0<T0:1339328,T1:892800,D:84,S:446444,C:1339332>
cpu: 1, clocks: 1339332, slice: 446444
CPU1<T0:1339328,T1:446432,D:8,S:446444,C:1339332>
checking TSC synchronization across CPUs: ap 331
ap 335
ap 337
ap 340
ap 345
ap 347
ap 335
ap 337
ap 340
ap 345
ap 347
ap 335
ap 337
ap 340
ap 345
ap 347
ap 335
ap 337
ap 340
ap 345
ap 347
ap 335
ap 337
ap 340
ap 345

ap 347
BIOS BUG: CPU#0 improperly initialized, has -16 usecs TSC skew! FIXED.
BIOS BUG: CPU#1 improperly initialized, has 16 usecs TSC skew! FIXED.
Setting commenced=1, go go go
...



A notable difference is:
Synchronizing Arb IDs.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-10, 2-13, 2-20, 2-21, 2-22, 2-23 not connected.
..TIMER: vector=49 pin1=2 pin2=0
activating NMI Watchdog ... done.

whereas in a lockup the following occurs:
Synchronizing Arb IDs.
..TIMER: vector=49 pin1=2 pin2=0
activating NMI Watchdog ... done.

i.e. before the init IO_APIC IRQs

Paul
