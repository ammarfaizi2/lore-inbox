Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261205AbSL2SKg>; Sun, 29 Dec 2002 13:10:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261290AbSL2SKg>; Sun, 29 Dec 2002 13:10:36 -0500
Received: from tag.witbe.net ([81.88.96.48]:63249 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id <S261205AbSL2SKe>;
	Sun, 29 Dec 2002 13:10:34 -0500
From: "Paul Rolland" <rol@as2917.net>
To: "'Manfred Spraul'" <manfred@colorfullife.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [2.5.53] So sloowwwww......
Date: Sun, 29 Dec 2002 19:18:54 +0100
Message-ID: <00c001c2af66$bf5d6850$2101a8c0@witbe>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
In-Reply-To: <3E0F3545.4040601@colorfullife.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> I'd guess power management, a runaway interrupt, bad mtrr settings, 
> problems with the memory map decoding or Hyperthreading.
> 
> Check
> /proc/interrupts
> /proc/mtrr
> The memory detection results at the top of dmesg
> disable apm, acpi.
> Check anything Hyperthreading related in dmesg.
> 
Here is the result with a kernel without APM and ACPI :

Boot process log, for memory/hyperthreading (but this is a P4, not
a Xeon, so I guess there is no hyperthreading available) :
Linux version 2.5.53 (root@donald.as2917.net) (gcc version 3.2 20020903
(Red Hat Linux 8.0 3.2-7)) #23 Sun Dec 29 19:03:10 CET 2002
Video mode to be used for restore is f01
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fffc000 (usable)
 BIOS-e820: 000000001fffc000 - 000000001ffff000 (ACPI data)
 BIOS-e820: 000000001ffff000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 131068
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126972 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
Building zonelist for node : 0
Kernel command line: auto BOOT_IMAGE=test ro
BOOT_FILE=/boot/vmlinuz-2.5.53 hdd=scsi panic=30 console=ttyS0
ide_setup: hdd=scsi -- BAD OPTION
Found and enabled local APIC!
Initializing CPU#0
Detected 2423.222 MHz processor.
Console: colour VGA+ 80x50
Calibrating delay loop... 4784.12 BogoMIPS
Memory: 513636k/524272k available (2870k kernel code, 9844k reserved,
1098k data, 340k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU#0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#0: Thermal monitoring enabled
Machine check exception polling timer started.
CPU: Intel(R) Pentium(R) 4 CPU 2.40GHz stepping 04
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 2423.0556 MHz.
..... host bus clock speed is 134.0641 MHz.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
mtrr: v2.0 (20020519)
PCI: PCI BIOS revision 2.10 entry at 0xf11a0, last bus=1
PCI: Using configuration type 1
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
Linux Plug and Play Support v0.93 (c) Adam Belay
block request queues:
 128 requests per read queue
 128 requests per write queue
 8 requests per batch
 enter congestion at 31
 exit congestion at 33
...

1 [19:09] rol@donald:~> cat /proc/interrupts 
           CPU0       
  0:     247202          XT-PIC  timer
  1:         15          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  4:        293          XT-PIC  serial
  5:          0          XT-PIC  EMU10K1
  7:        221          XT-PIC  eth0
  8:          1          XT-PIC  rtc
 10:        724          XT-PIC  aic7xxx
 12:         52          XT-PIC  i8042
 14:       2906          XT-PIC  ide0
 15:         25          XT-PIC  ide1
NMI:          0 
LOC:     245939 
ERR:          0
MIS:          0
2 [19:09] rol@donald:~> cat /proc/mtrr
reg00: base=0x00000000 (   0MB), size= 512MB: write-back, count=1
reg01: base=0xd0000000 (3328MB), size= 256MB: write-combining, count=1

and final test : time make bzImage
real    6m1.191s
user    5m32.214s
sys     0m22.714s

You are correct, something coming out of APM/ACPI is breaking
performance.

I'm going to try to identify more closely...

Regards,
Paul

