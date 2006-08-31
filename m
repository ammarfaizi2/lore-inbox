Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932096AbWHaLoR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932096AbWHaLoR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 07:44:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932093AbWHaLoR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 07:44:17 -0400
Received: from fwstl1-1.wul.qc.ec.gc.ca ([205.211.132.24]:49326 "EHLO
	ecqcmtlbh.quebec.int.ec.gc.ca") by vger.kernel.org with ESMTP
	id S932089AbWHaLoQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 07:44:16 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
Subject: TR: HP XW6200: ACPI errors vs SMP / Hyperthreading + bad memory detection, 2.6.16.28 and 2.6.17.11? [try #2]
Date: Thu, 31 Aug 2006 07:44:09 -0400
Message-ID: <8E8F647D7835334B985D069AE964A4F7024692@ECQCMTLMAIL1.quebec.int.ec.gc.ca>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: HP XW6200: ACPI errors vs SMP / Hyperthreading + bad memory detection, 2.6.16.28 and 2.6.17.11? [try #2]
Thread-Index: AcbLkyy0oe2yFxPRT3+XbAm0791sBwAANuXQAFdLM8A=
From: "Fortier,Vincent [Montreal]" <Vincent.Fortier1@EC.GC.CA>
To: <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>
X-OriginalArrivalTime: 31 Aug 2006 11:44:09.0938 (UTC) FILETIME=[C5CDAB20:01C6CCF2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I've been running into a few troubles on our HP XW6200 workstations.

SYMPTOM 1:

If I'm booting normally I'm getting theses errors in dmesg (using either
a 2.6.16.x or 2.6.17.11):

EXT3-fs: mounted filesystem with ordered data mode.
Adding 2048276k swap on /dev/sda3.  Priority:-1 extents:1
across:2048276k
EXT3 FS on sda2, internal journal
ACPI Error (evgpe-0688): No handler or method for GPE[ 0], disabling
event [20060127]
ACPI Error (evgpe-0688): No handler or method for GPE[ 1], disabling
event [20060127]
ACPI Error (evgpe-0688): No handler or method for GPE[ 2], disabling
event [20060127]
ACPI Error (evgpe-0688): No handler or method for GPE[ 5], disabling
event [20060127]
ACPI Error (evgpe-0688): No handler or method for GPE[ 6], disabling
event [20060127]
ACPI Error (evgpe-0688): No handler or method for GPE[ 7], disabling
event [20060127]
ACPI Error (evgpe-0688): No handler or method for GPE[ 9], disabling
event [20060127]
ACPI Error (evgpe-0688): No handler or method for GPE[ A], disabling
event [20060127]
ACPI Error (evgpe-0688): No handler or method for GPE[ F], disabling
event [20060127]
ACPI Error (evgpe-0688): No handler or method for GPE[10], disabling
event [20060127]
ACPI Error (evgpe-0688): No handler or method for GPE[11], disabling
event [20060127]
ACPI Error (evgpe-0688): No handler or method for GPE[12], disabling
event [20060127]
ACPI Error (evgpe-0688): No handler or method for GPE[13], disabling
event [20060127]
ACPI Error (evgpe-0688): No handler or method for GPE[14], disabling
event [20060127]
ACPI Error (evgpe-0688): No handler or method for GPE[15], disabling
event [20060127]
ACPI Error (evgpe-0688): No handler or method for GPE[16], disabling
event [20060127]
ACPI Error (evgpe-0688): No handler or method for GPE[17], disabling
event [20060127]
ACPI Error (evgpe-0688): No handler or method for GPE[19], disabling
event [20060127]
ACPI Error (evgpe-0688): No handler or method for GPE[1A], disabling
event [20060127]
ACPI Error (evgpe-0688): No handler or method for GPE[1B], disabling
event [20060127]
ACPI Error (evgpe-0688): No handler or method for GPE[1C], disabling
event [20060127]
ACPI Error (evgpe-0688): No handler or method for GPE[1D], disabling
event [20060127]
ACPI Error (evgpe-0688): No handler or method for GPE[1E], disabling
event [20060127]
ACPI Error (evgpe-0688): No handler or method for GPE[1F], disabling
event [20060127]
mice: PS/2 mouse device common for all mice
usbcore: registered new driver usbmouse


Also, if I add the acpi=off it removes the ACPI Error msgs but then I
just
can see two cpu instead of the usual 4 (2 + hyper-threading)... I really
don't know if I'm actually seing two physical CPU or just one with it's
hyperthreading?
Here is one cpuinfo:
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 4
model name      : Intel(R) Xeon(TM) CPU 3.20GHz
stepping        : 1
cpu MHz         : 3200.728
cache size      : 1024 KB
physical id     : 0
siblings        : 1
core id         : 0
cpu cores       : 1
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 5
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe lm
constant_tsc pni monitor ds_cpl cid cx16 xtpr
bogomips        : 6409.57

Top with acpi=off
top - 17:57:51 up  1:28,  3 users,  load average: 2.56, 2.61, 2.41
Tasks: 120 total,   4 running, 116 sleeping,   0 stopped,   0 zombie
 Cpu0 : 56.3% us,  5.5% sy,  0.0% ni, 31.4% id,  1.5% wa,  0.2% hi,5.1%
si
 Cpu1 : 57.3% us,  5.7% sy,  0.0% ni, 33.1% id,  1.7% wa,  0.2% hi,2.0%
si

Top without acpi=off
top - 17:58:42 up 8 min,  1 user,  load average: 0.00, 0.05, 0.03
Tasks:  84 total,   1 running,  83 sleeping,   0 stopped,   0 zombie
 Cpu0 :  0.0% us,  0.0% sy,  0.0% ni, 100.0% id,  0.0% wa,  0.0% hi,0.0%
si
 Cpu1 :  0.0% us,  0.0% sy,  0.0% ni, 100.0% id,  0.0% wa,  0.0% hi,0.0%
si
 Cpu2 :  0.0% us,  0.0% sy,  0.0% ni, 99.0% id,  0.0% wa,  0.0% hi,1.0%
si
 Cpu3 :  0.0% us,  0.0% sy,  0.0% ni, 94.4% id,  0.0% wa,  0.0% hi,5.6%
si

Note that noapic option did not changed any behaviour about this.

========================================================================
===
SYMPTOM 2:

Also, theses workstations are either running with 4gig or 5gig of ram
(depending of the workstation..).  If the kernel is not set-up into
"bigmem" (64gig) then I can only see about 3gig of ram?

Here is the meminfo WITHOUT 64gig highmem enabled:
MemTotal:      3370236 kB
MemFree:       3136524 kB
Buffers:          8656 kB
Cached:         119728 kB
SwapCached:          0 kB
Active:         149880 kB
Inactive:        45432 kB
HighTotal:     2228180 kB
HighFree:      2031484 kB
LowTotal:      1142056 kB
LowFree:       1105040 kB
SwapTotal:     2048276 kB
SwapFree:      2048276 kB
Dirty:               4 kB
Writeback:           0 kB
Mapped:          85092 kB
Slab:            17796 kB
CommitLimit:   3733392 kB
Committed_AS:   157468 kB
PageTables:        620 kB
VmallocTotal:   114680 kB
VmallocUsed:     43564 kB
VmallocChunk:    66036 kB


And here is the same system WITH 64gig highmem enabled:
MemTotal:      5189828 kB
MemFree:       3583332 kB
Buffers:        152364 kB
Cached:        1201992 kB
SwapCached:          0 kB
Active:        1098516 kB
Inactive:       368720 kB
HighTotal:     4325332 kB
HighFree:      3002304 kB
LowTotal:       864496 kB
LowFree:        581028 kB
SwapTotal:     2048276 kB
SwapFree:      2048276 kB
Dirty:            7672 kB
Writeback:           0 kB
Mapped:         166440 kB
Slab:           120676 kB
CommitLimit:   4643188 kB
Committed_AS:   299400 kB
PageTables:       2408 kB
VmallocTotal:   118776 kB
VmallocUsed:     43528 kB
VmallocChunk:    70132 kB

Note that noapic or acpi=off do not affect this.


Has anybody ran into theses type of errors?

Thnx!

Vincent Fortier

