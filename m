Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262040AbTKHAWG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 19:22:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261656AbTKGWHq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 17:07:46 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:17156 "EHLO
	arnor.me.apana.org.au") by vger.kernel.org with ESMTP
	id S264083AbTKGLX7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 06:23:59 -0500
Date: Fri, 7 Nov 2003 22:23:46 +1100
To: Jens Axboe <axboe@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BIO] Bounce queue in bio_add_page
Message-ID: <20031107112346.GA5153@gondor.apana.org.au>
References: <20031101044619.GA15628@gondor.apana.org.au> <20031101100543.GA16682@gondor.apana.org.au> <20031103122500.GA6963@suse.de> <20031103205234.GA17570@gondor.apana.org.au> <20031104084929.GH1477@suse.de> <20031104090325.GA21301@gondor.apana.org.au> <20031104090353.GM1477@suse.de> <20031105094855.GD1477@suse.de> <20031106210900.GA29000@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20031106210900.GA29000@gondor.apana.org.au>
User-Agent: Mutt/1.5.4i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 07, 2003 at 08:09:00AM +1100, herbert wrote:
> On Wed, Nov 05, 2003 at 10:48:55AM +0100, Jens Axboe wrote:
> > 
> > I don't see any problems with this approach, I'll commit the code.
> 
> Actually, please hold onto that patch if possible, I've just received
> a report that it maybe causing worse problems than the one it solves.
> 
> I'll get back to you.

OK, looks like the crash is unrelated to this change.  Here is
the dump:

LILO 22.5.8 boot: Linux
Loading Linux..................................
BIOS data check successful
Linux version 2.6.0-test9.custom586.1 (root@sitvanit) (gcc version 3.3.2 (Debian)) #1 Wed Nov 5 23:33:12 IST 2003
BIOS-provided physical RAM map:
 BIOS-88: 0000000000000000 - 000000000009f000 (usable)
 BIOS-88: 0000000000100000 - 0000000002400000 (usable)
36MB LOWMEM available.
On node 0 totalpages: 9216
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 5120 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
DMI not present.
Building zonelist for node : 0
Kernel command line: auto BOOT_IMAGE=Linux ro root=301 console=tty0 console=ttyS0,9600n8
No local APIC present or hardware disabled
Initializing CPU#0
PID hash table entries: 256 (order 8: 2048 bytes)
Detected 83.274 MHz processor.
Console: colour VGA+ 80x25
Memory: 33292k/36864k available (1003k kernel code, 3136k reserved, 358k data, 272k init, 0k highmem)
Calibrating delay loop... 162.30 BogoMIPS
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
checking if image is initramfs...it isn't (ungzip failed); looks like an initrd
Freeing initrd memory: 956k freed
Intel Pentium with F0 0F bug - workaround enabled.
CPU: Intel OverDrive PODP5V83 stepping 02
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.00 entry at 0xea100, last bus=0
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
spurious 8259A interrupt: IRQ7.
ikconfig 0.7 with /proc/config*
VFS: Disk quotas dquot_6.5.1
devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
Initializing Cryptographic API
pty: 256 Unix98 ptys configured
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16450
ttyS1 at I/O 0x2f8 (irq = 3) is a 16450
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Translated Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
NET: Registered protocol family 2
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 2048 bind 4096)
RAMDISK: cramfs filesystem found at block 0
RAMDISK: Loading 956 blocks [1 disk] into ram disk... |/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\done.
VFS: Mounted root (cramfs filesystem).
Freeing unused kernel memory: 272k freed
initrd-tools: 0.1.54
warning: can't open /etc/mtab: No such file or directory
NET: Registered protocol family 1
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 50MHz system bus speed for PIO modes; override with idebus=xx
Module ide_probe_mod cannot be unloaded due to unsafe usage in include/linux/module.h:483
hda: WDC AC2420H, ATA DISK drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: max request size: 128KiB
hda: 830760 sectors (425 MB) w/128KiB Cache, CHS=989/15/56
 /dev/ide/host0/bus0/target0/lun0: p1 p2
mount: fs type ext3 not supported by kernel
INIT: version 2.85 booting
Starting Bootlog daemon: Adding 318352k swap on /dev/hda2.  Priority:-1 extents:1
Real Time Clock Driver v1.12
SCSI subsystem initialized
Configuring Adaptec (SCSI-ID 7) at IO:134, IRQ 15, DMA priority 6
scsi0 : Adaptec 1542
isa bounce pool size: 16 pages
  Vendor: SEAGATE   Model: ST19171N          Rev: 0024
  Type:   Direct-Access                      ANSI SCSI revision: 02
SCSI device sda: 17783112 512-byte hdwr sectors (9105 MB)
SCSI device sda: drive cache: write through
 /dev/scsi/host0/bus0/target0/lun0: p1 p2 p3
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
ip_tables: (C) 2000-2002 Netfilter core team
ip_conntrack version 2.1 (288 buckets, 2304 max) - 300 bytes per conntrack
smc-ultra.c:v2.02 2/3/98 Donald Becker (becker@cesdis.gsfc.nasa.gov)
eth0: SMC EtherEZ at 0x280, 00 00 C0 ED 9C C6,assigned  IRQ 10 memory 0xc8000-0xc9fff.
ne.c:v1.10 9/23/94 Donald Becker (becker@scyld.com)
Last modified Nov 1, 2000 by Paul Gortmaker
NE*000 ethercard probe at 0x300: 00 40 05 14 a0 2c
eth1: NE2000 found at 0x300, using IRQ 5.
nfs warning: mount version older than kernel
bootlogd.
------------[ cut here ]------------
kernel BUG at mm/filemap.c:329!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<c012d4e7>]    Not tainted
EFLAGS: 00010246
EIP is at unlock_page+0x17/0x40
eax: 00000000   ebx: c100e448   ecx: 0000001c   edx: c100e448
esi: c105a058   edi: c1304f20   ebp: c0257ebc   esp: c0257e58
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=c0256000 task=c0224c80)
Stack: c10e3114 00000001 c015f09e c1304f20 00000000 00011000 c01496ed c1304f20 
       00011000 00000000 00011000 c1304f20 c01a252f c1304f20 00011000 00000000 
       00011000 c1304f20 00000000 00000000 00000000 00000000 c12f8b30 c029ace0 
Call Trace:
 [<c015f09e>] mpage_end_io_read+0x4e/0x70
 [<c01496ed>] bio_endio+0x3d/0x60
 [<c01a252f>] __end_that_request_first+0x1ef/0x210
 [<c01a2567>] end_that_request_first+0x17/0x20
 [<c30c9768>] scsi_end_request+0x28/0xb0 [scsi_mod]
 [<c30c9b5a>] scsi_io_completion+0x1da/0x470 [scsi_mod]
 [<c30428bc>] sd_rw_intr+0x7c/0x240 [sd_mod]
 [<c30c5a01>] scsi_finish_command+0x81/0xe0 [scsi_mod]
 [<c30c5826>] scsi_softirq+0xd6/0x200 [scsi_mod]
 [<c011c453>] do_softirq+0x93/0xa0
 [<c010cea6>] do_IRQ+0xd6/0x110
 [<c0105000>] _stext+0x0/0x20
 [<c010b6c8>] common_interrupt+0x18/0x20
 [<c01088a0>] default_idle+0x0/0x30
 [<c0105000>] _stext+0x0/0x20
 [<c01088c4>] default_idle+0x24/0x30
 [<c0108935>] cpu_idle+0x25/0x40
 [<c02586a9>] start_kernel+0x159/0x190

Code: 0f 0b 49 01 3e cc 20 c0 39 36 75 03 5b 5e c3 89 f0 31 c9 ba 
 <0>Kernel panic: Fatal exception in interrupt
In interrupt handler - not syncing
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
