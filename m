Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276255AbRJKNF1>; Thu, 11 Oct 2001 09:05:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276305AbRJKNFT>; Thu, 11 Oct 2001 09:05:19 -0400
Received: from sproxy.gmx.de ([213.165.64.20]:42065 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S276255AbRJKNFH> convert rfc822-to-8bit;
	Thu, 11 Oct 2001 09:05:07 -0400
Subject: Re: PROBLEM: aic7xxx SCSI system hangs
From: Alexander Feigl <Alexander.Feigl@gmx.de>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <200110102027.f9AKRFY85831@aslan.scsiguy.com>
In-Reply-To: <200110102027.f9AKRFY85831@aslan.scsiguy.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/0.14 (Preview Release)
Date: 11 Oct 2001 14:58:13 +0200
Message-Id: <1002805093.3593.9.camel@PowerBox.MysticWorld.de>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Sorry for my incomplete console output yesterday. I also learned why the
[scsi_eh_0] process looked normal when I did a btp last time. I also
added aic7xxx=verbose and incresed the loglevel of my system.

After invoking cdrecord, there is some time (some minutes) while there
is no output of cdrecord. Then there is a huge amout of syslog messages,
then is is silent for some time again. Then cdrecord prints some error
messages. On serial console it hangs immediately, on local text console
it gives a segmentation fault. Any further invocations of cdrecord or
any SCSI (generic?) application hang immediately when started. (even a
cdrecord -scanbus)

Here is the syslog and kdb backtrace of the [scsi_eh_0] proccess

---------------------------------------------------------------------------------------
Linux version 2.4.11-xfs (dreamer@PowerBox.MysticWorld.homenet) (gcc version egcs-2.9
1.66 19990314/Linux (egcs-1.1.2 release / Mandrake Linux 8.1)) #1 Mit Okt 10 20:
02:42 CEST 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff8000 (ACPI data)
 BIOS-e820: 000000001fff8000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
On node 0 totalpages: 131056
zone(0): 4096 pages.
zone(1): 126960 pages.
zone(2): 0 pages.
Kernel command line: BOOT_IMAGE=2411 ro root=306 ramdisk_size=8192 devfs=mount v
ideo=riva:off console=ttyS1
Initializing CPU#0
Detected 908.966 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1808.79 BogoMIPS
Memory: 511756k/524224k available (1025k kernel code, 12080k reserved, 812k data
, 228k init, 0k highmem)
kdb version 1.9 by Scott Lurndal, Keith Owens. Copyright SGI, All Rights Reserve
d
Dentry-cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: AMD Athlon(tm) Processor stepping 02
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfdb71, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
IA-32 Microcode Update Driver: v1.08 <tigran@veritas.com>
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.14)
Starting kswapd
VFS: Diskquotas version dquot_6.4.0 initialized
devfs: v0.117 (20010927) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI IS
APNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10e
Non-volatile memory driver v1.1
block: 128 slots per queue, batch=16
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
AMD7409: IDE controller on PCI bus 00 dev 39
AMD7409: chipset revision 7
AMD7409: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:pio
hda: QUANTUM FIREBALLlct15 30, ATA DISK drive
hdc: ST340823A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 58633344 sectors (30020 MB) w/418KiB Cache, CHS=3649/255/63, UDMA(33)
hdc: 78165360 sectors (40021 MB) w/1024KiB Cache, CHS=77545/16/63, UDMA(33)
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2 < p5 p6 p7 p8 p9 p10 p11 >
 /dev/ide/host0/bus1/target0/lun0: [PTBL] [4865/255/63] p1 p2 < p5 p6 >
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 1552k freed
VFS: Mounted root (ext2 filesystem).
Mounted devfs on /dev
SCSI subsystem driver Revision: 1.00
ahc_pci:0:11:0: Reading SEEPROM...done.
ahc_pci:0:11:0: BIOS eeprom is present
ahc_pci:0:11:0: Secondary High byte termination Enabled
ahc_pci:0:11:0: Secondary Low byte termination Enabled
ahc_pci:0:11:0: Primary Low Byte termination Enabled
ahc_pci:0:11:0: Primary High Byte termination Enabled
ahc_pci:0:11:0: Downloading Sequencer Program... 422 instructions downloaded
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.1
        <Adaptec 2940 Ultra2 SCSI adapter>
aic7890/91: Ultra2 Wide Channel A, SCSI Id=7, 32/255 SCBs
  Vendor: PLEXTOR   Model: CD-ROM PX-32TS    Rev: 1.02
  Type:   CD-ROM                             ANSI SCSI revision: 02
(scsi0:A:2:1): Sending SDTR period c, offset 7f
(scsi0:A:2:1): Received SDTR period c, offset f
	Filtered to period c, offset f
(scsi0:A:2): 20.000MB/s transfers (20.000MHz, offset 15)
scsi0: target 2 synchronous at 20.0MHz, offset = 0xf
  Vendor: PLEXTOR   Model: CD-R   PX-W1210S  Rev: 1.03
  Type:   CD-ROM                             ANSI SCSI revision: 02
(scsi0:A:3:1): Sending SDTR period c, offset 7f
(scsi0:A:3:1): Received SDTR period c, offset 10
	Filtered to period c, offset 10
(scsi0:A:3): 20.000MB/s transfers (20.000MHz, offset 16)
scsi0: target 3 synchronous at 20.0MHz, offset = 0x10
Loading xfs module
SGI XFS with ACLs, EAs, DMAPI, realtime, quota, no debug enabled
Mounting /proc filesystem
Creating root device
XFS mounting filesystem ide0(3,6)
Mounting root filesystem
Remounting devfs at correct place if necessary
Freeing unused kernel memory: 228k freed
INIT: version 2.78 booting
Couldnt get a file descriptor referring to the console
get_console_fd: Das Argument ist ungültig
Standardzeichensatz setzen:  [  OK  ]
			Willkommen zu Mandrake Linux
	Drücken Sie »I«, um im interaktiven Modus zu starten.
Einhängen des Dateisystems »/proc«:  [  OK  ]
Starten des DevFS Dämons:  [  OK  ]
klogctl: Das Argument ist ungültig
Unmounting initrd:  [  OK  ]
Kern-Parameter konfigurieren:  [  OK  ]
Setting clock  (utc): Don Okt 11 14:18:32 CEST 2001 [  OK  ]
Swap-Partitionen einbinden:  Adding Swap: 1028120k swap-space (priority -1)
Adding Swap: 530104k swap-space (priority -2)
[  OK  ]
Setting hostname PowerBox.MysticWorld.de:  [  OK  ]
Checking root filesystem
[  OK  ]
Verzeichnisbaumwurzel im Schreib-/Lese-Modus einhängen:  [  OK  ]
Finden der Modulabhängigkeiten:  [  OK  ]
i2c-core.o: i2c core module
i2c-algo-bit.o: i2c bit algorithm module
Linux video capture interface: v1.00
bttv: driver version 0.8.28 loaded [v4l/v4l2]
bttv: using 10 buffers with 2080k (520 pages) each for capture
bttv: Host bridge is Advanced Micro Devices [AMD] AMD-751 [Irongate] System Cont
roller
bttv: Bt8xx card found (0).
bttv0: Bt848 (rev 18) at 00:09.0, irq: 11, latency: 64, memory: 0xeddff000
bttv0: using: BT848A(MIRO PCTV pro) [card=11,insmod option]
i2c-core.o: adapter bt848 #0 registered as adapter 0.
bttv0: i2c: checking for MSP34xx @ 0x80... found
bttv0: miro: id=1 tuner=0 radio=matchbox stereo=yes
bttv0: i2c: checking for MSP34xx @ 0x80... found
i2c-core.o: driver i2c msp3400 driver registered.
msp34xx: init: chip=MSP3410D-B4, has NICAM support
msp3410: daemon started
bttv0: i2c attach [MSP3410D-B4]
i2c-core.o: client [MSP3410D-B4] registered to adapter [bt848 #0](pos. 0).
bttv0: i2c: checking for TDA9875 @ 0xb0... not found
bttv0: i2c: checking for TDA7432 @ 0x8a... not found
tvaudio: TV audio decoder + audio/video mux driver
tvaudio: known chips: tda9840,tda9873h,tda9850,tda9855,tea6300,tea6420,tda8425,p
ic16c54 (PV951)
i2c-core.o: driver generic i2c audio driver registered.
i2c-core.o: driver i2c TV tuner driver registered.
tuner: chip found @ 0xc0
bttv0: i2c attach [Temic PAL (4002 FH5)]
i2c-core.o: client [Temic PAL (4002 FH5)] registered to adapter [bt848 #0](pos. 
1).
devfs: devfs_register(): device already registered: "v4l/video0"
devfs: devfs_register(): device already registered: "v4l/vbi0"
devfs: devfs_register(): device already registered: "v4l/radio0"
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
Checking filesystems
[  OK  ]
Einhängen lokaler Dateisysteme:  XFS mounting filesystem ide0(3,5)
XFS mounting filesystem ide1(22,6)
XFS mounting filesystem ide0(3,11)
[  OK  ]
Kontrollieren des LoopBack-Dateisystemes[  OK  ]
Einhängen der Loopback-Dateisysteme:  [  OK  ]
Running devfsd actions:  [  OK  ]
Loading compose keys: compose.latin.inc [  OK  ]
The BackSpace key sends: ^?[  OK  ]
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 2, lun 0
Attached scsi CD-ROM sr1 at scsi0, channel 0, id 3, lun 0
(scsi0:A:2:0): Sending SDTR period c, offset f
(scsi0:A:2:0): Received SDTR period c, offset f
	Filtered to period c, offset f
(scsi0:A:2:0): Sending SDTR period c, offset f
(scsi0:A:2:0): Received SDTR period c, offset f
	Filtered to period c, offset f
sr0: scsi-1 drive
devfs: devfs_register(): device already registered: "cd"
Uniform CD-ROM driver Revision: 3.12
devfs: devfs_register(): device already registered: "cdrom0"
(scsi0:A:3:0): Sending SDTR period c, offset 10
(scsi0:A:3:0): Received SDTR period c, offset 10
	Filtered to period c, offset 10
sr1: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray
devfs: devfs_register(): device already registered: "cd"
devfs: devfs_register(): device already registered: "cdrom1"
Swap-Bereich aktivieren:  [  OK  ]
Building Window Manager Sessions [  OK  ]
Linux Tulip driver version 0.9.15-pre7 (Oct 2, 2001)
tulip0:  MII transceiver #1 config 3000 status 7829 advertising 01e1.
eth0: Lite-On 82c168 PNIC rev 32 at 0xd600, 00:A0:CC:59:AC:06, IRQ 5.
INIT: Entering runlevel: 1
Entering non-interactive startup
Allen Prozessen das Signal »TERM« senden ...
INIT: no more processes left in this runlevel
Sende allen Prozmd: recovery thread got woken up ...
essen das Signalmd: recovery thread finished ...
 »KILL« ...
INIT anweisen, in den Einbenutzer-Betrieb zu wechseln.
INIT: Going single user
sh-2.05# modprobe sg
sh-2.05# cdrecord -toc dev=0,2,0
Cdrecord 1.10 (i586-mandrake-linux-gnu) Copyright (C) 1995-2001 Jörg Schilling
(scsi0:A:2:0): Sending SDTR period c, offset 7f
(scsi0:A:2:0): Received SDTR period c, offset f
	Filtered to period c, offset f
(scsi0:A:2:0): Sending SDTR period c, offset f
(scsi0:A:2:0): Received SDTR period c, offset f
	Filtered to period c, offset f
(scsi0:A:2:0): Sending SDTR period c, offset f
scsidev: '0,2,0'
(scsi0:A:2:0): Received SDTR period c, offset f
	Filtered to period c, offset f
scsibus: 0 target: 2 lun: 0
(scsi0:A:2:0): Sending SDTR period c, offset f
Linux sg driver version: 3.1.20
(scsi0:A:2:0): Received SDTR period c, offset f
	Filtered to period c, offset f
(scsi0:A:2:0): Sending SDTR period c, offset f
(scsi0:A:2:0): Received SDTR period c, offset f
	Filtered to period c, offset f
Using libscg ver(scsi0:A:2:0): Sending SDTR period c, offset f
sion 'schily-0.5(scsi0:A:2:0): Received SDTR period c, offset f
	Filtered to period c, offset f
'
Device type  (scsi0:A:2:0): Sending SDTR period c, offset f
  : Removable CD(scsi0:A:2:0): Received SDTR period c, offset f
	Filtered to period c, offset f
-ROM
Version   (scsi0:A:2:0): Sending SDTR period c, offset f
     : 2
Respon(scsi0:A:2:0): Received SDTR period c, offset f
	Filtered to period c, offset f
se Format: 2
Ca(scsi0:A:2:0): Sending SDTR period c, offset f
pabilities   : S(scsi0:A:2:0): Received SDTR period c, offset f
	Filtered to period c, offset f
YNC LINKED 
Ven(scsi0:A:2:0): Sending SDTR period c, offset f
dor_info    : 'P(scsi0:A:2:0): Received SDTR period c, offset f
	Filtered to period c, offset f
LEXTOR '
Identifikation : 'CD-ROM PX-32TS  '
Revision       : '1.02'
Device seems to be: Generic CD-ROM.
Using generic SCSI-2 CD driver (scs(scsi0:A:2:0): Sending SDTR period c, offset 
f
i2_cd).
Driver (scsi0:A:2:0): Received SDTR period c, offset f
	Filtered to period c, offset f
flags   : 
(scsi0:A:2:0): Sending SDTR period c, offset f
(scsi0:A:2:0): Received SDTR period c, offset f
	Filtered to period c, offset f
first: 1 last 18
(scsi0:A:2:0): Sending SDTR period c, offset f
(scsi0:A:2:0): Received SDTR period c, offset f
	Filtered to period c, offset f
scsi0:0:2:0: Attempting to queue an ABORT message
scsi0: Dumping Card State in Command phase, at SEQADDR 0xbf
ACCUM = 0x80, SINDEX = 0xa0, DINDEX = 0xe4, ARG_2 = 0x0
HCNT = 0xa
SCSISEQ = 0x12, SBLKCTL = 0xa
 DFCNTRL = 0x24, DFSTATUS = 0x80
LASTPHASE = 0x80, SCSISIGI = 0x44, SXFRCTL0 = 0x80
SSTAT0 = 0x0, SSTAT1 = 0x3
STACK == 0x35, 0x17b, 0x165, 0x0
SCB count = 4
Kernel NEXTQSCB = 3
Card NEXTQSCB = 3
QINFIFO entries: 
Waiting Queue entries: 
Disconnected Queue entries: 
QOUTFIFO entries: 
Sequencer Free SCB List: 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 2
2 23 24 25 26 27 28 29 30 31 
Pending list: 2
Kernel Free SCB list: 1 0 
Untagged Q(2): 2 
DevQ(0:2:0): 0 waiting
DevQ(0:3:0): 0 waiting
scsi0:0:2:0: Device is active, asserting ATN
Recovery code sleeping
Recovery code awake
Timer Expired
aic7xxx_abort returns 8195
scsi0:0:2:0: Attempting to queue a TARGET RESET message
aic7xxx_dev_reset returns 8195
Recovery SCB completes
(scsi0:A:2): 3.300MB/s transfers
scsi0: target 2 using asynchronous transfers
(scsi0:A:3): 3.300MB/s transfers
scsi0: target 3 using asynchronous transfers
scsi0: SCSI bus reset delivered. 1 SCBs aborted.
(scsi0:A:2:0): Sending SDTR period c, offset f
(scsi0:A:2:0): Received SDTR period c, offset f
	Filtered to period c, offset f
(scsi0:A:2): 20.000MB/s transfers (20.000MHz, offset 15)
scsi0: target 2 synchronous at 20.0MHz, offset = 0xf
(scsi0:A:2:0): Sending SDTR period c, offset f
(scsi0:A:2:0): Received SDTR period c, offset f
	Filtered to period c, offset f
(scsi0:A:2:0): Sending SDTR period c, offset f
(scsi0:A:2:0): Received SDTR period c, offset f
	Filtered to period c, offset f
(scsi0:A:2:0): Sending SDTR period c, offset f
(scsi0:A:2:0): Received SDTR period c, offset f
	Filtered to period c, offset f
(scsi0:A:2:0): Sending SDTR period c, offset f
(scsi0:A:2:0): Received SDTR period c, offset f
	Filtered to period c, offset f
(scsi0:A:2:0): Sending SDTR period c, offset f
(scsi0:A:2:0): Received SDTR period c, offset f
	Filtered to period c, offset f
(scsi0:A:2:0): Sending SDTR period c, offset f
(scsi0:A:2:0): Received SDTR period c, offset f
	Filtered to period c, offset f
(scsi0:A:2:0): Sending SDTR period c, offset f
(scsi0:A:2:0): Received SDTR period c, offset f
	Filtered to period c, offset f
(scsi0:A:2:0): Sending SDTR period c, offset f
(scsi0:A:2:0): Received SDTR period c, offset f
	Filtered to period c, offset f
(scsi0:A:2:0): Sending SDTR period c, offset f
(scsi0:A:2:0): Received SDTR period c, offset f
	Filtered to period c, offset f
(scsi0:A:2:0): Sending SDTR period c, offset f
(scsi0:A:2:0): Received SDTR period c, offset f
	Filtered to period c, offset f
(scsi0:A:2:0): Sending SDTR period c, offset f
(scsi0:A:2:0): Received SDTR period c, offset f
	Filtered to period c, offset f
(scsi0:A:2:0): Sending SDTR period c, offset f
(scsi0:A:2:0): Received SDTR period c, offset f
	Filtered to period c, offset f
(scsi0:A:2:0): Sending SDTR period c, offset f
(scsi0:A:2:0): Received SDTR period c, offset f
	Filtered to period c, offset f
(scsi0:A:2:0): Sending SDTR period c, offset f
(scsi0:A:2:0): Received SDTR period c, offset f
	Filtered to period c, offset f
(scsi0:A:2:0): Sending SDTR period c, offset f
(scsi0:A:2:0): Received SDTR period c, offset f
	Filtered to period c, offset f
(scsi0:A:2:0): Sending SDTR period c, offset f
(scsi0:A:2:0): Received SDTR period c, offset f
	Filtered to period c, offset f
(scsi0:A:2:0): Sending SDTR period c, offset f
(scsi0:A:2:0): Received SDTR period c, offset f
	Filtered to period c, offset f
(scsi0:A:2:0): Sending SDTR period c, offset f
(scsi0:A:2:0): Received SDTR period c, offset f
	Filtered to period c, offset f
(scsi0:A:2:0): Sending SDTR period c, offset f
(scsi0:A:2:0): Received SDTR period c, offset f
	Filtered to period c, offset f
(scsi0:A:2:0): Sending SDTR period c, offset f
(scsi0:A:2:0): Received SDTR period c, offset f
	Filtered to period c, offset f
(scsi0:A:2:0): Sending SDTR period c, offset f
(scsi0:A:2:0): Received SDTR period c, offset f
	Filtered to period c, offset f
(scsi0:A:2:0): Sending SDTR period c, offset f
(scsi0:A:2:0): Received SDTR period c, offset f
	Filtered to period c, offset f
(scsi0:A:2:0): Sending SDTR period c, offset f
(scsi0:A:2:0): Received SDTR period c, offset f
	Filtered to period c, offset f
(scsi0:A:2:0): Sending SDTR period c, offset f
(scsi0:A:2:0): Received SDTR period c, offset f
	Filtered to period c, offset f
(scsi0:A:2:0): Sending SDTR period c, offset f
(scsi0:A:2:0): Received SDTR period c, offset f
	Filtered to period c, offset f
(scsi0:A:2:0): Sending SDTR period c, offset f
(scsi0:A:2:0): Received SDTR period c, offset f
	Filtered to period c, offset f
(scsi0:A:2:0): Sending SDTR period c, offset f
(scsi0:A:2:0): Received SDTR period c, offset f
	Filtered to period c, offset f
(scsi0:A:2:0): Sending SDTR period c, offset f
(scsi0:A:2:0): Received SDTR period c, offset f
	Filtered to period c, offset f
(scsi0:A:2:0): Sending SDTR period c, offset f
(scsi0:A:2:0): Received SDTR period c, offset f
	Filtered to period c, offset f
(scsi0:A:2:0): Sending SDTR period c, offset f
(scsi0:A:2:0): Received SDTR period c, offset f
	Filtered to period c, offset f
(scsi0:A:2:0): Sending SDTR period c, offset f
(scsi0:A:2:0): Received SDTR period c, offset f
	Filtered to period c, offset f
(scsi0:A:2:0): Sending SDTR period c, offset f
(scsi0:A:2:0): Received SDTR period c, offset f
	Filtered to period c, offset f
(scsi0:A:2:0): Sending SDTR period c, offset f
(scsi0:A:2:0): Received SDTR period c, offset f
	Filtered to period c, offset f
(scsi0:A:2:0): Sending SDTR period c, offset f
(scsi0:A:2:0): Received SDTR period c, offset f
	Filtered to period c, offset f
(scsi0:A:2:0): Sending SDTR period c, offset f
(scsi0:A:2:0): Received SDTR period c, offset f
	Filtered to period c, offset f
(scsi0:A:2:0): Sending SDTR period c, offset f
(scsi0:A:2:0): Received SDTR period c, offset f
	Filtered to period c, offset f
(scsi0:A:2:0): Sending SDTR period c, offset f
(scsi0:A:2:0): Received SDTR period c, offset f
	Filtered to period c, offset f
(scsi0:A:2:0): Sending SDTR period c, offset f
(scsi0:A:2:0): Received SDTR period c, offset f
	Filtered to period c, offset f
(scsi0:A:2:0): Sending SDTR period c, offset f
(scsi0:A:2:0): Received SDTR period c, offset f
	Filtered to period c, offset f
(scsi0:A:2:0): Sending SDTR period c, offset f
(scsi0:A:2:0): Received SDTR period c, offset f
	Filtered to period c, offset f
(scsi0:A:2:0): Sending SDTR period c, offset f
(scsi0:A:2:0): Received SDTR period c, offset f
	Filtered to period c, offset f
(scsi0:A:2:0): Sending SDTR period c, offset f
(scsi0:A:2:0): Received SDTR period c, offset f
	Filtered to period c, offset f
(scsi0:A:2:0): Sending SDTR period c, offset f
(scsi0:A:2:0): Received SDTR period c, offset f
	Filtered to period c, offset f
(scsi0:A:2:0): Sending SDTR period c, offset f
(scsi0:A:2:0): Received SDTR period c, offset f
	Filtered to period c, offset f
(scsi0:A:2:0): Sending SDTR period c, offset f
(scsi0:A:2:0): Received SDTR period c, offset f
	Filtered to period c, offset f
(scsi0:A:2:0): Sending SDTR period c, offset f
(scsi0:A:2:0): Received SDTR period c, offset f
	Filtered to period c, offset f
(scsi0:A:2:0): Sending SDTR period c, offset f
(scsi0:A:2:0): Received SDTR period c, offset f
	Filtered to period c, offset f
scsi0:0:2:0: Attempting to queue an ABORT message
scsi0: Dumping Card State in Command phase, at SEQADDR 0xc0
ACCUM = 0x80, SINDEX = 0xa0, DINDEX = 0xe4, ARG_2 = 0x0
HCNT = 0xa
SCSISEQ = 0x12, SBLKCTL = 0xa
 DFCNTRL = 0x24, DFSTATUS = 0x80
LASTPHASE = 0x80, SCSISIGI = 0x44, SXFRCTL0 = 0x80
SSTAT0 = 0x0, SSTAT1 = 0x3
STACK == 0x35, 0x17b, 0x165, 0x0
SCB count = 4
Kernel NEXTQSCB = 2
Card NEXTQSCB = 2
QINFIFO entries: 
Waiting Queue entries: 
Disconnected Queue entries: 
QOUTFIFO entries: 
Sequencer Free SCB List: 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 2
2 23 24 25 26 27 28 29 30 31 
Pending list: 3
Kernel Free SCB list: 1 0 
Untagged Q(2): 3 
DevQ(0:2:0): 0 waiting
DevQ(0:3:0): 0 waiting
scsi0:0:2:0: Device is active, asserting ATN
Recovery code sleeping
Recovery code awake
aic7xxx_abort returns 8194
scsi: device set offline - not ready or command retry failed after bus reset: ho
st 0 channel 0 id 2 lun 0
track:   1 lba:         0 (        0) 00:02:00 adr: 1 control: 0 mode: -1
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl
cdrecord: No such device or address. Cannot send SCSI cmd via ioctl

Entering kdb (current=0xc02cc000, pid 0) due to Keyboard Entry
kdb> btp 16
    EBP       EIP         Function(args)
0xdf945e7c 0xc0112d34 schedule+0x2d4 (0x3e8, 0xdf945ef0, 0xdf8de080, 0x0, 0xdf94
4000)
                               kernel .text 0xc0100000 0xc0112a60 0xc0112e80
0xdf945eb0 0xc011311c wait_for_completion+0x7c
                               kernel .text 0xc0100000 0xc01130a0 0xc0113140
           0xc0105763 kernel_thread+0x23
                               kernel .text 0xc0100000 0xc0105740 0xc0105780
kdb> ps
Task Addr  Pid      Parent   [*] cpu  State Thread     Command
0xc181c000 00000001 00000000  0  000  stop  0xc181c270 init
0xc1810000 00000002 00000001  0  000  stop  0xc1810270 keventd
0xc183e000 00000003 00000001  0  000  stop  0xc183e270 kapm-idled
0xc183a000 00000004 00000000  0  000  stop  0xc183a270 ksoftirqd_CPU0
0xc1838000 00000005 00000000  0  000  stop  0xc1838270 kswapd
0xc1836000 00000006 00000000  0  000  stop  0xc1836270 bdflush
0xc1834000 00000007 00000000  0  000  stop  0xc1834270 kupdated
0xdfa16000 00000010 00000001  0  000  stop  0xdfa16270 pagebuf_daemon
0xdf944000 00000016 00000001  0  000  stop  0xdf944270 scsi_eh_0
0xdf7ce000 00000219 00000001  0  000  stop  0xdf7ce270 msp3410 [auto]
0xdf72c000 00000235 00000001  0  000  stop  0xdf72c270 mdrecoveryd
0xdee40000 00000649 00000001  0  000  stop  0xdee40270 init
0xdf780000 00000650 00000649  0  000  stop  0xdf780270 sh
0xdf5b4000 00000653 00000650  0  000  stop  0xdf5b4270 cdrecord

