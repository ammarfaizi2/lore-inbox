Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261225AbVCTP2u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261225AbVCTP2u (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 10:28:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261227AbVCTP2u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 10:28:50 -0500
Received: from mail2.alphalink.com.au ([202.161.124.194]:45739 "EHLO
	mail2.alphalink.com.au") by vger.kernel.org with ESMTP
	id S261225AbVCTP0x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 10:26:53 -0500
Subject: 2.6.11 AC patch CD/DVD issues
From: Takis Diakoumis <takisd@alphalink.com.au>
Reply-To: takisd@alphalink.com.au
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Mon, 21 Mar 2005 02:27:26 +1100
Message-Id: <1111332446.8418.47.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

currently running kernel 2.6.11.3 with ac patch 2.6.11-ac3. i just
noticed an issue with the attached CD/DVD drives - they no longer seem
to allow CD audio ripping/playback/dvd multimedia. data CDs/DVDs are ok
when mounted - though all gui umount tools (i'm using gnome) report
errors in accessing the drives (they won't eject - though umount itself
is working).

i am running debian testing branch.

i've been tinkering with the ac patch to get proper support for the
raid/ata controller IT8212 on the gigabyte 8knxp motherboard. i am using
this in pass through mode only - not raid. i was on the 2.6.7 kernel
with the IT8212 module from the chip vendor, but this began to dump when
adding additional drives. did some digging, landed on the ac patch and
have been compiling it and using it since kernel2.6.10 and associated ac
patches. i have since tried to go backwards from 2.6.10 but couldn't get
a working kernel for 2.6.8 and 2.6.9 with the ac patches (wouldn't boot
- blank screen only). unfortunately i couldn't determine with which
version (or all) it may have first appeared.

i did not compile the it821x driver into the kernel but as a module (i
have tried that also - no change). though i'm not actually loading the
module from /etc/modules, its loaded anyway (along with a myriad of
other ata controllers which then report errors as they can't be unloaded
- though i read somewhere on this list that this was by design???).

the it821x module does seem to be working ok (though a couple of odd
lines appear in dmesg - see below). i have complete access to the drives
connected to the controller without issue as far as i can tell.

all cd ripping/reading tools for audio/multimedia cds report unable to
initialize /dev/cdrom (a link to cdrom device).

i have tried setting the controller in the bios to ata mode only or in
raid mode and not defining a raid array, which defaults to plain ata
mode anyway. no change with either setting. if i disable the controller
from the bios, all is ok and i have full expected access to both cd and
dvd drives with all tools/apps etc. enabling again, i lose them beyond
simple data mounts.

physical drive configuration is as follows:
IDE0: 120gb primary drive (/dev/hde)
      80gb slave drive (/dev/hdf)
IDE1: DVD reader primary (/dev/hdg)
      CD-RW slave (/dev/hdh)
IT8212: 80gb primary drive (/dev/hda)
        20gb slave drive (/dev/hdb)

the IT8212 controller takes /dev/hda to hdd. so primary/secondary ide go
from hde to hdh. root is mounted on /dev/hde.

i have included relevant output below (sorry, it seems like quite the
dump - tried to follow the instructions on how to report a bug). please
let me know if there is anything else required that may help. also, am
willing to test anything given. (like i said, i've been compiling since
2.6.8 to get it8212 support)

thanks.

df
Filesystem           1K-blocks      Used Available Use% Mounted on
/dev/hde2            114223428  15156732  93264420  14% /
tmpfs                   517984         0    517984   0% /dev/shm
/dev/hdf1             76920416   9493932  63519076  14% /home/takisd
/dev/hdb1             19694836     43688  18650704   1% /mnt/backup
/dev/hda1             76922968  23898540  49116896  33% /software
------------------------------
dmesg (cut with relevant bits)
Kernel command line: root=/dev/hde2 vga=791 ro
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
IT8212: IDE controller at PCI slot 0000:03:0c.0
ACPI: PCI interrupt 0000:03:0c.0[A] -> GSI 21 (level, low) -> IRQ 169
IT8212: chipset revision 17
it821x: controller in smart mode.
IT8212: 100% native mode on irq 169
    ide0: BM-DMA at 0x9000-0x9007, BIOS settings: hda:pio, hdb:DMA
    ide1: BM-DMA at 0x9008-0x900f, BIOS settings: hdc:pio, hdd:pio
hda: WDC WD800JB-00FMA0, ATA DISK drive
hdb: Maxtor 2B020H1, ATA DISK drive
hda: Performing identify fixups.
hdb: Performing identify fixups.
    ide2: BM-DMA at 0xf000-0xf007, BIOS settings: hde:DMA, hdf:DMA
    ide3: BM-DMA at 0xf008-0xf00f, BIOS settings: hdg:DMA, hdh:DMA
hde: WDC WD1200JB-00CRA1, ATA DISK drive
hdf: WDC WD800JB-00ETA0, ATA DISK drive
hdg: SONY DVD-ROM DDU1613, ATAPI CD/DVD-ROM drive
hdh: SONY CD-RW CRX230E, ATAPI CD/DVD-ROM drive
hda: max request size: 128KiB
hda: 156301488 sectors (80026 MB) w/8192KiB Cache, CHS=65535/16/63, BUG
hda: cache flushes not supported
 /dev/ide/host0/bus0/target0/lun0:hda: recal_intr: status=0x51
{ DriveReady SeekComplete Error }
hda: recal_intr: error=0x04 { DriveStatusError }
hdb: max request size: 128KiB
hdb: 40020624 sectors (20490 MB) w/2048KiB Cache, CHS=39703/16/63, BUG
hdb: cache flushes not supported
 /dev/ide/host0/bus0/target1/lun0:hdb: recal_intr: status=0x51
{ DriveReady SeekComplete Error }
hdb: recal_intr: error=0x04 { DriveStatusError }
hde: max request size: 128KiB
hde: 234441648 sectors (120034 MB) w/8192KiB Cache, CHS=65535/16/63,
UDMA(100)
hde: cache flushes not supported
hdf: max request size: 1024KiB
hdf: 156301488 sectors (80026 MB) w/8192KiB Cache, CHS=16383/255/63,
UDMA(100)
hdf: cache flushes supported
Adding 1172696k swap on /dev/hde1.  Priority:-1 extents:1
EXT3 FS on hde2, internal journal
EXT3 FS on hdf1, internal journal
EXT3 FS on hdb1, internal journal
EXT3 FS on hda1, internal journal
--------------------------

---------------
cat /proc/version
Linux version 2.6.11.3.15032005 (root@fulcrum) (gcc version 3.3.5
(Debian 1:3.3.5-8)) #1 SMP Tue Mar 15 14:50:11 EST 2005
---------------
/usr/src/linux/scripts/ver_linux
Linux fulcrum 2.6.11.3.15032005 #1 SMP Tue Mar 15 14:50:11 EST 2005 i686
GNU/Linux

Gnu C                  3.3.5
Gnu make               3.80
binutils               2.15
util-linux             2.12
mount                  2.12
module-init-tools      3.2-pre1
e2fsprogs              1.35
reiserfsprogs          line
reiser4progs           line
PPP                    2.4.2
nfs-utils              1.0.6
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.2.1
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.2.1
./ver_linux: line 90: udevinfo: command not found
Modules Loaded         ipv6 lp autofs4 nfsd exportfs lockd sunrpc cdrom
analog gameport parport_pc parport floppy pcspkr eth1394 ohci1394
ieee1394 snd_intel8x0 snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm
snd_timer snd soundcore snd_page_alloc i2c_i801 generic ehci_hcd
uhci_hcd usbcore shpchp pci_hotplug intel_agp intel_mch_agp md mousedev
evdev nvidia agpgart psmouse smbfs e1000 it87 i2c_sensor i2c_isa
i2c_core rtc vfat fat ntfs ide_disk ide_generic via82cxxx trm290 triflex
slc90e66 sis5513 siimage serverworks sc1200 rz1000 piix pdc202xx_old
opti621 ns87415 hpt366 hpt34x cy82c693 cs5530 cs5520 cmd64x atiixp
amd74xx alim15x3 aec62xx pdc202xx_new unix it821x ide_core ext3 jbd
mbcache
---------------
cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 3.00GHz
stepping        : 9
cpu MHz         : 3015.186
cache size      : 512 KB
physical id     : 0
siblings        : 2
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
xtpr
bogomips        : 5980.16

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 3.00GHz
stepping        : 9
cpu MHz         : 3015.186
cache size      : 512 KB
physical id     : 0
siblings        : 2
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
xtpr
bogomips        : 6012.92
---------------
fdisk -l
Disk /dev/hda: 80.0 GB, 80026361856 bytes
16 heads, 63 sectors/track, 155061 cylinders
Units = cylinders of 1008 * 512 = 516096 bytes

   Device Boot      Start         End      Blocks   Id  System
/dev/hda1               1      155061    78150712+  83  Linux

Disk /dev/hdb: 20.4 GB, 20490559488 bytes
255 heads, 63 sectors/track, 2491 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes

   Device Boot      Start         End      Blocks   Id  System
/dev/hdb1               1        2491    20008926   83  Linux

Disk /dev/hde: 120.0 GB, 120034123776 bytes
255 heads, 63 sectors/track, 14593 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes

   Device Boot      Start         End      Blocks   Id  System
/dev/hde1               1         146     1172713+  82  Linux swap
/dev/hde2   *         147       14593   116045527+  83  Linux

Disk /dev/hdf: 80.0 GB, 80026361856 bytes
255 heads, 63 sectors/track, 9729 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes

   Device Boot      Start         End      Blocks   Id  System
/dev/hdf1               1        9729    78148161   83  Linux
---------------
cat /proc/modules
ipv6 271392 12 - Live 0xf94e9000
lp 13060 0 - Live 0xf93c5000
autofs4 20868 0 - Live 0xf93da000
nfsd 226336 8 - Live 0xf9461000
exportfs 7296 1 nfsd, Live 0xf9394000
lockd 68264 2 nfsd, Live 0xf93ef000
sunrpc 149828 2 nfsd,lockd, Live 0xf9402000
cdrom 42528 0 - Live 0xf93ce000
analog 13344 0 - Live 0xf938b000
gameport 5888 1 analog, Live 0xf9383000
parport_pc 37956 1 - Live 0xf93b5000
parport 39880 2 lp,parport_pc, Live 0xf93aa000
floppy 62480 0 - Live 0xf9399000
pcspkr 4684 0 - Live 0xf9366000
eth1394 23176 0 - Live 0xf9369000
ohci1394 36612 0 - Live 0xf9311000
ieee1394 113208 2 eth1394,ohci1394, Live 0xf9326000
snd_intel8x0 35136 3 - Live 0xf92b7000
snd_ac97_codec 79864 1 snd_intel8x0, Live 0xf92f0000
snd_pcm_oss 55968 0 - Live 0xf92e1000
snd_mixer_oss 21888 1 snd_pcm_oss, Live 0xf9290000
snd_pcm 98180 4 snd_intel8x0,snd_ac97_codec,snd_pcm_oss, Live 0xf92c8000
snd_timer 27780 1 snd_pcm, Live 0xf9225000
snd 60260 11
snd_intel8x0,snd_ac97_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer,
Live 0xf929b000
soundcore 11872 1 snd, Live 0xf9221000
snd_page_alloc 11140 2 snd_intel8x0,snd_pcm, Live 0xf91e6000
i2c_i801 9868 0 - Live 0xf91bc000
generic 5764 0 - Live 0xf887a000
ehci_hcd 36360 0 - Live 0xf927e000
uhci_hcd 34704 0 - Live 0xf9274000
usbcore 124536 3 ehci_hcd,uhci_hcd, Live 0xf9238000
shpchp 103812 0 - Live 0xf9259000
pci_hotplug 36680 1 shpchp, Live 0xf922e000
intel_agp 24220 0 - Live 0xf91ea000
intel_mch_agp 11920 1 - Live 0xf91b8000
md 50768 0 - Live 0xf91f1000
mousedev 13088 2 - Live 0xf91b3000
evdev 10752 0 - Live 0xf91af000
nvidia 3474648 12 - Live 0xf959e000
agpgart 36912 3 intel_agp,intel_mch_agp,nvidia, Live 0xf9168000
psmouse 30728 0 - Live 0xf9173000
smbfs 70648 0 - Live 0xf919c000
e1000 91444 0 - Live 0xf9184000
it87 27292 0 - Live 0xf9158000
i2c_sensor 4608 1 it87, Live 0xf908b000
i2c_isa 3072 0 - Live 0xf9089000
i2c_core 24576 4 i2c_i801,it87,i2c_sensor,i2c_isa, Live 0xf9161000
rtc 14028 0 - Live 0xf90a3000
vfat 15232 0 - Live 0xf908f000
fat 42780 1 vfat, Live 0xf9097000
ntfs 113264 0 - Live 0xf90aa000
ide_disk 20096 9 - Live 0xf907e000
ide_generic 2304 0 [permanent], Live 0xf9073000
via82cxxx 13468 0 [permanent], Live 0xf9084000
trm290 5380 0 [permanent], Live 0xf907b000
triflex 4864 0 [permanent], Live 0xf9078000
slc90e66 6912 0 [permanent], Live 0xf9075000
sis5513 15752 0 [permanent], Live 0xf905a000
siimage 13824 0 [permanent], Live 0xf906c000
serverworks 8840 0 [permanent], Live 0xf9068000
sc1200 8320 0 [permanent], Live 0xf9064000
rz1000 3712 0 [permanent], Live 0xf902b000
piix 11780 0 [permanent], Live 0xf8845000
pdc202xx_old 12416 0 [permanent], Live 0xf905f000
opti621 5764 0 [permanent], Live 0xf9028000
ns87415 4808 0 [permanent], Live 0xf9025000
hpt366 21248 0 [permanent], Live 0xf9053000
hpt34x 6400 0 [permanent], Live 0xf887d000
cy82c693 5632 0 [permanent], Live 0xf8872000
cs5530 6016 0 [permanent], Live 0xf886f000
cs5520 5888 0 [permanent], Live 0xf8867000
cmd64x 13212 0 [permanent], Live 0xf8875000
atiixp 7312 0 [permanent], Live 0xf8864000
amd74xx 14236 0 [permanent], Live 0xf886a000
alim15x3 11788 0 [permanent], Live 0xf8834000
aec62xx 8704 0 [permanent], Live 0xf8841000
pdc202xx_new 10240 0 [permanent], Live 0xf883d000
unix 30868 660 - Live 0xf885b000
it821x 10116 0 [permanent], Live 0xf8839000
ide_core 136480 28
generic,ide_disk,ide_generic,via82cxxx,trm290,triflex,slc90e66,sis5513,siimage,serverworks,sc1200,rz1000,piix,pdc202xx_old,opti621,ns87415,hpt366,hpt34x,cy82c693,cs5530,cs5520,cmd64x,atiixp,amd74xx,alim15x3,aec62xx,pdc202xx_new,it821x, Live 0xf9002000
ext3 147592 4 - Live 0xf902d000
jbd 66456 1 ext3, Live 0xf8849000
mbcache 11140 1 ext3, Live 0xf8804000
-----------------------
cat /proc/ioports
0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide3
01f0-01f7 : ide2
0290-0297 : it87
02f8-02ff : serial
0376-0376 : ide3
0378-037a : parport0
03c0-03df : vesafb
03f6-03f6 : ide2
03f8-03ff : serial
0cf8-0cff : PCI conf1
1000-107f : 0000:00:1f.0
  1000-1003 : PM1a_EVT_BLK
  1004-1005 : PM1a_CNT_BLK
  1008-100b : PM_TMR
  1028-102f : GPE0_BLK
1080-10bf : 0000:00:1f.0
1400-141f : 0000:00:1f.3
  1400-140f : i801-smbus
8010-8017 : 0000:03:0c.0
  8010-8017 : ide0
8400-8403 : 0000:03:0c.0
  8402-8402 : ide0
8810-8817 : 0000:03:0c.0
8c00-8c03 : 0000:03:0c.0
9000-900f : 0000:03:0c.0
  9000-9007 : ide0
  9008-900f : ide1
a000-afff : PCI Bus #02
  a000-a01f : 0000:02:01.0
    a000-a01f : e1000
b000-b01f : 0000:00:1d.1
  b000-b01f : uhci_hcd
b400-b41f : 0000:00:1d.2
  b400-b41f : uhci_hcd
b800-b81f : 0000:00:1d.3
  b800-b81f : uhci_hcd
bc00-bc1f : 0000:00:1d.0
  bc00-bc1f : uhci_hcd
d800-d8ff : 0000:00:1f.5
  d800-d8ff : Intel ICH5
dc00-dc3f : 0000:00:1f.5
  dc00-dc3f : Intel ICH5
f000-f00f : 0000:00:1f.1
  f000-f007 : ide2
  f008-f00f : ide3
----------------------------
lspci -vvv
0000:00:00.0 Host bridge: Intel Corp. 82875P Memory Controller Hub (rev
02)
        Subsystem: Giga-byte Technology: Unknown device 2578
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Region 0: Memory at e8000000 (32-bit, prefetchable) [size=128M]
        Capabilities: [e4] #09 [2106]
        Capabilities: [a0] AGP version 3.0
                Status: RQ=32 Iso- ArqSz=2 Cal=2 SBA+ ITACoh- GART64-
HTrans- 64bit- FW+ AGP3+ Rate=x4,x8
                Command: RQ=1 ArqSz=0 Cal=2 SBA+ AGP+ GART64- 64bit- FW-
Rate=x8
0000:00:01.0 PCI bridge: Intel Corp. 82875P Processor to AGP Controller
(rev 02) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: f8000000-f9ffffff
        Prefetchable memory behind bridge: f0000000-f7ffffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

0000:00:03.0 PCI bridge: Intel Corp. 82875P Processor to PCI to CSA
Bridge (rev 02) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
        I/O behind bridge: 0000a000-0000afff
        Memory behind bridge: fc000000-fc0fffff
        Prefetchable memory behind bridge: fff00000-000fffff
        BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

0000:00:1d.0 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB
UHCI #1 (rev 02) (prog-if 00 [UHCI])
        Subsystem: Giga-byte Technology: Unknown device 24d2
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 185
        Region 4: I/O ports at bc00 [size=32]

0000:00:1d.1 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB
UHCI #2 (rev 02) (prog-if 00 [UHCI])
        Subsystem: Giga-byte Technology GA-8IPE1000 Pro2 motherboard
(865PE)
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 193
        Region 4: I/O ports at b000 [size=32]

0000:00:1d.2 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB
UHCI #3 (rev 02) (prog-if 00 [UHCI])
        Subsystem: Giga-byte Technology GA-8IPE1000 Pro2 motherboard
(865PE)
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin C routed to IRQ 177
        Region 4: I/O ports at b400 [size=32]

0000:00:1d.3 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB
UHCI #4 (rev 02) (prog-if 00 [UHCI])
        Subsystem: Giga-byte Technology GA-8IPE1000 Pro2 motherboard
(865PE)
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 185
        Region 4: I/O ports at b800 [size=32]

0000:00:1d.7 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB2
EHCI Controller (rev 02) (prog-if 20 [EHCI])
        Subsystem: Giga-byte Technology GA-8IPE1000 Pro2 motherboard
(865PE)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin D routed to IRQ 201
        Region 0: Memory at fc100000 (32-bit, non-prefetchable)
[size=1K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0
+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev c2) (prog-if
00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=03, subordinate=03, sec-latency=32
        I/O behind bridge: 00008000-00009fff
        Memory behind bridge: fa000000-fbffffff
        Prefetchable memory behind bridge: fff00000-000fffff
        BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

0000:00:1f.0 ISA bridge: Intel Corp. 82801EB/ER (ICH5/ICH5R) LPC Bridge
(rev 02)        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV-
VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

0000:00:1f.1 IDE interface: Intel Corp. 82801EB/ER (ICH5/ICH5R) Ultra
ATA 100 Storage Controller (rev 02) (prog-if 8a [Master SecP PriP])
        Subsystem: Giga-byte Technology GA-8IPE1000 Pro2 motherboard
(865PE)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 177
        Region 0: I/O ports at <unassigned>
        Region 1: I/O ports at <unassigned>
        Region 2: I/O ports at <unassigned>
        Region 3: I/O ports at <unassigned>
        Region 4: I/O ports at f000 [size=16]
        Region 5: Memory at 40000000 (32-bit, non-prefetchable)
[size=1K]

0000:00:1f.3 SMBus: Intel Corp. 82801EB/ER (ICH5/ICH5R) SMBus Controller
(rev 02)
        Subsystem: Giga-byte Technology GA-8IPE1000 Pro2 motherboard
(865PE)
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 9
        Region 4: I/O ports at 1400 [size=32]

0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801EB/ER
(ICH5/ICH5R) AC'97 Audio Controller (rev 02)
        Subsystem: Giga-byte Technology: Unknown device a002
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 209
        Region 0: I/O ports at d800 [size=256]
        Region 1: I/O ports at dc00 [size=64]
        Region 2: Memory at fc101000 (32-bit, non-prefetchable)
[size=512]
        Region 3: Memory at fc102000 (32-bit, non-prefetchable)
[size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0
+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:01:00.0 VGA compatible controller: nVidia Corporation NV34 [GeForce
FX 5200] (rev a1) (prog-if 00 [VGA])
        Subsystem: Giga-byte Technology: Unknown device 3103
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 248 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 185
        Region 0: Memory at f8000000 (32-bit, non-prefetchable)
[size=16M]
        Region 1: Memory at f0000000 (32-bit, prefetchable) [size=128M]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [44] AGP version 3.0
                Status: RQ=32 Iso- ArqSz=0 Cal=3 SBA+ ITACoh- GART64-
HTrans- 64bit- FW+ AGP3+ Rate=x4,x8
                Command: RQ=32 ArqSz=2 Cal=0 SBA+ AGP+ GART64- 64bit-
FW- Rate=x8

0000:02:01.0 Ethernet controller: Intel Corp. 82547EI Gigabit Ethernet
Controller (LOM)
        Subsystem: Giga-byte Technology GA-8IPE1000 Pro2 motherboard
(865PE)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (63750ns min), Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin A routed to IRQ 177
        Region 0: Memory at fc000000 (32-bit, non-prefetchable)
[size=128K]
        Region 2: I/O ports at a000 [size=32]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0
+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=1 PME-

0000:03:0a.0 FireWire (IEEE 1394): Texas Instruments TSB43AB23
IEEE-1394a-2000 Controller (PHY/Link) (prog-if 10 [OHCI])
        Subsystem: Giga-byte Technology: Unknown device 1000
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min, 1000ns max), Cache Line Size: 0x08 (32
bytes)
        Interrupt: pin A routed to IRQ 217
        Region 0: Memory at fb004000 (32-bit, non-prefetchable)
[size=2K]
        Region 1: Memory at fb000000 (32-bit, non-prefetchable)
[size=16K]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1
+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME+

0000:03:0c.0 RAID bus controller: Integrated Technology Express, Inc.
IT/ITE8212 Dual channel ATA RAID controller (PCI version seems to be
IT8212, embedded seems (rev 11)
        Subsystem: Integrated Technology Express, Inc.: Unknown device
0001
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (2000ns min, 2000ns max)
        Interrupt: pin A routed to IRQ 169
        Region 0: I/O ports at 8010 [size=8]
        Region 1: I/O ports at 8400 [size=4]
        Region 2: I/O ports at 8810 [size=8]
        Region 3: I/O ports at 8c00 [size=4]
        Region 4: I/O ports at 9000 [size=16]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-



