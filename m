Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267133AbTAHVcP>; Wed, 8 Jan 2003 16:32:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267457AbTAHVcO>; Wed, 8 Jan 2003 16:32:14 -0500
Received: from fmr01.intel.com ([192.55.52.18]:2758 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S267133AbTAHVcF>;
	Wed, 8 Jan 2003 16:32:05 -0500
Message-ID: <007d01c2b758$c73d17b0$79d40a0a@amr.corp.intel.com>
From: "Rusty Lynch" <rusty@linux.co.intel.com>
To: "Rusty Lynch" <rusty@linux.co.intel.com>,
       "Scott Murray" <scottm@somanetworks.com>
Cc: <greg@kroah.com>, <harold.yang@intel.com>, <linux-kernel@vger.kernel.org>,
       <pcihpd-discuss@lists.sourceforge.net>
References: <Pine.LNX.4.44.0301081453520.15466-100000@rancor.yyz.somanetworks.com> <005f01c2b756$b42a59a0$79d40a0a@amr.corp.intel.com>
Subject: Re: [Pcihpd-discuss] Re:[BUG] cpci patch for kernel 2.4.19 bug
Date: Wed, 8 Jan 2003 12:59:04 -0800
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_007A_01C2B715.B8E903B0"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_007A_01C2B715.B8E903B0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Just realized that the data I attached was for a 2.5.54
kernel with my patch to register both cpci buses.  Here
is the same output for a normal 2.5.54 kernel.

I also added my dmesg.

    --rustyl

From: "Rusty Lynch" <rusty@linux.co.intel.com>
> From: "Scott Murray" <scottm@somanetworks.com>
> > On Wed, 8 Jan 2003, Rusty Lynch wrote:
> > 
> > > From: "Yang, Harold" <harold.yang@intel.com>
> > > > 
> > > > Hi, Scott & Greg:
> > > > 
> > > > I have applied the cpci patch for kernel 2.4.19, and test it
> > > > thoroughly on ZT5084 platform. Two bugs are found:
> > > > 
> > > > 1. In my ZT5084, the driver can't correctly detect the cPCI
> > > >    Hot Swap bridge device. Two DEC21154 exist on ZT5084,
> > > >    however, only one is the right bridge. The driver can't 
> > > >    distinguish them correctly.
> > > 
> > > I just got a couple of ZT5541 peripheral master boards
> > > and can finally see what happens when an enumerable board
> > > is plugged into a ZT5084 chassis using a ZT5550 system master 
> > > board.
> > > 
> > > As of yet I have only tried a 2.5.54 kernel, but I see the 
> > > same problems along with some other wacky behavior that I 
> > > am trying to isolate.
> > > 
> > > Now about the multiple DEC21154 devices ==>  on my ZT5550 that
> > > is in system master mode, the first DEC21154 device is a bridge
> > > for the slots to the left of the system slots, and the second
> > > DEC21154 is a bridge for the right of the system slots.
> > 
> > Okay, that's what I originally wanted to determine from the lspci
> > output I requested when Harold mentioned this problem at the end
> > of November.
> > 
> 
> I am attaching output for:
> 1. lspci -vvv
> 2. cat /proc/ioports
> 3. cat /proc/iomem
> 
> For a ZT5550 running as system master in the second system slot
> of a ZT5084 chassis that has two ZT5541 (peripherial master) boards
> plugged in (one to the left of the sytem slots and the other to 
> the right of the system slots.)
> 
> > > So if I boot the system master (I'll talk about problems with 
> > > hotswaping in another email) with a peripheral board plugged
> > > into one of the slots on the right of the master using the
> > > current 2.5.54 kernel then I run into problems the first time 
> > > cpci_hotplug_core.c::check_slots() runs because it only looks
> > > at the first bus when trying to find the card that caused the
> > > #ENUM.
> > 
> > I assume by problems you mean that the cPCI event thread gets
> > shut down (which is what I'd expect), or do you mean something more 
> > severe?
> > 
> 
> The event thread shutsdown with the 
> "cannot find ENUM# source, shutting down" error message.  That's all.
> 
> > > The following patch will register each of the cpci busses instead
> > > of just the first one detected.
> > 
> > Your patch is better than Harold's hack, but I'm probably going to
> > try and think of some other alternative, as the while loop idea
> > doesn't handle the possibility of someone having a 21154 bridge
> > on a PMC card or actually as a bridge on a cPCI card.  The original
> > code doesn't really handle that possiblity either, so I'll need to
> > cook up something better anyway.
> > 
> > > NOTE: I'm a little worried that the right way to do this is to
> > >       properly initialize the RSS bits, or at least see how the
> > >       chassis is configured via the RSS bits to determine which 
> > >       cpci bus to register.  The ZT5084 doesn't have near as many
> > >       configurations as newer designs like the ZT5088.
> > [snip]
> > 
> > I will investigate reading the active bus(es) out of the HC, as I've
> > gotten the documentation for the HC from Performance Tech, I was just
> > too busy before Christmas to dig into it then.  I'll try and have
> > something that attempts to handle your ZT5084 chassis done in a few
> > days.
> > 
> > Scott
> 
------=_NextPart_000_007A_01C2B715.B8E903B0
Content-Type: application/octet-stream;
	name="dmesg.log"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="dmesg.log"

Linux version 2.5.54 (rusty@cpci-b) (gcc version 3.2 20020903 (Red Hat =
Linux 8.0 3.2-7)) #2 SMP Wed Jan 8 12:46:53 PST 2003=0A=
Video mode to be used for restore is ffff=0A=
BIOS-provided physical RAM map:=0A=
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)=0A=
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)=0A=
 BIOS-e820: 00000000000e7400 - 0000000000100000 (reserved)=0A=
 BIOS-e820: 0000000000100000 - 0000000010000000 (usable)=0A=
 BIOS-e820: 00000000fffc0000 - 0000000100000000 (reserved)=0A=
256MB LOWMEM available.=0A=
On node 0 totalpages: 65536=0A=
  DMA zone: 4096 pages, LIFO batch:1=0A=
  Normal zone: 61440 pages, LIFO batch:15=0A=
  HighMem zone: 0 pages, LIFO batch:1=0A=
ACPI: Unable to locate RSDP=0A=
Building zonelist for node : 0=0A=
Kernel command line: auto BOOT_IMAGE=3Dhack2 ro BOOT_FILE=3D/boot/hack2 =
debug=3D1=0A=
Local APIC disabled by BIOS -- reenabling.=0A=
Could not enable APIC!=0A=
Initializing CPU#0=0A=
PID hash table entries: 2048 (order 11: 16384 bytes)=0A=
Detected 498.539 MHz processor.=0A=
Console: colour VGA+ 80x25=0A=
Calibrating delay loop... 985.08 BogoMIPS=0A=
Memory: 255512k/262144k available (2038k kernel code, 5892k reserved, =
808k data, 120k init, 0k highmem)=0A=
Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)=0A=
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)=0A=
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)=0A=
-> /dev=0A=
-> /dev/console=0A=
-> /root=0A=
CPU: L1 I cache: 16K, L1 D cache: 16K=0A=
CPU: L2 cache: 256K=0A=
CPU serial number disabled.=0A=
CPU:     After generic, caps: 0383f9ff 00000000 00000000 00000000=0A=
Enabling fast FPU save and restore... done.=0A=
Enabling unmasked SIMD FPU exception support... done.=0A=
Checking 'hlt' instruction... OK.=0A=
POSIX conformance testing by UNIFIX=0A=
CPU0: Intel Pentium III (Coppermine) stepping 03=0A=
per-CPU timeslice cutoff: 730.93 usecs.=0A=
task migration cache decay timeout: 1 msecs.=0A=
SMP motherboard not detected.=0A=
Local APIC not detected. Using dummy APIC emulation.=0A=
Starting migration thread for cpu 0=0A=
CPUS done 2=0A=
Linux NET4.0 for Linux 2.4=0A=
Based upon Swansea University Computer Society NET3.039=0A=
Initializing RT netlink socket=0A=
device class 'cpu': registering=0A=
device class cpu: adding driver system:cpu=0A=
PCI: PCI BIOS revision 2.10 entry at 0xfd89e, last bus=3D3=0A=
PCI: Using configuration type 1=0A=
device class cpu: adding device CPU 0=0A=
interfaces: adding device CPU 0=0A=
BIO: pool of 256 setup, 14Kb (56 bytes/bio)=0A=
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)=0A=
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)=0A=
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)=0A=
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)=0A=
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)=0A=
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)=0A=
ACPI: Subsystem revision 20021217=0A=
ACPI: System description tables not found=0A=
    ACPI-0065: *** Error: acpi_load_tables: Could not get RSDP, =
AE_NOT_FOUND=0A=
    ACPI-0115: *** Error: acpi_load_tables: Could not load tables: =
AE_NOT_FOUND=0A=
ACPI: Unable to load the System Description Tables=0A=
Linux Plug and Play Support v0.93 (c) Adam Belay=0A=
block request queues:=0A=
 128 requests per read queue=0A=
 128 requests per write queue=0A=
 8 requests per batch=0A=
 enter congestion at 31=0A=
 exit congestion at 33=0A=
ACPI: ACPI tables contain no PCI IRQ routing entries=0A=
PCI: Invalid ACPI-PCI IRQ routing table=0A=
PCI: Probing PCI hardware=0A=
PCI: Probing PCI hardware (bus 00)=0A=
PCI: Using IRQ router PIIX [8086/7110] at 00:07.0=0A=
PCI: Cannot allocate resource region 4 of device 00:07.1=0A=
IA-32 Microcode Update Driver: v1.11 <tigran@veritas.com>=0A=
Enabling SEP on CPU 0=0A=
aio_setup: sizeof(struct page) =3D 40=0A=
Journalled Block Device driver loaded=0A=
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).=0A=
Limiting direct PCI/PCI transfers.=0A=
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled=0A=
ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A=0A=
ttyS1 at I/O 0x2f8 (irq =3D 3) is a 16550A=0A=
device class 'tty': registering=0A=
pty: 256 Unix98 ptys configured=0A=
Real Time Clock Driver v1.11=0A=
Non-volatile memory driver v1.2=0A=
Linux agpgart interface v0.100 (c) Dave Jones=0A=
[drm] Initialized r128 2.3.0 20021029 on minor 0=0A=
Linux Tulip driver version 1.1.13 (May 11, 2002)=0A=
PCI: Found IRQ 11 for device 00:05.0=0A=
PCI: Sharing IRQ 11 with 02:0d.0=0A=
tulip0:  EEPROM default media type Autosense.=0A=
tulip0:  Index #0 - Media 10baseT (#0) described by a 21142 Serial PHY =
(2) block.=0A=
tulip0:  Index #1 - Media 10baseT-FDX (#4) described by a 21142 Serial =
PHY (2) block.=0A=
tulip0:  Index #2 - Media 10base2 (#1) described by a 21142 Serial PHY =
(2) block.=0A=
tulip0:  Index #3 - Media AUI (#2) described by a 21142 Serial PHY (2) =
block.=0A=
tulip0:  Index #4 - Media MII (#11) described by a 21142 MII PHY (3) =
block.=0A=
tulip0:  MII transceiver #0 config 1000 status 782d advertising 01e1.=0A=
eth0: Digital DS21143 Tulip rev 65 at 0x1080, 00:80:50:02:73:75, IRQ 11.=0A=
PCI: Found IRQ 10 for device 00:06.0=0A=
PCI: Sharing IRQ 10 with 03:0a.0=0A=
tulip1:  EEPROM default media type Autosense.=0A=
tulip1:  Index #0 - Media 10baseT (#0) described by a 21142 Serial PHY =
(2) block.=0A=
tulip1:  Index #1 - Media 10baseT-FDX (#4) described by a 21142 Serial =
PHY (2) block.=0A=
tulip1:  Index #2 - Media 10base2 (#1) described by a 21142 Serial PHY =
(2) block.=0A=
tulip1:  Index #3 - Media AUI (#2) described by a 21142 Serial PHY (2) =
block.=0A=
tulip1:  Index #4 - Media MII (#11) described by a 21142 MII PHY (3) =
block.=0A=
tulip1:  MII transceiver #0 config 1000 status 782d advertising 01e1.=0A=
eth1: Digital DS21143 Tulip rev 65 at 0x1400, 00:80:50:02:73:76, IRQ 10.=0A=
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2=0A=
ide: Assuming 33MHz system bus speed for PIO modes; override with =
idebus=3Dxx=0A=
hda: IBM-DJSA-210, ATA DISK drive=0A=
hdc: CD-224E, ATAPI CD/DVD-ROM drive=0A=
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14=0A=
ide1 at 0x170-0x177,0x376 on irq 15=0A=
hda: host protected area =3D> 1=0A=
hda: 19640880 sectors (10056 MB) w/384KiB Cache, CHS=3D19485/16/63=0A=
 hda: hda1 hda2 hda3=0A=
hdc: ATAPI 24X CD-ROM drive, 128kB Cache=0A=
Uniform CD-ROM driver Revision: 3.12=0A=
end_request: I/O error, dev hdc, sector 0=0A=
device class 'input': registering=0A=
register interface 'mouse' with class 'input'=0A=
mice: PS/2 mouse device common for all mice=0A=
input: PC Speaker=0A=
input: PS/2 Generic Mouse on isa0060/serio1=0A=
serio: i8042 AUX port at 0x60,0x64 irq 12=0A=
input: AT Set 2 keyboard on isa0060/serio0=0A=
serio: i8042 KBD port at 0x60,0x64 irq 1=0A=
cpci_hotplug: CompactPCI Hot Plug Core version: 0.2=0A=
pci_hotplug: PCI Hot Plug PCI Core version: 0.5=0A=
cpcihp_zt5550: ZT5550 CompactPCI Hot Plug Driver version: 0.2=0A=
NET4: Linux TCP/IP 1.0 for NET4.0=0A=
IP: routing cache hash table of 1024 buckets, 16Kbytes=0A=
TCP: Hash tables configured (established 8192 bind 10922)=0A=
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.=0A=
cpci_hotplug: cannot find ENUM# source, shutting down=0A=
kjournald starting.  Commit interval 5 seconds=0A=
EXT3-fs: mounted filesystem with ordered data mode.=0A=
VFS: Mounted root (ext3 filesystem) readonly.=0A=
Freeing unused kernel memory: 120k freed=0A=
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,2), internal journal=0A=
Adding 514072k swap on /dev/hda3.  Priority:-1 extents:1=0A=
eth0: Setting full-duplex based on MII#0 link partner capability of 45e1.=0A=
spurious 8259A interrupt: IRQ7.=0A=
eth1: Setting full-duplex based on MII#0 link partner capability of 01e1.=0A=
warning: process `update' used the obsolete bdflush system call=0A=
Fix your initscripts?=0A=
warning: process `update' used the obsolete bdflush system call=0A=
Fix your initscripts?=0A=

------=_NextPart_000_007A_01C2B715.B8E903B0
Content-Type: text/plain;
	name="lspci_system_master.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="lspci_system_master.txt"

00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge =
(rev 03)=0A=
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR+ FastB2B-=0A=
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort+ >SERR- <PERR-=0A=
	Latency: 64=0A=
	Region 0: Memory at f8000000 (32-bit, prefetchable) [size=3D64M]=0A=
	Capabilities: [a0] AGP version 1.0=0A=
		Status: RQ=3D31 SBA+ 64bit- FW- Rate=3Dx1,x2=0A=
		Command: RQ=3D0 SBA- AGP- 64bit- FW- Rate=3D<none>=0A=
=0A=
00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge =
(rev 03) (prog-if 00 [Normal decode])=0A=
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop- ParErr- =
Stepping- SERR+ FastB2B-=0A=
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
	Latency: 128=0A=
	Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D64=0A=
	I/O behind bridge: 0000f000-00000fff=0A=
	Memory behind bridge: f5000000-f5ffffff=0A=
	Prefetchable memory behind bridge: fff00000-000fffff=0A=
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B+=0A=
=0A=
00:05.0 Ethernet controller: Digital Equipment Corporation DECchip =
21142/43 (rev 41)=0A=
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- =
Stepping- SERR+ FastB2B-=0A=
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
	Latency: 165 (5000ns min, 10000ns max), cache line size 08=0A=
	Interrupt: pin A routed to IRQ 11=0A=
	Region 0: I/O ports at 1080 [size=3D128]=0A=
	Region 1: Memory at f4001000 (32-bit, non-prefetchable) [size=3D1K]=0A=
	Expansion ROM at <unassigned> [disabled] [size=3D256K]=0A=
=0A=
00:06.0 Ethernet controller: Digital Equipment Corporation DECchip =
21142/43 (rev 41)=0A=
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- =
Stepping- SERR+ FastB2B-=0A=
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
	Latency: 165 (5000ns min, 10000ns max), cache line size 08=0A=
	Interrupt: pin A routed to IRQ 10=0A=
	Region 0: I/O ports at 1400 [size=3D128]=0A=
	Region 1: Memory at f4001400 (32-bit, non-prefetchable) [size=3D1K]=0A=
	Expansion ROM at <unassigned> [disabled] [size=3D256K]=0A=
=0A=
00:07.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)=0A=
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-=0A=
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
	Latency: 0=0A=
=0A=
00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01) =
(prog-if 80 [Master])=0A=
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-=0A=
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
	Latency: 64=0A=
	Region 4: I/O ports at 14a0 [size=3D16]=0A=
=0A=
00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01) =
(prog-if 00 [UHCI])=0A=
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-=0A=
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
	Latency: 64=0A=
	Interrupt: pin D routed to IRQ 9=0A=
	Region 4: I/O ports at 1060 [size=3D32]=0A=
=0A=
00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 02)=0A=
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-=0A=
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
	Interrupt: pin ? routed to IRQ 9=0A=
=0A=
00:08.0 PCI bridge: Digital Equipment Corporation DECchip 21154 (rev 05) =
(prog-if 00 [Normal decode])=0A=
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR+ FastB2B-=0A=
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
	Latency: 64, cache line size 08=0A=
	Bus: primary=3D00, secondary=3D02, subordinate=3D02, sec-latency=3D68=0A=
	I/O behind bridge: 00002000-00002fff=0A=
	Memory behind bridge: f6000000-f61fffff=0A=
	Prefetchable memory behind bridge: 00000000fff00000-0000000000000000=0A=
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-=0A=
	Capabilities: [dc] Power Management version 1=0A=
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA =
PME(D0-,D1-,D2-,D3hot-,D3cold-)=0A=
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-=0A=
		Bridge: PM- B3+=0A=
=0A=
00:0b.0 Class ff00: Ziatech Corporation: Unknown device 5550 (rev 03)=0A=
	Subsystem: Ziatech Corporation: Unknown device 5550=0A=
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR+ FastB2B-=0A=
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dslow >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
	Interrupt: pin A routed to IRQ 9=0A=
	Region 0: I/O ports at 1480 [size=3D32]=0A=
	Region 1: Memory at f4000000 (32-bit, non-prefetchable) [size=3D4K]=0A=
=0A=
00:0c.0 PCI bridge: Digital Equipment Corporation DECchip 21154 (rev 05) =
(prog-if 00 [Normal decode])=0A=
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR+ FastB2B-=0A=
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
	Latency: 64, cache line size 08=0A=
	Bus: primary=3D00, secondary=3D03, subordinate=3D03, sec-latency=3D68=0A=
	I/O behind bridge: 00003000-00003fff=0A=
	Memory behind bridge: f6200000-f63fffff=0A=
	Prefetchable memory behind bridge: 00000000fff00000-0000000000000000=0A=
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-=0A=
	Capabilities: [dc] Power Management version 1=0A=
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA =
PME(D0-,D1-,D2-,D3hot-,D3cold-)=0A=
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-=0A=
		Bridge: PM- B3+=0A=
=0A=
01:00.0 VGA compatible controller: Chips and Technologies F69000 =
HiQVideo (rev 64) (prog-if 00 [VGA])=0A=
	Subsystem: Chips and Technologies F69000 HiQVideo=0A=
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping+ SERR+ FastB2B-=0A=
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
	Interrupt: pin A routed to IRQ 11=0A=
	Region 0: Memory at f5000000 (32-bit, non-prefetchable) [size=3D16M]=0A=
	Expansion ROM at <unassigned> [disabled] [size=3D256K]=0A=
=0A=
02:0d.0 Bridge: Digital Equipment Corporation DECchip 21554 (rev 01)=0A=
	Subsystem: Ziatech Corporation: Unknown device 5541=0A=
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- =
Stepping- SERR+ FastB2B+=0A=
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
	Latency: 64, cache line size 08=0A=
	Interrupt: pin A routed to IRQ 11=0A=
	Region 0: Memory at f6101000 (32-bit, non-prefetchable) [size=3D4K]=0A=
	Region 1: I/O ports at 2400 [size=3D256]=0A=
	Region 2: I/O ports at 2000 [size=3D256]=0A=
	Region 3: Memory at f6000000 (32-bit, non-prefetchable) [size=3D1M]=0A=
	Region 4: Memory at f6100000 (32-bit, non-prefetchable) [size=3D4K]=0A=
	Capabilities: [dc] Power Management version 0=0A=
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA =
PME(D0-,D1-,D2-,D3hot-,D3cold-)=0A=
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-=0A=
	Capabilities: [e4] Slot ID: 0 slots, First-, chassis 00=0A=
	Capabilities: [ec] #06 [0000]=0A=
=0A=
03:0a.0 Bridge: Digital Equipment Corporation DECchip 21554 (rev 01)=0A=
	Subsystem: Ziatech Corporation: Unknown device 5541=0A=
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- =
Stepping- SERR+ FastB2B+=0A=
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
	Latency: 64, cache line size 08=0A=
	Interrupt: pin A routed to IRQ 10=0A=
	Region 0: Memory at f6301000 (32-bit, non-prefetchable) [size=3D4K]=0A=
	Region 1: I/O ports at 3400 [size=3D256]=0A=
	Region 2: I/O ports at 3000 [size=3D256]=0A=
	Region 3: Memory at f6200000 (32-bit, non-prefetchable) [size=3D1M]=0A=
	Region 4: Memory at f6300000 (32-bit, non-prefetchable) [size=3D4K]=0A=
	Capabilities: [dc] Power Management version 0=0A=
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA =
PME(D0-,D1-,D2-,D3hot-,D3cold-)=0A=
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-=0A=
	Capabilities: [e4] Slot ID: 0 slots, First-, chassis 00=0A=
	Capabilities: [ec] #06 [0080]=0A=
=0A=

------=_NextPart_000_007A_01C2B715.B8E903B0
Content-Type: text/plain;
	name="proc_iomem.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="proc_iomem.txt"

00000000-0009f7ff : System RAM=0A=
0009f800-0009ffff : reserved=0A=
000a0000-000bffff : Video RAM area=0A=
000c0000-000c7fff : Video ROM=0A=
000c9800-000c9fff : Extension ROM=0A=
000ca000-000ca7ff : Extension ROM=0A=
000f0000-000fffff : System ROM=0A=
00100000-0fffffff : System RAM=0A=
  00100000-002fda69 : Kernel code=0A=
  002fda6a-003c7d67 : Kernel data=0A=
f4000000-f4000fff : PCI device 1138:5550 (Ziatech Corporation)=0A=
  f4000000-f4000fff : cpcihp_zt5550=0A=
f4001000-f40013ff : Digital Equipment Co DECchip 21142/43=0A=
  f4001000-f40013ff : tulip=0A=
f4001400-f40017ff : Digital Equipment Co DECchip 21142/43 (#2)=0A=
  f4001400-f40017ff : tulip=0A=
f5000000-f5ffffff : PCI Bus #01=0A=
  f5000000-f5ffffff : Chips and Technologi F69000 HiQVideo=0A=
f6000000-f61fffff : PCI Bus #02=0A=
  f6000000-f60fffff : Digital Equipment Co DECchip 21554=0A=
  f6100000-f6100fff : Digital Equipment Co DECchip 21554=0A=
  f6101000-f6101fff : Digital Equipment Co DECchip 21554=0A=
f6200000-f63fffff : PCI Bus #03=0A=
  f6200000-f62fffff : Digital Equipment Co DECchip 21554 (#2)=0A=
  f6300000-f6300fff : Digital Equipment Co DECchip 21554 (#2)=0A=
  f6301000-f6301fff : Digital Equipment Co DECchip 21554 (#2)=0A=
f8000000-fbffffff : Intel Corp. 440BX/ZX/DX - 82443B=0A=
fffc0000-ffffffff : reserved=0A=

------=_NextPart_000_007A_01C2B715.B8E903B0
Content-Type: text/plain;
	name="proc_ioports.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="proc_ioports.txt"

0000-001f : dma1=0A=
0020-003f : pic1=0A=
0040-005f : timer=0A=
0060-006f : keyboard=0A=
0070-007f : rtc=0A=
0080-008f : dma page reg=0A=
00a0-00bf : pic2=0A=
00c0-00df : dma2=0A=
00e1-00e1 : #ENUM hotswap signal register=0A=
00f0-00ff : fpu=0A=
0170-0177 : ide1=0A=
01f0-01f7 : ide0=0A=
02f8-02ff : serial=0A=
0376-0376 : ide1=0A=
03c0-03df : vga+=0A=
03f6-03f6 : ide0=0A=
03f8-03ff : serial=0A=
0cf8-0cff : PCI conf1=0A=
1000-103f : Intel Corp. 82371AB/EB/MB PIIX4 =0A=
1040-105f : Intel Corp. 82371AB/EB/MB PIIX4 =0A=
1060-107f : Intel Corp. 82371AB/EB/MB PIIX4 =0A=
1080-10ff : Digital Equipment Co DECchip 21142/43=0A=
  1080-10ff : tulip=0A=
1400-147f : Digital Equipment Co DECchip 21142/43 (#2)=0A=
  1400-147f : tulip=0A=
1480-149f : PCI device 1138:5550 (Ziatech Corporation)=0A=
14a0-14af : Intel Corp. 82371AB/EB/MB PIIX4 =0A=
2000-2fff : PCI Bus #02=0A=
  2000-20ff : Digital Equipment Co DECchip 21554=0A=
  2400-24ff : Digital Equipment Co DECchip 21554=0A=
3000-3fff : PCI Bus #03=0A=
  3000-30ff : Digital Equipment Co DECchip 21554 (#2)=0A=
  3400-34ff : Digital Equipment Co DECchip 21554 (#2)=0A=

------=_NextPart_000_007A_01C2B715.B8E903B0--

