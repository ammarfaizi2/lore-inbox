Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318315AbSG3QH4>; Tue, 30 Jul 2002 12:07:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318317AbSG3QH4>; Tue, 30 Jul 2002 12:07:56 -0400
Received: from mailrelay1.lanl.gov ([128.165.4.101]:5610 "EHLO
	mailrelay1.lanl.gov") by vger.kernel.org with ESMTP
	id <S318315AbSG3QHy>; Tue, 30 Jul 2002 12:07:54 -0400
Subject: 2.5.29, CPU#1 not working with CONFIG_SMP=y, 2.5.28 OK.
From: Steven Cole <elenstev@mesatop.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 30 Jul 2002 10:08:44 -0600
Message-Id: <1028045324.3148.32.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On my dual p3 with an Intel STL2 motherboard, linux-2.5.29 does not see
the second CPU properly.  And yes, I double checked that I really had
CONFIG_SMP=y for 2.5.29, rebuilding to make sure.  2.5.28 worked fine
for SMP.

Here are snippets from the dmesg output from 2.5.28 and 2.5.29:

2.5.28 dmesg snippet:

Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 999.0611 MHz.
..... host bus clock speed is 133.0281 MHz.
cpu: 0, clocks: 133281, slice: 4038
CPU0<T0:133280,T1:129232,D:10,S:4038,C:133281>
cpu: 1, clocks: 133281, slice: 4038
CPU1<T0:133280,T1:125200,D:4,S:4038,C:133281>
checking TSC synchronization across CPUs: passed.
migration_task 0 on cpu=0
migration_task 1 on cpu=1
Linux NET4.0 for Linux 2.4

2.5.29 dmesg snippet:

Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 999.0634 MHz.
..... host bus clock speed is 133.0284 MHz.
cpu: 0, clocks: 133284, slice: 4038
CPU0<T0:133280,T1:129232,D:10,S:4038,C:133284>
checking TSC synchronization across 2 CPUs: passed.
Bringing up 3
CPUS done 4294967295
Linux NET4.0 for Linux 2.4

Earlier in the 2.5.29 dmesg output, the second CPU is initialized:

Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 1994.75 BogoMIPS
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU1: Intel 00/08 stepping 06
Total of 2 processors activated (3969.02 BogoMIPS).

The output of /proc/cpuinfo shows two cpus for 2.5.28 and only
one for 2.5.29:

[steven@spc5 steven]$ cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : 00/08
stepping        : 6
cpu MHz         : 1000.127
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 mmx fxsr sse
bogomips        : 1974.27

And indeed, the second cpu is not being used.  I noticed this when
running a benchmark for 2.5.29 which came out much lower, about half
speed.

I also tried Craig Kulesa's patches for rmap and slabLRU for 2.5.29
since the readme mentioned an SMP fix, but that kernel shows this same
problem as vanilla 2.5.29.

Steven


