Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261165AbSJLMqN>; Sat, 12 Oct 2002 08:46:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261173AbSJLMqN>; Sat, 12 Oct 2002 08:46:13 -0400
Received: from ns3.neutech.fi ([194.100.130.126]:44302 "HELO cyplex.neutech.fi")
	by vger.kernel.org with SMTP id <S261165AbSJLMqL>;
	Sat, 12 Oct 2002 08:46:11 -0400
Date: Sat, 12 Oct 2002 15:51:59 +0300 (EEST)
From: Toni Mattila <tontsa@neutech.fi>
To: linux-kernel@vger.kernel.org
Subject: lk2.2.22 and IO-apic problem (dell poweredge)
Message-ID: <Pine.LNX.4.44L0.0210121547520.12491-100000@cyclone.neutech.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have small issue with 2.2.22 kernel with Dell Poweredge 2600 server.

It finds 5 IO-apics and complains about max reached. What happens is that
it falls back to XT-PIC and now scsi/ethernet is on same IRQ..

[root@cyclone conf]# cat /proc/interrupts
           CPU0       CPU1
  0:    3755229          0          XT-PIC  timer
  1:       4348          0          XT-PIC  keyboard
  2:          0          0          XT-PIC  cascade
  5:     568216          0          XT-PIC  ioc0, ioc1, eth1
  8:          1          0          XT-PIC  rtc
 11:    3558184          0          XT-PIC  eth0
 13:          1          0          XT-PIC  fpu
 14:          2          0          XT-PIC  ide0
NMI:          0
ERR:          0

It seems CPU1 doesn't get any interrupts either.


>From dmesg:
Linux version 2.2.22tm2 (root@cyclone.neutech.fi) (gcc version 
egcs-2.91.66 19990314/Linux (egcs-1.1
.2 release)) #1 SMP Fri Oct 11 22:56:02 EEST 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0009e000 @ 00000000 (usable)
 BIOS-e820: 3fee0000 @ 00100000 (usable)
Warning only 960MB will be used.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: DELL     Product ID: PE 0123      APIC at: 0xFEE00000
Processor #0 Unknown CPU [15:2] APIC version 20
Processor #2 Unknown CPU [15:2] APIC version 20
I/O APIC #4 Version 32 at 0xFEC00000.
I/O APIC #5 Version 32 at 0xFEC80000.
I/O APIC #6 Version 32 at 0xFEC81000.
I/O APIC #7 Version 32 at 0xFEC82000.
I/O APIC #8 Version 32 at 0xFEC82800.
Warning: Max I/O APICs exceeded (max 4, found 5).
Warning: switching to non APIC mode.
Processors: 2
mapped APIC to ffffe000 (fee00000)
mapped IOAPIC to ffffd000 (fec00000)
mapped IOAPIC to ffffc000 (fec80000)
mapped IOAPIC to ffffb000 (fec81000)
mapped IOAPIC to ffffa000 (fec82000)
Detected 2192964 kHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 4377.80 BogoMIPS
Memory: 971228k/983040k available (836k kernel code, 428k reserved, 10060k 
data, 60k init)
Dentry hash table entries: 131072 (order 8, 1024k)
Buffer cache hash table entries: 524288 (order 9, 2048k)
Page cache hash table entries: 262144 (order 8, 1024k)
VFS: Diskquotas version dquot_6.4.0 initialized
CPU: L1 I cache: 12K, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Intel(R) XEON(TM) CPU 2.20GHz
CPU: Intel(R) XEON(TM) CPU 2.20GHz
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Checking 386/387 coupling... OK, FPU using exception 16 error reporting.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.35a (19990819) Richard Gooch (rgooch@atnf.csiro.au)
CPU: L1 I cache: 12K, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Intel(R) XEON(TM) CPU 2.20GHz
Intel machine check reporting enabled on CPU#0.
per-CPU timeslice cutoff: 100.01 usecs.
CPU0: Intel(R) XEON(TM) CPU 2.20GHz stepping 04
calibrating APIC timer ...
..... CPU clock speed is 2192.9137 MHz.
..... system bus clock speed is 99.6777 MHz.
Booting processor 2 eip 2000
Calibrating delay loop... 4377.80 BogoMIPS
CPU: L1 I cache: 12K, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Intel(R) XEON(TM) CPU 2.20GHz
Intel machine check reporting enabled on CPU#2.
OK.
CPU2: Intel(R) XEON(TM) CPU 2.20GHz stepping 04
Total of 2 processors activated (8755.60 BogoMIPS).
checking TSC synchronization across CPUs: passed.
PCI: PCI BIOS revision 2.10 entry at 0xfc6ce

[root@cyclone linux]# grep -i apic .config
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y

[root@cyclone linux]# lsmod
Module                  Size  Used by
nfs                    73396   1  (autoclean)
lockd                  45072   1  (autoclean) [nfs]
sunrpc                 63940   1  (autoclean) [nfs lockd]
binfmt_misc             4156   0
e1000                  61024   1  (autoclean)
3c59x                  22440   1  (autoclean)
softdog                 1252   1
mptscsih               33520   7
mptctl                 21268   0  (unused)
mptbase                33696   4  [mptscsih mptctl]


Thanks in advance,
Toni Mattila


