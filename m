Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131028AbRDFDNF>; Thu, 5 Apr 2001 23:13:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131063AbRDFDM4>; Thu, 5 Apr 2001 23:12:56 -0400
Received: from escape.com ([198.6.71.10]:63742 "HELO escape.com")
	by vger.kernel.org with SMTP id <S131028AbRDFDMn>;
	Thu, 5 Apr 2001 23:12:43 -0400
Date: Fri, 06 Apr 2001 03:13:54 UTC
From: "Robert A. Morris" <ramorris@dilithium.net>
Reply-To: ramorris@dilithium.net
Subject: 2.2.19 + ide 2.2.19 03252001 patch problem
To: linux-kernel@vger.kernel.org
Message-ID: <TradeClient.0.9.0.Linux-2.2.18.0104052013545D.1150@ryoko.unguez.net>
Organization: Massachusetts Institute of Technology
X-Mailer: TradeClient 0.9.0 [en_US] Linux 2.2.18
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
Importance: Normal
X-Accept-Language: en_US
Sensitivity: Public-Document
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recently upgraded my desktop machine to 2.2.19 plus
the ide.2.2.19.03252001.patch available from kernel.org
so that I may use DMA with my VIA 82C686A controller.
Now, when I attempt to mount or otherwise access
/dev/hdb, I get the following error:

Apr  5 18:15:14 ryoko kernel: hdb: task_no_data_intr: status=0x51 {
DriveReady SeekComplete Error }
Apr  5 18:15:14 ryoko kernel: hdb: task_no_data_intr: error=0x04 {
DriveStatusError }
Apr  5 18:15:14 ryoko kernel: hdb: Write Cache FAILED Flushing!

This did NOT happen with 2.2.18 and the corresponding 
ide.2.2.18.1209.patch.  It does NOT seem to happen on
/dev/hda or /dev/hdc, which is lucky, since /dev/hdb
is unused.  I'm using lilo.conf to specify idebus=33.

The controller is a VIA 82C686A (Asus K7V mainboard).
hda: WDC WD307AA, 29333MB w/2048kB Cache, CHS=3739/255/63, UDMA(66)
hdb: WDC AC28400R, 8063MB w/512kB Cache, CHS=1027/255/63, (U)DMA
hdc: WDC WD307AA-00BAA0, 29333MB w/2048kB Cache, CHS=59598/16/63,
UDMA(66)

I'm using SCSI emulation on the secondary slave device, 
identified as:

  Vendor: TOSHIBA   Model: DVD-ROM SD-M1402  Rev: 1008
  Type:   CD-ROM                             ANSI SCSI revision: 02
Detected scsi CD-ROM sr1 at scsi1, channel 0, id 0, lun 0

I include the complete dmesg log and some proc output below.
Please let me know if more is required.  Thanks in advance!

Linux version 2.2.19 (root@ryoko.unguez.net) (gcc version egcs-2.91.66
19990314/
Linux (egcs-1.1.2 release)) #1 Thu Apr 5 17:38:40 PDT 2001
USER-provided physical RAM map:
 USER: 0009f000 @ 00000000 (usable)
 USER: 13f00000 @ 00100000 (usable)
Detected 800035 kHz processor.
ide_setup: idebus=33
Console: colour VGA+ 80x25
Calibrating delay loop... 1595.80 BogoMIPS
Memory: 322280k/327680k available (1388k kernel code, 416k reserved,
3520k data,
 76k init)
Dentry hash table entries: 65536 (order 7, 512k)
Buffer cache hash table entries: 524288 (order 9, 2048k)
Page cache hash table entries: 131072 (order 7, 512k)
VFS: Diskquotas version dquot_6.4.0 initialized
CPU: L1 I Cache: 64K  L1 D Cache: 64K
CPU: L2 Cache: 512K
CPU: AMD Athlon(tm) Processor stepping 01
Checking 386/387 coupling... OK, FPU using exception 16 error reporting.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.35a (19990819) Richard Gooch (rgooch@atnf.csiro.au)
PCI: PCI BIOS revision 2.10 entry at 0xf1010
PCI: Using configuration type 1
PCI: Probing PCI hardware
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 263M
agpgart: Detected Via Apollo Pro chipset
agpgart: AGP aperture is 64M @ 0xe4000000
Linux NET4.0 for Linux 2.2
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0 for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
TCP: Hash tables configured (ehash 524288 bhash 65536)
Starting kswapd v 1.5 
parport0: PC-style at 0x378, irq 7 [SPP,PS2,EPP]
matroxfb: Matrox unknown G400 (AGP) detected
matroxfb: MTRR's turned on
matroxfb: 1024x768x8bpp (virtual: 1024x16380)
matroxfb: framebuffer at 0xE2000000, mapped to 0xd480a000, size 16777216
Console: switching to colour frame buffer device 128x48
fb0: MATROX VGA frame buffer device
Detected PS/2 Mouse Port.
Serial driver version 4.27 with no serial options enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
pty: 256 Unix98 ptys configured
lp0: using parport0 (interrupt-driven).
js: Joystick driver v1.2.15 (c) 1999 Vojtech Pavlik <vojtech@suse.cz>
i2c: initialized
Linux video capture interface: v1.00
bttv0: Brooktree Bt878 (rev 2) bus: 0, devfn: 72, irq: 9, memory:
0xe1000000.
bttv: 1 Bt8xx card(s) found.
bttv0: Hauppauge eeprom: tuner=Philips FM1236 (2)
bttv0: audio chip: TDA9850
bttv0: NO fader chip: TEA6300
bttv0: model: BT878(Hauppauge new)
loop: registered device at major 7
Uniform Multi-Platform E-IDE driver Revision: 6.30
ide: Assuming 33MHz system bus speed for PIO modes
VP_IDE: IDE controller on PCI bus 00 dev 21
VP_IDE: chipset revision 16
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686a (rev 22) IDE UDMA66 controller on pci00:04.1
    ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:DMA, hdd:DMA
hda: WDC WD307AA, ATA DISK drive
hdb: WDC AC28400R, ATA DISK drive
hdc: WDC WD307AA-00BAA0, ATA DISK drive
hdd: TOSHIBA DVD-ROM SD-M1402, ATAPI CDROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: WDC WD307AA, 29333MB w/2048kB Cache, CHS=3739/255/63, UDMA(66)
hdb: WDC AC28400R, 8063MB w/512kB Cache, CHS=1027/255/63, (U)DMA
hdc: WDC WD307AA-00BAA0, 29333MB w/2048kB Cache, CHS=59598/16/63,
UDMA(66)
Floppy drive(s): fd0 is 2.88M AMI BIOS
FDC 0 is a post-1991 82077
(scsi0) <Adaptec AIC-7850 SCSI host adapter> found at PCI 0/12/0
(scsi0) Narrow Channel, SCSI ID=7, 3/255 SCBs
(scsi0) Cables present (Int-50 YES, Ext-50 YES)
(scsi0) Downloading sequencer code... 415 instructions downloaded
scsi0 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.1.33/3.2.4
       <Adaptec AIC-7850 SCSI host adapter>
scsi1 : SCSI host adapter emulation for IDE ATAPI devices
scsi : 2 hosts.
  Vendor: IOMEGA    Model: ZIP 100           Rev: J.03
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi removable disk sda at scsi0, channel 0, id 5, lun 0
  Vendor: YAMAHA    Model: CRW4416S          Rev: 1.0h
  Type:   CD-ROM                             ANSI SCSI revision: 02
Detected scsi CD-ROM sr0 at scsi0, channel 0, id 6, lun 0
  Vendor: TOSHIBA   Model: DVD-ROM SD-M1402  Rev: 1008
  Type:   CD-ROM                             ANSI SCSI revision: 02
Detected scsi CD-ROM sr1 at scsi1, channel 0, id 0, lun 0
scsi : detected 3 SCSI generics 2 SCSI cdroms 1 SCSI disk total.
sr0: scsi3-mmc drive: 16x/16x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.11
sr1: scsi3-mmc drive: 40x/40x cd/rw xa/form2 cdda tray
sda : READ CAPACITY failed.
sda : status = 1, message = 00, host = 0, driver = 28 
sda : extended sense code = 2 
sda : block size assumed to be 512 bytes, disk size 1GB.  
PPP: version 2.3.7 (demand dialling)
TCP compression code copyright 1989 Regents of the University of
California
PPP line discipline registered.
PPP BSD Compression module registered
PPP Deflate Compression module registered
3c59x.c 18Feb01 Donald Becker and others
http://www.scyld.com/network/vortex.html
eth0: 3Com 3c905B Cyclone 10/100/BNC at 0xa400,  00:50:da:6a:be:c4, IRQ
5
  8K byte-wide RAM 5:3 Rx:Tx split, 10baseT interface.
  Enabling bus-master transmits and whole-frame receives.
Partition check:
 sda:scsidisk I/O error: dev 08:00, sector 0
 unable to read partition table
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 >
 hdb: hdb1 hdb2
 hdc: hdc1
apm: BIOS version 1.2 Flags 0x0b (Driver version 1.13)
[drm] AGP 0.99 on VIA Apollo Pro @ 0xe4000000 64MB
[drm] Initialized mga 2.0.0 20000910 on minor 63
Creative EMU10K1 PCI Audio Driver, version 0.7, 17:39:47 Apr  5 2001
emu10k1: EMU10K1 rev 6 model 0x8027 found, IO at 0xa000-0xa01f, IRQ 10
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 76k freed
Adding Swap: 136512k swap-space (priority -1)
hdb: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
hdb: task_no_data_intr: error=0x04 { DriveStatusError }
hdb: Write Cache FAILED Flushing!
(repeats...)

[root@ryoko ide]# ls
drivers  hda  hdb  hdc  hdd  ide0  ide1  via

[root@ryoko ide]# cat drivers 
ide-scsi version 0.9
ide-disk version 1.09

[root@ryoko ide]# cat via 
----------VIA BusMastering IDE Configuration----------------
Driver Version:                     3.20
South Bridge:                       VIA vt82c686a
Revision:                           ISA 0x22 IDE 0x10
BM-DMA base:                        0xd801
PCI clock:                          33MHz
Master Read  Cycle IRDY:            0ws
Master Write Cycle IRDY:            0ws
BM IDE Status Register Read Retry:  yes
Max DRDY Pulse Width:               No limit
-----------------------Primary IDE-------Secondary IDE------
Read DMA FIFO flush:          yes                 yes
End Sector FIFO flush:         no                  no
Prefetch Buffer:              yes                  no
Post Write Buffer:            yes                  no
Enabled:                      yes                 yes
Simplex only:                  no                  no
Cable Type:                   80w                 80w
-------------------drive0----drive1----drive2----drive3-----
Transfer Mode:        PIO       PIO       PIO       PIO
Address Setup:       30ns      30ns      30ns      30ns
Cmd Active:          90ns      90ns      90ns      90ns
Cmd Recovery:        30ns      30ns      30ns      30ns
Data Active:         90ns      90ns      90ns      90ns
Data Recovery:       30ns      30ns      30ns      30ns
Cycle Time:          30ns      30ns      30ns      60ns
Transfer Rate:   66.0MB/s  66.0MB/s  66.0MB/s  33.0MB/s

[root@ryoko hda]# cat settings 
name                    value           min             max            
mode
----                    -----           ---             ---            
----
accoustic               0               0               254            
rw
bios_cyl                3739            0               65535          
rw
bios_head               255             0               255            
rw
bios_sect               63              0               63             
rw
breada_readahead        4               0               127            
rw
bswap                   0               0               1              
r
current_speed           68              0               69             
rw
file_readahead          124             0               2097151        
rw
ide_scsi                0               0               1              
rw
init_speed              12              0               69             
rw
io_32bit                3               0               3              
rw
keepsettings            0               0               1              
rw
lun                     0               0               7              
rw
max_kb_per_request      64              1               127            
rw
multcount               8               0               8              
rw
nice1                   1               0               1              
rw
nowerr                  0               0               1              
rw
number                  0               0               3              
rw
pio_mode                write-only      0               255            
w
slow                    0               0               1              
rw
unmaskirq               1               0               1              
rw
using_dma               1               0               1              
rw
wcache                  1               0               1              
rw

[root@ryoko hdb]# cat settings 
name                    value           min             max            
mode
----                    -----           ---             ---            
----
accoustic               0               0               254            
rw
bios_cyl                1027            0               65535          
rw
bios_head               255             0               255            
rw
bios_sect               63              0               63             
rw
breada_readahead        4               0               127            
rw
bswap                   0               0               1              
r
current_speed           68              0               69             
rw
file_readahead          124             0               2097151        
rw
ide_scsi                0               0               1              
rw
init_speed              12              0               69             
rw
io_32bit                3               0               3              
rw
keepsettings            0               0               1              
rw
lun                     0               0               7              
rw
max_kb_per_request      64              1               127            
rw
multcount               8               0               8              
rw
nice1                   1               0               1              
rw
nowerr                  0               0               1              
rw
number                  1               0               3              
rw
pio_mode                write-only      0               255            
w
slow                    0               0               1              
rw
unmaskirq               1               0               1              
rw
using_dma               1               0               1              
rw
wcache                  1               0               1              
rw

[root@ryoko hdc]# cat settings 
name                    value           min             max            
mode
----                    -----           ---             ---            
----
accoustic               0               0               254            
rw
bios_cyl                59598           0               65535          
rw
bios_head               16              0               255            
rw
bios_sect               63              0               63             
rw
breada_readahead        4               0               127            
rw
bswap                   0               0               1              
r
current_speed           68              0               69             
rw
file_readahead          124             0               2097151        
rw
ide_scsi                0               0               1              
rw
init_speed              12              0               69             
rw
io_32bit                3               0               3              
rw
keepsettings            0               0               1              
rw
lun                     0               0               7              
rw
max_kb_per_request      64              1               127            
rw
multcount               8               0               8              
rw
nice1                   1               0               1              
rw
nowerr                  0               0               1              
rw
number                  2               0               3              
rw
pio_mode                write-only      0               255            
w
slow                    0               0               1              
rw
unmaskirq               1               0               1              
rw
using_dma               1               0               1              
rw
wcache                  1               0               1              
rw

[root@ryoko hdd]# cat settings 
name                    value           min             max            
mode
----                    -----           ---             ---            
----
bios_cyl                0               0               1023           
rw
bios_head               0               0               255            
rw
bios_sect               0               0               63             
rw
current_speed           66              0               69             
rw
ide_scsi                0               0               1              
rw
init_speed              12              0               69             
rw
io_32bit                1               0               3              
rw
keepsettings            0               0               1              
rw
log                     0               0               1              
rw
nice1                   1               0               1              
rw
number                  3               0               3              
rw
pio_mode                write-only      0               255            
w
slow                    0               0               1              
rw
transform               1               0               3              
rw
unmaskirq               1               0               1              
rw
using_dma               1               0               1              
rw

