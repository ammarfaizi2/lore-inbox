Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267085AbSLRBFG>; Tue, 17 Dec 2002 20:05:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267086AbSLRBFG>; Tue, 17 Dec 2002 20:05:06 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:43792
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S267085AbSLRBE7>; Tue, 17 Dec 2002 20:04:59 -0500
Date: Tue, 17 Dec 2002 17:10:47 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Markus Wagner <Markus1108Wagner@t-online.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: No booting with a Silicon Image 3112 SATA-Controller
In-Reply-To: <200212172307.44339.520087183254-0001@t-online.de>
Message-ID: <Pine.LNX.4.10.10212171554540.31876-200000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="1430322656-1703241051-1040173847=:31876"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--1430322656-1703241051-1040173847=:31876
Content-Type: text/plain; charset=us-ascii


Attached is SATA booting and running as /dev/md0 in raid 1

[root@athy root]# hdparm -t /dev/md0

/dev/md0:
 Timing buffered disk reads:  64 MB in  1.55 seconds = 41.29 MB/sec

Try enableing offboard booting.

This is the next rev below, with the real mccoy devices.

Linux version 2.4.20-ac1 (root@svwks.linux-ide.org) (gcc version 3.2
20020903 (Red Hat Linux 8.0 3.2-7)) #1 Sat Dec 14 02:37:07 PST 2002

SvrWks CSB6: IDE controller at PCI slot 00:0f.1
SvrWks CSB6: chipset revision 160
SvrWks CSB6: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1420-0x1427, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1428-0x142f, BIOS settings: hdc:DMA, hdd:pio
SvrWks CSB6: IDE controller at PCI slot 00:0e.0
PCI: Guessed IRQ 11 for device 00:0e.0
SvrWks CSB6: chipset revision 160
SvrWks CSB6: 100% native mode on irq 11
    ide2: BM-DMA at 0x1410-0x1417, BIOS settings: hde:pio, hdf:pio
SiI3112 Serial ATA: IDE controller at PCI slot 00:04.0
SiI3112 Serial ATA: chipset revision 2
SiI3112 Serial ATA: not 100% native mode: will probe irqs later
    ide3: MMIO-DMA at 0xe880d000-0xe880d007, BIOS settings: hdg:pio, hdh:pio
    ide4: MMIO-DMA at 0xe880d008-0xe880d00f, BIOS settings: hdi:pio, hdj:pio
hda: IC25N030ATCS04-0, ATA DISK drive
blk: queue c0319e00, I/O limit 4095Mb (mask 0xffffffff)
hdc: HL-DT-STDVD-ROM GDR8160B, ATAPI CD/DVD-ROM drive
hdg: WDC WD800BB-00CAA0, ATA DISK drive
blk: queue c031aae4, I/O limit 4095Mb (mask 0xffffffff)
hdi: ST330013AS, ATA DISK drive
blk: queue c031af30, I/O limit 4095Mb (mask 0xffffffff)
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide3 at 0xe880d080-0xe880d087,0xe880d08a on irq 10
ide4 at 0xe880d0c0-0xe880d0c7,0xe880d0ca on irq 10
hda: host protected area => 1
hda: 58605120 sectors (30006 MB) w/1768KiB Cache, CHS=3648/255/63, UDMA(100)
hdg: host protected area => 1
hdg: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=155061/16/63, UDMA(100)
hdi: host protected area => 1
hdi: 58633344 sectors (30020 MB) w/8192KiB Cache, CHS=58168/16/63 UDMA(100)


On Tue, 17 Dec 2002, Markus Wagner wrote:

> Hi,
> 
> I got a PCI SATA-Controller with the SiI 3112 Chipset. I tried to get it 
> running with 
> 
> 2.4.19-ac4-ide ( from linux-ide.org )
> 2.4.20-ac1 and -ac2.
> 
> The support for the controller is compiled directly into the kernel.
> 
> Since I dont have a SATA-HDD, I am using a SATA to PATA dongle with an IBM 
> DTLA 307030 HDD.
> 
> When booting the 2.4.20-ac1/-ac2 kernel, the boot process stops at 
> 
> VFS: Mounted root (ext3 filesystem) readonly.
> Freeing unused kernel memory: 132k freed
> 
> with no further action.
> 
> With Kernel 2.4.19-ac4-ide the system booted and crashed shortly after.
> 
> I tried the "ide=reveresed" kernel option with all kernels used.
> 
> Some info about my system:
> MoBo: ECS Elitegroup K7S5A with AMD Athlon C 1400 ( SiS 735 Chipset )
> The HDD ( IBM DTLA-307030 ) works without failure when using the onboard 
> Controller.
> 
> I tried to remove the network and the sound card to get a unique interrupt for 
> the controller but that didn't change things.
> 
> This is the Screen-Output when booting 2.4.20-ac2:
> ...
> Uniform Multi-Platform E-IDE driver Revision: 7.00beta-2.4
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> SIS5513: IDE controller at PCI slot 00:02.5
> SIS5513: chipset revision 208
> SIS5513: not 100% native mode: will probe irqs later
> SiS735    ATA 100 controller
>     ide0: BM-DMA at 0xff00-0xff07, BIOS settings: hda:DMA, hdb:DMA
>     ide1: BM-DMA at 0xff08-0xff0f, BIOS settings: hdc:DMA, hdd:DMA
> SiI3112 Serial ATA: IDE controller at PCI slot 00:0b.0
> PCI: Found IRQ 5 for device 00:0b.0
> PCI: Sharing IRQ 5 with 00:11.0
> SiI3112 Serial ATA: chipset revision 1
> SiI3112 Serial ATA: not 100% native mode: will probe irqs later
>     ide2: MMIO-DMA at 0xe280ee00-0xe280ee07, BIOS settings: hde:pio, hdf:pio
>     ide3: MMIO-DMA at 0xe280ee08-0xe280ee0f, BIOS settings: hdg:pio, hdh:pio
> hdc: CREATIVECD-RW RW121032E, ATAPI CD/DVD-ROM drive
> hdd: CREATIVE CD5233E, ATAPI CD/DVD-ROM drive
> hde: IBM-DTLA-307030, ATA DISK drive
> hde: DMA disabled
> hdg: no response (status = 0xfe)
>     ide2 at 0xe280ee80-0xe280ee87, 0xe280ee8a on IRQ 5
> hde: host protected area => 1
> hde: 60036480 sectors (30739 MB) w/1916KiB Cache, CHS=3737/255/63, UDMA(100)
> ide-floppy driver 0.99.newide
> Partition check:
>  hda: hda1 hda2 hda3 hda4
> ide-floppy driver 0.99.newide
> md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
> md: Autodetecting RAID arrays.
> md: autorun ...
> md: ... autorun DONE.
> NET4: Linux TCP/IP 1.0 for NET4.0
> IP Protocols: ICMP, UDP, TCP, IGMP
> IP: routing cache hash table of 4096 buckets, 32Kbytes
> TCP: Hash tables configured (established 32768 bind 65536)
> Linux IP multicast router 0.06 plus PIM-SM
> NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> kjournald starting.  Commit interval 5 seconds
> EXT3-fs: mounted filesystem with ordered data mode.
> VFS: Mounted root (ext3 filesystem) readonly.
> Freeing unused kernel memory: 132k freed
> 
> Output of scripts/ver_linux:
> 
> Linux jupiter 2.4.20-ac2 #2 Die Dez 17 21:08:28 EST 2002 i686 unknown
> 
> Gnu C                  2.96
> Gnu make               3.79.1
> util-linux             2.11n
> mount                  2.11n
> modutils               2.4.18
> e2fsprogs              1.27
> reiserfsprogs          3.x.0j
> Linux C Library        2.2.5
> Dynamic linker (ldd)   2.2.5
> Procps                 2.0.7
> Net-tools              1.60
> Console-tools          0.3.3
> Sh-utils               2.0.11
> Modules Loaded         sr_mod emu10k1 ac97_codec sound soundcore agpgart 
> nvidia natsemi ide-scsi scsi_mod ide-cd cdrom
> 
> cat /proc/pci ( with HDD on oboard IDE) :
> PCI devices found:
>   Bus  0, device   0, function  0:
>     Host bridge: Silicon Integrated Systems [SiS] 735 Host (rev 1).
>       Master Capable.  Latency=32.
>       Non-prefetchable 32 bit memory at 0xd0000000 [0xd3ffffff].
>   Bus  0, device   1, function  0:
>     PCI bridge: Silicon Integrated Systems [SiS] 5591/5592 AGP (rev 0).
>       Master Capable.  Latency=64.  Min Gnt=10.
>   Bus  0, device   2, function  0:
>     ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513 (rev 0).
>   Bus  0, device   2, function  5:
>     IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev 208).
>       Master Capable.  Latency=128.
>       I/O at 0xff00 [0xff0f].
>   Bus  0, device  11, function  0:
>     Unknown mass storage controller: PCI device 1095:3112 (CMD Technology Inc) 
> (rev 1).
>       IRQ 5.
>       Master Capable.  Latency=64.
>       I/O at 0xd800 [0xd807].
>       I/O at 0xd400 [0xd403].
>       I/O at 0xd000 [0xd007].
>       I/O at 0xcc00 [0xcc03].
>       I/O at 0xc800 [0xc80f].
>       Non-prefetchable 32 bit memory at 0xcffffe00 [0xcfffffff].
>   Bus  0, device  15, function  0:
>     Ethernet controller: National Semiconductor Corporation DP83815 
> (MacPhyter) Ethernet Controller (rev 0).
>       IRQ 10.
>       Master Capable.  Latency=64.  Min Gnt=11.Max Lat=52.
>       I/O at 0xc400 [0xc4ff].
>       Non-prefetchable 32 bit memory at 0xcfffe000 [0xcfffefff].
>   Bus  0, device  17, function  0:
>     Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 8).
>       IRQ 5.
>       Master Capable.  Latency=64.  Min Gnt=2.Max Lat=20.
>       I/O at 0xc000 [0xc01f].
>   Bus  0, device  17, function  1:
>     Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 8).
>       Master Capable.  Latency=64.
>       I/O at 0xdc00 [0xdc07].
>   Bus  1, device   0, function  0:
>     VGA compatible controller: nVidia Corporation NV11 [GeForce2 MX] (rev 
> 161).
>       IRQ 11.
>       Master Capable.  Latency=248.  Min Gnt=5.Max Lat=1.
>       Non-prefetchable 32 bit memory at 0xce000000 [0xceffffff].
>       Prefetchable 32 bit memory at 0xc0000000 [0xc7ffffff].
> 
> Hope you can make use of this
> 
> best regards,
> 
> Markus Wagner
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
LAD Storage Consulting Group


--1430322656-1703241051-1040173847=:31876
Content-Type: text/plain; charset=us-ascii; name="athy.dmesg"
Content-Transfer-Encoding: base64
Content-ID: <Pine.LNX.4.10.10212171710470.31876@master.linux-ide.org>
Content-Description: 
Content-Disposition: attachment; filename="athy.dmesg"

TGludXggdmVyc2lvbiAyLjQuMTgtM2JpZ21lbSAocm9vdEBhdXRvYnVpbGQu
bGludXgtaWRlLm9yZykgKGdjYyB2ZXJzaW9uIDIuOTYgMjAwMDA3MzEgKFJl
ZCBIYXQgTGludXggNy4zIDIuOTYtMTEwKSkgIzEgU01QIFRodSBOb3YgMjEg
MTU6MDE6MzkgUFNUIDIwMDINCkJJT1MtcHJvdmlkZWQgcGh5c2ljYWwgUkFN
IG1hcDoNCiBCSU9TLWU4MjA6IDAwMDAwMDAwMDAwMDAwMDAgLSAwMDAwMDAw
MDAwMDlmMDAwICh1c2FibGUpDQogQklPUy1lODIwOiAwMDAwMDAwMDAwMDlm
MDAwIC0gMDAwMDAwMDAwMDBhMDAwMCAocmVzZXJ2ZWQpDQogQklPUy1lODIw
OiAwMDAwMDAwMDAwMGU0ODAwIC0gMDAwMDAwMDAwMDEwMDAwMCAocmVzZXJ2
ZWQpDQogQklPUy1lODIwOiAwMDAwMDAwMDAwMTAwMDAwIC0gMDAwMDAwMDAx
MDAwMDAwMCAodXNhYmxlKQ0KIEJJT1MtZTgyMDogMDAwMDAwMDBmZWMwMDAw
MCAtIDAwMDAwMDAwZmVjMTAwMDAgKHJlc2VydmVkKQ0KIEJJT1MtZTgyMDog
MDAwMDAwMDBmZWUwMDAwMCAtIDAwMDAwMDAwZmVlMDEwMDAgKHJlc2VydmVk
KQ0KIEJJT1MtZTgyMDogMDAwMDAwMDBmZmY4MDAwMCAtIDAwMDAwMDAxMDAw
MDAwMDAgKHJlc2VydmVkKQ0KZm91bmQgU01QIE1QLXRhYmxlIGF0IDAwMGY3
NGQwDQpobSwgcGFnZSAwMDBmNzAwMCByZXNlcnZlZCB0d2ljZS4NCmhtLCBw
YWdlIDAwMGY4MDAwIHJlc2VydmVkIHR3aWNlLg0KaG0sIHBhZ2UgMDAwOWYw
MDAgcmVzZXJ2ZWQgdHdpY2UuDQpobSwgcGFnZSAwMDBhMDAwMCByZXNlcnZl
ZCB0d2ljZS4NCk9uIG5vZGUgMCB0b3RhbHBhZ2VzOiA2NTUzNg0Kem9uZSgw
KTogNDA5NiBwYWdlcy4NCnpvbmUoMSk6IDYxNDQwIHBhZ2VzLg0Kem9uZSgy
KTogMCBwYWdlcy4NCkludGVsIE11bHRpUHJvY2Vzc29yIFNwZWNpZmljYXRp
b24gdjEuNA0KICAgIFZpcnR1YWwgV2lyZSBjb21wYXRpYmlsaXR5IG1vZGUu
DQpPRU0gSUQ6IFRZQU4gICAgIFByb2R1Y3QgSUQ6IEdVSU5ORVNTICAgICBB
UElDIGF0OiAweEZFRTAwMDAwDQpQcm9jZXNzb3IgIzEgUGVudGl1bSh0bSkg
UHJvIEFQSUMgdmVyc2lvbiAxNg0KUHJvY2Vzc29yICMwIFBlbnRpdW0odG0p
IFBybyBBUElDIHZlcnNpb24gMTYNCkkvTyBBUElDICMyIFZlcnNpb24gMTcg
YXQgMHhGRUMwMDAwMC4NClByb2Nlc3NvcnM6IDINCktlcm5lbCBjb21tYW5k
IGxpbmU6IGF1dG8gQk9PVF9JTUFHRT1saW51eCBybyByb290PTkwMCBCT09U
X0ZJTEU9L2Jvb3Qvdm1saW51ei0yLjQuMTgtM2JpZ21lbSBpZGU9cmV2ZXJz
ZQ0KaWRlX3NldHVwOiBpZGU9cmV2ZXJzZSA6IEVuYWJsZWQgc3VwcG9ydCBm
b3IgSURFIGludmVyc2Ugc2NhbiBvcmRlci4NCkluaXRpYWxpemluZyBDUFUj
MA0KRGV0ZWN0ZWQgOTk3LjQ3OCBNSHogcHJvY2Vzc29yLg0KQ29uc29sZTog
Y29sb3VyIFZHQSsgODB4MjUNCkNhbGlicmF0aW5nIGRlbGF5IGxvb3AuLi4g
MTk5Mi4yOSBCb2dvTUlQUw0KTWVtb3J5OiAyNTQ3MDhrLzI2MjE0NGsgYXZh
aWxhYmxlICgxMjQ4ayBrZXJuZWwgY29kZSwgNzA0OGsgcmVzZXJ2ZWQsIDg2
MWsgZGF0YSwgMzEyayBpbml0LCAwayBoaWdobWVtKQ0KRGVudHJ5IGNhY2hl
IGhhc2ggdGFibGUgZW50cmllczogMzI3NjggKG9yZGVyOiA2LCAyNjIxNDQg
Ynl0ZXMpDQpJbm9kZSBjYWNoZSBoYXNoIHRhYmxlIGVudHJpZXM6IDE2Mzg0
IChvcmRlcjogNSwgMTMxMDcyIGJ5dGVzKQ0KTW91bnQtY2FjaGUgaGFzaCB0
YWJsZSBlbnRyaWVzOiA0MDk2IChvcmRlcjogMywgMzI3NjggYnl0ZXMpDQpC
dWZmZXIgY2FjaGUgaGFzaCB0YWJsZSBlbnRyaWVzOiAxNjM4NCAob3JkZXI6
IDQsIDY1NTM2IGJ5dGVzKQ0KUGFnZS1jYWNoZSBoYXNoIHRhYmxlIGVudHJp
ZXM6IDY1NTM2IChvcmRlcjogNiwgMjYyMTQ0IGJ5dGVzKQ0KQ1BVOiBCZWZv
cmUgdmVuZG9yIGluaXQsIGNhcHM6IDAxODNmYmZmIGMxYzdmYmZmIDAwMDAw
MDAwLCB2ZW5kb3IgPSAyDQpDUFU6IEwxIEkgQ2FjaGU6IDY0SyAoNjQgYnl0
ZXMvbGluZSksIEQgY2FjaGUgNjRLICg2NCBieXRlcy9saW5lKQ0KQ1BVOiBM
MiBDYWNoZTogMjU2SyAoNjQgYnl0ZXMvbGluZSkNCkNQVTogQWZ0ZXIgdmVu
ZG9yIGluaXQsIGNhcHM6IDAxODNmYmZmIGMxYzdmYmZmIDAwMDAwMDAwIDAw
MDAwMDAwDQpJbnRlbCBtYWNoaW5lIGNoZWNrIGFyY2hpdGVjdHVyZSBzdXBw
b3J0ZWQuDQpJbnRlbCBtYWNoaW5lIGNoZWNrIHJlcG9ydGluZyBlbmFibGVk
IG9uIENQVSMwLg0KQ1BVOiAgICAgQWZ0ZXIgZ2VuZXJpYywgY2FwczogMDE4
M2ZiZmYgYzFjN2ZiZmYgMDAwMDAwMDAgMDAwMDAwMDANCkNQVTogICAgICAg
ICAgICAgQ29tbW9uIGNhcHM6IDAxODNmYmZmIGMxYzdmYmZmIDAwMDAwMDAw
IDAwMDAwMDAwDQpFbmFibGluZyBmYXN0IEZQVSBzYXZlIGFuZCByZXN0b3Jl
Li4uIGRvbmUuDQpDaGVja2luZyAnaGx0JyBpbnN0cnVjdGlvbi4uLiBPSy4N
ClBPU0lYIGNvbmZvcm1hbmNlIHRlc3RpbmcgYnkgVU5JRklYDQptdHJyOiB2
MS40MCAoMjAwMTAzMjcpIFJpY2hhcmQgR29vY2ggKHJnb29jaEBhdG5mLmNz
aXJvLmF1KQ0KbXRycjogZGV0ZWN0ZWQgbXRyciB0eXBlOiBJbnRlbA0KQ1BV
OiBCZWZvcmUgdmVuZG9yIGluaXQsIGNhcHM6IDAxODNmYmZmIGMxYzdmYmZm
IDAwMDAwMDAwLCB2ZW5kb3IgPSAyDQpDUFU6IEwxIEkgQ2FjaGU6IDY0SyAo
NjQgYnl0ZXMvbGluZSksIEQgY2FjaGUgNjRLICg2NCBieXRlcy9saW5lKQ0K
Q1BVOiBMMiBDYWNoZTogMjU2SyAoNjQgYnl0ZXMvbGluZSkNCkNQVTogQWZ0
ZXIgdmVuZG9yIGluaXQsIGNhcHM6IDAxODNmYmZmIGMxYzdmYmZmIDAwMDAw
MDAwIDAwMDAwMDAwDQpJbnRlbCBtYWNoaW5lIGNoZWNrIHJlcG9ydGluZyBl
bmFibGVkIG9uIENQVSMwLg0KQ1BVOiAgICAgQWZ0ZXIgZ2VuZXJpYywgY2Fw
czogMDE4M2ZiZmYgYzFjN2ZiZmYgMDAwMDAwMDAgMDAwMDAwMDANCkNQVTog
ICAgICAgICAgICAgQ29tbW9uIGNhcHM6IDAxODNmYmZmIGMxYzdmYmZmIDAw
MDAwMDAwIDAwMDAwMDAwDQpDUFUwOiBBTUQgQXRobG9uKHRtKSBQcm9jZXNz
b3Igc3RlcHBpbmcgMDINCnBlci1DUFUgdGltZXNsaWNlIGN1dG9mZjogNzMx
LjcwIHVzZWNzLg0KdGFzayBtaWdyYXRpb24gY2FjaGUgZGVjYXkgdGltZW91
dDogMTAgbXNlY3MuDQplbmFibGVkIEV4dElOVCBvbiBDUFUjMA0KRVNSIHZh
bHVlIGJlZm9yZSBlbmFibGluZyB2ZWN0b3I6IDAwMDAwMDAwDQpFU1IgdmFs
dWUgYWZ0ZXIgZW5hYmxpbmcgdmVjdG9yOiAwMDAwMDAwMA0KQm9vdGluZyBw
cm9jZXNzb3IgMS8wIGVpcCAyMDAwDQpJbml0aWFsaXppbmcgQ1BVIzENCm1h
c2tlZCBFeHRJTlQgb24gQ1BVIzENCkVTUiB2YWx1ZSBiZWZvcmUgZW5hYmxp
bmcgdmVjdG9yOiAwMDAwMDAwMA0KRVNSIHZhbHVlIGFmdGVyIGVuYWJsaW5n
IHZlY3RvcjogMDAwMDAwMDANCkNhbGlicmF0aW5nIGRlbGF5IGxvb3AuLi4g
MTk5Mi4yOSBCb2dvTUlQUw0KQ1BVOiBCZWZvcmUgdmVuZG9yIGluaXQsIGNh
cHM6IDAxODNmYmZmIGMxYzdmYmZmIDAwMDAwMDAwLCB2ZW5kb3IgPSAyDQpD
UFU6IEwxIEkgQ2FjaGU6IDY0SyAoNjQgYnl0ZXMvbGluZSksIEQgY2FjaGUg
NjRLICg2NCBieXRlcy9saW5lKQ0KQ1BVOiBMMiBDYWNoZTogMjU2SyAoNjQg
Ynl0ZXMvbGluZSkNCkNQVTogQWZ0ZXIgdmVuZG9yIGluaXQsIGNhcHM6IDAx
ODNmYmZmIGMxYzdmYmZmIDAwMDAwMDAwIDAwMDAwMDAwDQpJbnRlbCBtYWNo
aW5lIGNoZWNrIHJlcG9ydGluZyBlbmFibGVkIG9uIENQVSMxLg0KQ1BVOiAg
ICAgQWZ0ZXIgZ2VuZXJpYywgY2FwczogMDE4M2ZiZmYgYzFjN2ZiZmYgMDAw
MDAwMDAgMDAwMDAwMDANCkNQVTogICAgICAgICAgICAgQ29tbW9uIGNhcHM6
IDAxODNmYmZmIGMxYzdmYmZmIDAwMDAwMDAwIDAwMDAwMDAwDQpDUFUxOiBB
TUQgQXRobG9uKHRtKSBQcm9jZXNzb3Igc3RlcHBpbmcgMDINClRvdGFsIG9m
IDIgcHJvY2Vzc29ycyBhY3RpdmF0ZWQgKDM5ODQuNTggQm9nb01JUFMpLg0K
RU5BQkxJTkcgSU8tQVBJQyBJUlFzDQpTZXR0aW5nIDIgaW4gdGhlIHBoeXNf
aWRfcHJlc2VudF9tYXANCi4uLmNoYW5naW5nIElPLUFQSUMgcGh5c2ljYWwg
QVBJQyBJRCB0byAyIC4uLiBvay4NCmluaXQgSU9fQVBJQyBJUlFzDQogSU8t
QVBJQyAoYXBpY2lkLXBpbikgMi0wLCAyLTE2LCAyLTE3LCAyLTE4LCAyLTE5
LCAyLTIwLCAyLTIxLCAyLTIyLCAyLTIzIG5vdCBjb25uZWN0ZWQuDQouLlRJ
TUVSOiB2ZWN0b3I9MHgzMSBwaW4xPTIgcGluMj0wDQpudW1iZXIgb2YgTVAg
SVJRIHNvdXJjZXM6IDE2Lg0KbnVtYmVyIG9mIElPLUFQSUMgIzIgcmVnaXN0
ZXJzOiAyNC4NCnRlc3RpbmcgdGhlIElPIEFQSUMuLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLg0KDQpJTyBBUElDICMyLi4uLi4uDQouLi4uIHJlZ2lzdGVyICMw
MDogMDIwMDAwMDANCi4uLi4uLi4gICAgOiBwaHlzaWNhbCBBUElDIGlkOiAw
Mg0KLi4uLiByZWdpc3RlciAjMDE6IDAwMTcwMDExDQouLi4uLi4uICAgICA6
IG1heCByZWRpcmVjdGlvbiBlbnRyaWVzOiAwMDE3DQouLi4uLi4uICAgICA6
IFBSUSBpbXBsZW1lbnRlZDogMA0KLi4uLi4uLiAgICAgOiBJTyBBUElDIHZl
cnNpb246IDAwMTENCi4uLi4gcmVnaXN0ZXIgIzAyOiAwMDAwMDAwMA0KLi4u
Li4uLiAgICAgOiBhcmJpdHJhdGlvbjogMDANCi4uLi4gSVJRIHJlZGlyZWN0
aW9uIHRhYmxlOg0KIE5SIExvZyBQaHkgTWFzayBUcmlnIElSUiBQb2wgU3Rh
dCBEZXN0IERlbGkgVmVjdDogICANCiAwMCAwMDAgMDAgIDEgICAgMCAgICAw
ICAgMCAgIDAgICAgMCAgICAwICAgIDAwDQogMDEgMDAzIDAzICAwICAgIDAg
ICAgMCAgIDAgICAwICAgIDEgICAgMSAgICAzOQ0KIDAyIDAwMyAwMyAgMCAg
ICAwICAgIDAgICAwICAgMCAgICAxICAgIDEgICAgMzENCiAwMyAwMDMgMDMg
IDEgICAgMSAgICAwICAgMSAgIDAgICAgMSAgICAxICAgIDQxDQogMDQgMDAz
IDAzICAwICAgIDAgICAgMCAgIDAgICAwICAgIDEgICAgMSAgICA0OQ0KIDA1
IDAwMyAwMyAgMSAgICAxICAgIDAgICAxICAgMCAgICAxICAgIDEgICAgNTEN
CiAwNiAwMDMgMDMgIDAgICAgMCAgICAwICAgMCAgIDAgICAgMSAgICAxICAg
IDU5DQogMDcgMDAzIDAzICAwICAgIDAgICAgMCAgIDAgICAwICAgIDEgICAg
MSAgICA2MQ0KIDA4IDAwMyAwMyAgMCAgICAwICAgIDAgICAwICAgMCAgICAx
ICAgIDEgICAgNjkNCiAwOSAwMDMgMDMgIDAgICAgMCAgICAwICAgMCAgIDAg
ICAgMSAgICAxICAgIDcxDQogMGEgMDAzIDAzICAxICAgIDEgICAgMCAgIDEg
ICAwICAgIDEgICAgMSAgICA3OQ0KIDBiIDAwMyAwMyAgMSAgICAxICAgIDAg
ICAxICAgMCAgICAxICAgIDEgICAgODENCiAwYyAwMDMgMDMgIDAgICAgMCAg
ICAwICAgMCAgIDAgICAgMSAgICAxICAgIDg5DQogMGQgMDAzIDAzICAwICAg
IDAgICAgMCAgIDAgICAwICAgIDEgICAgMSAgICA5MQ0KIDBlIDAwMyAwMyAg
MCAgICAwICAgIDAgICAwICAgMCAgICAxICAgIDEgICAgOTkNCiAwZiAwMDMg
MDMgIDAgICAgMCAgICAwICAgMCAgIDAgICAgMSAgICAxICAgIEExDQogMTAg
MDAwIDAwICAxICAgIDAgICAgMCAgIDAgICAwICAgIDAgICAgMCAgICAwMA0K
IDExIDAwMCAwMCAgMSAgICAwICAgIDAgICAwICAgMCAgICAwICAgIDAgICAg
MDANCiAxMiAwMDAgMDAgIDEgICAgMCAgICAwICAgMCAgIDAgICAgMCAgICAw
ICAgIDAwDQogMTMgMDAwIDAwICAxICAgIDAgICAgMCAgIDAgICAwICAgIDAg
ICAgMCAgICAwMA0KIDE0IDAwMCAwMCAgMSAgICAwICAgIDAgICAwICAgMCAg
ICAwICAgIDAgICAgMDANCiAxNSAwMDAgMDAgIDEgICAgMCAgICAwICAgMCAg
IDAgICAgMCAgICAwICAgIDAwDQogMTYgMDAwIDAwICAxICAgIDAgICAgMCAg
IDAgICAwICAgIDAgICAgMCAgICAwMA0KIDE3IDAwMCAwMCAgMSAgICAwICAg
IDAgICAwICAgMCAgICAwICAgIDAgICAgMDANCklSUSB0byBwaW4gbWFwcGlu
Z3M6DQpJUlEwIC0+IDA6Mg0KSVJRMSAtPiAwOjENCklSUTMgLT4gMDozDQpJ
UlE0IC0+IDA6NA0KSVJRNSAtPiAwOjUNCklSUTYgLT4gMDo2DQpJUlE3IC0+
IDA6Nw0KSVJROCAtPiAwOjgNCklSUTkgLT4gMDo5DQpJUlExMCAtPiAwOjEw
DQpJUlExMSAtPiAwOjExDQpJUlExMiAtPiAwOjEyDQpJUlExMyAtPiAwOjEz
DQpJUlExNCAtPiAwOjE0DQpJUlExNSAtPiAwOjE1DQouLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4gZG9uZS4NClVzaW5nIGxvY2FsIEFQ
SUMgdGltZXIgaW50ZXJydXB0cy4NCmNhbGlicmF0aW5nIEFQSUMgdGltZXIg
Li4uDQouLi4uLiBDUFUgY2xvY2sgc3BlZWQgaXMgOTk3LjQ1OTEgTUh6Lg0K
Li4uLi4gaG9zdCBidXMgY2xvY2sgc3BlZWQgaXMgMjY1Ljk4OTEgTUh6Lg0K
Y3B1OiAwLCBjbG9ja3M6IDI2NTk4OTEsIHNsaWNlOiA4ODY2MzANCkNQVTA8
VDA6MjY1OTg4OCxUMToxNzczMjQ4LEQ6MTAsUzo4ODY2MzAsQzoyNjU5ODkx
Pg0KY3B1OiAxLCBjbG9ja3M6IDI2NTk4OTEsIHNsaWNlOiA4ODY2MzANCkNQ
VTE8VDA6MjY1OTg4OCxUMTo4ODY2MjQsRDo0LFM6ODg2NjMwLEM6MjY1OTg5
MT4NCmNoZWNraW5nIFRTQyBzeW5jaHJvbml6YXRpb24gYWNyb3NzIENQVXM6
IHBhc3NlZC4NCm10cnI6IHlvdXIgQ1BVcyBoYWQgaW5jb25zaXN0ZW50IGZp
eGVkIE1UUlIgc2V0dGluZ3MNCm10cnI6IHByb2JhYmx5IHlvdXIgQklPUyBk
b2VzIG5vdCBzZXR1cCBhbGwgQ1BVcw0KUENJOiBQQ0kgQklPUyByZXZpc2lv
biAyLjEwIGVudHJ5IGF0IDB4ZmQ3YzAsIGxhc3QgYnVzPTENClBDSTogVXNp
bmcgY29uZmlndXJhdGlvbiB0eXBlIDENClBDSTogUHJvYmluZyBQQ0kgaGFy
ZHdhcmUNClVua25vd24gYnJpZGdlIHJlc291cmNlIDA6IGFzc3VtaW5nIHRy
YW5zcGFyZW50DQpVbmtub3duIGJyaWRnZSByZXNvdXJjZSAxOiBhc3N1bWlu
ZyB0cmFuc3BhcmVudA0KVW5rbm93biBicmlkZ2UgcmVzb3VyY2UgMjogYXNz
dW1pbmcgdHJhbnNwYXJlbnQNCkJJT1MgZmFpbGVkIHRvIGVuYWJsZSBQQ0kg
c3RhbmRhcmRzIGNvbXBsaWFuY2UsIGZpeGluZyB0aGlzIGVycm9yLg0KSS9P
IEFQSUM6IEFNRCBFcnJhdGEgIzIyIG1heSBiZSBwcmVzZW50LiBJbiB0aGUg
ZXZlbnQgb2YgaW5zdGFiaWxpdHkgdHJ5DQogICAgICAgIDogYm9vdGluZyB3
aXRoIHRoZSAibm9hcGljIiBvcHRpb24uDQppc2FwbnA6IFNjYW5uaW5nIGZv
ciBQblAgY2FyZHMuLi4NCmlzYXBucDogTm8gUGx1ZyAmIFBsYXkgZGV2aWNl
IGZvdW5kDQpMaW51eCBORVQ0LjAgZm9yIExpbnV4IDIuNA0KQmFzZWQgdXBv
biBTd2Fuc2VhIFVuaXZlcnNpdHkgQ29tcHV0ZXIgU29jaWV0eSBORVQzLjAz
OQ0KSW5pdGlhbGl6aW5nIFJUIG5ldGxpbmsgc29ja2V0DQphcG06IEJJT1Mg
bm90IGZvdW5kLg0KU3RhcnRpbmcga3N3YXBkDQpWRlM6IERpc2txdW90YXMg
dmVyc2lvbiBkcXVvdF82LjUuMCBpbml0aWFsaXplZA0KcHR5OiAyMDQ4IFVu
aXg5OCBwdHlzIGNvbmZpZ3VyZWQNClNlcmlhbCBkcml2ZXIgdmVyc2lvbiA1
LjA1YyAoMjAwMS0wNy0wOCkgd2l0aCBNQU5ZX1BPUlRTIE1VTFRJUE9SVCBT
SEFSRV9JUlEgU0VSSUFMX1BDSSBJU0FQTlAgZW5hYmxlZA0KdHR5UzAwIGF0
IDB4MDNmOCAoaXJxID0gNCkgaXMgYSAxNjU1MEENClJlYWwgVGltZSBDbG9j
ayBEcml2ZXIgdjEuMTBlDQpibG9jazogNDgwIHNsb3RzIHBlciBxdWV1ZSwg
YmF0Y2g9MTIwDQpVbmlmb3JtIE11bHRpLVBsYXRmb3JtIEUtSURFIGRyaXZl
ciBSZXZpc2lvbjogNi4zMQ0KaWRlOiBBc3N1bWluZyAzM01IeiBzeXN0ZW0g
YnVzIHNwZWVkIGZvciBQSU8gbW9kZXM7IG92ZXJyaWRlIHdpdGggaWRlYnVz
PXh4DQpTaUkzMTEyOiBJREUgY29udHJvbGxlciBvbiBQQ0kgYnVzIDAwIGRl
diA1MA0KU2lJMzExMjogY2hpcHNldCByZXZpc2lvbiAxDQpTaUkzMTEyOiBu
b3QgMTAwJSBuYXRpdmUgbW9kZTogd2lsbCBwcm9iZSBpcnFzIGxhdGVyDQpT
aUkzMTEyOiBCQVNFIENMT0NLID09IDEwMCANCiAgICBpZGUwOiBNTUlPLURN
QSBhdCAweGQwODBkMDAwLTB4ZDA4MGQwMDcsIEJJT1Mgc2V0dGluZ3M6IGhk
YTpETUEsIGhkYjpwaW8NCiAgICBpZGUxOiBNTUlPLURNQSBhdCAweGQwODBk
MDA4LTB4ZDA4MGQwMGYsIEJJT1Mgc2V0dGluZ3M6IGhkYzpETUEsIGhkZDpw
aW8NCkFNRDc0MTE6IElERSBjb250cm9sbGVyIG9uIFBDSSBidXMgMDAgZGV2
IDM5DQpBTUQ3NDExOiBjaGlwc2V0IHJldmlzaW9uIDENCkFNRDc0MTE6IG5v
dCAxMDAlIG5hdGl2ZSBtb2RlOiB3aWxsIHByb2JlIGlycXMgbGF0ZXINCiAg
ICBpZGUyOiBCTS1ETUEgYXQgMHhmMDAwLTB4ZjAwNywgQklPUyBzZXR0aW5n
czogaGRlOkRNQSwgaGRmOnBpbw0KICAgIGlkZTM6IEJNLURNQSBhdCAweGYw
MDgtMHhmMDBmLCBCSU9TIHNldHRpbmdzOiBoZGc6cGlvLCBoZGg6cGlvDQpo
ZGE6IFNUMzIwMDExQSwgQVRBIERJU0sgZHJpdmUNCmJsazogcXVldWUgYzAz
ZWZjMjQsIEkvTyBsaW1pdCA0MDk1TWIgKG1hc2sgMHhmZmZmZmZmZikNCmhk
YzogU1QzMjAwMTFBLCBBVEEgRElTSyBkcml2ZQ0KYmxrOiBxdWV1ZSBjMDNm
MDAwOCwgSS9PIGxpbWl0IDQwOTVNYiAobWFzayAweGZmZmZmZmZmKQ0KaGRl
OiBNYXh0b3IgNTQ2MTBINiwgQVRBIERJU0sgZHJpdmUNCmhkZzogQ0QtUk9N
IENEVTYxMSwgQVRBUEkgQ0QvRFZELVJPTSBkcml2ZQ0KaWRlMCBhdCAweGQw
ODBkMDgwLTB4ZDA4MGQwODcsMHhkMDgwZDA4YSBvbiBpcnEgMw0KaWRlMSBh
dCAweGQwODBkMGMwLTB4ZDA4MGQwYzcsMHhkMDgwZDBjYSBvbiBpcnEgMw0K
aWRlMiBhdCAweDFmMC0weDFmNywweDNmNiBvbiBpcnEgMTQNCmlkZTMgYXQg
MHgxNzAtMHgxNzcsMHgzNzYgb24gaXJxIDE1DQpoZGE6IDM5MTAyMzM2IHNl
Y3RvcnMgKDIwMDIwIE1CKSB3LzIwNDhLaUIgQ2FjaGUsIENIUz0zODc5Mi8x
Ni82MywgVURNQSgxMDApDQpoZGM6IDM5MTAyMzM2IHNlY3RvcnMgKDIwMDIw
IE1CKSB3LzIwNDhLaUIgQ2FjaGUsIENIUz0zODc5Mi8xNi82MywgVURNQSgx
MDApDQpoZGU6IDkwMDQ1NjQ4IHNlY3RvcnMgKDQ2MTAzIE1CKSB3LzIwNDhL
aUIgQ2FjaGUsIENIUz01NjA1LzI1NS82MywgVURNQSgxMDApDQppZGUtZmxv
cHB5IGRyaXZlciAwLjk5Lm5ld2lkZQ0KUGFydGl0aW9uIGNoZWNrOg0KIGhk
YTogW1BUQkxdIFsyNDM0LzI1NS82M10gaGRhMQ0KIGhkYzogaGRjMQ0KIGhk
ZTogaGRlMSBoZGUyIGhkZTMgaGRlNCA8IGhkZTUgaGRlNiBoZGU3ID4NCkZs
b3BweSBkcml2ZShzKTogZmQwIGlzIDEuNDRNDQpGREMgMCBpcyBhIHBvc3Qt
MTk5MSA4MjA3Nw0KUkFNRElTSyBkcml2ZXIgaW5pdGlhbGl6ZWQ6IDE2IFJB
TSBkaXNrcyBvZiA0MDk2SyBzaXplIDEwMjQgYmxvY2tzaXplDQppZGUtZmxv
cHB5IGRyaXZlciAwLjk5Lm5ld2lkZQ0KbWQ6IG1kIGRyaXZlciAwLjkwLjAg
TUFYX01EX0RFVlM9MjU2LCBNRF9TQl9ESVNLUz0yNw0KbWQ6IEF1dG9kZXRl
Y3RpbmcgUkFJRCBhcnJheXMuDQogW2V2ZW50czogMDAwMDAwMDRdDQogW2V2
ZW50czogMDAwMDAwMDRdDQptZDogYXV0b3J1biAuLi4NCm1kOiBjb25zaWRl
cmluZyBoZGMxIC4uLg0KbWQ6ICBhZGRpbmcgaGRjMSAuLi4NCm1kOiAgYWRk
aW5nIGhkYTEgLi4uDQptZDogY3JlYXRlZCBtZDANCm1kOiBiaW5kPGhkYTEs
MT4NCm1kOiBiaW5kPGhkYzEsMj4NCm1kOiBydW5uaW5nOiA8aGRjMT48aGRh
MT4NCm1kOiBoZGMxJ3MgZXZlbnQgY291bnRlcjogMDAwMDAwMDQNCm1kOiBo
ZGExJ3MgZXZlbnQgY291bnRlcjogMDAwMDAwMDQNCm1kOiBtZDA6IHJhaWQg
YXJyYXkgaXMgbm90IGNsZWFuIC0tIHN0YXJ0aW5nIGJhY2tncm91bmQgcmVj
b25zdHJ1Y3Rpb24NCm1kOiBSQUlEIGxldmVsIDEgZG9lcyBub3QgbmVlZCBj
aHVua3NpemUhIENvbnRpbnVpbmcgYW55d2F5Lg0Ka21vZDogZmFpbGVkIHRv
IGV4ZWMgL3NiaW4vbW9kcHJvYmUgLXMgLWsgbWQtcGVyc29uYWxpdHktMywg
ZXJybm8gPSAyDQptZDogcGVyc29uYWxpdHkgMyBpcyBub3QgbG9hZGVkIQ0K
bWQgOmRvX21kX3J1bigpIHJldHVybmVkIC0yMg0KbWQ6IG1kMCBzdG9wcGVk
Lg0KbWQ6IHVuYmluZDxoZGMxLDE+DQptZDogZXhwb3J0X3JkZXYoaGRjMSkN
Cm1kOiB1bmJpbmQ8aGRhMSwwPg0KbWQ6IGV4cG9ydF9yZGV2KGhkYTEpDQpt
ZDogLi4uIGF1dG9ydW4gRE9ORS4NCnBjaV9ob3RwbHVnOiBQQ0kgSG90IFBs
dWcgUENJIENvcmUgdmVyc2lvbjogMC40DQpORVQ0OiBMaW51eCBUQ1AvSVAg
MS4wIGZvciBORVQ0LjANCklQIFByb3RvY29sczogSUNNUCwgVURQLCBUQ1As
IElHTVANCklQOiByb3V0aW5nIGNhY2hlIGhhc2ggdGFibGUgb2YgMjA0OCBi
dWNrZXRzLCAxNktieXRlcw0KVENQOiBIYXNoIHRhYmxlcyBjb25maWd1cmVk
IChlc3RhYmxpc2hlZCAxNjM4NCBiaW5kIDE2Mzg0KQ0KTGludXggSVAgbXVs
dGljYXN0IHJvdXRlciAwLjA2IHBsdXMgUElNLVNNDQpORVQ0OiBVbml4IGRv
bWFpbiBzb2NrZXRzIDEuMC9TTVAgZm9yIExpbnV4IE5FVDQuMC4NClJBTURJ
U0s6IENvbXByZXNzZWQgaW1hZ2UgZm91bmQgYXQgYmxvY2sgMA0KRnJlZWlu
ZyBpbml0cmQgbWVtb3J5OiAyNTNrIGZyZWVkDQpWRlM6IE1vdW50ZWQgcm9v
dCAoZXh0MiBmaWxlc3lzdGVtKS4NClNDU0kgc3Vic3lzdGVtIGRyaXZlciBS
ZXZpc2lvbjogMS4wMA0Ka21vZDogZmFpbGVkIHRvIGV4ZWMgL3NiaW4vbW9k
cHJvYmUgLXMgLWsgc2NzaV9ob3N0YWRhcHRlciwgZXJybm8gPSAyDQpzY3Np
MCA6IEFkYXB0ZWMgQUlDN1hYWCBFSVNBL1ZMQi9QQ0kgU0NTSSBIQkEgRFJJ
VkVSLCBSZXYgNi4yLjUNCiAgICAgICAgPEFkYXB0ZWMgYWljNzg5OSBVbHRy
YTE2MCBTQ1NJIGFkYXB0ZXI+DQogICAgICAgIGFpYzc4OTk6IFVsdHJhMTYw
IFdpZGUgQ2hhbm5lbCBBLCBTQ1NJIElkPTcsIDMyLzI1MyBTQ0JzDQoNCnNj
c2kxIDogQWRhcHRlYyBBSUM3WFhYIEVJU0EvVkxCL1BDSSBTQ1NJIEhCQSBE
UklWRVIsIFJldiA2LjIuNQ0KICAgICAgICA8QWRhcHRlYyBhaWM3ODk5IFVs
dHJhMTYwIFNDU0kgYWRhcHRlcj4NCiAgICAgICAgYWljNzg5OTogVWx0cmEx
NjAgV2lkZSBDaGFubmVsIEIsIFNDU0kgSWQ9NywgMzIvMjUzIFNDQnMNCg0K
ICBWZW5kb3I6IFFVQU5UVU0gICBNb2RlbDogVklLSU5HIDQuNSBXU0UgICAg
UmV2OiA4ODBSDQogIFR5cGU6ICAgRGlyZWN0LUFjY2VzcyAgICAgICAgICAg
ICAgICAgICAgICBBTlNJIFNDU0kgcmV2aXNpb246IDAyDQogIFZlbmRvcjog
UVVBTlRVTSAgIE1vZGVsOiBWSUtJTkcgSUkgNC41V0xTICBSZXY6IDU1NTIN
CiAgVHlwZTogICBEaXJlY3QtQWNjZXNzICAgICAgICAgICAgICAgICAgICAg
IEFOU0kgU0NTSSByZXZpc2lvbjogMDINCnNjc2kwOkE6MTowOiBUYWdnZWQg
UXVldWluZyBlbmFibGVkLiAgRGVwdGggMjUzDQpzY3NpMDpBOjI6MDogVGFn
Z2VkIFF1ZXVpbmcgZW5hYmxlZC4gIERlcHRoIDI1Mw0KQXR0YWNoZWQgc2Nz
aSBkaXNrIHNkYSBhdCBzY3NpMCwgY2hhbm5lbCAwLCBpZCAxLCBsdW4gMA0K
QXR0YWNoZWQgc2NzaSBkaXNrIHNkYiBhdCBzY3NpMCwgY2hhbm5lbCAwLCBp
ZCAyLCBsdW4gMA0KKHNjc2kwOkE6MSk6IDQwLjAwME1CL3MgdHJhbnNmZXJz
ICgyMC4wMDBNSHosIG9mZnNldCAzMSwgMTZiaXQpDQpTQ1NJIGRldmljZSBz
ZGE6IDg4OTk3MzcgNTEyLWJ5dGUgaGR3ciBzZWN0b3JzICg0NTU3IE1CKQ0K
IHNkYTogc2RhMQ0KKHNjc2kwOkE6Mik6IDQwLjAwME1CL3MgdHJhbnNmZXJz
ICgyMC4wMDBNSHosIG9mZnNldCAzMSwgMTZiaXQpDQpTQ1NJIGRldmljZSBz
ZGI6IDg5MTA0MjMgNTEyLWJ5dGUgaGR3ciBzZWN0b3JzICg0NTYyIE1CKQ0K
IHNkYjogc2RiMQ0KbWQ6IHJhaWQxIHBlcnNvbmFsaXR5IHJlZ2lzdGVyZWQg
YXMgbnIgMw0KSm91cm5hbGxlZCBCbG9jayBEZXZpY2UgZHJpdmVyIGxvYWRl
ZA0KbWQ6IEF1dG9kZXRlY3RpbmcgUkFJRCBhcnJheXMuDQogW2V2ZW50czog
MDAwMDAwMDRdDQogW2V2ZW50czogMDAwMDAwMDRdDQptZDogYXV0b3J1biAu
Li4NCm1kOiBjb25zaWRlcmluZyBoZGExIC4uLg0KbWQ6ICBhZGRpbmcgaGRh
MSAuLi4NCm1kOiAgYWRkaW5nIGhkYzEgLi4uDQptZDogY3JlYXRlZCBtZDAN
Cm1kOiBiaW5kPGhkYzEsMT4NCm1kOiBiaW5kPGhkYTEsMj4NCm1kOiBydW5u
aW5nOiA8aGRhMT48aGRjMT4NCm1kOiBoZGExJ3MgZXZlbnQgY291bnRlcjog
MDAwMDAwMDQNCm1kOiBoZGMxJ3MgZXZlbnQgY291bnRlcjogMDAwMDAwMDQN
Cm1kOiBtZDA6IHJhaWQgYXJyYXkgaXMgbm90IGNsZWFuIC0tIHN0YXJ0aW5n
IGJhY2tncm91bmQgcmVjb25zdHJ1Y3Rpb24NCm1kOiBSQUlEIGxldmVsIDEg
ZG9lcyBub3QgbmVlZCBjaHVua3NpemUhIENvbnRpbnVpbmcgYW55d2F5Lg0K
bWQwOiBtYXggdG90YWwgcmVhZGFoZWFkIHdpbmRvdyBzZXQgdG8gNTA4aw0K
bWQwOiAxIGRhdGEtZGlza3MsIG1heCByZWFkYWhlYWQgcGVyIGRhdGEtZGlz
azogNTA4aw0KcmFpZDE6IGRldmljZSBoZGExIG9wZXJhdGlvbmFsIGFzIG1p
cnJvciAwDQpyYWlkMTogZGV2aWNlIGhkYzEgb3BlcmF0aW9uYWwgYXMgbWly
cm9yIDENCnJhaWQxOiByYWlkIHNldCBtZDAgbm90IGNsZWFuOyByZWNvbnN0
cnVjdGluZyBtaXJyb3JzDQpyYWlkMTogcmFpZCBzZXQgbWQwIGFjdGl2ZSB3
aXRoIDIgb3V0IG9mIDIgbWlycm9ycw0KbWQ6IHVwZGF0aW5nIG1kMCBSQUlE
IHN1cGVyYmxvY2sgb24gZGV2aWNlDQptZDogaGRhMSBbZXZlbnRzOiAwMDAw
MDAwNV08Nj4od3JpdGUpIGhkYTEncyBzYiBvZmZzZXQ6IDE5NTUwOTc2DQpt
ZDogc3luY2luZyBSQUlEIGFycmF5IG1kMA0KbWQ6IG1pbmltdW0gX2d1YXJh
bnRlZWRfIHJlY29uc3RydWN0aW9uIHNwZWVkOiAxMDAgS0Ivc2VjL2Rpc2Mu
DQptZDogdXNpbmcgbWF4aW11bSBhdmFpbGFibGUgaWRsZSBJTyBiYW5kd2l0
aCAoYnV0IG5vdCBtb3JlIHRoYW4gMTAwMDAwIEtCL3NlYykgZm9yIHJlY29u
c3RydWN0aW9uLg0KbWQ6IHVzaW5nIDUwOGsgd2luZG93LCBvdmVyIGEgdG90
YWwgb2YgMTk1NTA5NzYgYmxvY2tzLg0KbWQ6IGhkYzEgW2V2ZW50czogMDAw
MDAwMDVdPDY+KHdyaXRlKSBoZGMxJ3Mgc2Igb2Zmc2V0OiAxOTU1MTA0MA0K
bWQ6IC4uLiBhdXRvcnVuIERPTkUuDQpram91cm5hbGQgc3RhcnRpbmcuICBD
b21taXQgaW50ZXJ2YWwgNSBzZWNvbmRzDQpFWFQzLWZzOiBtb3VudGVkIGZp
bGVzeXN0ZW0gd2l0aCBvcmRlcmVkIGRhdGEgbW9kZS4NCkZyZWVpbmcgdW51
c2VkIGtlcm5lbCBtZW1vcnk6IDMxMmsgZnJlZWQNCnVzYi5jOiByZWdpc3Rl
cmVkIG5ldyBkcml2ZXIgdXNiZGV2ZnMNCnVzYi5jOiByZWdpc3RlcmVkIG5l
dyBkcml2ZXIgaHViDQp1c2Itb2hjaS5jOiBVU0IgT0hDSSBhdCBtZW1iYXNl
IDB4YzAwZGMwMDAsIElSUSAxMQ0KdXNiLW9oY2kuYzogdXNiLTAwOjA3LjQs
IEFkdmFuY2VkIE1pY3JvIERldmljZXMgW0FNRF0gQU1ELTc2NSBbVmlwZXJd
IFVTQg0KdXNiLmM6IG5ldyBVU0IgYnVzIHJlZ2lzdGVyZWQsIGFzc2lnbmVk
IGJ1cyBudW1iZXIgMQ0KaHViLmM6IFVTQiBodWIgZm91bmQNCmh1Yi5jOiA0
IHBvcnRzIGRldGVjdGVkDQpFWFQzIEZTIDIuNC0wLjkuMTcsIDEwIEphbiAy
MDAyIG9uIG1kKDksMCksIGludGVybmFsIGpvdXJuYWwNCmlkZS1mbG9wcHkg
ZHJpdmVyIDAuOTkubmV3aWRlDQpoZGc6IEFUQVBJIDEwWCBDRC1ST00gZHJp
dmUsIDI1NmtCIENhY2hlDQpVbmlmb3JtIENELVJPTSBkcml2ZXIgUmV2aXNp
b246IDMuMTINCmhkZzogRE1BIGRpc2FibGVkDQpwYXJwb3J0MDogUEMtc3R5
bGUgYXQgMHgzNzggW1BDU1BQXQ0KaXBfY29ubnRyYWNrICgyMDQ4IGJ1Y2tl
dHMsIDE2Mzg0IG1heCkNCmVlcHJvMTAwLmM6djEuMDlqLXQgOS8yOS85OSBE
b25hbGQgQmVja2VyIGh0dHA6Ly93d3cuc2N5bGQuY29tL25ldHdvcmsvZWVw
cm8xMDAuaHRtbA0KZWVwcm8xMDAuYzogJFJldmlzaW9uOiAxLjM2ICQgMjAw
MC8xMS8xNyBNb2RpZmllZCBieSBBbmRyZXkgVi4gU2F2b2Noa2luIDxzYXdA
c2F3LnN3LmNvbS5zZz4gYW5kIG90aGVycw0KZXRoMDogT0VNIGk4MjU1Ny9p
ODI1NTggMTAvMTAwIEV0aGVybmV0LCAwMDo5MDoyNzpFNTo4RDpCQiwgSVJR
IDUuDQogIEJvYXJkIGFzc2VtYmx5IDcyNzA5NS0wMDQsIFBoeXNpY2FsIGNv
bm5lY3RvcnMgcHJlc2VudDogUko0NQ0KICBQcmltYXJ5IGludGVyZmFjZSBj
aGlwIGk4MjU1NSBQSFkgIzEuDQogIEdlbmVyYWwgc2VsZi10ZXN0OiBwYXNz
ZWQuDQogIFNlcmlhbCBzdWItc3lzdGVtIHNlbGYtdGVzdDogcGFzc2VkLg0K
ICBJbnRlcm5hbCByZWdpc3RlcnMgc2VsZi10ZXN0OiBwYXNzZWQuDQogIFJP
TSBjaGVja3N1bSBzZWxmLXRlc3Q6IHBhc3NlZCAoMHgwNGY0NTE4YikuDQpJ
bnRlbChSKSBQUk8vMTAwMCBOZXR3b3JrIERyaXZlciAtIHZlcnNpb24gNC4x
LjcNCkNvcHlyaWdodCAoYykgMTk5OS0yMDAyIEludGVsIENvcnBvcmF0aW9u
Lg0KDQpDb21wYXEgR2lnYWJpdCBFdGhlcm5ldCBTZXJ2ZXIgQWRhcHRlcg0K
ZXRoMTogIE1lbToweGY0MDIwMDAwICBJUlE6MTAgIFNwZWVkOjEwMDAgTWJw
cyAgRHVwbGV4OkZ1bGwNCmV0aDA6IDAgbXVsdGljYXN0IGJsb2NrcyBkcm9w
cGVkLg0KZXRoMDogMCBtdWx0aWNhc3QgYmxvY2tzIGRyb3BwZWQuDQpJU08g
OTY2MCBFeHRlbnNpb25zOiBNaWNyb3NvZnQgSm9saWV0IExldmVsIDMNCklT
TyA5NjYwIEV4dGVuc2lvbnM6IFJSSVBfMTk5MUENCklTTyA5NjYwIEV4dGVu
c2lvbnM6IE1pY3Jvc29mdCBKb2xpZXQgTGV2ZWwgMw0KSVNPIDk2NjAgRXh0
ZW5zaW9uczogUlJJUF8xOTkxQQ0K
--1430322656-1703241051-1040173847=:31876--
