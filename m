Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290192AbSAQT2n>; Thu, 17 Jan 2002 14:28:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290199AbSAQT2j>; Thu, 17 Jan 2002 14:28:39 -0500
Received: from exchange-public.alexa.com ([209.247.255.131]:31752 "EHLO
	shockG.archive.alexa.com") by vger.kernel.org with ESMTP
	id <S290192AbSAQT23>; Thu, 17 Jan 2002 14:28:29 -0500
Message-ID: <A6CFEF730CCE38449F1774A6B5D62B0C0319BB@shockG.archive.alexa.com>
From: Guolin Cheng <Guolin@alexa.com>
To: "'ebiederman@lnxi.com'" <ebiederman@lnxi.com>
Cc: linux-kernel@vger.kernel.org,
        Etherboot-users <etherboot-users@lists.sourceforge.net>,
        Ops <Ops@alexa.com>
Subject: RE: [Etherboot-users] 1G memory limit and Etherboot
Date: Thu, 17 Jan 2002 11:27:17 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Eric,

  The error messages are attached, which is output when I set mknbi options
--rdbase=0x37BF0000:

  The basic configuration/facts are:

	 HP Vectra 420VL  DT
	 1.6G Pentium 4, 1.5G memory, 
	 RedHat 7.1 base system, 2.4.16 kernel, with CONFIG_HIMEM4G option
set.
	 The initrd file size is 20828KB compressed,  After gunzip it is
64M, which contains all the /, except /var and /usr.
	 The Etherboot is version 5.02 (5.04 also can not work neither).
	 mknbi is version 1.2.6.
	The options gave to mknbi are:
        /usr/bin/mknbi-linux --output=${KERNEL_OUTPUT} --ip=dhcp
--rdbase=0x37BF0000 --rootdir=/dev/ram0   --append="mem=1536M" vmlinuz
initrd.img 
 	(--rdbase=top/asis options can not work, while --rdbase=0x36BA9000
works !!!!!, which means 0x38000000 - 20828k of initrd size!!  )
		
  My questions are:

	1, Where comes the number 0x38000000, which is 896M? ( I enabled
CONFIG_HIMEM4G in kernel configuration)
	2, Why kernel reports 640M HIMEM? ( if I don't enable "mem=1536M" in
kernel command line, it will reports 639M HIMEM)  why not report 1536M total
memory?
	3, Why it reports 4 pages (pages 000fb000 / 000fc000 / 000f5000 /
000f6000) reserved twice?  Which kernel parts reserves it? and for which
purpose? Since it I boot the same machine using local hard drive, it will
disappears.
	4, Do you think we need to upgrade mknbi and etherboot packages?
Because I think using --rdbase=0x??? is not an elegant solution. The system
should automatically detected the memory and find a good position to store
the compressed initrd file.  Otherwise everytime I change the memory of a
box, or I changed the contents of initrd, I have to calculate the size for
--rdbase option again and again.

     Thanks a lot.


    Yours sincerely,
    Guolin Cheng
    Alexa Internet Inc.
   (415) 561-6021
   guolin@alexa.com
	

		
	

	

	

  Linux version 2.4.16 (root@linux-test.alexa.com) (gcc version 2.96
20000731 (Red
 Hat Linux 7.1 2.96-81)) #1 Tue Dec 18 11:40:51 PST 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000c0000 - 00000000000c4000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000005fff0000 (usable)
 BIOS-e820: 000000005fff0000 - 000000005fff8000 (ACPI data)
 BIOS-e820: 000000005fff8000 - 0000000060000000 (ACPI NVS)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
640MB HIGHMEM available.
found SMP MP-table at 000fb6b0
hm, page 000fb000 reserved twice.
hm, page 000fc000 reserved twice.
hm, page 000f5000 reserved twice.
hm, page 000f6000 reserved twice.
initrd extends beyond end of memory (0x39047000 > 0x38000000)
disabling initrd
On node 0 totalpages: 393216
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 163840 pages.
Intel MultiProcessor Specification v1.1
    Virtual Wire compatibility mode.
OEM ID: INTEL    Product ID: I845         APIC at: 0xFEE00000
Processor #0 Pentium 4(tm) APIC version 20
I/O APIC #2 Version 32 at 0xFEC00000.
Processors: 1
Kernel command line: rw root=/dev/ram0 ip=dhcp rdbase= mem=1536M
Initializing CPU#0
Detected 1594.118 MHz processor.
Calibrating delay loop... 3178.49 BogoMIPS
Memory: 1544892k/1572864k available (1603k kernel code, 27584k reserved,
513k da
ta, 496k init, 655360k highmem)
Dentry-cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Mount-cache hash table entries: 32768 (order: 6, 262144 bytes)
Buffer-cache hash table entries: 131072 (order: 7, 524288 bytes)
Page-cache hash table entries: 524288 (order: 9, 2097152 bytes)
CPU: L1 I cache: 12K, L1 D cache: 8K
CPU: L2 cache: 256K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel(R) Pentium(R) 4 CPU 1600MHz stepping 0a
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
..TIMER: vector=0x31 pin1=2 pin2=0
testing the IO APIC.......................

.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1594.1459 MHz.
..... host bus clock speed is 99.6339 MHz.
cpu: 0, clocks: 996339, slice: 498169
CPU0<T0:996336,T1:498160,D:7,S:498169,C:996339>
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfdab1, last bus=2
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
PCI: Using IRQ router PIIX [8086/2440] at 00:1f.0
PCI->APIC IRQ transform: (B0,I31,P3) -> 19
PCI->APIC IRQ transform: (B0,I31,P1) -> 17
PCI->APIC IRQ transform: (B0,I31,P2) -> 23
PCI->APIC IRQ transform: (B0,I31,P1) -> 17
PCI->APIC IRQ transform: (B2,I8,P0) -> 20
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd
allocated 32 pages and 32 bhs reserved for the highmem bounces
VFS: Diskquotas version dquot_6.4.0 initialized
Journalled Block Device driver loaded
pty: 2048 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
SERIAL_PCI IS
APNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
block: 128 slots per queue, batch=32
RAMDISK driver initialized: 16 RAM disks of 131072K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev f9
PIIX4: chipset revision 18
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:DMA
hda: IC35L020AVER07-0, ATA DISK drive
hdc: Maxtor 4G160J8, ATA DISK drive
hdd: Maxtor 4G120J6, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 39851760 sectors (20404 MB) w/1916KiB Cache, CHS=2480/255/63, UDMA(100)
hdc: 320173056 sectors (163929 MB) w/2048KiB Cache, CHS=83705/255/63,
UDMA(100)
hdd: 240121728 sectors (122942 MB) w/2048KiB Cache, CHS=58853/255/63,
UDMA(100)
Partition check:
 hda: hda1 hda2 < hda5 hda6 hda7 hda8 hda9 hda10 hda11 >
 hdc: hdc1
 hdd: hdd1
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
loop: loaded (max 8 devices)
eepro100.c:v1.09j-t 9/29/99 Donald Becker
http://cesdis.gsfc.nasa.gov/linux/driv
ers/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin
<saw@sa
w.sw.com.sg> and others
eth0: Intel Corp. 82820 (ICH2) Chipset Ethernet Controller,
00:04:23:06:DE:32, I
RQ 20.
  Board assembly 000000-000, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 816M
agpgart: Detected Intel i845 chipset
agpgart: AGP aperture is 64M @ 0xe0000000
[drm] AGP 0.99 on Intel i845 @ 0xe0000000 64MB
[drm] Initialized i810 1.1.0 20010616 on minor 0
SCSI subsystem driver Revision: 1.00
request_module[scsi_hostadapter]: Root fs not mounted
usb.c: registered new driver hub
uhci.c: USB Universal Host Controller Interface driver v1.1
PCI: Setting latency timer of device 00:1f.2 to 64
uhci.c: USB UHCI at I/O 0xd000, IRQ 19
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Setting latency timer of device 00:1f.4 to 64
uhci.c: USB UHCI at I/O 0xd400, IRQ 23
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
Initializing USB Mass Storage driver...
usb.c: registered new driver usb-storage
USB Mass Storage support registered.
md: linear personality registered as nr 1
md: raid0 personality registered as nr 2
md: raid1 personality registered as nr 3
md: raid5 personality registered as nr 4
raid5: measuring checksumming speed
   8regs     :  1877.200 MB/sec
   32regs    :  1130.000 MB/sec
   pIII_sse  :  2069.200 MB/sec
   pII_mmx   :  1880.000 MB/sec
   p5_mmx    :  1851.200 MB/sec
raid5: using function: pIII_sse (2069.200 MB/sec)
md: multipath personality registered as nr 7
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
LVM version 1.0.1-rc4(ish)(03/10/2001)
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 16384 buckets, 128Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
Sending DHCP requests ., OK
IP-Config: Got DHCP answer from 10.0.7.22, my address is 10.0.7.206
IP-Config: Complete:
      device=eth0, addr=10.0.7.206, mask=255.0.0.0, gw=10.0.0.2,
     host=bigdrive-test.alexa.com, domain=alexa.com, nis-domain=alexa.com,
     bootserver=10.0.7.22, rootserver=10.0.7.22, rootpath=
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Kernel panic: VFS: Unable to mount root fs on 01:00
 
  

-----Original Message-----
From: ebiederman@lnxi.com [mailto:ebiederman@lnxi.com]
Sent: Tuesday, December 18, 2001 10:55 AM
To: Guolin Cheng
Cc: linux-kernel@vger.kernel.org; Etherboot-users
Subject: Re: [Etherboot-users] 1G memory limit and Etherboot


Guolin Cheng <Guolin@alexa.com> writes:

> hi, Eric,
> 
>  I tried a few days ago, using etherboot 5.0.2, mknbi 1.2.6 with different
> --rdbase options, but all failed. The kernel is 2.4.13, the initrd is
around
> 64M. 

Unless something regressed 2.4.13 should be fairly robust in this
regard.
 
>  The netbooted client is a 1.5G memory HP Vectra 420. It can successfully
> netbooted with 512M memory. But can not boot when memory is added to 1024M
> and 1.5G.
> 
>  The error prompt is something like:
> 
> 	Kernel panic: VFS: Unable to mount root fs on 01:00

Which just means it couldn't find your ramdisk.  If you could please
report all of your kernel messages.  A serial console is ideal for that
purpose.  Without more information I cannot even guess why you are having
problems.

>  I'm using Official kernel 2.4.13, the base system is RedHat 7.1 on HP
> vectra 420.
> 
>  The commands I used to create the tagged images is:
> 
>  /usr/bin/mknbi-linux --output=./kernel.test.0540 --ip=dhcp
> --rdbase=0x5b000000 --rootdir=/dev/ram0 --append="idebus=66 ide0=ata66
> ide1=ata66 ro" bzImage initrd
> 
>  I also tried options, --rdbase=top/asis/0x00300000, all can failed with
the
> same above problem.
> 
>  At last I use local hard disk boot, with the same kernel (4G high memory
> option enabled), it can boot successfully, then I tried to see the memory
> mapping, and get the following information:
> 
[snip]
> 
>  Please suggest which method, I can try to netboot the machine. Thanks a
> lot.


Eric
