Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131606AbRCXHvC>; Sat, 24 Mar 2001 02:51:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131607AbRCXHux>; Sat, 24 Mar 2001 02:50:53 -0500
Received: from www.wen-online.de ([212.223.88.39]:39433 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S131606AbRCXHus>;
	Sat, 24 Mar 2001 02:50:48 -0500
Date: Sat, 24 Mar 2001 08:49:57 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Kevin Buhr <buhr@stat.wisc.edu>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.2-ac20 patch for process time double-counting (was: Linux
 2.4.2 fails to merge mmap areas, 700% slowdown.)
In-Reply-To: <vbalmpwxj5o.fsf@mozart.stat.wisc.edu>
Message-ID: <Pine.LNX.4.33.0103240841280.2032-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 Mar 2001, Kevin Buhr wrote:

> Mike Galbraith <mikeg@wen-online.de> writes:
> >
> > > Mike, would you like to try out the following (untested) patch against
> > > vanilla ac20 to see if it does the trick?
> >
> > Yes, that fixed it.
>
> Great!  Can you test one more configuration, please?  I can't test it
> properly with my SMP motherboard.  Under "ac20", if you disable:
>
>         Symmetric multi-processing support (CONFIG_SMP)
>
> you'll get to say yes to:
>
>         APIC support on uniprocessors (CONFIG_X86_UP_APIC)
>
> If you say yes to that, you'll also get to say yes to:
>
>         IO-APIC support on uniprocessors (CONFIG_X86_UP_IOAPIC)
>
> Can you check that the following patch against vanilla "ac20" works
> correctly with SMP disabled and X86_UP_APIC enabled?  (The original
> patch I gave you won't compile with this configuration, since I put
> the declaration in the wrong include file.)  It shouldn't matter
> whether X86_UP_IOAPIC is enabled or disabled.
>
> In addition to checking that the sys/user times look right, please
> check for the message:
>
>         Using local APIC timer interrupts.

Times are fine.  Local APIC timer interrupts are used.

> in your boot messages (I *don't* think it'll be there, but I'm not
> sure, and I'd really like to know one way or the other).  In fact, if
> you could send me your kernel messages up to the PCI probe, that would
> be ideal.

Linux version 2.4.2-ac20 (root@el-kaboom) (gcc version gcc-2.95.3 20010315 (release)) #1 Sat Mar 24 07:57:01 CET 2001
BIOS-provided physical RAM map:
 BIOS-e820: 000000000009fc00 @ 0000000000000000 (usable)
 BIOS-e820: 0000000000000400 @ 000000000009fc00 (reserved)
 BIOS-e820: 0000000000010000 @ 00000000000f0000 (reserved)
 BIOS-e820: 0000000007ef0000 @ 0000000000100000 (usable)
 BIOS-e820: 0000000000003000 @ 0000000007ff0000 (ACPI NVS)
 BIOS-e820: 000000000000d000 @ 0000000007ff3000 (ACPI data)
 BIOS-e820: 0000000000010000 @ 00000000ffff0000 (reserved)
Scan SMP from c0000000 for 1024 bytes.
Scan SMP from c009fc00 for 1024 bytes.
Scan SMP from c00f0000 for 65536 bytes.
Scan SMP from c009fc00 for 4096 bytes.
On node 0 totalpages: 32752
zone(0): 4096 pages.
zone(1): 28656 pages.
zone(2): 0 pages.
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
mapped APIC to ffffe000 (fee00000)
Kernel command line: root=/dev/hda6,ro sb=220,5,1,7 mpu401=0x300,0 adlib=0x388 BOOT_IMAGE=242ac20
Initializing CPU#0
Detected 499.176 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 996.14 BogoMIPS
Memory: 126500k/131008k available (1101k kernel code, 4120k reserved, 339k data, 204k init, 0k highmem)
Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
CPU: After generic, caps: 0383fbff 00000000 00000000 00000000
CPU: Common caps: 0383fbff 00000000 00000000 00000000
CPU: Intel Pentium III (Katmai) stepping 03
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
Getting VERSION: 40011
Getting VERSION: 40011
Getting ID: 0
Getting ID: f000000
Getting LVT0: 700
Getting LVT1: 400
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000040
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 499.1652 MHz.
..... host bus clock speed is 99.8329 MHz.
cpu: 0, clocks: 998329, slice: 499164
CPU0<T0:998320,T1:499152,D:4,S:499164,C:998329>

> Thanks muchly!

Testing's easy, thanks for the fix.

	-Mike

