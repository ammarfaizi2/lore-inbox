Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266746AbRGORzd>; Sun, 15 Jul 2001 13:55:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266754AbRGORzR>; Sun, 15 Jul 2001 13:55:17 -0400
Received: from delta.Colorado.EDU ([128.138.139.9]:51208 "EHLO
	ibg.colorado.edu") by vger.kernel.org with ESMTP id <S266746AbRGORzB>;
	Sun, 15 Jul 2001 13:55:01 -0400
Message-Id: <200107151755.LAA134914@ibg.colorado.edu>
To: linux-kernel@vger.kernel.org
Subject: Crashes reading and writing to disk
Organization: Institute for Behavioral Genetics
              University of Colorado
              Boulder, CO  80309-0447
X-Phone: +1 303 492 2843
X-FAX: +1 303 492 0852
X-URL: http://ibgwww.Colorado.EDU/~lessem/
X-Copyright: All original content is copyright 2001 Jeff Lessem.
X-Copyright: Quoted and non-original content may be copyright the
X-Copyright: original author or others.
Date: Sun, 15 Jul 2001 11:55:04 -0600
From: Jeff Lessem <Jeff.Lessem@Colorado.EDU>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My machine is an 8 processor Dell P-III 700Mhz with 8GB of memory and
no swap.  The disk systems I am using are 3 12 drawer JBODs with 6
disks in a raid 5 arrangement and spanned logical drives attached to
an AMI Megaraid 467 (Elite 1500) controller with a total of 700GB+ of
space formated reiserfs.  I am using kernel 2.4.6, compiled with gcc
2.95.4.

Identical crashes occur when using ext2, non-spanned drives (170GB),
or kernel 2.4.4.  The failures occur with all 3 JBODs, two different
467 RAID controllers and a 466 RAID controller.  I still cannot rule
out hardware failure, because an identical machine with a very similar
setup can pass the following tests without crashing.

When reading or writing to the disk the machine crashes.  This can
reliably be repeated with either of the following commands:

dd if=/dev/zero bs=1G count=10 | split -b 1073741824

find /bigfulldisk -type f -exec cat {} \; > /dev/null

The dd crash reliable occurs after writing about 4.5GB of data, but
after a reboot, only about 1.7GB of data has made it to disk (an
emergency sync request just causes the crash to occur again).  I am
not sure how much data has been read by the time the find command
causes a crash, but it dies in less than 5 minutes.

Attached below is the ksymoops output from the stack dump.  I don't
know if it will be useful, but I can provide any other information
that is requested.  As I can recreate the crash at will, please let me
know if there is any before or after information that would be useful
in tracking down the cause of these problems.

ksymoops 2.4.1 on i686 2.4.6.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.6/ (default)
     -m /boot/System.map-2.4.6 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

wait_on_irq, CPU 2:
irq:  1 [ 1 1 0 0 0 0 0 0 ]
bh:   0 [ 0 0 1 0 0 0 0 0 ]
Stack dumps:
CPU 0: <unknown> 
CPU 1:55555555 55555555 55555555 55555555 55555555 55555555 55555555 55555555 
       55555555 55555555 55555555 55555555 55555555 55555555 55555555 55555555 
       55555555 55555555 55555555 55555555 55555555 55555555 55555555 55555555 
Call Trace: 
CPU 3:00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
       00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
       00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
Call Trace: 
CPU 4:f4fb0600 f4fb06c0 f4fb0660 00000000 00000000 00000000 c690ce78 00000000 
       00000000 00000000 00000001 f4fb06ac f4fb06ac f3bdebc0 f4fb0718 f4fb0658 
       00000000 004fc394 00021000 00000821 00000000 00000000 00000033 0000b7c6 
Call Trace: 
CPU 5:00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
       00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
       00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
Call Trace: 
CPU 6:6c69616d 55555500 55555555 55555555 55555555 55555555 55555555 55555555 
       00000000 00000000 00000000 d3329440 d33166b0 d33166b0 d33166b8 d33166b8 
       d3329468 d3298d80 d33166c8 d33166c8 d33166d0 d33166d0 00000000 d33166fc 
Call Trace: 
CPU 7:00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
       00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
       00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
Call Trace: 
CPU 2:c9c9bec8 c01ffe5d 00000002 00000040 00000000 c010823d c01ffe72 c9c9bf18 
       d34f4000 00000001 c017cc3f c9c9bf18 c9c9bf18 00000001 00000000 d34f4368 
       c0118f70 d34f4000 c024dd8c 00000000 d34f4130 d34f4130 c0189a3b c024dc68 
Call Trace: [<c010823d>] [<c017cc3f>] [<c0118f70>] [<c0189a3b>] [<c0118cc5>] [<c0118b3a>] [<c01085cb>] 
       [<c0105180>] [<c0105180>] [<c0106d04>] [<c0105180>] [<c0105180>] [<c01051ac>] [<c0105212>] [<c0114e66>] 
Warning (Oops_read): Code line not seen, dumping what data is available

Trace; c010823d <__global_cli+bd/124>
Trace; c017cc3f <flush_to_ldisc+9b/11c>
Trace; c0118f70 <__run_task_queue+60/70>
Trace; c0189a3b <console_softint+17/d4>
Trace; c0118cc5 <tasklet_action+91/c0>
Trace; c0118b3a <do_softirq+5a/88>
Trace; c01085cb <do_IRQ+db/ec>
Trace; c0105180 <default_idle+0/34>
Trace; c0105180 <default_idle+0/34>
Trace; c0106d04 <ret_from_intr+0/7>
Trace; c0105180 <default_idle+0/34>
Trace; c0105180 <default_idle+0/34>
Trace; c01051ac <default_idle+2c/34>
Trace; c0105212 <cpu_idle+3e/54>
Trace; c0114e66 <printk+16e/17c>


2 warnings issued.  Results may not be reliable.

The boot session log, in the event it is useful.

Linux version 2.4.6 (lessem@octopus) (gcc version 2.95.4 20010522 (Debian prerelease)) #4 SMP Fri Jul 13 13:10:00 BST 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009d400 (usable)
 BIOS-e820: 000000000009d400 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000003ff8000 (usable)
 BIOS-e820: 0000000003ff8000 - 0000000003fffc00 (ACPI data)
 BIOS-e820: 0000000003fffc00 - 0000000004000000 (ACPI NVS)
 BIOS-e820: 0000000004000000 - 00000000f0000000 (usable)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 0000000210000000 (usable)
7552MB HIGHMEM available.
Scan SMP from c0000000 for 1024 bytes.
Scan SMP from c009fc00 for 1024 bytes.
Scan SMP from c00f0000 for 65536 bytes.
found SMP  at 000f6570
hm, page 000f6000 reserved twice.
hm, page 000f7000 reserved twice.
On node 0 totalpages: 2162688
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 1933312 pages.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: INTEL    Product ID: OCPRF100     APIC at: 0xFEE00000
Processor #7 Pentium(tm) Pro APIC version 17
    Floating point unit present.
    Machine Exception supported.
    64 bit compare & exchange supported.
    Internal APIC present.
    SEP present.
    MTRR  present.
    PGE  present.
    MCA  present.
    CMOV  present.
    PAT  present.
    PSE  present.
    MMX  present.
    FXSR  present.
    XMM  present.
    Bootup CPU
Processor #0 Pentium(tm) Pro APIC version 17
    Floating point unit present.
    Machine Exception supported.
    64 bit compare & exchange supported.
    Internal APIC present.
    SEP present.
    MTRR  present.
    PGE  present.
    MCA  present.
    CMOV  present.
    PAT  present.
    PSE  present.
    MMX  present.
    FXSR  present.
    XMM  present.
Processor #1 Pentium(tm) Pro APIC version 17
    Floating point unit present.
    Machine Exception supported.
    64 bit compare & exchange supported.
    Internal APIC present.
    SEP present.
    MTRR  present.
    PGE  present.
    MCA  present.
    CMOV  present.
    PAT  present.
    PSE  present.
    MMX  present.
    FXSR  present.
    XMM  present.
Processor #2 Pentium(tm) Pro APIC version 17
    Floating point unit present.
    Machine Exception supported.
    64 bit compare & exchange supported.
    Internal APIC present.
    SEP present.
    MTRR  present.
    PGE  present.
    MCA  present.
    CMOV  present.
    PAT  present.
    PSE  present.
    MMX  present.
    FXSR  present.
    XMM  present.
Processor #3 Pentium(tm) Pro APIC version 17
    Floating point unit present.
    Machine Exception supported.
    64 bit compare & exchange supported.
    Internal APIC present.
    SEP present.
    MTRR  present.
    PGE  present.
    MCA  present.
    CMOV  present.
    PAT  present.
    PSE  present.
    MMX  present.
    FXSR  present.
    XMM  present.
Processor #4 Pentium(tm) Pro APIC version 17
    Floating point unit present.
    Machine Exception supported.
    64 bit compare & exchange supported.
    Internal APIC present.
    SEP present.
    MTRR  present.
    PGE  present.
    MCA  present.
    CMOV  present.
    PAT  present.
    PSE  present.
    MMX  present.
    FXSR  present.
    XMM  present.
Processor #5 Pentium(tm) Pro APIC version 17
    Floating point unit present.
    Machine Exception supported.
    64 bit compare & exchange supported.
    Internal APIC present.
    SEP present.
    MTRR  present.
    PGE  present.
    MCA  present.
    CMOV  present.
    PAT  present.
    PSE  present.
    MMX  present.
    FXSR  present.
    XMM  present.
Processor #6 Pentium(tm) Pro APIC version 17
    Floating point unit present.
    Machine Exception supported.
    64 bit compare & exchange supported.
    Internal APIC present.
    SEP present.
    MTRR  present.
    PGE  present.
    MCA  present.
    CMOV  present.
    PAT  present.
    PSE  present.
    MMX  present.
    FXSR  present.
    XMM  present.
Bus #0 is PCI   
Bus #1 is PCI   
Bus #2 is PCI   
Bus #3 is PCI   
Bus #4 is PCI   
Bus #5 is PCI   
Bus #6 is ISA   
I/O APIC #8 Version 19 at 0xFEC00000.
Int: type 3, pol 1, trig 1, bus 6, IRQ 00, APIC ID 8, APIC INT 00
Int: type 0, pol 1, trig 1, bus 6, IRQ 01, APIC ID 8, APIC INT 01
Int: type 0, pol 1, trig 1, bus 6, IRQ 00, APIC ID 8, APIC INT 02
Int: type 0, pol 1, trig 1, bus 6, IRQ 03, APIC ID 8, APIC INT 03
Int: type 0, pol 1, trig 1, bus 6, IRQ 04, APIC ID 8, APIC INT 04
Int: type 0, pol 3, trig 3, bus 0, IRQ 28, APIC ID 8, APIC INT 3a
Int: type 0, pol 1, trig 1, bus 6, IRQ 06, APIC ID 8, APIC INT 06
Int: type 0, pol 1, trig 1, bus 6, IRQ 07, APIC ID 8, APIC INT 07
Int: type 0, pol 3, trig 1, bus 6, IRQ 08, APIC ID 8, APIC INT 08
Int: type 0, pol 1, trig 1, bus 6, IRQ 09, APIC ID 8, APIC INT 09
Int: type 0, pol 3, trig 3, bus 0, IRQ 00, APIC ID 8, APIC INT 3b
Int: type 0, pol 3, trig 3, bus 0, IRQ 29, APIC ID 8, APIC INT 12
Int: type 0, pol 1, trig 1, bus 6, IRQ 0c, APIC ID 8, APIC INT 0c
Int: type 0, pol 1, trig 1, bus 6, IRQ 0d, APIC ID 8, APIC INT 0d
Int: type 0, pol 1, trig 1, bus 6, IRQ 0e, APIC ID 8, APIC INT 0e
Int: type 0, pol 3, trig 3, bus 0, IRQ 10, APIC ID 8, APIC INT 3d
Int: type 0, pol 3, trig 3, bus 0, IRQ 30, APIC ID 8, APIC INT 30
Int: type 0, pol 3, trig 3, bus 0, IRQ 3f, APIC ID 8, APIC INT 31
Int: type 0, pol 3, trig 3, bus 2, IRQ 00, APIC ID 8, APIC INT 3b
Int: type 0, pol 3, trig 3, bus 2, IRQ 10, APIC ID 8, APIC INT 32
Int: type 0, pol 3, trig 3, bus 4, IRQ 00, APIC ID 8, APIC INT 3b
Int: type 0, pol 3, trig 3, bus 4, IRQ 10, APIC ID 8, APIC INT 20
Int: type 0, pol 3, trig 3, bus 5, IRQ 00, APIC ID 8, APIC INT 3b
Lint: type 3, pol 1, trig 1, bus 6, IRQ 00, APIC ID ff, APIC LINT 00
Lint: type 1, pol 1, trig 1, bus 0, IRQ 00, APIC ID ff, APIC LINT 01
Processors: 8
mapped APIC to ffffe000 (fee00000)
mapped IOAPIC to ffffd000 (fec00000)
Kernel command line: root=/dev/sdb1 console=ttyS0,38400 console=tty0 mem=8650752K
Initializing CPU#0
Detected 700.106 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1395.91 BogoMIPS
Memory: 8504564k/8650752k available (1018k kernel code, 145800k reserved, 365k data, 204k init, 7733248k highmem)
Dentry-cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
Mount-cache hash table entries: 262144 (order: 9, 2097152 bytes)
Buffer-cache hash table entries: 524288 (order: 9, 2097152 bytes)
Page-cache hash table entries: 524288 (order: 9, 2097152 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 1024K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX confomtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 1024K
Intel machine check reporting enabled on CPU#0.
CPU0: Intel Pentium III (Cascades) stepping 01
per-CPU timeslice cutoff: 2923.17 usecs.
Getting VERSION: 40011
Getting VERSION: 40011
Getting ID: 7000000
Getting ID: 8000000
Getting LVT0: 700
Getting LVT1: 400
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
CPU present map: ff
Booting processor 1/0 eip 2000
Setting warm reset code and vector.
1.
2.
3.
Asserting INIT.
Waiting for send to finish...
+Deasserting INIT.
Waiting for send to finish...
+#startup loops: 2.
Sending STARTUP #1.
After apic_write.
Initializing CPU#1
Startup point 1.
CPU#1 (phys ID: 0) waiting for CALLOUT
Waiting for send to finish...
+Sending STARTUP #2.
After apic_write.
Startup point 1.
Waiting for send to finish...
+After Startup.
Before Callout 1.
After Callout 1.
CALLIN, before setup_local_APIC().
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 1399.19 BogoMIPS
Stack at about c9c9ffbc
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 1024K
Intel machine check reporting enabled on CPU#1.
OK.
CPU1: Intel Pentium III (Cascades) stepping 01
CPU has booted.
Booting processor 2/1 eip 2000
Setting warm reset code and vector.
1.
2.
3.
Asserting INIT.
Waiting for send to finish...
+Deasserting INIT.
Waiting for send to finish...
+#startup loops: 2.
Sending STARTUP #1.
After apic_write.
Initializing CPU#2
Startup point 1.
CPU#2 (phys ID: 1) waiting for CALLOUT
Waiting for send to finish...
+Sending STARTUP #2.
After apic_write.
Startup point 1.
Waiting for send to finish...
+After Startup.
Before Callout 2.
After Callout 2.
CALLIN, before setup_local_APIC().
masked ExtINT on CPU#2
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 1399.19 BogoMIPS
Stack at about c9c9bfbc
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 1024K
Intel machine check reporting enabled on CPU#2.
OK.
CPU2: Intel Pentium III (Cascades) stepping 01
CPU has booted.
Booting processor 3/2 eip 2000
Setting warm reset code and vector.
1.
2.
3.
Asserting INIT.
Waiting for send to finish...
+Deasserting INIT.
Waiting for send to finish...
+#startup loops: 2.
Sending STARTUP #1.
After apic_write.
Initializing CPU#3
Startup point 1.
CPU#3 (phys ID: 2) waiting for CALLOUT
Waiting for send to finish...
+Sending STARTUP #2.
After apic_write.
Startup point 1.
Waiting for send to finish...
+After Startup.
Before Callout 3.
After Callout 3.
CALLIN, before setup_local_APIC().
masked ExtINT on CPU#3
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 1399.19 BogoMIPS
Stack at about c9c99fbc
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 1024K
Intel machine check reporting enabled on CPU#3.
OK.
CPU3: Intel Pentium III (Cascades) stepping 01
CPU has booted.
Booting processor 4/3 eip 2000
Setting warm reset code and vector.
1.
2.
3.
Asserting INIT.
Waiting for send to finish...
+Deasserting INIT.
Waiting for send to finish...
+#startup loops: 2.
Sending STARTUP #1.
After apic_write.
Initializing CPU#4
Startup point 1.
CPU#4 (phys ID: 3) waiting for CALLOUT
Waiting for send to finish...
+Sending STARTUP #2.
After apic_write.
Startup point 1.
Waiting for send to finish...
+After Startup.
Before Callout 4.
After Callout 4.
CALLIN, before setup_local_APIC().
masked ExtINT on CPU#4
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 1399.19 BogoMIPS
Stack at about c9c97fbc
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 1024K
Intel machine check reporting enabled on CPU#4.
OK.
CPU4: Intel Pentium III (Cascades) stepping 01
CPU has booted.
Booting processor 5/4 eip 2000
Setting warm reset code and vector.
1.
2.
3.
Asserting INIT.
Waiting for send to finish...
+Deasserting INIT.
Waiting for send to finish...
+#startup loops: 2.
Sending STARTUP #1.
After apic_write.
Initializing CPU#5
Startup point 1.
CPU#5 (phys ID: 4) waiting for CALLOUT
Waiting for send to finish...
+Sending STARTUP #2.
After apic_write.
Startup point 1.
Waiting for send to finish...
+After Startup.
Before Callout 5.
After Callout 5.
CALLIN, before setup_local_APIC().
masked ExtINT on CPU#5
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 1399.19 BogoMIPS
Stack at about c9c93fbc
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 1024K
Intel machine check reporting enabled on CPU#5.
OK.
CPU5: Intel Pentium III (Cascades) stepping 01
CPU has booted.
Booting processor 6/5 eip 2000
Setting warm reset code and vector.
1.
2.
3.
Asserting INIT.
Waiting for send to finish...
+Deasserting INIT.
Waiting for send to finish...
+#startup loops: 2.
Sending STARTUP #1.
After apic_write.
Initializing CPU#6
Startup point 1.
CPU#6 (phys ID: 5) waiting for CALLOUT
Waiting for send to finish...
+Sending STARTUP #2.
After apic_write.
Startup point 1.
Waiting for send to finish...
+After Startup.
Before Callout 6.
After Callout 6.
CALLIN, before setup_local_APIC().
masked ExtINT on CPU#6
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 1399.19 BogoMIPS
Stack at about c9c91fbc
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 1024K
Intel machine check reporting enabled on CPU#6.
OK.
CPU6: Intel Pentium III (Cascades) stepping 01
CPU has booted.
Booting processor 7/6 eip 2000
Setting warm reset code and vector.
1.
2.
3.
Asserting INIT.
Waiting for send to finish...
+Deasserting INIT.
Waiting for send to finish...
+#startup loops: 2.
Sending STARTUP #1.
After apic_write.
Initializing CPU#7
Startup point 1.
CPU#7 (phys ID: 6) waiting for CALLOUT
Waiting for send to finish...
+Sending STARTUP #2.
After apic_write.
Startup point 1.
Waiting for send to finish...
+After Startup.
Before Callout 7.
After Callout 7.
CALLIN, before setup_local_APIC().
masked ExtINT on CPU#7
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 1399.19 BogoMIPS
Stack at about c9cbffbc
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 1024K
Intel machine check reporting enabled on CPU#7.
OK.
CPU7: Intel Pentium III (Cascades) stepping 01
CPU has booted.
Before bogomips.
Total of 8 processors activated (11190.27 BogoMIPS).
Before bogocount - setting activated=1.
Boot done.
ENABLING IO-APIC IRQs
...changing IO-APIC physical APIC ID to 8 ... ok.
Synchronizing Arb IDs.
..TIMER: vector=31 pin1=2 pin2=0
testing the IO APIC.......................

.................................... done.
calibrating APIC timer ...
..... CPU clock speed is 700.1107 MHz.
..... host bus clock speed is 100.0158 MHz.
cpu: 0, clocks: 1000158, slice: 111128
CPU0<T0:1000144,T1:889008,D:8,S:111128,C:1000158>
cpu: 1, clocks: 1000158, slice: 111128
cpu: 2, clocks: 1000158, slice: 111128
cpu: 7, clocks: 1000158, slice: 111128
cpu: 5, clocks: 1000158, slice: 111128
cpu: 6, clocks: 1000158, slice: 111128
CPU7<T0:1000144,T1:111120,D:0,S:111128,C:1000158>
CPU5<T0:1000144,T1:333376,D:0,S:111128,C:1000158>
cpu: 4, clocks: 1000158, slice: 111128
CPU1<T0:1000144,T1:777888,D:0,S:111128,C:1000158>
CPU6<T0:1000144,T1:222240,D:8,S:111128,C:1000158>
CPU2<T0:1000144,T1:666752,D:8,S:111128,C:1000158>
cpu: 3, clocks: 1000158, slice: 111128
CPU4<T0:1000144,T1:444496,D:8,S:111128,C:1000158>
CPU3<T0:1000144,T1:555632,D:0,S:111128,C:1000158>
checking TSC synchronization across CPUs: passed.
Setting commenced=1, go go go
PCI: PCI BIOS revision 2.10 entry at 0xfdaca, last bus=5
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 1: assuming transparent
Unknown bridge resource 2: assuming transparent
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 1: assuming transparent
Unknown bridge resource 2: assuming transparent
PCI: Discovered primary peer bus 02 [IRQ]
PCI: Discovered primary peer bus 04 [IRQ]
PCI: Discovered primary peer bus 05 [IRQ]
PCI: Using IRQ router PIIX [8086/7110] at 00:0f.0
querying PCI -> IRQ mapping bus:0, slot:0, pin:0.
PCI->APIC IRQ transform: (B0,I0,P0) -> 59
querying PCI -> IRQ mapping bus:0, slot:4, pin:0.
PCI->APIC IRQ transform: (B0,I4,P0) -> 61
querying PCI -> IRQ mapping bus:0, slot:10, pin:0.
PCI->APIC IRQ transform: (B0,I10,P0) -> 58
querying PCI -> IRQ mapping bus:0, slot:10, pin:1.
PCI->APIC IRQ transform: (B0,I10,P1) -> 18
querying PCI -> IRQ mapping bus:0, slot:12, pin:0.
PCI->APIC IRQ transform: (B0,I12,P0) -> 48
querying PCI -> IRQ mapping bus:0, slot:15, pin:3.
PCI->APIC IRQ transform: (B0,I15,P3) -> 49
querying PCI -> IRQ mapping bus:2, slot:0, pin:0.
PCI->APIC IRQ transform: (B2,I0,P0) -> 59
querying PCI -> IRQ mapping bus:2, slot:4, pin:0.
PCI->APIC IRQ transform: (B2,I4,P0) -> 50
querying PCI -> IRQ mapping bus:4, slot:0, pin:0.
PCI->APIC IRQ transform: (B4,I0,P0) -> 59
querying PCI -> IRQ mapping bus:4, slot:4, pin:0.
PCI->APIC IRQ transform: (B4,I4,P0) -> 32
querying PCI -> IRQ mapping bus:5, slot:0, pin:0.
PCI->APIC IRQ transform: (B5,I0,P0) -> 59
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd v1.8
allocated 32 pages and 32 bhs reserved for the highmem bounces
pty: 256 Unix98 ptys configured
Serial driver version 5.05a (2001-03-20) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
block: queued sectors max/low 5662464kB/5531392kB, 8192 slots per queue
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 79
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1220-0x1227, BIOS settings: hda:DMA, hdb:pio
hda: SAMSUNG CD-ROM SC-148C, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
SCSI subsystem driver Revision: 1.00
sym53c8xx: at PCI bus 0, device 10, function 0
sym53c8xx: 53c896 detected 
sym53c8xx: at PCI bus 0, device 10, function 1
sym53c8xx: 53c896 detected 
sym53c896-0: rev 0x7 on pci bus 0 device 10 function 0 irq 58
sym53c896-0: ID 7, Fast-40, Parity Checking
sym53c896-0: handling phase mismatch from SCRIPTS.
sym53c896-1: rev 0x7 on pci bus 0 device 10 function 1 irq 18
sym53c896-1: ID 7, Fast-40, Parity Checking
sym53c896-1: handling phase mismatch from SCRIPTS.
scsi0 : sym53c8xx-1.7.3a-20010304
scsi1 : sym53c8xx-1.7.3a-20010304
  Vendor: SEAGATE   Model: ST39204LC         Rev: 0005
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0 : channel 0 target 0 lun 1 request sense failed, performing reset.
SCSI bus is being reset for host 0 channel 0.
sym53c8xx_reset: pid=0 reset_flags=1 serial_number=0 serial_number_at_timeout=0
scsi0: device driver called scsi_done() for a synchronous reset.
sym53c896-0: handling phase mismatch from SCRIPTS.
  Vendor: DELL      Model: 1x2 U2W SCSI BP   Rev: 1.7 
  Type:   Processor                          ANSI SCSI revision: 02
megaraid: v1.14g-ac2 (Release Date: Mar 22, 2001; 19:34:02)
megaraid: found 0x8086:0x1960:idx 0:bus 0:slot 4:func 1
scsi2 : Found a MegaRAID controller at 0xf880a000, IRQ: 61
megaraid: [H79N:2.10] detected 3 logical drives
megaraid: found 0x8086:0x1960:idx 1:bus 2:slot 4:func 1
scsi3 : Found a MegaRAID controller at 0xf880c000, IRQ: 50
megaraid: [H79N:2.10] detected 1 logical drives
scsi2 : AMI MegaRAID H79N 254 commands 16 targs 2 chans 8 luns
scsi3 : AMI MegaRAID H79N 254 commands 16 targs 2 chans 8 luns
scsi2: scanning channel 1 for devices.
  Vendor: Dell      Model: 12 BAY U2W CU     Rev: 0209
  Type:   Processor                          ANSI SCSI revision: 03
scsi2: scanning channel 2 for devices.
  Vendor: Dell      Model: 12 BAY U2W CU     Rev: 0209
  Type:   Processor                          ANSI SCSI revision: 03
scsi2: scanning virtual channel for logical drives.
  Vendor: MegaRAID  Model: LD0 RAID5 47310R  Rev: H79N
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: MegaRAID  Model: LD1 RAID5 73655R  Rev: H79N
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: MegaRAID  Model: LD2 RAID5 73655R  Rev: H79N
  Type:   Direct-Access                      ANSI SCSI revision: 02
scsi3: scanning channel 1 for devices.
  Vendor: Dell      Model: 12 BAY U2W CU     Rev: 0209
  Type:   Processor                          ANSI SCSI revision: 03
scsi3: scanning channel 2 for devices.
scsi3: scanning virtual channel for logical drives.
  Vendor: MegaRAID  Model: LD0 RAID5 46780R  Rev: H79N
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sda at scsi0, channel 0, id 0, lun 0
Detected scsi disk sdb at scsi2, channel 2, id 0, lun 0
Detected scsi disk sdc at scsi2, channel 2, id 0, lun 1
Detected scsi disk sdd at scsi2, channel 2, id 0, lun 2
Detected scsi disk sde at scsi3, channel 2, id 0, lun 0
sym53c896-0-<0,*>: FAST-20 WIDE SCSI 40.0 MB/s (50.0 ns, offset 31)
SCSI device sda: 17783239 512-byte hdwr sectors (9105 MB)
Partition check:
 sda: sda1 sda2 sda3 < sda5 sda6 sda7 >
SCSI device sdb: 711290880 512-byte hdwr sectors (364181 MB)
 sdb: sdb1 sdb2
SCSI device sdc: 355645440 512-byte hdwr sectors (182090 MB)
 sdc: sdc1
SCSI device sdd: 355645440 512-byte hdwr sectors (182090 MB)
 sdd: unknown partition table
SCSI device sde: 710205440 512-byte hdwr sectors (363625 MB)
 sde: sde1
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 131072 buckets, 1024Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 204k freed
Intel(R) PRO/1000 Network Driver - version 3.0.10
Copyright (c) 1999 - 2001 Intel Corporation

Intel(R) PRO/1000 Network Connection
eth0:  Mem:0xfc820000  IRQ:32  Speed:1000 Mbps  Duplex:Full
reiserfs: checking transaction log (device 08:21) ...
reiserfs: replayed 9 transactions in 2 seconds
Using r5 hash to sort names
ReiserFS version 3.6.25
Real Time Clock Driver v1.10d
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
Debian GNU/Linux testing/unstable zeon ttyS0

zeon login: 
Debian GNU/Linux testing/unstable zeon ttyS0

zeon login: nfsd: terminating on signal 2
nfsd: terminating on signal 2
nfsd: terminating on signal 2
nfsd: terminating on signal 2
nfsd: terminating on signal 2
nfsd: terminating on signal 2
nfsd: terminating on signal 2
nfsd: terminating on signal 2

wait_on_irq, CPU 2:
irq:  1 [ 1 1 0 0 0 0 0 0 ]
bh:   0 [ 0 0 1 0 0 0 0 0 ]
Stack dumps:
CPU 0: <unknown> 
CPU 1:55555555 55555555 55555555 55555555 55555555 55555555 55555555 55555555 
       55555555 55555555 55555555 55555555 55555555 55555555 55555555 55555555 
       55555555 55555555 55555555 55555555 55555555 55555555 55555555 55555555 
Call Trace: 

CPU 3:00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
       00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
       00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
Call Trace: 

CPU 4:f4fb0600 f4fb06c0 f4fb0660 00000000 00000000 00000000 c690ce78 00000000 
       00000000 00000000 00000001 f4fb06ac f4fb06ac f3bdebc0 f4fb0718 f4fb0658 
       00000000 004fc394 00021000 00000821 00000000 00000000 00000033 0000b7c6 
Call Trace: 

CPU 5:00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
       00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
       00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
Call Trace: 

CPU 6:6c69616d 55555500 55555555 55555555 55555555 55555555 55555555 55555555 
       00000000 00000000 00000000 d3329440 d33166b0 d33166b0 d33166b8 d33166b8 
       d3329468 d3298d80 d33166c8 d33166c8 d33166d0 d33166d0 00000000 d33166fc 
Call Trace: 

CPU 7:00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
       00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
       00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
Call Trace: 

CPU 2:c9c9bec8 c01ffe5d 00000002 00000040 00000000 c010823d c01ffe72 c9c9bf18 
       d34f4000 00000001 c017cc3f c9c9bf18 c9c9bf18 00000001 00000000 d34f4368 
       c0118f70 d34f4000 c024dd8c 00000000 d34f4130 d34f4130 c0189a3b c024dc68 
Call Trace: [<c010823d>] [<c017cc3f>] [<c0118f70>] [<c0189a3b>] [<c0118cc5>] [<c0118b3a>] [<c01085cb>] 
       [<c0105180>] [<c0105180>] [<c0106d04>] [<c0105180>] [<c0105180>] [<c01051ac>] [<c0105212>] [<c0114e66>] 

SysRq: Emergency Sync
SysRq: Emergency Sync
SysRq: Emergency Sync
Syncing device 08:11 ... 
wait_on_irq, CPU 0:
irq:  1 [ 0 0 1 0 0 0 0 0 ]
bh:   1 [ 1 0 1OK
 0<6>Syncing device 08:21 ...  0 0 1 0 ]
Stack dumps:
CPU 1:55555555 55555555 55555555 55555555 55555555 55555555 55555555 55555555 
       55555555 55555555 55555555 55555555 55555555 55555555 55555555 55555555 
       55555555 55555555 55555555 55555555 55555555 55555555 55555555 55555555 
Call Trace: 

CPU 2:00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
       00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
       00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
Call Trace: 

CPU 3:00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
       00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
       00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
Call Trace: 

CPU 4:55555555 55555555 55555555 55555555 55555555 55555555 55555555 55555555 
       55555555 55555555 55555555 55555555 55555555 55555555 55555555 55555555 
       55555555 55555555 55555555 55555555 55555555 55555555 55555555 55555555 
Call Trace: [<c0111ceb>] [<c01b1362>] [<c01b0783>] [<c011bb24>] [<c0111ceb>] [<c01b1362>] [<c01b0783>] 
       [<c01a0f0e>] [<c01a7005>] [<c01a6836>] [<c01a6a38>] [<c01a6c32>] [<c01b481f>] [<c01a5fe6>] [<c01b0545>] 
       [<c01b11f8>] [<c011ba07>] [<c011bc16>] [<c011beac>] [<c0118ea0>] [<c011bb24>] [<c011018d>] [<c0105180>] 
       [<c0105180>] [<c0105180>] [<c010521e>] [<c0114e66>] 

CPU 5:f4fb0600 f4fb06c0 f4fb0660 00000000 00000000 00000000 c690ce78 00000000 
       00000000 00000000 00000001 f4fb06ac f4fb06ac f3bdebc0 f4fb0718 f4fb0658 
       00000000 004fc394 00021000 00000821 00000000 00000000 00000033 0000b7c6 
Call Trace: 

CPU 6:6c69616d 55555500 55555555 55555555 55555555 55555555 55555555 55555555 
       00000000 00000000 00000000 d3329440 d33166b0 d33166b0 d33166b8 d33166b8 
       d3329468 d3298d80 d33166c8 d33166c8 d33166d0 d33166d0 00000000 d33166fc 
Call Trace: 

CPU 7:00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
       00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
       00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
Call Trace: 

CPU 0:c025bef0 c01ffe5d 00000000 00000000 00000000 c010823d c01ffe72 f684ae60 
       00000004 00000001 c018bd1a 00000000 c018bce4 00000001 00000000 c011be45 
       00000000 00000000 00000000 00000001 00000000 0000c000 0000c000 00000008 
Call Trace: [<c010823d>] [<c018bd1a>] [<c018bce4>] [<c011be45>] [<c0118ea0>] [<c0118d85>] [<c0118b3a>] 
       [<c01085cb>] [<c0105180>] [<c0105180>] [<c0106d04>] [<c0105180>] [<c0105180>] [<c01051ac>] [<c0105212>] 
       [<c0105000>] 

SysRq: Resetting
