Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262038AbSLOQ0b>; Sun, 15 Dec 2002 11:26:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262190AbSLOQ0b>; Sun, 15 Dec 2002 11:26:31 -0500
Received: from secondary.dns.nitric.com ([64.81.197.162]:25754 "EHLO
	primary.mx.nitric.com") by vger.kernel.org with ESMTP
	id <S262038AbSLOQ0a>; Sun, 15 Dec 2002 11:26:30 -0500
To: linux-kernel@vger.kernel.org
From: merlin hughes <merlin@merlin.org>
Subject: kernels 2.4.19--2.4.20-ac2 hang at boot
Date: Sun, 15 Dec 2002 11:34:19 -0500
Message-Id: <20021215163419.893D986749@primary.mx.nitric.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On a new machine, kernels 2.4.19-pre7 onwards hang immediately
after 'Okay, booting the kernel.' Earlier 2.4 kernels boot fine if
I supply mem=120M manually (installed memory minus shared memory).
2.2 kernels boot fine with no command-line arguments.

Shuttle FX41 mobo; Via KM266 chipset; onboard video.

This seems to be similar to Justin Heesemann's problem:
  http://www.uwsg.iu.edu/hypermail/linux/kernel/0208.2/0772.html

I assigned shared video to 0M in the BIOS but the system hung at
the same place, would only boot 2.4.19-pre6 with mem=120M
(I presume; no video to be sure that it was the same place). This
suggests that maybe it's not shared video memory that's the problem,
and mem=120M in some other way worked around the issue on earler
2.4 kernels.

Some 2.4.19-pre7 change to arch/i386/kernel/setup.c definitely
seems to have rendered these systems unbootable.

dmesg 2.4.19-pre6 / 8MB shared video RAM
----
Linux version 2.4.19-pre6-morigu (root@morigu.merlin.org) (gcc version 2.95.4 20011002 (Debian prerelease)) #2 Sat Dec 14 00:21:12 EST 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000a0000 - 00000000077f0000 (reserved)
 BIOS-e820: 00000000077f0000 - 00000000077f3000 (ACPI NVS)
 BIOS-e820: 00000000077f3000 - 0000000007800000 (ACPI data)
On node 0 totalpages: 30720
zone(0): 4096 pages.
zone(1): 26624 pages.
zone(2): 0 pages.
Kernel command line: auto BOOT_IMAGE=linux ro root=301 mem=120M
Initializing CPU#0
Detected 1100.070 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 2195.45 BogoMIPS
Memory: 119784k/122880k available (762k kernel code, 2708k reserved, 225k data, 196k init, 0k highmem)
...
----

dmesg 2.2.20 / 8MB shared video RAM
----
Linux version 2.2.20 (herbert@gondolin) (gcc version 2.7.2.3) #1 Sat Apr 20 11:45:28 EST 2002
BIOS-provided physical RAM map:
 BIOS-e820: 000a0000 @ 00000000 (usable)
 BIOS-e820: 076f0000 @ 00100000 (usable)
Detected 1100070 kHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 2195.45 BogoMIPS
Memory: 118916k/122816k available (1756k kernel code, 408k reserved, 1584k data, 152k init)
...
----

dmesg 2.4.19-pre6 / 0MB shared video RAM (still needed mem=120M)
----
Linux version 2.4.19-pre6-morigu (root@morigu.merlin.org) (gcc version 2.95.4 20011002 (Debian prerelease)) #2 Sat Dec 14 00:21:12 EST 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000a0000 - 0000000007ff0000 (reserved)
 BIOS-e820: 0000000007ff0000 - 0000000007ff3000 (ACPI NVS)
 BIOS-e820: 0000000007ff3000 - 0000000008000000 (ACPI data)
On node 0 totalpages: 30720
zone(0): 4096 pages.
zone(1): 26624 pages.
zone(2): 0 pages.
Kernel command line: auto BOOT_IMAGE=linux ro root=301 mem=120M
Initializing CPU#0
Detected 1100.070 MHz processor.
Calibrating delay loop... 2195.45 BogoMIPS
Memory: 119788k/122880k available (762k kernel code, 2704k reserved, 225k data, 196k init, 0k highmem)
...
----

dmesg 2.2.20 / 0MB shared video RAM
----
Linux version 2.2.20 (herbert@gondolin) (gcc version 2.7.2.3) #1 Sat Apr 20 11:45:28 EST 2002
BIOS-provided physical RAM map:
 BIOS-e820: 000a0000 @ 00000000 (usable)
 BIOS-e820: 07ef0000 @ 00100000 (usable)
Detected 1100070 kHz processor.
Console: colour dummy device 80x25
Calibrating delay loop... 2195.45 BogoMIPS
Memory: 127028k/131008k available (1756k kernel code, 408k reserved, 1664k data, 152k init)
...
----

merlin
