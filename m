Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311682AbSCNRB7>; Thu, 14 Mar 2002 12:01:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311679AbSCNRBs>; Thu, 14 Mar 2002 12:01:48 -0500
Received: from smokey.blackcatnetworks.co.uk ([212.135.138.139]:13453 "EHLO
	smokey.blackcatnetworks.co.uk") by vger.kernel.org with ESMTP
	id <S311673AbSCNRB1> convert rfc822-to-8bit; Thu, 14 Mar 2002 12:01:27 -0500
Date: Thu, 14 Mar 2002 17:01:23 +0000
From: Alex Walker <alex@x3ja.co.uk>
To: Oleg Drokin <green@namesys.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops in 2.5.6 and 2.5.7-pre1 - reiserfs?
Message-ID: <20020314170123.G9664@x3ja.co.uk>
In-Reply-To: <20020314162009.F9664@x3ja.co.uk> <20020314192916.A1929@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020314192916.A1929@namesys.com>; from green@namesys.com on Thu, Mar 14, 2002 at 07:29:16PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Appears to work fine - thanks for the quick response!
(Although I did think it had killed my net card, but they just shuffled
tulip stuff around)

Whilst I'm here... Is there a neat way to convert your root system from
3.5 to 3.6?  I tried "mount -o remount,conv /" which gave no errors, but
didn't actually convert it.  I also tried adding conv to the options in
/etc/fstab, but to similar effect...  Do I have to copy to a different
partition with a 3.6 format and use that as my root to do it?

Cheers.

Alex

On Thu, Mar 14, 2002 at 07:29:16PM +0300, Oleg Drokin wrote:
> Hello!

>   Try the patch attached.

> Bye,
>     Oleg
> On Thu, Mar 14, 2002 at 04:20:09PM +0000, Alex Walker wrote:
> > Please CC me in replies to this - I'm not on the list.
> > I am using the 2.5 series on a couple of machine (mainly because they
> > now have ALSA and preempt in) and one is running fine, the other oopses
> > on boot to 2.5.6 or 2.5.7-pre1.
> > I think the problem is from reiserfs somewhere.  Attached are the
> > ksymoops interpretations of the two Oops (which seem virtually
> > identical), and also the kernel logs of boot to both kernels.
> > I have reiserfs on my root partition, and it is in the 3.5 format
> > (haven't got found out how to convert to 3.6) which may be significant.
> > All other partitions are in the 3.6 format.
> > The last known working 2.5 kernel for me is 2.5.6-pre1.
> > If you want any more information, please let me know.
> > Cheers,
> > Alex
> > -- 
> >       ALEX|X3JA
> >    alex@x3ja.co.uk
> >     ICQ: 1523424

> > ksymoops 2.4.3 on i686 2.5.6-pre1.  Options used
> >      -V (default)
> >      -K (specified)
> >      -L (specified)
> >      -o /lib/modules/2.5.6 (specified)
> >      -m /boot/System.map-2.5.6 (specified)
> > No modules in ksyms, skipping objects
> > cpu: 0, clocks: 1328955, slice: 664477
> > Unable to handle kernel NULL pointer dereference at virtual address 00000010
> > c0135f3e
> > *pde = 00000000
> > Oops: 0000
> > CPU:    0
> > EIP:    0010:[<c0135f3e>]    Not tainted
> > Using defaults from ksymoops -t elf32-i386 -a i386
> > EFLAGS: 00010286
> > eax: 00001000   ebx: 0000000e   ecx: 00000008   edx: 00002012
> > esi: 00000008   edi: 00002012   ebp: 00000000   esp: c13edd64
> > ds: 0018   es: 0018   ss: 0018
> > Stack: 00001000 00002012 00000000 d3d09c00 d3d09c00 c01365e8 00000000 00002012 
> >        00001000 d3d09c00 d4834000 d48453ec c01367ef 00000000 00002012 00001000 
> >        d3d09c00 c01b2196 00000000 00002012 00001000 00000306 00000000 d3d09d54 
> > Call Trace: [<c01365e8>] [<c01367ef>] [<c01b2196>] [<c0135710>] [<c01a4808>] 
> >    [<c01a50cc>] [<c01bbe0c>] [<c0139f7f>] [<c01a54af>] [<c01a4fa8>] [<c013a136>] 
> >    [<c014aa99>] [<c014ad70>] [<c014abb4>] [<c014b190>] [<c0105259>] [<c0105073>] 
> >    [<c01055fc>] 
> > Code: 0f b7 45 10 b0 00 66 0f b6 55 10 01 d0 0f b7 c0 89 44 24 10 
> > >>EIP; c0135f3e <__get_hash_table+1a/bc>   <=====
> > Trace; c01365e8 <__getblk+1c/40>
> > Trace; c01367ee <__bread+16/70>
> > Trace; c01b2196 <journal_init+de/68c>
> > Trace; c0135710 <__wait_on_buffer+84/90>
> > Trace; c01a4808 <read_bitmaps+cc/164>
> > Trace; c01a50cc <reiserfs_fill_super+124/49c>
> > Trace; c01bbe0c <sprintf+14/18>
> > Trace; c0139f7e <get_sb_bdev+23e/2b4>
> > Trace; c01a54ae <reiserfs_get_sb+1e/24>
> > Trace; c01a4fa8 <reiserfs_fill_super+0/49c>
> > Trace; c013a136 <do_kern_mount+4a/c0>
> > Trace; c014aa98 <do_add_mount+6c/13c>
> > Trace; c014ad70 <do_mount+16c/188>
> > Trace; c014abb4 <copy_mount_options+4c/9c>
> > Trace; c014b190 <sys_mount+a4/110>
> > Trace; c0105258 <prepare_namespace+a8/e0>
> > Trace; c0105072 <init+22/160>
> > Trace; c01055fc <kernel_thread+28/38>
> > Code;  c0135f3e <__get_hash_table+1a/bc>
> > 00000000 <_EIP>:
> > Code;  c0135f3e <__get_hash_table+1a/bc>   <=====
> >    0:   0f b7 45 10               movzwl 0x10(%ebp),%eax   <=====
> > Code;  c0135f42 <__get_hash_table+1e/bc>
> >    4:   b0 00                     mov    $0x0,%al
> > Code;  c0135f44 <__get_hash_table+20/bc>
> >    6:   66 0f b6 55 10            movzbw 0x10(%ebp),%dx
> > Code;  c0135f48 <__get_hash_table+24/bc>
> >    b:   01 d0                     add    %edx,%eax
> > Code;  c0135f4a <__get_hash_table+26/bc>
> >    d:   0f b7 c0                  movzwl %ax,%eax
> > Code;  c0135f4e <__get_hash_table+2a/bc>
> >   10:   89 44 24 10               mov    %eax,0x10(%esp,1)
> >  <0>Kernel panic: Attempted to kill init!

> > ksymoops 2.4.3 on i686 2.5.6-pre1.  Options used
> >      -V (default)
> >      -K (specified)
> >      -L (specified)
> >      -o /lib/modules/2.5.7-pre1/ (specified)
> >      -m /boot/System.map-2.5.7-pre1 (specified)
> > No modules in ksyms, skipping objects
> > cpu: 0, clocks: 1328955, slice: 664477
> > Unable to handle kernel NULL pointer dereference at virtual address 00000010
> > c01362de
> > *pde = 00000000
> > Oops: 0000
> > CPU:    0
> > EIP:    0010:[<c01362de>]    Not tainted
> > Using defaults from ksymoops -t elf32-i386 -a i386
> > EFLAGS: 00010292
> > eax: 00001000   ebx: 0000000e   ecx: 00000008   edx: 00002012
> > esi: 00000008   edi: 00002012   ebp: 00000000   esp: c13edd6c
> > ds: 0018   es: 0018   ss: 0018
> > Stack: 00001000 00002012 00000000 d3d09c00 d3d09c00 c0136988 00000000 00002012 
> >        00001000 d3d09c00 d4834000 d48453ec c0136b8f 00000000 00002012 00001000 
> >        d3d09c00 c01b26f6 00000000 00002012 00001000 00000306 00000000 d3d09d54 
> > Call Trace: [<c0136988>] [<c0136b8f>] [<c01b26f6>] [<c0135ab0>] [<c01a4d68>] 
> >    [<c01a562c>] [<c01bc36c>] [<c013b639>] [<c013a310>] [<c01a5a0f>] [<c01a5508>] 
> >    [<c013a4e0>] [<c014ae59>] [<c014b130>] [<c014af74>] [<c014b550>] [<c0105259>] 
> >    [<c0105073>] [<c01055fc>] 
> > Code: 0f b7 45 10 b0 00 66 0f b6 55 10 01 d0 0f b7 c0 89 44 24 10 
> > >>EIP; c01362de <__get_hash_table+1a/bc>   <=====
> > Trace; c0136988 <__getblk+1c/40>
> > Trace; c0136b8e <__bread+16/70>
> > Trace; c01b26f6 <journal_init+de/68c>
> > Trace; c0135ab0 <__wait_on_buffer+84/90>
> > Trace; c01a4d68 <read_bitmaps+cc/164>
> > Trace; c01a562c <reiserfs_fill_super+124/49c>
> > Trace; c01bc36c <sprintf+14/18>
> > Trace; c013b638 <bdevname+30/3a>
> > Trace; c013a310 <get_sb_bdev+1d4/238>
> > Trace; c01a5a0e <reiserfs_get_sb+1e/24>
> > Trace; c01a5508 <reiserfs_fill_super+0/49c>
> > Trace; c013a4e0 <do_kern_mount+50/cc>
> > Trace; c014ae58 <do_add_mount+6c/13c>
> > Trace; c014b130 <do_mount+16c/188>
> > Trace; c014af74 <copy_mount_options+4c/9c>
> > Trace; c014b550 <sys_mount+a4/110>
> > Trace; c0105258 <prepare_namespace+a8/e0>
> > Trace; c0105072 <init+22/160>
> > Trace; c01055fc <kernel_thread+28/38>
> > Code;  c01362de <__get_hash_table+1a/bc>
> > 00000000 <_EIP>:
> > Code;  c01362de <__get_hash_table+1a/bc>   <=====
> >    0:   0f b7 45 10               movzwl 0x10(%ebp),%eax   <=====
> > Code;  c01362e2 <__get_hash_table+1e/bc>
> >    4:   b0 00                     mov    $0x0,%al
> > Code;  c01362e4 <__get_hash_table+20/bc>
> >    6:   66 0f b6 55 10            movzbw 0x10(%ebp),%dx
> > Code;  c01362e8 <__get_hash_table+24/bc>
> >    b:   01 d0                     add    %edx,%eax
> > Code;  c01362ea <__get_hash_table+26/bc>
> >    d:   0f b7 c0                  movzwl %ax,%eax
> > Code;  c01362ee <__get_hash_table+2a/bc>
> >   10:   89 44 24 10               mov    %eax,0x10(%esp,1)
> >  <0>Kernel panic: Attempted to kill init!

> > Loading 2.5.6...................
> > s Linux version 2.5.6 (alex@numbers) (gcc version 2.95.4 20011002 (Debian prerelease)) #3 Thu Mar 14 14:48:28 GMT 2002
> > BIOS-provided physical RAM map:
> >  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
> >  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
> >  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
> >  BIOS-e820: 0000000000100000 - 0000000013fc0000 (usable)
> >  BIOS-e820: 0000000013fc0000 - 0000000013ff8000 (ACPI data)
> >  BIOS-e820: 0000000013ff8000 - 0000000014000000 (ACPI NVS)
> >  BIOS-e820: 00000000ffb80000 - 00000000ffc00000 (reserved)
> >  BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
> > 319MB LOWMEM available.
> > On node 0 totalpages: 81856
> > zone(0): 4096 pages.
> > zone(1): 77760 pages.
> > zone(2): 0 pages.
> > Kernel command line: BOOT_IMAGE=2.5.6 ro root=306 console=ttyS0,9600n8 console=tty0
> > Local APIC disabled by BIOS -- reenabling.
> > Found and enabled local APIC!
> > Initializing CPU#0
> > Detected 930.255 MHz processor.
> > Console: colour VGA+ 80x25
> > Calibrating delay loop... 1854.66 BogoMIPS
> > Memory: 321084k/327424k available (1470k kernel code, 5952k reserved, 474k data, 208k init, 0k highmem)
> > Dentry-cache hash table entries: 65536 (order: 7, 524288 bytes)
> > Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
> > Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
> > Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
> > Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
> > CPU: L1 I cache: 16K, L1 D cache: 16K
> > CPU: L2 cache: 256K
> > Intel machine check architecture supported.
> > Intel machine check reporting enabled on CPU#0.
> > CPU: Intel Pentium III (Coppermine) stepping 06
> > Enabling fast FPU save and restore... done.
> > Enabling unmasked SIMD FPU exception support... done.
> > Checking 'hlt' instruction... OK.
> > POSIX conformance testing by UNIFIX
> > enabled ExtINT on CPU#0
> > ESR value before enabling vector: 00000000
> > ESR value after enabling vector: 00000000
> > Using local APIC timer interrupts.
> > calibrating APIC timer ...
> > ..... CPU clock speed is 930.2691 MHz.
> > ..... host bus clock speed is 132.8955 MHz.
> > cpu: 0, clocks: 1328955, slice: 664477
> > CPU0<T0:1328944,T1:664464,D:3,S:664477,C:1328955>
> > mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
> > mtrr: detected mtrr type: Intel
> > Linux NET4.0 for Linux 2.4
> > Based upon Swansea University Computer Society NET3.039
> > Initializing RT netlink socket
> > PCI: PCI BIOS revision 2.10 entry at 0xfda95, last bus=2
> > PCI: Using configuration type 1
> > PCI: Probing PCI hardware
> > Unknown bridge resource 0: assuming transparent
> > PCI: Discovered primary peer bus 08 [IRQ]
> > PCI: Using IRQ router PIIX [8086/2440] at 00:1f.0
> > Starting kswapd
> > BIO: pool of 256 setup, 14Kb (56 bytes/bio)
> > biovec: init pool 0, 1 entries, 12 bytes
> > biovec: init pool 1, 4 entries, 48 bytes
> > biovec: init pool 2, 16 entries, 192 bytes
> > biovec: init pool 3, 64 entries, 768 bytes
> > biovec: init pool 4, 128 entries, 1536 bytes
> > biovec: init pool 5, 256 entries, 3072 bytes
> > Journalled Block Device driver loaded
> > Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
> > ACPI: Core Subsystem version [20011018]
> > ACPI: Subsystem enabled
> > Power Resource: found
> > Power Resource: found
> > Power Resource: found
> > Power Resource: found
> > ACPI: System firmware supports S0 S1 S4 S5
> > Processor[0]: C0 C1
> > ACPI: Power Button (FF) found
> > ACPI: Sleep Button (CM) found
> > pty: 256 Unix98 ptys configured
> > Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
> > ttyS00 at 0x03f8 (irq = 4) is a 16550A
> > Real Time Clock Driver v1.11
> > block: 256 slots per queue, batch=32
> > Linux video capture interface: v1.00
> > Linux agpgart interface v0.99 (c) Jeff Hartmann
> > agpgart: Maximum main memory to use for agp memory: 262M
> > agpgart: Detected Intel i815 chipset
> > agpgart: AGP aperture is 64M @ 0xf8000000
> > Uniform Multi-Platform E-IDE driver ver.:7.0.0
> > ide: system bus speed 33MHz
> > Intel Corp. 82820 820 (Camino 2) Chipset IDE U100: IDE controller on PCI slot 00:1f.1
> > Intel Corp. 82820 820 (Camino 2) Chipset IDE U100: chipset revision 2
> > Intel Corp. 82820 820 (Camino 2) Chipset IDE U100: not 100% native mode: will probe irqs later
> >     ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:DMA
> >     ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
> > hda: QUANTUM FIREBALLlct20 20, ATA DISK drive
> > hdb: SAMSUNG SV2044D, ATA DISK drive
> > hdc: MATSHITADVD-ROM SR-8586, ATAPI CD/DVD-ROM drive
> > ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> > ide1 at 0x170-0x177,0x376 on irq 15
> > blk: queue c034dbac, I/O limit 4095Mb (mask 0xffffffff)
> > hda: 39876480 sectors (20417 MB) w/418KiB Cache, CHS=39560/16/63, UDMA(33)
> > blk: queue c034ddcc, I/O limit 4095Mb (mask 0xffffffff)
> > hdb: 39862368 sectors (20410 MB) w/472KiB Cache, CHS=39546/16/63, UDMA(66)
> > Partition check:
> >  hda: [PTBL] [2482/255/63] hda1 hda3 < hda5 hda6 hda7 hda8 hda9 hda10 hda11 hda12 hda13 >
> >  hdb: hdb1 hdb2 hdb3 < hdb5 hdb6 hdb7 hdb8 hdb9 hdb10 >
> > usb.c: registered new driver usbfs
> > usb.c: registered new driver hub
> > uhci.c: USB Universal Host Controller Interface driver v1.1
> > PCI: Found IRQ 3 for device 00:1f.2
> > PCI: Setting latency timer of device 00:1f.2 to 64
> > uhci.c: USB UHCI at I/O 0xef40, IRQ 3
> > hcd.c: new USB bus registered, assigned bus number 1
> > hub.c: USB hub found at /
> > hub.c: 2 ports detected
> > PCI: Found IRQ 9 for device 00:1f.4
> > PCI: Setting latency timer of device 00:1f.4 to 64
> > uhci.c: USB UHCI at I/O 0xef80, IRQ 9
> > hcd.c: new USB bus registered, assigned bus number 2
> > hub.c: USB hub found at /
> > hub.c: 2 ports detected
> > usb.c: registered new driver hid
> > hid-core.c: v1.31:USB HID core driver
> > mice: PS/2 mouse device common for all mice
> > NET4: Linux TCP/IP 1.0 for NET4.0
> > IP Protocols: ICMP, UDP, TCP, IGMP
> > IP: routing cache hash table of 2048 buckets, 16Kbytes
> > TCP: Hash tables configured (established 32768 bind 32768)
> > ip_conntrack (2558 buckets, 20464 max)
> > ip_tables: (C) 2000-2002 Netfilter core team
> > NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> > found reiserfs format "3.5" with standard journal
> > Unable to handle kernel NULL pointer dereference at virtual address 00000010
> >  printing eip:
> > c0135f3e
> > *pde = 00000000
> > Oops: 0000
> > CPU:    0
> > EIP:    0010:[<c0135f3e>]    Not tainted
> > EFLAGS: 00010286
> > eax: 00001000   ebx: 0000000e   ecx: 00000008   edx: 00002012
> > esi: 00000008   edi: 00002012   ebp: 00000000   esp: c13edd64
> > ds: 0018   es: 0018   ss: 0018
> > Process swapper (pid: 1, threadinfo=c13ec000 task=c13ea040)
> > Stack: 00001000 00002012 00000000 d3d09c00 d3d09c00 c01365e8 00000000 00002012 
> >        00001000 d3d09c00 d4834000 d48453ec c01367ef 00000000 00002012 00001000 
> >        d3d09c00 c01b2196 00000000 00002012 00001000 00000306 00000000 d3d09d54 
> > Call Trace: [<c01365e8>] [<c01367ef>] [<c01b2196>] [<c0135710>] [<c01a4808>] 
> >    [<c01a50cc>] [<c01bbe0c>] [<c0139f7f>] [<c01a54af>] [<c01a4fa8>] [<c013a136>] 
> >    [<c014aa99>] [<c014ad70>] [<c014abb4>] [<c014b190>] [<c0105259>] [<c0105073>] 
> >    [<c01055fc>] 
> > Code: 0f b7 45 10 b0 00 66 0f b6 55 10 01 d0 0f b7 c0 89 44 24 10 
> >  <0>Kernel panic: Attempted to kill init!

> > Loading 2.5.7-p1...................
> > s Linux version 2.5.7-pre1 (alex@numbers) (gcc version 2.95.4 20011002 (Debian prerelease)) #2 Thu Mar 14 15:50:33 GMT 2002
> > BIOS-provided physical RAM map:
> >  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
> >  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
> >  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
> >  BIOS-e820: 0000000000100000 - 0000000013fc0000 (usable)
> >  BIOS-e820: 0000000013fc0000 - 0000000013ff8000 (ACPI data)
> >  BIOS-e820: 0000000013ff8000 - 0000000014000000 (ACPI NVS)
> >  BIOS-e820: 00000000ffb80000 - 00000000ffc00000 (reserved)
> >  BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
> > 319MB LOWMEM available.
> > On node 0 totalpages: 81856
> > zone(0): 4096 pages.
> > zone(1): 77760 pages.
> > zone(2): 0 pages.
> > Kernel command line: BOOT_IMAGE=2.5.7-p1 ro root=306 console=ttyS0,9600n8 console=tty0
> > Local APIC disabled by BIOS -- reenabling.
> > Found and enabled local APIC!
> > Initializing CPU#0
> > Detected 930.254 MHz processor.
> > Console: colour VGA+ 80x25
> > Calibrating delay loop... 1854.66 BogoMIPS
> > Memory: 321084k/327424k available (1471k kernel code, 5952k reserved, 476k data, 208k init, 0k highmem)
> > Dentry-cache hash table entries: 65536 (order: 7, 524288 bytes)
> > Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
> > Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
> > Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
> > Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
> > CPU: L1 I cache: 16K, L1 D cache: 16K
> > CPU: L2 cache: 256K
> > Intel machine check architecture supported.
> > Intel machine check reporting enabled on CPU#0.
> > CPU: Intel Pentium III (Coppermine) stepping 06
> > Enabling fast FPU save and restore... done.
> > Enabling unmasked SIMD FPU exception support... done.
> > Checking 'hlt' instruction... OK.
> > POSIX conformance testing by UNIFIX
> > enabled ExtINT on CPU#0
> > ESR value before enabling vector: 00000000
> > ESR value after enabling vector: 00000000
> > Using local APIC timer interrupts.
> > calibrating APIC timer ...
> > ..... CPU clock speed is 930.2702 MHz.
> > ..... host bus clock speed is 132.8955 MHz.
> > cpu: 0, clocks: 1328955, slice: 664477
> > CPU0<T0:1328944,T1:664464,D:3,S:664477,C:1328955>
> > mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
> > mtrr: detected mtrr type: Intel
> > Linux NET4.0 for Linux 2.4
> > Based upon Swansea University Computer Society NET3.039
> > Initializing RT netlink socket
> > PCI: PCI BIOS revision 2.10 entry at 0xfda95, last bus=2
> > PCI: Using configuration type 1
> > PCI: Probing PCI hardware
> > Unknown bridge resource 0: assuming transparent
> > PCI: Discovered primary peer bus 08 [IRQ]
> > PCI: Using IRQ router PIIX [8086/2440] at 00:1f.0
> > Starting kswapd
> > BIO: pool of 256 setup, 14Kb (56 bytes/bio)
> > biovec: init pool 0, 1 entries, 12 bytes
> > biovec: init pool 1, 4 entries, 48 bytes
> > biovec: init pool 2, 16 entries, 192 bytes
> > biovec: init pool 3, 64 entries, 768 bytes
> > biovec: init pool 4, 128 entries, 1536 bytes
> > biovec: init pool 5, 256 entries, 3072 bytes
> > Journalled Block Device driver loaded
> > Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
> > ACPI: Core Subsystem version [20011018]
> > ACPI: Subsystem enabled
> > Power Resource: found
> > Power Resource: found
> > Power Resource: found
> > Power Resource: found
> > ACPI: System firmware supports S0 S1 S4 S5
> > Processor[0]: C0 C1
> > ACPI: Power Button (FF) found
> > ACPI: Sleep Button (CM) found
> > pty: 256 Unix98 ptys configured
> > Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
> > ttyS00 at 0x03f8 (irq = 4) is a 16550A
> > Real Time Clock Driver v1.11
> > block: 256 slots per queue, batch=32
> > Linux video capture interface: v1.00
> > Linux agpgart interface v0.99 (c) Jeff Hartmann
> > agpgart: Maximum main memory to use for agp memory: 262M
> > agpgart: Detected Intel i815 chipset
> > agpgart: AGP aperture is 64M @ 0xf8000000
> > Uniform Multi-Platform E-IDE driver ver.:7.0.0
> > ide: system bus speed 33MHz
> > Intel Corp. 82820 820 (Camino 2) Chipset IDE U100: IDE controller on PCI slot 00:1f.1
> > Intel Corp. 82820 820 (Camino 2) Chipset IDE U100: chipset revision 2
> > Intel Corp. 82820 820 (Camino 2) Chipset IDE U100: not 100% native mode: will probe irqs later
> >     ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:DMA
> >     ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
> > hda: QUANTUM FIREBALLlct20 20, ATA DISK drive
> > hdb: SAMSUNG SV2044D, ATA DISK drive
> > hdc: MATSHITADVD-ROM SR-8586, ATAPI CD/DVD-ROM drive
> > ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> > ide1 at 0x170-0x177,0x376 on irq 15
> > blk: queue c034de0c, I/O limit 4095Mb (mask 0xffffffff)
> > hda: 39876480 sectors (20417 MB) w/418KiB Cache, CHS=39560/16/63, UDMA(33)
> > blk: queue c034e02c, I/O limit 4095Mb (mask 0xffffffff)
> > hdb: 39862368 sectors (20410 MB) w/472KiB Cache, CHS=39546/16/63, UDMA(66)
> > Partition check:
> >  hda: [PTBL] [2482/255/63] hda1 hda3 < hda5 hda6 hda7 hda8 hda9 hda10 hda11 hda12 hda13 >
> >  hdb: hdb1 hdb2 hdb3 < hdb5 hdb6 hdb7 hdb8 hdb9 hdb10 >
> > usb.c: registered new driver usbfs
> > usb.c: registered new driver hub
> > uhci.c: USB Universal Host Controller Interface driver v1.1
> > PCI: Found IRQ 3 for device 00:1f.2
> > PCI: Setting latency timer of device 00:1f.2 to 64
> > uhci.c: USB UHCI at I/O 0xef40, IRQ 3
> > hcd.c: new USB bus registered, assigned bus number 1
> > hub.c: USB hub found at /
> > hub.c: 2 ports detected
> > PCI: Found IRQ 9 for device 00:1f.4
> > PCI: Setting latency timer of device 00:1f.4 to 64
> > uhci.c: USB UHCI at I/O 0xef80, IRQ 9
> > hcd.c: new USB bus registered, assigned bus number 2
> > hub.c: USB hub found at /
> > hub.c: 2 ports detected
> > usb.c: registered new driver hid
> > hid-core.c: v1.31:USB HID core driver
> > mice: PS/2 mouse device common for all mice
> > NET4: Linux TCP/IP 1.0 for NET4.0
> > IP Protocols: ICMP, UDP, TCP, IGMP
> > IP: routing cache hash table of 2048 buckets, 16Kbytes
> > TCP: Hash tables configured (established 32768 bind 32768)
> > ip_conntrack (2558 buckets, 20464 max)
> > ip_tables: (C) 2000-2002 Netfilter core team
> > NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> > found reiserfs format "3.5" with standard journal
> > Unable to handle kernel NULL pointer dereference at virtual address 00000010
> >  printing eip:
> > c01362de
> > *pde = 00000000
> > Oops: 0000
> > CPU:    0
> > EIP:    0010:[<c01362de>]    Not tainted
> > EFLAGS: 00010292
> > eax: 00001000   ebx: 0000000e   ecx: 00000008   edx: 00002012
> > esi: 00000008   edi: 00002012   ebp: 00000000   esp: c13edd6c
> > ds: 0018   es: 0018   ss: 0018
> > Process swapper (pid: 1, threadinfo=c13ec000 task=c13ea040)
> > Stack: 00001000 00002012 00000000 d3d09c00 d3d09c00 c0136988 00000000 00002012 
> >        00001000 d3d09c00 d4834000 d48453ec c0136b8f 00000000 00002012 00001000 
> >        d3d09c00 c01b26f6 00000000 00002012 00001000 00000306 00000000 d3d09d54 
> > Call Trace: [<c0136988>] [<c0136b8f>] [<c01b26f6>] [<c0135ab0>] [<c01a4d68>] 
> >    [<c01a562c>] [<c01bc36c>] [<c013b639>] [<c013a310>] [<c01a5a0f>] [<c01a5508>] 
> >    [<c013a4e0>] [<c014ae59>] [<c014b130>] [<c014af74>] [<c014b550>] [<c0105259>] 
> >    [<c0105073>] [<c01055fc>] 
> > Code: 0f b7 45 10 b0 00 66 0f b6 55 10 01 d0 0f b7 c0 89 44 24 10 
> >  <0>Kernel panic: Attempted to kill init!

> --- linux-2.5.6/fs/reiserfs/journal.c.orig	Tue Mar 12 15:25:27 2002
> +++ linux-2.5.6/fs/reiserfs/journal.c	Tue Mar 12 15:26:47 2002
> @@ -1958,8 +1958,7 @@
>        		SB_ONDISK_JOURNAL_DEVICE( super ) ?
>  		to_kdev_t(SB_ONDISK_JOURNAL_DEVICE( super )) : super -> s_dev;	
>  	/* there is no "jdev" option and journal is on separate device */
> -	if( ( !jdev_name || !jdev_name[ 0 ] ) && 
> -	    SB_ONDISK_JOURNAL_DEVICE( super ) ) {
> +	if( ( !jdev_name || !jdev_name[ 0 ] ) ) {
>  		journal -> j_dev_bd = bdget( kdev_t_to_nr( jdev ) );
>  		if( journal -> j_dev_bd )
>  			result = blkdev_get( journal -> j_dev_bd, 
> @@ -1974,9 +1973,6 @@
>  		return result;
>  	}

> -	/* no "jdev" option and journal is on the host device */
> -	if( !jdev_name || !jdev_name[ 0 ] )
> -		return 0;
>  	journal -> j_dev_file = filp_open( jdev_name, 0, 0 );
>  	if( !IS_ERR( journal -> j_dev_file ) ) {
>  		struct inode *jdev_inode;

Alex

-- 
      ALEX|X3JA
   alex@x3ja.co.uk
    ICQ: 1523424
MSN: x3ja@hotmail.com
