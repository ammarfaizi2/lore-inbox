Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265952AbUAFXKC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 18:10:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265962AbUAFXKC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 18:10:02 -0500
Received: from maximus.kcore.de ([213.133.102.235]:63141 "EHLO
	maximus.kcore.de") by vger.kernel.org with ESMTP id S265952AbUAFXJk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 18:09:40 -0500
From: Oliver Feiler <kiza@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: Oops 2.6.0 - SCSI (driver aha152x) related
Date: Wed, 7 Jan 2004 00:08:36 +0100
User-Agent: KMail/1.5
X-PGP-Key-Fingerprint: E9DD 32F1 FA8A 0945 6A74  07DE 3A98 9F65 561D 4FD2
X-PGP-Key: http://kiza.kcore.de/pgpkey
X-Species: Snow Leopard
X-Operating-System: Linux
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_0/z+/wXUALTVj48"
Message-Id: <200401070008.36922.kiza@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_0/z+/wXUALTVj48
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

I have the following reproducable oops happening with 2.6.0, see attached file 
oops-2.6.0-scsi. It was captured and processed on -test11, but also happens 
on 2.6.0. I've also attached dmesg, .config and output from ver_linux from 
the system.

It's a 486 ISA only system with an Adaptec AVA-1520 (aha152x) SCSI card. A 
Panasonic DVD-RAM LF-D101 drive is the only device attached to the bus. The 
oops only seems to happen after I exchanged the disc in the drive at least 
once since reboot. If I boot with a disc in the drive I can mount it a dozen 
of times and it works just fine. If I eject the disc and insert it again, the 
oops occurs as soon as I mount it. The system hangs then, I cannot switch 
consoles or type anything. Rebooting with ctrl+alt+del however works until 
"unmount: / device is busy".

An IDE CD-ROM works fine so it should be related to the SCSI driver.

I know this stuff is very ancient now, but if someone is interested in working 
on the problem I'd be quite happy. Let me know if there is any more info you 
need.

Bye,
Oliver

--Boundary-00=_0/z+/wXUALTVj48
Content-Type: text/plain;
  charset="us-ascii";
  name="oops-2.6.0-scsi"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="oops-2.6.0-scsi"

ksymoops 2.4.8 on i486 2.6.0-test11.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.6.0-test11/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Jan  6 14:40:13 deekin kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000000
Jan  6 14:40:13 deekin kernel: c0203c18
Jan  6 14:40:13 deekin kernel: *pde = 00000000
Jan  6 14:40:13 deekin kernel: Oops: 0002 [#1]
Jan  6 14:40:13 deekin kernel: CPU:    0
Jan  6 14:40:13 deekin kernel: EIP:    0060:[<c0203c18>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Jan  6 14:40:13 deekin kernel: EFLAGS: 00010086
Jan  6 14:40:13 deekin kernel: eax: c137a800   ebx: c0e80200   ecx: c1379050   edx: 00000000
Jan  6 14:40:13 deekin kernel: esi: c137a800   edi: c13d0000   ebp: 00000246   esp: c13d1f2c
Jan  6 14:40:13 deekin kernel: ds: 007b   es: 007b   ss: 0068
Jan  6 14:40:14 deekin kernel: Stack: c1379050 00000002 c137a800 00000008 00000000 c137a800 c02060b3 c137a800 
Jan  6 14:40:14 deekin kernel:        0001221e 00000000 c030b004 c030b000 c13fdc10 c02037c0 c137a800 00000293 
Jan  6 14:40:14 deekin kernel:        c0125b6d 00000000 c13fdc28 c13fdc20 c13d0000 c13d0000 c13d0000 00000000 
Jan  6 14:40:14 deekin kernel: Call Trace:
Jan  6 14:40:14 deekin kernel:  [<c02060b3>] is_complete+0x2c3/0x310
Jan  6 14:40:14 deekin kernel:  [<c02037c0>] run+0x30/0x40
Jan  6 14:40:14 deekin kernel:  [<c0125b6d>] worker_thread+0x1bd/0x2b0
Jan  6 14:40:14 deekin kernel:  [<c0203790>] run+0x0/0x40
Jan  6 14:40:14 deekin kernel:  [<c0113b10>] default_wake_function+0x0/0x20
Jan  6 14:40:14 deekin kernel:  [<c0108fd6>] ret_from_fork+0x6/0x20
Jan  6 14:40:14 deekin kernel:  [<c0113b10>] default_wake_function+0x0/0x20
Jan  6 14:40:14 deekin kernel:  [<c01259b0>] worker_thread+0x0/0x2b0
Jan  6 14:40:14 deekin kernel:  [<c0107175>] kernel_thread_helper+0x5/0x10
Jan  6 14:40:14 deekin kernel: Code: 89 02 8b 41 04 8b 40 3c 8b 53 04 89 42 3c 8b 41 04 8b 40 40 


>>EIP; c0203c18 <busfree_run+368/520>   <=====

>>eax; c137a800 <__crc_memcpy_tokerneliovec+11c778/4bc1f2>
>>ebx; c0e80200 <__crc_idle_cpu+2b543/2c10e5>
>>ecx; c1379050 <__crc_memcpy_tokerneliovec+11afc8/4bc1f2>
>>esi; c137a800 <__crc_memcpy_tokerneliovec+11c778/4bc1f2>
>>edi; c13d0000 <__crc_memcpy_tokerneliovec+171f78/4bc1f2>
>>esp; c13d1f2c <__crc_memcpy_tokerneliovec+173ea4/4bc1f2>

Trace; c02060b3 <is_complete+2c3/310>
Trace; c02037c0 <run+30/40>
Trace; c0125b6d <worker_thread+1bd/2b0>
Trace; c0203790 <run+0/40>
Trace; c0113b10 <default_wake_function+0/20>
Trace; c0108fd6 <ret_from_fork+6/20>
Trace; c0113b10 <default_wake_function+0/20>
Trace; c01259b0 <worker_thread+0/2b0>
Trace; c0107175 <kernel_thread_helper+5/10>

Code;  c0203c18 <busfree_run+368/520>
00000000 <_EIP>:
Code;  c0203c18 <busfree_run+368/520>   <=====
   0:   89 02                     mov    %eax,(%edx)   <=====
Code;  c0203c1a <busfree_run+36a/520>
   2:   8b 41 04                  mov    0x4(%ecx),%eax
Code;  c0203c1d <busfree_run+36d/520>
   5:   8b 40 3c                  mov    0x3c(%eax),%eax
Code;  c0203c20 <busfree_run+370/520>
   8:   8b 53 04                  mov    0x4(%ebx),%edx
Code;  c0203c23 <busfree_run+373/520>
   b:   89 42 3c                  mov    %eax,0x3c(%edx)
Code;  c0203c26 <busfree_run+376/520>
   e:   8b 41 04                  mov    0x4(%ecx),%eax
Code;  c0203c29 <busfree_run+379/520>
  11:   8b 40 40                  mov    0x40(%eax),%eax


1 warning and 1 error issued.  Results may not be reliable.

--Boundary-00=_0/z+/wXUALTVj48
Content-Type: text/plain;
  charset="us-ascii";
  name="ver_linux"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="ver_linux"

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux deekin 2.6.0-test11 #2 Tue Jan 6 13:38:28 CET 2004 i486 unknown
 
Gnu C                  3.2.2
Gnu make               3.80
util-linux             2.11z
mount                  2.11z
module-init-tools      0.9.15-pre2
e2fsprogs              1.32
Linux C Library        2.3.1
Dynamic linker (ldd)   2.3.1
Linux C++ Library      5.0.2
Procps                 3.1.6
Net-tools              1.60
Kbd                    1.08
Sh-utils               2.0
Modules Loaded         snd_pcm_oss snd_mixer_oss snd_sb16 snd_opl3_lib snd_hwdep snd_sb16_dsp snd_sb_common snd_pcm snd_page_alloc snd_timer snd_mpu401_uart snd_rawmidi snd_seq_device snd rtc

--Boundary-00=_0/z+/wXUALTVj48
Content-Type: text/plain;
  charset="us-ascii";
  name="dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="dmesg"

Linux version 2.6.0-test11 (root@deekin) (gcc version 3.2.2) #2 Tue Jan 6 13:38:28 CET 2004
BIOS-provided physical RAM map:
 BIOS-88: 0000000000000000 - 000000000009f000 (usable)
 BIOS-88: 0000000000100000 - 0000000001400000 (usable)
20MB LOWMEM available.
On node 0 totalpages: 5120
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 1024 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
DMI not present.
Building zonelist for node : 0
Kernel command line: BOOT_IMAGE=Linux ro root=303 aha152x=0x140,12
Initializing CPU#0
PID hash table entries: 128 (order 7: 1024 bytes)
Console: colour VGA+ 80x25
Memory: 17696k/20480k available (1460k kernel code, 2348k reserved, 450k data, 100k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 65.15 BogoMIPS
Dentry cache hash table entries: 4096 (order: 2, 16384 bytes)
Inode-cache hash table entries: 2048 (order: 1, 8192 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 00000001 00000000 00000000 00000000
CPU:     After vendor identify, caps: 00000001 00000000 00000000 00000000
CPU:     After all inits, caps: 00000001 00000000 00000000 00000000
CPU: AMD Am5x86-WT stepping 04
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
NET: Registered protocol family 16
Linux Plug and Play Support v0.97 (c) Adam Belay
SCSI subsystem initialized
isapnp: Scanning for PnP cards...
pnp: SB audio device quirk - increasing port range
isapnp: Card 'Creative ViBRA16X PnP'
isapnp: 1 Plug & Play card detected total
pty: 256 Unix98 ptys configured
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
parport0: PC-style at 0x378 (0x778) [PCSPP(,...)]
parport0: irq 7 detected
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is an 8272A
ne.c:v1.10 9/23/94 Donald Becker (becker@scyld.com)
Last modified Nov 1, 2000 by Paul Gortmaker
NE*000 ethercard probe at 0x280: 00 00 21 6c 14 1d
eth0: NE2000 found at 0x280, using IRQ 10.
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 50MHz system bus speed for PIO modes; override with idebus=xx
hda: ST33221A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: max request size: 128KiB
hda: 6303024 sectors (3227 MB) w/128KiB Cache, CHS=6253/16/63
 hda: hda1 hda2 hda3
aha152x: processing commandline: ok
aha152x: BIOS test: passed, detected 1 controller(s)
aha152x: resetting bus...
aha152x0: vital data: rev=1, io=0x140 (0x140/0x140), irq=12, scsiid=7, reconnect=enabled, parity=enabled, synchronous=enabled, delay=1000, extended translation=disabled
aha152x0: trying software interrupt, ok.
scsi0 : Adaptec 152x SCSI driver; $Revision: 2.5 $
(scsi0:2:0) 01 03 01 32 08 00 
  Vendor: MATSHITA  Model: PD-2 LF-D100      Rev: A113
  Type:   CD-ROM                             ANSI SCSI revision: 02
sr0: scsi3-mmc drive: 0x/0x dvd-ram cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 2, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 2, lun 0,  type 5
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
NET: Registered protocol family 2
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 1024 bind 2048)
NET: Registered protocol family 1
NET: Registered protocol family 17
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 100k freed
spurious 8259A interrupt: IRQ7.
Adding 64504k swap on /dev/hda2.  Priority:-1 extents:1
EXT3 FS on hda3, internal journal
Real Time Clock Driver v1.12
pnp: Device 00:01.00 activated.

--Boundary-00=_0/z+/wXUALTVj48
Content-Type: application/x-gzip;
  name="config.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="config.gz"

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

--Boundary-00=_0/z+/wXUALTVj48--

