Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132991AbRDUWe7>; Sat, 21 Apr 2001 18:34:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132993AbRDUWeu>; Sat, 21 Apr 2001 18:34:50 -0400
Received: from Sarah.SomeSites.com ([208.44.57.7]:17924 "HELO
	Sarah.SomeSites.com") by vger.kernel.org with SMTP
	id <S132991AbRDUWej>; Sat, 21 Apr 2001 18:34:39 -0400
Message-ID: <003a01c0cab3$32d0b7f0$0100a8c0@SomeSites.com>
From: "James Turinsky (LKML)" <lkml@SomeSites.com>
To: <linux-kernel@vger.kernel.org>, <linux-usb-devel@lists.sourceforge.net>
Subject: [PANIC] [UPDATED] USB Zip 250 hangs 2.4.3, panics 2.4.3-ac2,-ac9
Date: Sat, 21 Apr 2001 18:34:14 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message -----
From: "James Turinsky (LKML)" <lkml@somesites.com>
To: <linux-kernel@vger.kernel.org>;
<linux-usb-devel@lists.sourceforge.net>
Sent: Friday, April 20, 2001 4:34 PM
Subject: USB Zip 250 hangs 2.4.3, panics 2.4.3-ac2,-ac9


> [not subbed to linux-usb-devel@lists.sourceforge.net, please mail me
> directly]
>
> Hi all,
>
> I'm having MAJOR problems with using a USB Zip 250 with Linux 2.4.3.
>
> First thing I saw, is under 2.4.3-ac9, I have hotplug support and
> /sbin/hotplug installed, and I plugged it in and it found the drive
> (yay!).  Then I mounted the disk in the drive ( -t vfat -o sync IIRC)
> and tried to copy a chunk of an ISO image sized just under the max of
> the zip disk. BLAMMO! Oops, process: swapper, Kernel panic: Aiee,
> killing interrupt handler! In interrupt handler - not syncing
> (I have the output -- but in pen and ink form and I'm not fit to type
it
> and run it through ksymoops yet.)  This was repeatable at least three
> times.

Here is that ksymoops output, if it's weird, it's because the oops I
fed it was typed manually

ksymoops 2.4.1 on i586 2.4.3-ac9.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.3-ac9/ (default)
     -m /boot/System.map-2.4.3-ac9 (specified)

c01c5f1c
Oops: 0000
CPU: 0
EIP: 0010:[<c01c5f1c>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010006
eax: c0253f34 ebx: c1237de8 ecx: 00000002 edx: 00000000
esi: c64807e0 edi: c1237d60 ebp: c1237de8 esp: c0253f1c
ds: 0018 es: 0018 ss: 0018
Process swapper (pid: 0, stackpage=c0253000)
stack: c12a0340 c01c5ebc 00000000 c0253fa4 00000282 c12a0340 c0253f34
c0253f34
c011a8a2 c12a0340 00000000 c028c5a0 00000000 c0253fa4 c010b8af c0253f8c
c023a3b4 c011787f 00000000 c01177b7 00000000 00000001 c028c5c0 0000000e
call trace: [<c01c5ebc>] [<c011a8a2>] [<c010b8af>] [<c011787f>]
[<c01177b7>]
[<c01176c0>] [<c0107e72>]
[<c0105120>] [<c0106b10>] [<c0105120>] [<c0105143>] [<c01051a7>]
[<c0105000>] [<c0100191>]
Code: f6 42 24 01 74 1e a1 48 54 2a c0 83 c0 fb 2b 42 2c 78 11 56

>>EIP; c01c5f1c <rh_int_timer_do+60/118>   <=====
Trace; c01c5ebc <rh_int_timer_do+0/118>
Trace; c011a8a2 <timer_bh+212/24c>
Trace; c010b8af <timer_interrupt+db/154>
Trace; c011787f <bh_action+1b/60>
Trace; c01177b7 <tasklet_hi_action+3b/60>
Trace; c01176c0 <do_softirq+40/64>
Trace; c0107e72 <do_IRQ+a2/b0>
Trace; c0105120 <default_idle+0/28>
Trace; c0106b10 <ret_from_intr+0/20>
Trace; c0105120 <default_idle+0/28>
Trace; c0105143 <default_idle+23/28>
Trace; c01051a7 <cpu_idle+3f/54>
Trace; c0105000 <init+0/110>
Trace; c0100191 <L6+0/2>
Code;  c01c5f1c <rh_int_timer_do+60/118>
00000000 <_EIP>:
Code;  c01c5f1c <rh_int_timer_do+60/118>   <=====
   0:   f6 42 24 01               testb  $0x1,0x24(%edx)   <=====
Code;  c01c5f20 <rh_int_timer_do+64/118>
   4:   74 1e                     je     24 <_EIP+0x24> c01c5f40
<rh_int_timer_do+84/118>
Code;  c01c5f22 <rh_int_timer_do+66/118>
   6:   a1 48 54 2a c0            mov    0xc02a5448,%eax
Code;  c01c5f27 <rh_int_timer_do+6b/118>
   b:   83 c0 fb                  add    $0xfffffffb,%eax
Code;  c01c5f2a <rh_int_timer_do+6e/118>
   e:   2b 42 2c                  sub    0x2c(%edx),%eax
Code;  c01c5f2d <rh_int_timer_do+71/118>
  11:   78 11                     js     24 <_EIP+0x24> c01c5f40
<rh_int_timer_do+84/118>
Code;  c01c5f2f <rh_int_timer_do+73/118>
  13:   56                        push   %esi

<0>Kernel panic: Aiee, killing interrupt handler!



> Then I booted 2.4.3-ac2 and repeated the behaviour.
>
> [note: -ac2 changelog contains "o Fix shm locking, races on swapping,
> accounting and swapout of already mapped pages (Stephen Tweedie)",
maybe
> that touched something which changed the behaviour between 2.4.3
and -ac
> series?]
>
> I booted 2.4.3 stock and tried the same thing.  Running ls -la on the
> zip mountpoint showed that it did indeed copy part of the file but
> stopped.  cp was in D state and I could not shutdown/halt the system
nor
> umount/eject the disk (and dammit, yanking the power/USB cable just
> dawned on me).  This behaviour was repeatable and the point at which
the
> file ended varied.
>
> I did manage to get a 13MB file copied to a Zip disk by mounting
without
> the '-o sync' and then issuing sync manually after the copy (which
then
> wrote it to disk).
>
> I will type in the Oops output and run it through ksymoops as soon as
> possible.
>
> I won't get access to the machine until Monday but if anyone has
> suggestions on things to try or instructions on how to help debug
this,
> please let me know
>
> Below is the of course standard info/debugging aid. If you want
anything
> else please tell me.
>
> --JT
> Sair LCA, LPIC-1 [I am a certification whore]
>
> Linux version 2.4.3-ac9 (foo) (gcc version 2.95.3 19991030
(prerelease))
> #1 Wed Apr 18 10:53:33 GMT 2001
> BIOS-provided physical RAM map:
>  BIOS-e820: 0000000000000000 - 000000000009e800 (usable)
>  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
>  BIOS-e820: 00000000000f820a - 0000000000100000 (reserved)
>  BIOS-e820: 0000000000100000 - 0000000008000000 (usable)
>  BIOS-e820: 00000000ffff820a - 0000000100000000 (reserved)
> On node 0 totalpages: 32768
> zone(0): 4096 pages.
> zone(1): 28672 pages.
> zone(2): 0 pages.
> No local APIC present or hardware disabled
> Kernel command line: BOOT_IMAGE=linux ro ide=reverse
> ide_setup: ide=reverse : Enabled support for IDE inverse scan order.
> Initializing CPU#0
> Detected 398.625 MHz processor.
> Console: colour dummy device 80x25
> Calibrating delay loop... 796.26 BogoMIPS
> Memory: 126664k/131072k available (1029k kernel code, 4016k reserved,
> 321k data, 216k init, 0k highmem)
> Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
> Buffer-cache hash table entries: 8192 (order: 3, 32768 bytes)
> Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
> Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
> VFS: Diskquotas version dquot_6.5.0 initialized
> CPU: Before vendor init, caps: 008021bf 808029bf 00000000, vendor = 2
> Enabling new style K6 write allocation for 128 Mb
> CPU: L1 I Cache: 32K (32 bytes/line), D cache 32K (32 bytes/line)
> CPU: After vendor init, caps: 008021bf 808029bf 00000000 00000002
> CPU:     After generic, caps: 008021bf 808029bf 00000000 00000002
> CPU:             Common caps: 008021bf 808029bf 00000000 00000002
> CPU: AMD-K6(tm) 3D processor stepping 0c
> Checking 'hlt' instruction... OK.
> POSIX conformance testing by UNIFIX
> mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
> mtrr: detected mtrr type: AMD K6
> PCI: PCI BIOS revision 2.10 entry at 0xfda2e, last bus=0
> PCI: Using configuration type 1
> PCI: Probing PCI hardware
> PCI: Using IRQ router PIIX [8086/7000] at 00:07.0
> Limiting direct PCI/PCI transfers.
> Activating ISA DMA hang workarounds.
> isapnp: Scanning for PnP cards...
> isapnp: Card 'OPL3-SA2 Sound Board'
> isapnp: 1 Plug & Play card detected total
> PnP: PNP BIOS installation structure at 0xc00f7da0
> PnP: PNP BIOS version 1.0, entry at f0000:c6cd, dseg at f0000
> Linux NET4.0 for Linux 2.4
> Based upon Swansea University Computer Society NET3.039
> Starting kswapd v1.8
> Winbond Super-IO detection, now testing ports 3F0,370,250,4E,2E ...
> SMSC Super-IO detection, now testing Ports 2F0, 370 ...
> PnPBIOS: Parport found PNPBIOS PNP0401 at io=0378,0778 irq=7 dma=3
> 0x378: FIFO is 16 bytes
> 0x378: writeIntrThreshold is 8
> 0x378: readIntrThreshold is 8
> 0x378: PWord is 8 bits
> 0x378: Interrupts are ISA-Pulses
> 0x378: ECP port cfgA=0x10 cfgB=0x4b
> 0x378: ECP settings irq=7 dma=3
> parport0: PC-style at 0x378 (0x778), irq 7, dma 3
> [PCSPP,TRISTATE,COMPAT,ECP,DMA]
> parport0: cpp_daisy: aa5500ff(38)
> parport0: assign_addrs: aa5500ff(38)
> parport0: cpp_daisy: aa5500ff(38)
> parport0: assign_addrs: aa5500ff(38)
> *NEW* atyfb: mach64VTA4 (ATI264VT) [0x5654 rev 0x40] 2M EDO, 14.31818
> MHz XTAL, 200 MHz PLL, 63 Mhz MCLK
> Console: switching to colour frame buffer device 80x25
> fb0: ATY Mach64 frame buffer device on PCI
> vesafb: abort, cannot reserve video memory at 0xfd000000
> Detected PS/2 Mouse Port.
> pty: 256 Unix98 ptys configured
> block: queued sectors max/low 84042kB/28014kB, 256 slots per queue
> Uniform Multi-Platform E-IDE driver Revision: 6.31
> ide: Assuming 33MHz system bus speed for PIO modes; override with
> idebus=xx
> PDC20262: IDE controller on PCI bus 00 dev 88
> PCI: Found IRQ 11 for device 00:11.0
> PDC20262: chipset revision 1
> PDC20262: not 100% native mode: will probe irqs later
> PDC20262: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI
Mode.
>     ide0: BM-DMA at 0xfcc0-0xfcc7, BIOS settings: hda:DMA, hdb:DMA
>     ide1: BM-DMA at 0xfcc8-0xfccf, BIOS settings: hdc:DMA, hdd:pio
> PIIX3: IDE controller on PCI bus 00 dev 39
> PIIX3: chipset revision 0
> PIIX3: not 100% native mode: will probe irqs later
>     ide2: BM-DMA at 0xfc90-0xfc97, BIOS settings: hde:pio, hdf:pio
>     ide3: BM-DMA at 0xfc98-0xfc9f, BIOS settings: hdg:pio, hdh:pio
> hda: IBM-DTTA-371010, ATA DISK drive
> hdc: NEC CD-ROM DRIVE:282, ATAPI CD/DVD-ROM drive
> ide0 at 0xf4f0-0xf4f7,0xfc8a on irq 11
> ide1 at 0xf4f8-0xf4ff,0xfc8e on irq 11
> hda: 19746720 sectors (10110 MB) w/465KiB Cache, CHS=19590/16/63,
> UDMA(33)
> hdc: ATAPI 8X CD-ROM drive, 128kB Cache
> Uniform CD-ROM driver Revision: 3.12
> Partition check:
>  /dev/ide/host0/bus0/target0/lun0: p1 p2 p3
> Floppy drive(s): fd0 is 1.44M
> FDC 0 is a post-1991 82077
> devfs: v0.102 (20000622) Richard Gooch (rgooch@atnf.csiro.au)
> devfs: boot_options: 0x0
> Serial driver version 5.05a (2001-03-20) with MANY_PORTS SHARE_IRQ
> DETECT_IRQ SERIAL_PCI ISAPNP enabled
> ttyS01 at 0x02f8 (irq = 3) is a 16550A
> ttyS02 at 0x03e8 (irq = 4) is a 16550A
> Real Time Clock Driver v1.10d
> usb.c: registered new driver usbdevfs
> usb.c: registered new driver hub
> PCI: Enabling device 00:07.2 (0004 -> 0005)
> PCI: Found IRQ 9 for device 00:07.2
> uhci.c: USB UHCI at I/O 0xfca0, IRQ 9
> usb.c: new USB bus registered, assigned bus number 1
> hub.c: USB hub found
> hub.c: 2 ports detected
> mice: PS/2 mouse device common for all mice
> NET4: Linux TCP/IP 1.0 for NET4.0
> IP Protocols: ICMP, UDP, TCP, IGMP
> IP: routing cache hash table of 1024 buckets, 8Kbytes
> TCP: Hash tables configured (established 8192 bind 8192)
> NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> VFS: Mounted root (ext2 filesystem) readonly.
> Mounted devfs on /dev
> Freeing unused kernel memory: 216k freed
> hub.c: USB new device connect on bus1/1, assigned device number 2
> usb.c: USB device 2 (vend/prod 0x59b/0x30) is not claimed by any
active
> driver.
> SCSI subsystem driver Revision: 1.00
> Initializing USB Mass Storage driver...
> usb.c: registered new driver usb-storage
> scsi0 : SCSI emulation for USB Mass Storage devices
>   Vendor: IOMEGA    Model: ZIP 250           Rev: 32.G
>   Type:   Direct-Access                      ANSI SCSI revision: 02
> WARNING: USB Mass Storage data integrity not assured
> USB Mass Storage device found at 2
> USB Mass Storage support registered.
> Adding Swap: 262576k swap-space (priority -1)
> Attached scsi removable disk sda at scsi0, channel 0, id 0, lun 0
> SCSI device sda: 489532 512-byte hdwr sectors (251 MB)
> sda: Write Protect is off
>  /dev/scsi/host0/bus0/target0/lun0: p4
> PCI: Enabling device 00:13.0 (0014 -> 0017)
> PCI: Found IRQ 10 for device 00:13.0
> 3c59x.c:LK1.1.13 27 Jan 2001  Donald Becker and others.
> http://www.scyld.com/network/vortex.html
> See Documentation/networking/vortex.txt
> eth0: 3Com PCI 3c905B Cyclone 100baseTx at 0xfc00,  00:10:4b:32:1b:4e,
> IRQ 10
>   product code 4e42 rev 00.0 date 01-30-98
>   8K byte-wide RAM 5:3 Rx:Tx split, autoselect/Autonegotiate
interface.
>   MII transceiver found at address 24, status 782d.
>   Enabling bus-master transmits and whole-frame receives.
> eth0: scatter/gather enabled. h/w checksums enabled
> eth0: using NWAY device table, not 8
> lp0: using parport0 (interrupt-driven).
> lp0: console ready
>
> Module                  Size  Used by
> lp                      5408   1  (autoclean)
> 3c59x                  23232   1  (autoclean)
> sd_mod                  9920   1  (autoclean)
> usb-storage            21296   1
> scsi_mod               77648   2  [sd_mod usb-storage]
>
>
> 00:07.2 USB Controller: Intel Corporation 82371SB PIIX3 USB
> [Natoma/Triton II] (rev 01) (prog-if 00 [UHCI])
> Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B-
> Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
> Latency: 64
> Interrupt: pin D routed to IRQ 9
> Region 4: I/O ports at fca0 [size=32]
>
> /proc/bus/usb/devices:
> T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
> B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
> D:  Ver= 1.00 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
> P:  Vendor=0000 ProdID=0000 Rev= 0.00
> S:  Product=USB UHCI-alt Root Hub
> S:  SerialNumber=fca0
> C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
> I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
> E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=255ms
> T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=12  MxCh= 0
> D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
> P:  Vendor=059b ProdID=0030 Rev= 1.00
> S:  Manufacturer=Iomega
> S:  Product=USB Zip 250
> S:  SerialNumber=059B00300D002999
> C:* #Ifs= 1 Cfg#= 1 Atr=c0 MxPwr=  0mA
> I:  If#= 0 Alt= 0 #EPs= 3 Cls=08(stor.) Sub=06 Prot=50
> Driver=usb-storage
> E:  Ad=01(O) Atr=02(Bulk) MxPS=  64 Ivl=  0ms
> E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=  0ms
> E:  Ad=83(I) Atr=03(Int.) MxPS=   2 Ivl= 32ms
>
> -
> To unsubscribe from this list: send the line "unsubscribe
linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

