Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262941AbUCRUuv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 15:50:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262946AbUCRUuu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 15:50:50 -0500
Received: from nsmtp.pacific.net.th ([203.121.130.117]:38827 "EHLO
	nsmtp.pacific.net.th") by vger.kernel.org with ESMTP
	id S262941AbUCRUuM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 15:50:12 -0500
Date: Fri, 19 Mar 2004 04:46:11 +0800
From: "Michael Frank" <mhf@linuxmail.org>
To: "Vojtech Pavlik" <vojtech@suse.cz>
Subject: Re: 2.6.x atkbd.c moaning
Cc: akpm@osdl.org, anton@samba.org,
       "kernel mailing list" <linux-kernel@vger.kernel.org>
References: <opr41z9zel4evsfm@smtp.pacific.net.th> <20040318120114.GN28212@krispykreme> <opr42hoctn4evsfm@smtp.pacific.net.th> <opr42nq0a24evsfm@smtp.pacific.net.th> <20040318195819.GB4248@ucw.cz>
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <opr42ry9kk4evsfm@smtp.pacific.net.th>
In-Reply-To: <20040318195819.GB4248@ucw.cz>
User-Agent: Opera M2/7.50 (Linux, build 615)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Mar 2004 20:58:19 +0100, Vojtech Pavlik <vojtech@suse.cz> wrote:

> On Fri, Mar 19, 2004 at 03:14:50AM +0800, Michael Frank wrote:
>> On Fri, 19 Mar 2004 01:03:38 +0800, Michael Frank <mhf@linuxmail.org> wrote:
>>
>> >On Thu, 18 Mar 2004 23:01:14 +1100, Anton Blanchard <anton@samba.org>
>> >wrote:
>> >
>> >>
>> >>>Why is this and should I investigate further?
>> >>..
>> >>
>> >>>mice: PS/2 mouse device common for all mice
>> >>>serio: i8042 AUX port at 0x60,0x64 irq 12
>> >>>input: ImExPS/2 Generic Explorer Mouse on isa0060/serio1
>> >>>serio: i8042 KBD port at 0x60,0x64 irq 1
>> >>>input: AT Translated Set 2 keyboard on isa0060/serio0
>> >>>atkbd.c: Unknown key released (translated set 2, code 0x7a on
>> >>>isa0060/serio0).
>> >>
>> >>Did this happen recently? If so, does backing out the following patch
>> >>help?
>> >
>> >I think so but later than this changeset 1.34 of 19 December.
>>
>> The Unknown key release msg is introduced in 2.6.1 with i8042
>> changesets from 1.33 to 1.35 (likely 1.34 as Anton suggested). Guess i
>> did not think much of it as it was "smaller" but "blaming xfree"
>> during boot since 2.6.2 caught my attention.
>
> XFree86 was fixed (post 4.4) thanks to this message. kbdrate is also
> fixed in the current version. With latest XFree86 and latest kbd package
> you shouldn't be getting this message anymore.

I appreciate the message when X-old or kbdrate-old is running but not
during boot right after HD init. Please see dmesg.

I updated to kbd-1.12-1 Change kdbrate does still create messages.
Will look for later package. Which version?

>
>> >The patch has no effect.
>> >
>> >Also the mouse screws up after a few hours and becomes unusable.
>> 	On 2.6.4
>>
>> On 2.6.[012] the mouse does not sync at all (even after power up).
>>
>> On 2.4.18-26 mouse never had problems.
>
> Can you give details on the mouse and the machine? I seem to have missed
> them.

Mouse is a noname USB mouse connected via an PS2 Adapter to the PS2 port.
Dmesg included.

>
>> >psmouse.c: Explorer Mouse at isa0060/serio1/input0 lost synchronization,
>> >throwing 1 bytes away.
>> >psmouse.c: Explorer Mouse at isa0060/serio1/input0 lost synchronization,
>> >throwing 3 bytes away.
>>
>> Could also be load dependent. Will do more testing on 2.6.4 to reproduce.
>>
>> The serious issue with the mouse is that it does not recover and stays
>> out of sync and interprets further movement as random coordinates/button
>> clicks.
>
> Does unloading and reloading the psmouse module help?
>

No, once sync lost, unload, load psmouse no use and
unplug, plug mouse no use too.

But: unload, remove mouse, plug mouse, load is OK
except setting for acceleration is too low.

Looks like psmouse reset no work on 2.6.

Regards
Michael

Linux version 2.6.4-mhf195 (mhf@mhfl4) (gcc version 2.95.3 20010315 (release)) #2 Fri Mar 19 00:38:13 HKT 2004
BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 000000001eff0000 (usable)
  BIOS-e820: 000000001eff0000 - 000000001eff3000 (ACPI NVS)
  BIOS-e820: 000000001eff3000 - 000000001f000000 (ACPI data)
  BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
495MB LOWMEM available.
On node 0 totalpages: 126960
   DMA zone: 4096 pages, LIFO batch:1
   Normal zone: 122864 pages, LIFO batch:16
   HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
Built 1 zonelists
Kernel command line: vga=0xf07 root=/dev/hda4  console=tty0 console=ttyS0,115200n8r devfs=nomount nousb acpi=off
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 2399.966 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x60
Memory: 498392k/507840k available (1997k kernel code, 8656k reserved, 1032k data, 148k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 4734.97 BogoMIPS
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU#0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU: Intel(R) Pentium(R) 4 CPU 2.40GHz stepping 07
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfbc60, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040220
ACPI: Interpreter disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00fc690
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xc6c0, dseg 0xf0000
pnp: 00:0b: ioport range 0x1000-0x107f has been reserved
pnp: 00:0b: ioport range 0x10c0-0x10df has been reserved
pnp: 00:0c: ioport range 0x3f0-0x3f1 has been reserved
PnPBIOS: 16 nodes reported by PnP BIOS; 16 recorded by driver
ACPI: ACPI tables contain no PCI IRQ routing entries
PCI: Invalid ACPI-PCI IRQ routing table
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
Uncovering SIS962 that hid as a SIS503 (compatible=1)
Enabling SiS 96x SMBus.
PCI: Using IRQ router SIS [1039/0962] at 0000:00:02.0
PCI: IRQ 0 for device 0000:00:02.1 doesn't match PIRQ mask - try pci=usepirqmask
PCI: IRQ 0 for device 0000:00:02.5 doesn't match PIRQ mask - try pci=usepirqmask
PCI: Found IRQ 10 for device 0000:00:02.5
PCI: Cannot allocate resource region 4 of device 0000:00:02.1
Machine check exception polling timer started.
ikconfig 0.7 with /proc/config*
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
udf: registering filesystem
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
Using anticipatory io scheduler
nbd: registered device at major 43
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
PPP BSD Compression module registered
Universal TUN/TAP device driver 1.5 (C)1999-2002 Maxim Krasnyansky
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SIS5513: IDE controller at PCI slot 0000:00:02.5
PCI: Found IRQ 10 for device 0000:00:02.5
SIS5513: chipset revision 0
SIS5513: not 100% native mode: will probe irqs later
SIS5513: SiS 962/963 MuTIOL IDE UDMA133 controller
     ide0: BM-DMA at 0x4000-0x4007, BIOS settings: hda:DMA, hdb:pio
     ide1: BM-DMA at 0x4008-0x400f, BIOS settings: hdc:pio, hdd:pio
hda: IC35L090AVV207-0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: max request size: 1024KiB
hda: 160836480 sectors (82348 MB) w/1821KiB Cache, CHS=16383/255/63, UDMA(100)
  hda: hda1 hda2 hda3 < hda5 hda6 hda7 hda8 hda9 > hda4
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
input: ImExPS/2 Generic Explorer Mouse on isa0060/serio1
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
IPv4 over IPv4 tunneling driver
GRE over IPv4 tunneling driver
ip_conntrack version 2.1 (3967 buckets, 31736 max) - 300 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
arp_tables: (C) 2002 David S. Miller
NET: Registered protocol family 1
NET: Registered protocol family 17
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 148k freed
INIT: version 2.84 booting
