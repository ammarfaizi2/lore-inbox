Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284245AbRLAUjm>; Sat, 1 Dec 2001 15:39:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284244AbRLAUjc>; Sat, 1 Dec 2001 15:39:32 -0500
Received: from smtp-abo-2.wanadoo.fr ([193.252.19.150]:56054 "EHLO
	amyris.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S284242AbRLAUjW>; Sat, 1 Dec 2001 15:39:22 -0500
Message-ID: <3C093F86.DA02646D@wanadoo.fr>
Date: Sat, 01 Dec 2001 21:37:26 +0100
From: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
Organization: Home PC
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Richard Gooch <rgooch@ras.ucalgary.ca>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.1-pre5 not easy to boot with devfs
In-Reply-To: <3C085FF3.813BAA57@wanadoo.fr>
		<9u9qas$1eo$1@penguin.transmeta.com>
		<200112010701.fB171N824084@vindaloo.ras.ucalgary.ca>
		<3C0898AD.FED8EF4A@wanadoo.fr> <200112011836.fB1IaxY31897@vindaloo.ras.ucalgary.ca>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Gooch wrote:
> 
> Pierre Rousselet writes:
> > Richard Gooch wrote:
> > > Indeed I do. Please Cc: me on devfs related stuff. And please apply
> > > devfs-patch-v200, which fixes a stupid typo. I'd also be interested in
> > > knowing the behaviour with 2.4.17-pre1.
> 
> Did you apply devfs-patch-v200?
> 
Well, I am now back with 2.4.16 and devfsd-1.3.18. Playing with devfs is
a risky game.

I applied devfs-patch-v200 against 2.5.1-pre5 :

patching file linux/Documentation/filesystems/devfs/ChangeLog
patching file linux/drivers/char/pty.c
patching file linux/drivers/char/tty_io.c
Hunk #1 succeeded at 1339 (offset -4 lines).
patching file linux/fs/devfs/base.c
patching file linux/include/linux/devfs_fs_kernel.h

And I got an oops when booting with devfsd-1.3.20. Luckily, I get the
same oops when booting without devfsd and starting it after loging in.
Here it is

ksymoops 2.4.3 on i686 2.5.1-pre5.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.1-pre5/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

 Unable to handle kernel paging request at virtual address 5a5a5a5e 
 c01516f9 
 *pde = 00000000 
 Oops: 0002 
 CPU:    0 
 EIP:    0010:[devfs_put+13/188]    Not tainted 
 EFLAGS: 00010206 
 eax: 5a5a5a5a   ebx: 5a5a5a5a   ecx: 00000017   edx: 5a5a5a5a 
 esi: 00000000   edi: 00000026   ebp: 00000000   esp: cf4f7f40 
 ds: 0018   es: 0018   ss: 0018 
 Process devfsd (pid: 167, stackpage=cf4f7000) 
 Stack: 00000026 c015420c 5a5a5a5a cf7a25e4 ffffffea 00000000 00000420
cfb80800  
        c01e7280 cf33c240 5a5a5a5a 000003fa 00000000 00000000 00000001
00000000  
        cf4f6000 00000000 00000000 00000000 cf4f6000 c01e72ac c01e72ac
c012f5e6  
 Call Trace: [devfsd_read+964/972] [sys_read+150/204]
[system_call+51/56]  
 Code: ff 4b 04 0f 94 c0 84 c0 0f 84 9e 00 00 00 3b 1d 00 15 21 c0  
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   ff 4b 04                  decl   0x4(%ebx)
Code;  00000002 Before first symbol
   3:   0f 94 c0                  sete   %al
Code;  00000006 Before first symbol
   6:   84 c0                     test   %al,%al
Code;  00000008 Before first symbol
   8:   0f 84 9e 00 00 00         je     ac <_EIP+0xac> 000000ac Before
first symbol
Code;  0000000e Before first symbol
   e:   3b 1d 00 15 21 c0         cmp    0xc0211500,%ebx


1 warning issued.  Results may not be reliable.

> > > and boot messages. And booting with
> >
> > Difficult, I have no log in this case. I don't see unusual message
> > before the oops except :
> 
> I need those boot messages.

Here is a log of a successful boot with devfs-patch-v200 but without
starting devfsd. 

Dec  1 18:47:20 milou kernel: Linux version 2.5.1-pre5 (root@milou) (gcc
version 2.95.3 20010315 (release)) #3 sam déc 1 18:21:42 CET 2001 
Dec  1 18:47:20 milou kernel: BIOS-provided physical RAM map: 
Dec  1 18:47:20 milou kernel:  BIOS-e820: 0000000000000000 -
000000000009fc00 (usable) 
Dec  1 18:47:20 milou kernel:  BIOS-e820: 000000000009fc00 -
00000000000a0000 (reserved) 
Dec  1 18:47:20 milou kernel:  BIOS-e820: 00000000000f0000 -
0000000000100000 (reserved) 
Dec  1 18:47:20 milou kernel:  BIOS-e820: 0000000000100000 -
0000000010000000 (usable) 
Dec  1 18:47:20 milou kernel:  BIOS-e820: 00000000ffff0000 -
0000000100000000 (reserved) 
Dec  1 18:47:20 milou kernel: On node 0 totalpages: 65536 
Dec  1 18:47:20 milou kernel: zone(0): 4096 pages. 
Dec  1 18:47:20 milou kernel: zone(1): 61440 pages. 
Dec  1 18:47:20 milou kernel: zone(2): 0 pages. 
Dec  1 18:47:20 milou kernel: Kernel command line: vga=4
root=/dev/discs/disc0/part2 ro mem=262144K 
Dec  1 18:47:20 milou kernel: Initializing CPU#0 
Dec  1 18:47:20 milou kernel: Detected 670.105 MHz processor. 
Dec  1 18:47:20 milou kernel: Console: colour VGA+ 80x30 
Dec  1 18:47:20 milou kernel: Calibrating delay loop... 1336.93 BogoMIPS 
Dec  1 18:47:20 milou kernel: Memory: 256424k/262144k available (733k
kernel code, 5332k reserved, 222k data, 68k init, 0k highmem) 
Dec  1 18:47:20 milou kernel: Dentry-cache hash table entries: 32768
(order: 6, 262144 bytes) 
Dec  1 18:47:20 milou kernel: Inode-cache hash table entries: 16384
(order: 5, 131072 bytes) 
Dec  1 18:47:20 milou kernel: Mount-cache hash table entries: 4096
(order: 3, 32768 bytes) 
Dec  1 18:47:20 milou kernel: Buffer-cache hash table entries: 16384
(order: 4, 65536 bytes) 
Dec  1 18:47:20 milou kernel: Page-cache hash table entries: 65536
(order: 6, 262144 bytes) 
Dec  1 18:47:20 milou kernel: CPU: Before vendor init, caps: 0383f9ff
00000000 00000000, vendor = 0 
Dec  1 18:47:20 milou kernel: CPU: L1 I cache: 16K, L1 D cache: 16K 
Dec  1 18:47:20 milou kernel: CPU: L2 cache: 256K 
Dec  1 18:47:20 milou kernel: Intel machine check architecture
supported. 
Dec  1 18:47:20 milou kernel: Intel machine check reporting enabled on
CPU#0. 
Dec  1 18:47:20 milou kernel: CPU: After vendor init, caps: 0383f9ff
00000000 00000000 00000000 
Dec  1 18:47:20 milou kernel: CPU:     After generic, caps: 0383f9ff
00000000 00000000 00000000 
Dec  1 18:47:20 milou kernel: CPU:             Common caps: 0383f9ff
00000000 00000000 00000000 
Dec  1 18:47:20 milou kernel: CPU: Intel Pentium III (Coppermine)
stepping 01 
Dec  1 18:47:20 milou kernel: Enabling fast FPU save and restore...
done. 
Dec  1 18:47:20 milou kernel: Enabling unmasked SIMD FPU exception
support... done. 
Dec  1 18:47:20 milou kernel: Checking 'hlt' instruction... OK. 
Dec  1 18:47:20 milou kernel: POSIX conformance testing by UNIFIX 
Dec  1 18:47:20 milou kernel: mtrr: v1.40 (20010327) Richard Gooch
(rgooch@atnf.csiro.au) 
Dec  1 18:47:20 milou kernel: mtrr: detected mtrr type: Intel 
Dec  1 18:47:20 milou kernel: PCI: PCI BIOS revision 2.10 entry at
0xfb380, last bus=1 
Dec  1 18:47:20 milou kernel: PCI: Using configuration type 1 
Dec  1 18:47:20 milou kernel: PCI: Probing PCI hardware 
Dec  1 18:47:20 milou kernel: Unknown bridge resource 0: assuming
transparent 
Dec  1 18:47:20 milou kernel: PCI: Using IRQ router PIIX [8086/7110] at
00:07.0 
Dec  1 18:47:20 milou kernel: Limiting direct PCI/PCI transfers. 
Dec  1 18:47:20 milou kernel: Linux NET4.0 for Linux 2.4 
Dec  1 18:47:20 milou kernel: Based upon Swansea University Computer
Society NET3.039 
Dec  1 18:47:20 milou kernel: apm: BIOS version 1.2 Flags 0x07 (Driver
version 1.15) 
Dec  1 18:47:20 milou kernel: Starting kswapd 
Dec  1 18:47:20 milou kernel: BIO: pool of 256 setup, 14Kb (56
bytes/bio) 
Dec  1 18:47:20 milou kernel: biovec: init pool 0, 1 entries, 12 bytes 
Dec  1 18:47:20 milou kernel: biovec: init pool 1, 4 entries, 48 bytes 
Dec  1 18:47:20 milou kernel: biovec: init pool 2, 16 entries, 192 bytes 
Dec  1 18:47:20 milou kernel: biovec: init pool 3, 64 entries, 768 bytes 
Dec  1 18:47:20 milou kernel: biovec: init pool 4, 128 entries, 1536
bytes 
Dec  1 18:47:20 milou kernel: biovec: init pool 5, 256 entries, 3072
bytes 
Dec  1 18:47:20 milou kernel: devfs: v1.2 (20011127) Richard Gooch
(rgooch@atnf.csiro.au) 
Dec  1 18:47:20 milou kernel: devfs: boot_options: 0x1 
Dec  1 18:47:20 milou kernel: block: 256 slots per queue, batch=32 
Dec  1 18:47:20 milou kernel: Uniform Multi-Platform E-IDE driver
Revision: 6.32 
Dec  1 18:47:20 milou kernel: ide: Assuming 33MHz system bus speed for
PIO modes; override with idebus=xx 
Dec  1 18:47:20 milou kernel: PIIX4: IDE controller on PCI slot 00:07.1 
Dec  1 18:47:20 milou kernel: PIIX4: chipset revision 1 
Dec  1 18:47:20 milou kernel: PIIX4: not 100% native mode: will probe
irqs later 
Dec  1 18:47:20 milou kernel:     ide0: BM-DMA at 0xf000-0xf007, BIOS
settings: hda:pio, hdb:pio 
Dec  1 18:47:20 milou kernel:     ide1: BM-DMA at 0xf008-0xf00f, BIOS
settings: hdc:pio, hdd:pio 
Dec  1 18:47:20 milou kernel: HPT366: onboard version of chipset, pin1=1
pin2=2 
Dec  1 18:47:20 milou kernel: HPT366: IDE controller on PCI slot 00:13.0 
Dec  1 18:47:20 milou kernel: PCI: Found IRQ 11 for device 00:13.0 
Dec  1 18:47:20 milou kernel: PCI: Sharing IRQ 11 with 00:13.1 
Dec  1 18:47:20 milou kernel: HPT366: chipset revision 1 
Dec  1 18:47:20 milou kernel: HPT366: not 100% native mode: will probe
irqs later 
Dec  1 18:47:20 milou kernel:     ide2: BM-DMA at 0xd400-0xd407, BIOS
settings: hde:pio, hdf:pio 
Dec  1 18:47:20 milou kernel: HPT366: IDE controller on PCI slot 00:13.1 
Dec  1 18:47:20 milou kernel: PCI: Found IRQ 11 for device 00:13.1 
Dec  1 18:47:20 milou kernel: PCI: Sharing IRQ 11 with 00:13.0 
Dec  1 18:47:20 milou kernel: HPT366: chipset revision 1 
Dec  1 18:47:20 milou kernel: HPT366: not 100% native mode: will probe
irqs later 
Dec  1 18:47:20 milou kernel:     ide3: BM-DMA at 0xe000-0xe007, BIOS
settings: hdg:pio, hdh:pio 
Dec  1 18:47:20 milou kernel: hdc: CRD-8240B, ATAPI CD/DVD-ROM drive 
Dec  1 18:47:20 milou kernel: hde: ST310212A, ATA DISK drive 
Dec  1 18:47:20 milou kernel: hdg: SAMSUNG SV0322A, ATA DISK drive 
Dec  1 18:47:20 milou kernel: ide1 at 0x170-0x177,0x376 on irq 15 
Dec  1 18:47:20 milou kernel: ide2 at 0xcc00-0xcc07,0xd002 on irq 11 
Dec  1 18:47:20 milou kernel: ide3 at 0xd800-0xd807,0xdc02 on irq 11 
Dec  1 18:47:20 milou kernel: blk: queue c0227dd4, I/O limit 4095Mb
(mask 0xffffffff) 
Dec  1 18:47:20 milou kernel: hde: 20005650 sectors (10243 MB) w/512KiB
Cache, CHS=19846/16/63, UDMA(66) 
Dec  1 18:47:20 milou kernel: blk: queue c022814c, I/O limit 4095Mb
(mask 0xffffffff) 
Dec  1 18:47:20 milou kernel: hdg: 6250608 sectors (3200 MB) w/478KiB
Cache, CHS=11024/9/63, UDMA(33) 
Dec  1 18:47:20 milou kernel: Partition check: 
Dec  1 18:47:20 milou kernel:  /dev/ide/host2/bus0/target0/lun0: [PTBL]
[1245/255/63] p1 p2 p3 p4 
Dec  1 18:47:20 milou kernel:  /dev/ide/host3/bus0/target0/lun0: p1 
Dec  1 18:47:20 milou kernel: Linux agpgart interface v0.99 (c) Jeff
Hartmann 
Dec  1 18:47:20 milou kernel: agpgart: Maximum main memory to use for
agp memory: 204M 
Dec  1 18:47:20 milou kernel: agpgart: Detected Intel 440BX chipset 
Dec  1 18:47:20 milou kernel: agpgart: AGP aperture is 256M @ 0xc0000000 
Dec  1 18:47:20 milou kernel: NET4: Linux TCP/IP 1.0 for NET4.0 
Dec  1 18:47:20 milou kernel: IP Protocols: ICMP, UDP, TCP, IGMP 
Dec  1 18:47:20 milou kernel: IP: routing cache hash table of 2048
buckets, 16Kbytes 
Dec  1 18:47:20 milou kernel: TCP: Hash tables configured (established
16384 bind 16384) 
Dec  1 18:47:20 milou kernel: NET4: Unix domain sockets 1.0/SMP for
Linux NET4.0. 
Dec  1 18:47:20 milou kernel: VFS: Mounted root (ext2 filesystem)
readonly. 
Dec  1 18:47:20 milou kernel: Mounted devfs on /dev 
Dec  1 18:47:20 milou kernel: Freeing unused kernel memory: 68k freed 
Dec  1 18:47:20 milou kernel: Adding Swap: 80316k swap-space (priority
-1) 
Dec  1 18:47:20 milou kernel: Real Time Clock Driver v1.10e 
Dec  1 18:47:20 milou kernel: es1370: version v0.37 time 18:25:27 Dec  1
2001 
Dec  1 18:47:20 milou kernel: PCI: Found IRQ 9 for device 00:09.0 
Dec  1 18:47:20 milou kernel: PCI: Sharing IRQ 9 with 00:07.2 
Dec  1 18:47:20 milou kernel: es1370: found adapter at io 0xc400 irq 9 
Dec  1 18:47:20 milou kernel: es1370: features: joystick off, line out,
mic impedance 0 
Dec  1 18:47:20 milou kernel: Serial driver version 5.05c (2001-07-08)
with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled 
Dec  1 18:47:20 milou kernel: ttyS00 at 0x03f8 (irq = 4) is a 16550A 
Dec  1 18:47:20 milou kernel: ttyS01 at 0x02f8 (irq = 3) is a 16550A 
Dec  1 18:47:20 milou kernel: ne2k-pci.c:v1.02 10/19/2000 D. Becker/P.
Gortmaker 
Dec  1 18:47:20 milou kernel:  
http://www.scyld.com/network/ne2k-pci.html 
Dec  1 18:47:20 milou kernel: PCI: Found IRQ 10 for device 00:0d.0 
Dec  1 18:47:20 milou kernel: eth0: RealTek RTL-8029 found at 0xc800,
IRQ 10, 00:40:05:E4:DB:3F. 
Dec  1 18:47:20 milou kernel: hdc: ATAPI CD-ROM drive, 0kB Cache, DMA 
Dec  1 18:47:20 milou kernel: Uniform CD-ROM driver Revision: 3.12 
Dec  1 18:47:20 milou kernel: parport0: PC-style at 0x378, irq 7
[PCSPP,TRISTATE] 
Dec  1 18:47:20 milou kernel: parport0: cpp_daisy: aa5500ff(98) 
Dec  1 18:47:20 milou kernel: parport0: assign_addrs: aa5500ff(98) 
Dec  1 18:47:20 milou kernel: parport0: Printer, HEWLETT-PACKARD DESKJET
930C 
Dec  1 18:47:20 milou kernel: lp0: using parport0 (interrupt-driven). 

> 
> > none already mounted on /dev
> 
> Edit your /etc/fstab and remove the line for devfs. You don't
> need/want that if you have CONFIG_DEVFS_MOUNT=y.

no problem

> 
> > /dev is only a mountpoint on my system. I have no other fallback without
> > devfs but a working kernel (thanksfully there are plenty).
> >
> > > "devfs=dall" is required as well.
> >
> > No option appended (no 'devfs='). grub.
> 
> I know nothing about grub. Somehow, you need to pass "devfs=dall" to

maybe I should pass an option but so far it was working without any, as
you can see it in the command line from the log above.

> the kernel when booting. And I need to see the boot messages when this
> option is given to the kernel. If it's too verbose, you can try
> "devfs=dreg,dunreg,dfree" instead. Copy the messages down by hand if
> you need to, but I need to see them. Do yourself a favour and set up a
> serial console so you can capture boot messages easily.

I'll try my best, I like devfs.
> 
> Also, make sure you are not using any proprietary drivers (like
> NVidia). If you have such drivers, move them to another directory to

no chance

> prevent their being loaded. Even if you load but don't use such
> drivers, they still make debugging information unreliable.
> 
> I've had a look at the code, and I see no reason for devfs to fail in
> this way, unless some driver is abusing it.

I would suspect 1st devfsd. 2.4.16 is not happy at all with
devfsd-1.3.20, even rxvt fails to find a terminal.

> 
>                                 Regards,
> 
>                                         Richard....
> Permanent: rgooch@atnf.csiro.au
> Current:   rgooch@ras.ucalgary.ca

Pierre
-- 
------------------------------------------------
 Pierre Rousselet <pierre.rousselet@wanadoo.fr>
------------------------------------------------
