Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263247AbSJCLUn>; Thu, 3 Oct 2002 07:20:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263249AbSJCLUn>; Thu, 3 Oct 2002 07:20:43 -0400
Received: from 62-190-201-39.pdu.pipex.net ([62.190.201.39]:2820 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S263247AbSJCLUb>; Thu, 3 Oct 2002 07:20:31 -0400
From: jbradford@dial.pipex.com
Message-Id: <200210031134.g93BYFKC000248@darkstar.example.net>
Subject: Re: 2.5.40: AT keyboard input problem
To: vojtech@suse.cz (Vojtech Pavlik)
Date: Thu, 3 Oct 2002 12:34:15 +0100 (BST)
Cc: tori@ringstrom.mine.nu, linux-kernel@vger.kernel.org
In-Reply-To: <20021003121319.B37941@ucw.cz> from "Vojtech Pavlik" at Oct 03, 2002 12:13:19 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, Oct 03, 2002 at 11:14:02AM +0100, jbradford@dial.pipex.com wrote:
> > > 
> > > On Thu, Oct 03, 2002 at 09:36:05AM +0100, jbradford@dial.pipex.com wrote:
> > > > > While 2.5 has worked better than I hoped for so far, I do have a problem 
> > > > > with the new input layer (I think) that is easily reproducible, and quite 
> > > > > irritating.
> > > > > 
> > > > > If I press and hold my left Alt key, press and release the right AltGr
> > > > > key, and then release the left Alt key, I get one of the following
> > > > > messages in dmesg:
> > > > 
> > > > [snip]
> > > > 
> > > > > The same thing happens for a few other combinations as well. I happens 
> > > > > both in X and in the console.
> > > > 
> > > > I am getting similar odd behavior with 2.5.40 and a Japanese keyboard.
> > > > Specifically, if I bang away at repeatedly on 't', 'h', '@', and ';', I
> > > > get unknown key messages in dmesg.
> > > > 
> > > > I posted about this a while ago, but I don't think anybody noticed :-)
> > > 
> > > Can you #define I8042_DEBUG_IO in i8042.h and send me the 'dmesg' output
> > > of the unknown key message and data around it?
> > 
> > OK, that was fun - every time I managed to cause the error, by the time I'd
> > switched to another VT, and typed dmesg, it was flooded with other keypresses
> > :-).  I should have used a serial terminal, but anyway, here goes:
> > 
> > i8042.c: fa <- i8042 (interrupt, kbd, 1) [694909]
> > i8042.c: f0 -> i8042 (kbd-data) [694909]
> > i8042.c: fa <- i8042 (interrupt, kbd, 1) [694912]
> > i8042.c: 00 -> i8042 (kbd-data) [694912]
> > i8042.c: fa <- i8042 (interrupt, kbd, 1) [694915]
> > i8042.c: 41 <- i8042 (interrupt, kbd, 1) [694916]
> > input: AT Set 2 keyboard on isa0060/serio0
> > i8042.c: 94 <- i8042 (interrupt, kbd, 1) [694937]
> > i8042.c: a3 <- i8042 (interrupt, kbd, 1) [694943]
> > i8042.c: 38 <- i8042 (interrupt, kbd, 1) [696272]
> > i8042.c: 3d <- i8042 (interrupt, kbd, 1) [696372]
> > i8042.c: bd <- i8042 (interrupt, kbd, 1) [696440]
> > i8042.c: b8 <- i8042 (interrupt, kbd, 1) [696446]
> > i8042.c: 1c <- i8042 (interrupt, kbd, 1) [697112]
> > 
> > This was in the syslog:
> > 
> > Oct  3 10:54:59 darkstar kernel: atkbd.c: Unknown key (set 2, scancode 0x94, on isa0060/serio0) pressed.
> 
> What's on the lines just before this one from i8042.c?

Forget the above report, I've since done a more comprehensive one, (below):

> > I am unable to reproduce this by pressing any single key.  Only by repeatedly
> > pressing many keys, (I.E. bashing the keyboard like mad), does this occur,
> > (and not always with the same scancode).  Very odd.
> > 
> > This particular IBM Japanese keyboard seems to be even more exotic than most,
> > in several ways, that might be relevant:
> > 
> > The Henkaku/Zenkaku key, which is in the top left, below escape, does not have
> > a scancode by default, I.E. showkey -s reports nothing when it is pressed.
> 
> showkey -s doesn't return true rawmode anymore because of USB keyboards,
> etc. So I'll need the dmesg log of these keys pressed.

Hmmm, but it's never worked since the 2.0.x days, (I've used this keyboard for over 5 years).

> > The three kana shift keys, (one between alt and the spacebar, and two between
> > alt-gr and the spacebar), which are marked differently to any other Japanese
> > keyboard I've ever seen, all report the keycode 57, and scancode 0x39 when
> > pressed, and scancode 0xb9 when released - the same as the space bar.
> > Therefore it doesn't seem possible to use them as independent keys.
> 
> Again, the dmesg log for these would be more interesting.

OK, here goes.  This is dmesg output from a serial terminal, showing a boot, (quite a lot of keyboard activity during boot, not sure if this is normal or not), and a single keypress of Henkaku/Zenkaku:

Linux version 2.5.40 (root@darkstar) (gcc version 2.95.3 20010315 (release)) #11 Thu Oct 3 10:37:32 BST 2002
Video mode to be used for restore is ffff
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000008000000 (usable)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
128MB LOWMEM available.
On node 0 totalpages: 32768
  DMA zone: 4096 pages
  Normal zone: 28672 pages
  HighMem zone: 0 pages
Building zonelist for node : 0
Kernel command line: BOOT_IMAGE=linux-debug ro root=301
Initializing CPU#0
Detected 200.459 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 396.28 BogoMIPS
Memory: 127388k/131072k available (1104k kernel code, 3300k reserved, 335k data, 224k init, 0k highmem)
Security Scaffold v1.0.0 initialized
Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: Before vendor init, caps: 008001bf 00000000 00000000, vendor = 0
Intel Pentium with F0 0F bug - workaround enabled.
CPU: After vendor init, caps: 008001bf 00000000 00000000 00000000
CPU:     After generic, caps: 008001bf 00000000 00000000 00000000
CPU:             Common caps: 008001bf 00000000 00000000 00000000
CPU: Intel Pentium MMX stepping 03
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
PCI: PCI BIOS revision 2.10 entry at 0xfb460, last bus=0
PCI: Using configuration type 1
adding '' to cpu class interfaces
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
Starting kswapd
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 246 entries (12 bytes)
biovec pool[1]:   4 bvecs: 246 entries (48 bytes)
biovec pool[2]:  16 bvecs: 246 entries (192 bytes)
biovec pool[3]:  64 bvecs: 246 entries (768 bytes)
biovec pool[4]: 128 bvecs: 123 entries (1536 bytes)
biovec pool[5]: 256 bvecs:  61 entries (3072 bytes)
aio_setup: sizeof(struct page) = 40
Capability LSM initialized
Limiting direct PCI/PCI transfers.
Activating ISA DMA hang workarounds.
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
block request queues:
 128 requests per read queue
 128 requests per write queue
 8 requests per batch
 enter congestion at 31
 exit congestion at 33
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
PPP generic driver version 2.4.2
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX3: IDE controller at PCI slot 00:07.1
PIIX3: chipset revision 0
PIIX3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:pio, hdb:pio
hda: Maxtor 90432D2, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: host protected area => 1
hda: 8440992 sectors (4322 MB) w/512KiB Cache, CHS=525/255/63, (U)DMA
 hda: hda1
SCSI subsystem driver Revision: 1.00
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.4
        <Adaptec 2940A Ultra SCSI adapter>
        aic7860: Ultra Single Channel A, SCSI Id=7, 3/253 SCBs

  Vendor: NEC       Model: CD-ROM DRIVE:462  Rev: 1.16
  Type:   CD-ROM                             ANSI SCSI revision: 02
(scsi0:A:1): 10.000MB/s transfers (10.000MHz, offset 15)
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 1, lun 0
sr0: scsi-1 drive
Uniform CD-ROM driver Revision: 3.12
input: PC Speaker
i8042.c: 20 -> i8042 (command) [0]
i8042.c: 47 <- i8042 (return) [0]
i8042.c: 60 -> i8042 (command) [0]
i8042.c: 56 -> i8042 (parameter) [0]
i8042.c: d3 -> i8042 (command) [0]
i8042.c: 5a -> i8042 (parameter) [0]
i8042.c: a5 <- i8042 (return) [0]
i8042.c: a9 -> i8042 (command) [0]
i8042.c: 00 <- i8042 (return) [0]
i8042.c: a7 -> i8042 (command) [1]
i8042.c: 20 -> i8042 (command) [1]
i8042.c: 76 <- i8042 (return) [1]
i8042.c: a8 -> i8042 (command) [1]
i8042.c: 20 -> i8042 (command) [1]
i8042.c: 56 <- i8042 (return) [1]
i8042.c: 60 -> i8042 (command) [2]
i8042.c: 74 -> i8042 (parameter) [2]
i8042.c: 60 -> i8042 (command) [2]
i8042.c: 54 -> i8042 (parameter) [2]
i8042.c: 60 -> i8042 (command) [2]
i8042.c: 56 -> i8042 (parameter) [2]
i8042.c: d4 -> i8042 (command) [2]
i8042.c: ed -> i8042 (parameter) [2]
i8042.c: 60 -> i8042 (command) [56]
i8042.c: 54 -> i8042 (parameter) [56]
i8042.c: fe <- i8042 (interrupt, aux, 12, timeout) [57]
serio: i8042 AUX port at 0x60,0x64 irq 12
i8042.c: 60 -> i8042 (command) [57]
i8042.c: 44 -> i8042 (parameter) [57]
i8042.c: 60 -> i8042 (command) [57]
i8042.c: 45 -> i8042 (parameter) [57]
i8042.c: ed -> i8042 (kbd-data) [58]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [60]
i8042.c: 00 -> i8042 (kbd-data) [60]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [63]
i8042.c: f2 -> i8042 (kbd-data) [63]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [66]
i8042.c: ab <- i8042 (interrupt, kbd, 1) [67]
i8042.c: 90 <- i8042 (interrupt, kbd, 1) [68]
i8042.c: f8 -> i8042 (kbd-data) [68]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [71]
i8042.c: f4 -> i8042 (kbd-data) [71]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [75]
i8042.c: ea -> i8042 (kbd-data) [75]
i8042.c: fe <- i8042 (interrupt, kbd, 1) [78]
i8042.c: f0 -> i8042 (kbd-data) [78]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [81]
i8042.c: 02 -> i8042 (kbd-data) [81]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [83]
i8042.c: f0 -> i8042 (kbd-data) [83]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [86]
i8042.c: 00 -> i8042 (kbd-data) [86]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [89]
i8042.c: 41 <- i8042 (interrupt, kbd, 1) [90]
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
ip_conntrack version 2.1 (1024 buckets, 8192 max) - 292 bytes per conntrack
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 224k freed
i8042.c: ff <- i8042 (interrupt, kbd, 1) [60446]

..and this is a boot followed by a press of the four keys - '???', 'space', '???', 'hiragana/romaji characters', (I can't read the text on the ones marked '???').

Linux version 2.5.40 (root@darkstar) (gcc version 2.95.3 20010315 (release)) #11 Thu Oct 3 10:37:32 BST 2002
Video mode to be used for restore is ffff
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000008000000 (usable)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
128MB LOWMEM available.
On node 0 totalpages: 32768
  DMA zone: 4096 pages
  Normal zone: 28672 pages
  HighMem zone: 0 pages
Building zonelist for node : 0
Kernel command line: BOOT_IMAGE=linux-debug ro root=301
Initializing CPU#0
Detected 200.483 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 396.28 BogoMIPS
Memory: 127388k/131072k available (1104k kernel code, 3300k reserved, 335k data, 224k init, 0k highmem)
Security Scaffold v1.0.0 initialized
Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: Before vendor init, caps: 008001bf 00000000 00000000, vendor = 0
Intel Pentium with F0 0F bug - workaround enabled.
CPU: After vendor init, caps: 008001bf 00000000 00000000 00000000
CPU:     After generic, caps: 008001bf 00000000 00000000 00000000
CPU:             Common caps: 008001bf 00000000 00000000 00000000
CPU: Intel Pentium MMX stepping 03
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
PCI: PCI BIOS revision 2.10 entry at 0xfb460, last bus=0
PCI: Using configuration type 1
adding '' to cpu class interfaces
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
Starting kswapd
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 246 entries (12 bytes)
biovec pool[1]:   4 bvecs: 246 entries (48 bytes)
biovec pool[2]:  16 bvecs: 246 entries (192 bytes)
biovec pool[3]:  64 bvecs: 246 entries (768 bytes)
biovec pool[4]: 128 bvecs: 123 entries (1536 bytes)
biovec pool[5]: 256 bvecs:  61 entries (3072 bytes)
aio_setup: sizeof(struct page) = 40
Capability LSM initialized
Limiting direct PCI/PCI transfers.
Activating ISA DMA hang workarounds.
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
block request queues:
 128 requests per read queue
 128 requests per write queue
 8 requests per batch
 enter congestion at 31
 exit congestion at 33
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
PPP generic driver version 2.4.2
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX3: IDE controller at PCI slot 00:07.1
PIIX3: chipset revision 0
PIIX3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:pio, hdb:pio
hda: Maxtor 90432D2, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: host protected area => 1
hda: 8440992 sectors (4322 MB) w/512KiB Cache, CHS=525/255/63, (U)DMA
 hda: hda1
SCSI subsystem driver Revision: 1.00
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.4
        <Adaptec 2940A Ultra SCSI adapter>
        aic7860: Ultra Single Channel A, SCSI Id=7, 3/253 SCBs

  Vendor: NEC       Model: CD-ROM DRIVE:462  Rev: 1.16
  Type:   CD-ROM                             ANSI SCSI revision: 02
(scsi0:A:1): 10.000MB/s transfers (10.000MHz, offset 15)
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 1, lun 0
sr0: scsi-1 drive
Uniform CD-ROM driver Revision: 3.12
input: PC Speaker
i8042.c: 20 -> i8042 (command) [0]
i8042.c: 47 <- i8042 (return) [0]
i8042.c: 60 -> i8042 (command) [0]
i8042.c: 56 -> i8042 (parameter) [0]
i8042.c: d3 -> i8042 (command) [0]
i8042.c: 5a -> i8042 (parameter) [0]
i8042.c: a5 <- i8042 (return) [0]
i8042.c: a9 -> i8042 (command) [1]
i8042.c: 00 <- i8042 (return) [1]
i8042.c: a7 -> i8042 (command) [1]
i8042.c: 20 -> i8042 (command) [1]
i8042.c: 76 <- i8042 (return) [1]
i8042.c: a8 -> i8042 (command) [1]
i8042.c: 20 -> i8042 (command) [1]
i8042.c: 56 <- i8042 (return) [1]
i8042.c: 60 -> i8042 (command) [2]
i8042.c: 74 -> i8042 (parameter) [2]
i8042.c: 60 -> i8042 (command) [2]
i8042.c: 54 -> i8042 (parameter) [2]
i8042.c: 60 -> i8042 (command) [2]
i8042.c: 56 -> i8042 (parameter) [2]
i8042.c: d4 -> i8042 (command) [2]
i8042.c: ed -> i8042 (parameter) [2]
i8042.c: 60 -> i8042 (command) [56]
i8042.c: 54 -> i8042 (parameter) [56]
i8042.c: fe <- i8042 (interrupt, aux, 12, timeout) [57]
serio: i8042 AUX port at 0x60,0x64 irq 12
i8042.c: 60 -> i8042 (command) [57]
i8042.c: 44 -> i8042 (parameter) [57]
i8042.c: 60 -> i8042 (command) [57]
i8042.c: 45 -> i8042 (parameter) [57]
i8042.c: ed -> i8042 (kbd-data) [58]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [61]
i8042.c: 00 -> i8042 (kbd-data) [61]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [63]
i8042.c: f2 -> i8042 (kbd-data) [63]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [66]
i8042.c: ab <- i8042 (interrupt, kbd, 1) [67]
i8042.c: 90 <- i8042 (interrupt, kbd, 1) [69]
i8042.c: f8 -> i8042 (kbd-data) [69]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [72]
i8042.c: f4 -> i8042 (kbd-data) [72]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [75]
i8042.c: ea -> i8042 (kbd-data) [75]
i8042.c: fe <- i8042 (interrupt, kbd, 1) [78]
i8042.c: f0 -> i8042 (kbd-data) [78]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [81]
i8042.c: 02 -> i8042 (kbd-data) [81]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [84]
i8042.c: f0 -> i8042 (kbd-data) [84]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [87]
i8042.c: 00 -> i8042 (kbd-data) [87]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [89]
i8042.c: 41 <- i8042 (interrupt, kbd, 1) [90]
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
ip_conntrack version 2.1 (1024 buckets, 8192 max) - 292 bytes per conntrack
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 224k freed
i8042.c: 39 <- i8042 (interrupt, kbd, 1) [48100]
i8042.c: b9 <- i8042 (interrupt, kbd, 1) [48204]
i8042.c: 39 <- i8042 (interrupt, kbd, 1) [49910]
i8042.c: b9 <- i8042 (interrupt, kbd, 1) [50005]
i8042.c: 39 <- i8042 (interrupt, kbd, 1) [51453]
i8042.c: b9 <- i8042 (interrupt, kbd, 1) [51548]
i8042.c: 39 <- i8042 (interrupt, kbd, 1) [57544]
i8042.c: b9 <- i8042 (interrupt, kbd, 1) [57638]

..finally, this is the output of a 'bashing away at t, h, ; and @' session:

input: AT Set 2 keyboard on isa0060/serio0
i8042.c: 27 <- i8042 (interrupt, kbd, 1) [202218]
i8042.c: 2a <- i8042 (interrupt, kbd, 1) [202228]
i8042.c: 03 <- i8042 (interrupt, kbd, 1) [202231]
i8042.c: aa <- i8042 (interrupt, kbd, 1) [202245]
i8042.c: 14 <- i8042 (interrupt, kbd, 1) [202247]
i8042.c: 23 <- i8042 (interrupt, kbd, 1) [202254]
i8042.c: 83 <- i8042 (interrupt, kbd, 1) [202282]
i8042.c: aa <- i8042 (interrupt, kbd, 1) [202286]
i8042.c: 60 -> i8042 (command) [202286]
i8042.c: 44 -> i8042 (parameter) [202286]
i8042.c: 60 -> i8042 (command) [202286]
i8042.c: 45 -> i8042 (parameter) [202286]
i8042.c: ed -> i8042 (kbd-data) [202286]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [202289]
i8042.c: 00 -> i8042 (kbd-data) [202289]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [202292]
i8042.c: f2 -> i8042 (kbd-data) [202292]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [202296]
i8042.c: ab <- i8042 (interrupt, kbd, 1) [202297]
i8042.c: 90 <- i8042 (interrupt, kbd, 1) [202298]
i8042.c: f8 -> i8042 (kbd-data) [202298]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [202301]
i8042.c: f4 -> i8042 (kbd-data) [202301]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [202305]
i8042.c: ea -> i8042 (kbd-data) [202305]
i8042.c: fe <- i8042 (interrupt, kbd, 1) [202308]
i8042.c: f0 -> i8042 (kbd-data) [202308]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [202311]
i8042.c: 02 -> i8042 (kbd-data) [202311]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [202313]
i8042.c: f0 -> i8042 (kbd-data) [202313]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [202316]
i8042.c: 00 -> i8042 (kbd-data) [202316]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [202319]
i8042.c: 41 <- i8042 (interrupt, kbd, 1) [202320]
input: AT Set 2 keyboard on isa0060/serio0
i8042.c: 94 <- i8042 (interrupt, kbd, 1) [202333]
i8042.c: a3 <- i8042 (interrupt, kbd, 1) [202339]
i8042.c: 2a <- i8042 (interrupt, kbd, 1) [202355]
i8042.c: 03 <- i8042 (interrupt, kbd, 1) [202358]
i8042.c: aa <- i8042 (interrupt, kbd, 1) [202364]
i8042.c: 27 <- i8042 (interrupt, kbd, 1) [202367]
i8042.c: a7 <- i8042 (interrupt, kbd, 1) [202418]
i8042.c: 23 <- i8042 (interrupt, kbd, 1) [202421]
i8042.c: 83 <- i8042 (interrupt, kbd, 1) [202431]
i8042.c: aa <- i8042 (interrupt, kbd, 1) [202434]
i8042.c: 60 -> i8042 (command) [202434]
i8042.c: 44 -> i8042 (parameter) [202434]
i8042.c: 60 -> i8042 (command) [202435]
i8042.c: 45 -> i8042 (parameter) [202435]
i8042.c: ed -> i8042 (kbd-data) [202435]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [202439]
i8042.c: 00 -> i8042 (kbd-data) [202439]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [202442]
i8042.c: f2 -> i8042 (kbd-data) [202442]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [202445]
i8042.c: ab <- i8042 (interrupt, kbd, 1) [202446]
i8042.c: 90 <- i8042 (interrupt, kbd, 1) [202447]
i8042.c: f8 -> i8042 (kbd-data) [202447]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [202450]
i8042.c: f4 -> i8042 (kbd-data) [202450]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [202454]
i8042.c: ea -> i8042 (kbd-data) [202454]
i8042.c: fe <- i8042 (interrupt, kbd, 1) [202457]
i8042.c: f0 -> i8042 (kbd-data) [202457]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [202460]
i8042.c: 02 -> i8042 (kbd-data) [202460]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [202462]
i8042.c: f0 -> i8042 (kbd-data) [202462]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [202465]
i8042.c: 00 -> i8042 (kbd-data) [202465]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [202468]
i8042.c: 41 <- i8042 (interrupt, kbd, 1) [202469]
input: AT Set 2 keyboard on isa0060/serio0
i8042.c: 94 <- i8042 (interrupt, kbd, 1) [202483]
atkbd.c: Unknown key (set 2, scancode 0x94, on isa0060/serio0) pressed.
i8042.c: 27 <- i8042 (interrupt, kbd, 1) [202495]
i8042.c: a3 <- i8042 (interrupt, kbd, 1) [202501]
i8042.c: 2a <- i8042 (interrupt, kbd, 1) [202510]
i8042.c: 03 <- i8042 (interrupt, kbd, 1) [202512]
i8042.c: a7 <- i8042 (interrupt, kbd, 1) [202555]
i8042.c: 83 <- i8042 (interrupt, kbd, 1) [202566]
i8042.c: aa <- i8042 (interrupt, kbd, 1) [202569]
i8042.c: 14 <- i8042 (interrupt, kbd, 1) [202581]
i8042.c: 23 <- i8042 (interrupt, kbd, 1) [202587]
i8042.c: 2a <- i8042 (interrupt, kbd, 1) [202642]
i8042.c: 03 <- i8042 (interrupt, kbd, 1) [202644]
i8042.c: aa <- i8042 (interrupt, kbd, 1) [202652]
i8042.c: 27 <- i8042 (interrupt, kbd, 1) [202654]
i8042.c: 94 <- i8042 (interrupt, kbd, 1) [202665]
i8042.c: a3 <- i8042 (interrupt, kbd, 1) [202672]
i8042.c: 83 <- i8042 (interrupt, kbd, 1) [202692]
i8042.c: aa <- i8042 (interrupt, kbd, 1) [202695]
i8042.c: 60 -> i8042 (command) [202695]
i8042.c: 44 -> i8042 (parameter) [202695]
i8042.c: 60 -> i8042 (command) [202696]
i8042.c: 45 -> i8042 (parameter) [202696]
i8042.c: ed -> i8042 (kbd-data) [202696]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [202699]
i8042.c: 00 -> i8042 (kbd-data) [202699]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [202701]
i8042.c: f2 -> i8042 (kbd-data) [202701]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [202705]
i8042.c: ab <- i8042 (interrupt, kbd, 1) [202707]
i8042.c: 90 <- i8042 (interrupt, kbd, 1) [202708]
i8042.c: f8 -> i8042 (kbd-data) [202708]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [202711]
i8042.c: f4 -> i8042 (kbd-data) [202711]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [202714]
i8042.c: ea -> i8042 (kbd-data) [202714]
i8042.c: fe <- i8042 (interrupt, kbd, 1) [202717]
i8042.c: f0 -> i8042 (kbd-data) [202717]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [202720]
i8042.c: 02 -> i8042 (kbd-data) [202720]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [202723]
i8042.c: f0 -> i8042 (kbd-data) [202723]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [202726]
i8042.c: 00 -> i8042 (kbd-data) [202726]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [202728]
i8042.c: 41 <- i8042 (interrupt, kbd, 1) [202729]
input: AT Set 2 keyboard on isa0060/serio0
i8042.c: 14 <- i8042 (interrupt, kbd, 1) [202749]
i8042.c: 23 <- i8042 (interrupt, kbd, 1) [202754]
i8042.c: 2a <- i8042 (interrupt, kbd, 1) [202774]
i8042.c: 03 <- i8042 (interrupt, kbd, 1) [202776]
i8042.c: aa <- i8042 (interrupt, kbd, 1) [202783]
i8042.c: 27 <- i8042 (interrupt, kbd, 1) [202786]
i8042.c: 94 <- i8042 (interrupt, kbd, 1) [202815]
i8042.c: a3 <- i8042 (interrupt, kbd, 1) [202822]
i8042.c: 83 <- i8042 (interrupt, kbd, 1) [202832]
i8042.c: aa <- i8042 (interrupt, kbd, 1) [202836]
i8042.c: 60 -> i8042 (command) [202836]
i8042.c: 44 -> i8042 (parameter) [202836]
i8042.c: 60 -> i8042 (command) [202836]
i8042.c: 45 -> i8042 (parameter) [202836]
i8042.c: ed -> i8042 (kbd-data) [202836]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [202839]
i8042.c: 00 -> i8042 (kbd-data) [202839]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [202842]
i8042.c: f2 -> i8042 (kbd-data) [202842]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [202846]
i8042.c: ab <- i8042 (interrupt, kbd, 1) [202847]
i8042.c: 90 <- i8042 (interrupt, kbd, 1) [202848]
i8042.c: f8 -> i8042 (kbd-data) [202848]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [202851]
i8042.c: f4 -> i8042 (kbd-data) [202851]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [202855]
i8042.c: ea -> i8042 (kbd-data) [202855]
i8042.c: fe <- i8042 (interrupt, kbd, 1) [202858]
i8042.c: f0 -> i8042 (kbd-data) [202858]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [202861]
i8042.c: 02 -> i8042 (kbd-data) [202861]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [202863]
i8042.c: f0 -> i8042 (kbd-data) [202863]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [202866]
i8042.c: 00 -> i8042 (kbd-data) [202866]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [202869]
i8042.c: 41 <- i8042 (interrupt, kbd, 1) [202870]
input: AT Set 2 keyboard on isa0060/serio0
i8042.c: 27 <- i8042 (interrupt, kbd, 1) [202891]
i8042.c: 2a <- i8042 (interrupt, kbd, 1) [202901]
i8042.c: 03 <- i8042 (interrupt, kbd, 1) [202904]
i8042.c: aa <- i8042 (interrupt, kbd, 1) [202918]
i8042.c: 14 <- i8042 (interrupt, kbd, 1) [202920]
i8042.c: 23 <- i8042 (interrupt, kbd, 1) [202926]
i8042.c: 83 <- i8042 (interrupt, kbd, 1) [202954]
i8042.c: aa <- i8042 (interrupt, kbd, 1) [202958]
i8042.c: 60 -> i8042 (command) [202958]
i8042.c: 44 -> i8042 (parameter) [202958]
i8042.c: 60 -> i8042 (command) [202958]
i8042.c: 45 -> i8042 (parameter) [202958]
i8042.c: ed -> i8042 (kbd-data) [202958]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [202961]
i8042.c: 00 -> i8042 (kbd-data) [202961]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [202964]
i8042.c: f2 -> i8042 (kbd-data) [202964]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [202967]
i8042.c: ab <- i8042 (interrupt, kbd, 1) [202968]
i8042.c: 90 <- i8042 (interrupt, kbd, 1) [202969]
i8042.c: f8 -> i8042 (kbd-data) [202969]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [202973]
i8042.c: f4 -> i8042 (kbd-data) [202973]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [202977]
i8042.c: ea -> i8042 (kbd-data) [202977]
i8042.c: fe <- i8042 (interrupt, kbd, 1) [202980]
i8042.c: f0 -> i8042 (kbd-data) [202980]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [202983]
i8042.c: 02 -> i8042 (kbd-data) [202983]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [202985]
i8042.c: f0 -> i8042 (kbd-data) [202985]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [202988]
i8042.c: 00 -> i8042 (kbd-data) [202988]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [202991]
i8042.c: 41 <- i8042 (interrupt, kbd, 1) [202992]
input: AT Set 2 keyboard on isa0060/serio0
i8042.c: 94 <- i8042 (interrupt, kbd, 1) [202998]
i8042.c: a3 <- i8042 (interrupt, kbd, 1) [203004]
i8042.c: 2a <- i8042 (interrupt, kbd, 1) [203020]
i8042.c: 03 <- i8042 (interrupt, kbd, 1) [203022]
i8042.c: aa <- i8042 (interrupt, kbd, 1) [203030]
i8042.c: 27 <- i8042 (interrupt, kbd, 1) [203032]
i8042.c: 23 <- i8042 (interrupt, kbd, 1) [203072]
i8042.c: 83 <- i8042 (interrupt, kbd, 1) [203082]
i8042.c: aa <- i8042 (interrupt, kbd, 1) [203086]
i8042.c: 60 -> i8042 (command) [203086]
i8042.c: 44 -> i8042 (parameter) [203086]
i8042.c: 60 -> i8042 (command) [203086]
i8042.c: 45 -> i8042 (parameter) [203086]
i8042.c: ed -> i8042 (kbd-data) [203086]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [203091]
i8042.c: 00 -> i8042 (kbd-data) [203091]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [203093]
i8042.c: f2 -> i8042 (kbd-data) [203093]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [203096]
i8042.c: ab <- i8042 (interrupt, kbd, 1) [203097]
i8042.c: 90 <- i8042 (interrupt, kbd, 1) [203099]
i8042.c: f8 -> i8042 (kbd-data) [203099]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [203102]
i8042.c: f4 -> i8042 (kbd-data) [203102]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [203106]
i8042.c: ea -> i8042 (kbd-data) [203106]
i8042.c: fe <- i8042 (interrupt, kbd, 1) [203109]
i8042.c: f0 -> i8042 (kbd-data) [203109]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [203112]
i8042.c: 02 -> i8042 (kbd-data) [203112]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [203115]
i8042.c: f0 -> i8042 (kbd-data) [203115]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [203118]
i8042.c: 00 -> i8042 (kbd-data) [203118]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [203120]
i8042.c: 41 <- i8042 (interrupt, kbd, 1) [203121]
input: AT Set 2 keyboard on isa0060/serio0
i8042.c: 27 <- i8042 (interrupt, kbd, 1) [203136]
i8042.c: 2a <- i8042 (interrupt, kbd, 1) [203146]
i8042.c: 03 <- i8042 (interrupt, kbd, 1) [203149]
i8042.c: 94 <- i8042 (interrupt, kbd, 1) [203163]
atkbd.c: Unknown key (set 2, scancode 0x94, on isa0060/serio0) pressed.
i8042.c: a3 <- i8042 (interrupt, kbd, 1) [203170]
i8042.c: 83 <- i8042 (interrupt, kbd, 1) [203207]
i8042.c: aa <- i8042 (interrupt, kbd, 1) [203210]
i8042.c: a7 <- i8042 (interrupt, kbd, 1) [203216]
i8042.c: 23 <- i8042 (interrupt, kbd, 1) [203236]
i8042.c: 14 <- i8042 (interrupt, kbd, 1) [203246]
i8042.c: 2a <- i8042 (interrupt, kbd, 1) [203267]
i8042.c: 03 <- i8042 (interrupt, kbd, 1) [203270]
i8042.c: aa <- i8042 (interrupt, kbd, 1) [203276]
i8042.c: 27 <- i8042 (interrupt, kbd, 1) [203278]
i8042.c: 94 <- i8042 (interrupt, kbd, 1) [203317]
i8042.c: a3 <- i8042 (interrupt, kbd, 1) [203333]
i8042.c: 83 <- i8042 (interrupt, kbd, 1) [203343]
i8042.c: aa <- i8042 (interrupt, kbd, 1) [203347]
i8042.c: 60 -> i8042 (command) [203347]
i8042.c: 44 -> i8042 (parameter) [203347]
i8042.c: 60 -> i8042 (command) [203347]
i8042.c: 45 -> i8042 (parameter) [203347]
i8042.c: ed -> i8042 (kbd-data) [203347]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [203350]
i8042.c: 00 -> i8042 (kbd-data) [203350]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [203353]
i8042.c: f2 -> i8042 (kbd-data) [203353]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [203356]
i8042.c: ab <- i8042 (interrupt, kbd, 1) [203357]
i8042.c: 90 <- i8042 (interrupt, kbd, 1) [203358]
i8042.c: f8 -> i8042 (kbd-data) [203358]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [203362]
i8042.c: f4 -> i8042 (kbd-data) [203362]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [203366]
i8042.c: ea -> i8042 (kbd-data) [203366]
i8042.c: fe <- i8042 (interrupt, kbd, 1) [203369]
i8042.c: f0 -> i8042 (kbd-data) [203369]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [203372]
i8042.c: 02 -> i8042 (kbd-data) [203372]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [203374]
i8042.c: f0 -> i8042 (kbd-data) [203374]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [203377]
i8042.c: 00 -> i8042 (kbd-data) [203377]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [203380]
i8042.c: 41 <- i8042 (interrupt, kbd, 1) [203381]
input: AT Set 2 keyboard on isa0060/serio0
i8042.c: 27 <- i8042 (interrupt, kbd, 1) [203402]
i8042.c: 2a <- i8042 (interrupt, kbd, 1) [203412]
i8042.c: 03 <- i8042 (interrupt, kbd, 1) [203415]
i8042.c: aa <- i8042 (interrupt, kbd, 1) [203429]
i8042.c: 14 <- i8042 (interrupt, kbd, 1) [203432]
i8042.c: 23 <- i8042 (interrupt, kbd, 1) [203438]
i8042.c: 83 <- i8042 (interrupt, kbd, 1) [203467]
i8042.c: aa <- i8042 (interrupt, kbd, 1) [203470]
i8042.c: 60 -> i8042 (command) [203470]
i8042.c: 44 -> i8042 (parameter) [203470]
i8042.c: 60 -> i8042 (command) [203470]
i8042.c: 45 -> i8042 (parameter) [203470]
i8042.c: ed -> i8042 (kbd-data) [203471]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [203474]
i8042.c: 00 -> i8042 (kbd-data) [203474]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [203476]
i8042.c: f2 -> i8042 (kbd-data) [203476]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [203480]
i8042.c: ab <- i8042 (interrupt, kbd, 1) [203481]
i8042.c: 90 <- i8042 (interrupt, kbd, 1) [203482]
i8042.c: f8 -> i8042 (kbd-data) [203482]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [203486]
i8042.c: f4 -> i8042 (kbd-data) [203486]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [203489]
i8042.c: ea -> i8042 (kbd-data) [203489]
i8042.c: fe <- i8042 (interrupt, kbd, 1) [203492]
i8042.c: f0 -> i8042 (kbd-data) [203492]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [203495]
i8042.c: 02 -> i8042 (kbd-data) [203495]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [203497]
i8042.c: f0 -> i8042 (kbd-data) [203498]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [203501]
i8042.c: 00 -> i8042 (kbd-data) [203501]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [203503]
i8042.c: 41 <- i8042 (interrupt, kbd, 1) [203504]
input: AT Set 2 keyboard on isa0060/serio0
i8042.c: a3 <- i8042 (interrupt, kbd, 1) [203512]
i8042.c: 94 <- i8042 (interrupt, kbd, 1) [203522]
i8042.c: 27 <- i8042 (interrupt, kbd, 1) [203549]
i8042.c: 23 <- i8042 (interrupt, kbd, 1) [203581]
i8042.c: 14 <- i8042 (interrupt, kbd, 1) [203591]
i8042.c: a7 <- i8042 (interrupt, kbd, 1) [203606]
i8042.c: 94 <- i8042 (interrupt, kbd, 1) [203663]
i8042.c: a3 <- i8042 (interrupt, kbd, 1) [203677]
i8042.c: 1d <- i8042 (interrupt, kbd, 1) [205982]
i8042.c: 11 <- i8042 (interrupt, kbd, 1) [206144]
i8042.c: 91 <- i8042 (interrupt, kbd, 1) [206284]
i8042.c: 9d <- i8042 (interrupt, kbd, 1) [206457]

My interpretation of all this is that Henkaku/Zenkaku is reporting a weird scancode, (FF), the characterset selection keys are all acting as a spacebar, and something is confusing it in to go in to a different 'mode' or something during the bashing session.

Incidently, I think there must be a secret key combination to switch the logic in this keyboard to something more Japanese - the key that I am using successfully as ALT, is labelled as follows on the keytop:

KANJI

KATAKANA

and on the front of the key, it says 'KANJI something' in green, (I can't understand all of it).

So, obviously this key is not supposed to be used as ALT, despite being in the position of ALT.

I suspect that they keyboard can emulate a US or Japanese keyboard, and it's stuck in US mode, but who knows?

> > The keyboard has a speaker in it, and a volume control, but it's never made a single noise,
> > apart from a click when it's switched on, (so it does work).
> > 
> > This is a very strange keyboard :-).  94X1110 is the IBM part number.

John.
