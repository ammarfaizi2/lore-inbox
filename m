Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285421AbRLGGA2>; Fri, 7 Dec 2001 01:00:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285422AbRLGGAL>; Fri, 7 Dec 2001 01:00:11 -0500
Received: from sm10.texas.rr.com ([24.93.35.222]:47065 "EHLO sm10.texas.rr.com")
	by vger.kernel.org with ESMTP id <S285421AbRLGGAA>;
	Fri, 7 Dec 2001 01:00:00 -0500
Date: Thu, 6 Dec 2001 23:57:04 -0600 (CST)
From: Brad Hartin <bhartin@satx.rr.com>
X-X-Sender: <bhartin@osprey>
To: <linux-kernel@vger.kernel.org>
Subject: Bug: linux-2.4.1[046] w/bttv 0.7.x
Message-ID: <Pine.LNX.4.33.0112062339490.6755-100000@osprey>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The following situation has happened with any combination of kernels
2.4.10, 2.4.14, and 2.4.16 together with bttv 0.7.79, 0.7.85, and 0.7.86.
The hardware consists of an Hauppauge WinTV Theater, Epox 8K7A+ rev1.1
motherboard, Asus Starforce Pro (GF2Pro/64), Ensoniq PCI, 3Ware Escalade
6200, Adaptec 2940UW, and Linksys LNE100TX.

Please CC replies to me, as I'm only watching the list via the archives.
If anyone needs any more info, just let me know and it's yours.

While watching TV, I will often see a freeze of the video input from the
card, and get the following error:

Dec  5 23:38:20 condor kernel: bttv0: irq: SCERR risc_count=1da20000
Dec  5 23:38:20 condor kernel: bttv0: irq: SCERR risc_count=1f129010
Dec  5 23:38:20 condor kernel: bttv0: irq: SCERR risc_count=1da20000
Dec  5 23:38:20 condor kernel: bttv0: irq: SCERR risc_count=1f129010
Dec  5 23:53:48 condor kernel: bttv0: irq: SCERR risc_count=1da20000
Dec  5 23:53:48 condor kernel: bttv0: aiee: error loops
Dec  5 23:53:51 condor kernel: bttv0: resetting chip

Note:  see my /proc/interrupts near the end--the three devices in
question below--the bttv, 3ware, and adaptec--do not share interrupts with
each other (but do with other things).

The errors seem to occur during disk access (the RAID volume on the 3Ware
or writing CDs to a Yamaha2100S on the Adaptec card).  Once in a while, it
results on a complete system lockup.  During one of these lockups (while
using 2.4.14+0.7.79) the system eventually became responsive again, just
in time to log the following errors:

Dec  4 18:14:09 condor kernel: bttv0: irq: SCERR risc_count=1d728000
Dec  4 18:14:09 condor kernel: 3w-xxxx: tw_check_bits(): Found unexpected
bits (0x57207030).
Dec  4 18:14:09 condor kernel: 3w-xxxx: tw_aen_read_queue(): Unexpected
bits.
Dec  4 18:14:09 condor kernel: 3w-xxxx: Microcontroller Error.
Dec  4 18:14:09 condor kernel: 3w-xxxx: tw_interrupt(): Error reading aen
queue.
Dec  4 18:14:09 condor kernel: uhci.c: 9800: host system error, PCI
problems?
Dec  4 18:14:09 condor kernel: 3w-xxxx: tw_check_bits(): Found unexpected
bits (0x57207030).
Dec  4 18:14:09 condor kernel: 3w-xxxx: tw_post_command_packet():
Unexpected bits.
Dec  4 18:14:09 condor kernel: 3w-xxxx: Microcontroller Error.
Dec  4 18:14:09 condor kernel: bttv0: irq: SCERR risc_count=1f133010
Dec  4 18:14:09 condor kernel: bttv0: aiee: error loops
Dec  4 18:14:09 condor kernel: bttv0: irq: SCERR risc_count=1d728014
Dec  4 18:14:09 condor kernel: bttv0: aiee: error loops
Dec  4 18:15:01 condor kernel: bttv0: resetting chip
Dec  4 18:15:01 condor kernel: 3w-xxxx: tw_check_bits(): Found unexpected
bits (0x57207030).
Dec  4 18:15:01 condor telnetd[3805]: ttloop: peer died: EOF
Dec  4 18:15:01 condor telnetd[3806]: ttloop: peer died: EOF
Dec  4 18:15:01 condor kernel: 3w-xxxx: tw_post_command_packet():
Unexpected bits.
Dec  4 18:15:01 condor kernel: 3w-xxxx: Microcontroller Error.
Dec  4 18:15:01 condor kernel: 3w-xxxx: tw_check_bits(): Found unexpected
bits (0x57207030).
Dec  4 18:15:01 condor kernel: 3w-xxxx: tw_post_command_packet():
Unexpected bits.
Dec  4 18:15:01 condor kernel: 3w-xxxx: Microcontroller Error.
Dec  4 18:15:01 condor kernel: 3w-xxxx: tw_check_bits(): Found unexpected
bits (0x57207030).
Dec  4 18:15:01 condor kernel: 3w-xxxx: tw_post_command_packet():
Unexpected bits.
Dec  4 18:15:01 condor kernel: 3w-xxxx: Microcontroller Error.
Dec  4 18:15:01 condor kernel: 3w-xxxx: tw_check_bits(): Found unexpected
bits (0x57207030).
Dec  4 18:15:01 condor kernel: 3w-xxxx: tw_post_command_packet():
Unexpected bits.
Dec  4 18:15:01 condor kernel: 3w-xxxx: Microcontroller Error.
Dec  4 18:15:01 condor kernel: 3w-xxxx: Microcontroller Error.
Dec  4 18:15:01 condor kernel: 3w-xxxx: tw_check_bits(): Found unexpected
bits (0x57207010).
Dec  4 18:15:01 condor kernel: 3w-xxxx: tw_interrupt(): Unexpected bits.
Dec  4 18:15:01 condor kernel: 3w-xxxx: Microcontroller Error.
Dec  4 18:15:01 condor kernel: 3w-xxxx: tw_interrupt(): Bad response,
status = 0xc7, flags = 0x1b, unit = 0x0.
Dec  4 18:15:01 condor kernel: 3w-xxxx: scsi2: Drive timeout on unit 0,
check drive and drive
cables.
Dec  4 18:15:01 condor kernel: 3w-xxxx: Microcontroller Error.
Dec  4 18:15:01 condor kernel: 3w-xxxx: tw_check_bits(): Found unexpected
bits (0x57207050).
Dec  4 18:15:01 condor kernel: 3w-xxxx: tw_interrupt(): Unexpected bits.
Dec  4 18:15:01 condor kernel: 3w-xxxx: Microcontroller Error.
Dec  4 18:15:01 condor kernel: 3w-xxxx: tw_scsi_eh_abort(): Abort failed
for unknown Scsi_Cmnd 0xdfff7e00, resetting card 2.
Dec  4 18:15:01 condor kernel: 3w-xxxx: tw_scsi_eh_abort(): Abort failed
for unknown Scsi_Cmnd 0xdfff7c00, resetting card 2.
Dec  4 18:15:01 condor kernel: 3w-xxxx: tw_scsi_eh_abort(): Abort failed
for unknown Scsi_Cmnd 0xdfff7a00, resetting card 2.
Dec  4 18:15:01 condor kernel: 3w-xxxx: tw_scsi_eh_abort(): Abort failed
for unknown Scsi_Cmnd 0xdfff7800, resetting card 2.
Dec  4 18:15:01 condor kernel: 3w-xxxx: tw_scsi_eh_abort(): Abort failed
for unknown Scsi_Cmnd 0xdfff7600, resetting card 2.
Dec  4 18:15:01 condor kernel: 3w-xxxx: tw_scsi_eh_abort(): Abort failed
for unknown Scsi_Cmnd 0xdfff7400, resetting card 2.
Dec  4 18:15:01 condor kernel: 3w-xxxx: tw_scsi_eh_reset(): Reset
succeeded for card 2.

Here is my .config:

[root@condor linux]# cat .config | grep -v "is not set" | grep -v "^$" |
grep -v "^#"
CONFIG_X86=y
CONFIG_ISA=y
CONFIG_UID16=y
CONFIG_EXPERIMENTAL=y
CONFIG_MODULES=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y
CONFIG_MK7=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_USE_3DNOW=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_NOHIGHMEM=y
CONFIG_MTRR=y
CONFIG_NET=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_HOTPLUG=y
CONFIG_PCMCIA=y
CONFIG_CARDBUS=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
CONFIG_PARPORT_PC_CML1=y
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_PC_SUPERIO=y
CONFIG_PNP=y
CONFIG_ISAPNP=y
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_NBD=y
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y
CONFIG_PACKET=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDESCSI=y
CONFIG_BLK_DEV_CMD640=y
CONFIG_BLK_DEV_RZ1000=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_HPT366=y
CONFIG_BLK_DEV_VIA82CXXX=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=y
CONFIG_SD_EXTRA_DEVS=40
CONFIG_CHR_DEV_ST=y
CONFIG_BLK_DEV_SR=y
CONFIG_SR_EXTRA_DEVS=2
CONFIG_CHR_DEV_SG=y
CONFIG_SCSI_DEBUG_QUEUES=y
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_BLK_DEV_3W_XXXX_RAID=y
CONFIG_SCSI_AIC7XXX=y
CONFIG_AIC7XXX_CMDS_PER_DEVICE=253
CONFIG_AIC7XXX_RESET_DELAY_MS=3000
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
CONFIG_NET_ETHERNET=y
CONFIG_NET_PCI=y
CONFIG_TULIP=y
CONFIG_NET_PCMCIA=y
CONFIG_PCMCIA_PCNET=y
CONFIG_NET_PCMCIA_RADIO=y
CONFIG_PCMCIA_RAYCS=y
CONFIG_INPUT=y
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=y
CONFIG_MOUSE=y
CONFIG_PSMOUSE=y
CONFIG_AGP=y
CONFIG_AGP_INTEL=y
CONFIG_AGP_I810=y
CONFIG_AGP_VIA=y
CONFIG_AGP_AMD=y
CONFIG_AGP_SIS=y
CONFIG_AGP_ALI=y
CONFIG_AGP_SWORKS=y
CONFIG_DRM=y
CONFIG_VIDEO_DEV=y
CONFIG_VIDEO_PROC_FS=y
CONFIG_QUOTA=y
CONFIG_AUTOFS_FS=y
CONFIG_AUTOFS4_FS=y
CONFIG_REISERFS_FS=y
CONFIG_EXT3_FS=y
CONFIG_JBD=y
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_CRAMFS=y
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_ROMFS_FS=y
CONFIG_EXT2_FS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
CONFIG_NFSD=y
CONFIG_NFSD_V3=y
CONFIG_SUNRPC=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_SMB_FS=y
CONFIG_ZLIB_FS_INFLATE=y
CONFIG_MSDOS_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
CONFIG_SOUND=y
CONFIG_SOUND_ES1370=y
CONFIG_SOUND_ES1371=y
CONFIG_USB=y
CONFIG_USB_UHCI_ALT=y
CONFIG_USB_STORAGE=y
CONFIG_USB_STORAGE_SDDR09=y
CONFIG_USB_HID=y
CONFIG_USB_SCANNER=y

My dmesg:

Linux version 2.4.16 (root@condor) (gcc version 2.96 20000731 (Red Hat
Linux 7.1 2.96-81)) #1 Wed Dec 5 23:57:40 CST 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000020000000 (usable)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
On node 0 totalpages: 131072
zone(0): 4096 pages.
zone(1): 126976 pages.
zone(2): 0 pages.
Kernel command line: auto BOOT_IMAGE=linux ro root=804
BOOT_FILE=/boot/vmlinuz
Initializing CPU#0
Detected 1529.003 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3047.42 BogoMIPS
Memory: 512892k/524288k available (1765k kernel code, 11012k reserved,
541k data, 212k init, 0k highmem)
Dentry-cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: Before vendor init, caps: 0183f9ff c1c7f9ff 00000000, vendor = 2
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After vendor init, caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU:     After generic, caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU:             Common caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU: AMD Athlon(tm) processor stepping 04
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfb5e0, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
PCI: Using IRQ router VIA [1106/0686] at 00:07.0
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd
VFS: Diskquotas version dquot_6.4.0 initialized
Journalled Block Device driver loaded
parport0: PC-style at 0x378 [PCSPP(,...)]
parport_pc: Via 686A parallel port: io=0x378
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
lp0: using parport0 (polling).
block: 128 slots per queue, batch=32
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
PCI: Enabling device 00:07.1 (0000 -> 0001)
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
VP_IDE: neither IDE port enabled (BIOS)
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
Linux Tulip driver version 0.9.15-pre9 (Nov 6, 2001)
PCI: Found IRQ 10 for device 00:0d.0
PCI: Sharing IRQ 10 with 00:07.2
PCI: Sharing IRQ 10 with 00:0b.0
eth0: ADMtek Comet rev 17 at 0xb000, 00:04:5A:48:64:EF, IRQ 10.
Linux video capture interface: v1.00
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 440M
agpgart: Detected AMD 761 chipset
agpgart: AGP aperture is 128M @ 0xd0000000
SCSI subsystem driver Revision: 1.00
PCI: Found IRQ 15 for device 00:08.0
PCI: Sharing IRQ 15 with 01:05.0
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.4
        <Adaptec 2940 Ultra SCSI adapter>
        aic7880: Ultra Wide Channel A, SCSI Id=7, 16/253 SCBs

  Vendor: YAMAHA    Model: CRW2100S          Rev: 1.0N
  Type:   CD-ROM                             ANSI SCSI revision: 02
(scsi0:A:1): 10.000MB/s transfers (10.000MHz, offset 7)
  Vendor: HP        Model: HP35470A          Rev: T603
  Type:   Sequential-Access                  ANSI SCSI revision: 02
(scsi0:A:3): 5.000MB/s transfers (5.000MHz, offset 8)
scsi1 : SCSI host adapter emulation for IDE ATAPI devices
3ware Storage Controller device driver for Linux v1.02.00.010.
PCI: Found IRQ 11 for device 00:09.0
scsi2 : Found a 3ware Storage Controller at 0xa800, IRQ: 11, P-chip: 5.7
scsi2 : 3ware Storage Controller
  Vendor: 3ware     Model: 3w-xxxx           Rev: 1.0
  Type:   Direct-Access                      ANSI SCSI revision: 00
st: Version 20011103, bufsize 32768, wrt 30720, max init. bufs 4, s/g segs
16
Attached scsi tape st0 at scsi0, channel 0, id 3, lun 0
Attached scsi disk sda at scsi2, channel 0, id 0, lun 0
SCSI device sda: 180135425 512-byte hdwr sectors (92229 MB)
Partition check:
 sda: sda1 sda2 sda3 sda4
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 1, lun 0
sr0: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
es1370: version v0.37 time 23:59:50 Dec  5 2001
es1371: version v0.30 time 23:59:52 Dec  5 2001
PCI: Found IRQ 10 for device 00:0b.0
PCI: Sharing IRQ 10 with 00:07.2
PCI: Sharing IRQ 10 with 00:0d.0
es1371: found chip, vendor id 0x1274 device id 0x5880 revision 0x02
es1371: found es1371 rev 2 at io 0xac00 irq 10
es1371: features: joystick 0x0
ac97_codec: AC97 Audio codec, id: 0x8384:0x7609 (SigmaTel STAC9721/23)
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus]
usb.c: registered new driver hub
uhci.c: USB Universal Host Controller Interface driver v1.1
PCI: Found IRQ 10 for device 00:07.2
PCI: Sharing IRQ 10 with 00:0b.0
PCI: Sharing IRQ 10 with 00:0d.0
uhci.c: USB UHCI at I/O 0x9800, IRQ 10
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
usb.c: registered new driver hid
hid-core.c: v1.8 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
usb.c: registered new driver usbscanner
scanner.c: 0.4.6:USB Scanner Driver
Initializing USB Mass Storage driver...
usb.c: registered new driver usb-storage
USB Mass Storage support registered.
mice: PS/2 mouse device common for all mice
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 131072 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
ds: no socket drivers loaded!
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 212k freed
hub.c: USB new device connect on bus1/2, assigned device number 2
input0: USB HID v1.10 Mouse [Logitech USB Mouse] on usb1:2.0
Adding Swap: 530104k swap-space (priority -1)

My bttv module loads:

Dec  6 00:22:31 condor kernel: tuner: ignoring SMBus Via Pro adapter at
5000 i2c adapter [id=0x40002]
Dec  6 00:22:31 condor kernel: tuner: ignoring ISA main adapter i2c
adapter [id=0x50000]
Dec  6 00:22:31 condor kernel: bttv: driver version 0.7.86 loaded
Dec  6 00:22:31 condor kernel: bttv: using 2 buffers with 2080k (4160k
total) for capture
Dec  6 00:22:31 condor kernel: bttv: Host bridge is Advanced Micro Devices
[AMD] AMD-760 [Irongate] System Controller
Dec  6 00:22:31 condor kernel: bttv: Bt8xx card found (0).
Dec  6 00:22:31 condor kernel: PCI: Found IRQ 12 for device 00:0c.0
Dec  6 00:22:31 condor kernel: PCI: Sharing IRQ 12 with 00:0c.1
Dec  6 00:22:31 condor kernel: bttv0: Bt878 (rev 2) at 00:0c.0, irq: 12,
latency: 32, memory:
0xe3002000
Dec  6 00:22:31 condor kernel: bttv0: detected: Hauppauge WinTV [card=10],
PCI subsystem ID is 0070:13eb
Dec  6 00:22:31 condor kernel: bttv0: using: BT878(Hauppauge (bt878))
[card=10,insmod option]
Dec  6 00:22:31 condor kernel: bttv0: Hauppauge/Voodoo msp34xx: reset line
init [5]
Dec  6 00:22:31 condor kernel: bttv0: i2c attach [client=EEPROM chip,ok]
Dec  6 00:22:31 condor kernel: dpl3518: init
Dec  6 00:22:31 condor kernel: bttv0: i2c attach [client=DPL3518,ok]
Dec  6 00:22:31 condor kernel: msp34xx: init: chip=MSP3430G-A1, has NICAM
support
Dec  6 00:22:31 condor kernel: msp3410: daemon started
Dec  6 00:22:31 condor kernel: bttv0: i2c attach [client=MSP3430G-A1,ok]
Dec  6 00:22:31 condor kernel: tuner: probing bt848 #0 i2c adapter
[id=0x10005]
Dec  6 00:22:31 condor kernel: tuner: chip found @ 0xc2
Dec  6 00:22:31 condor kernel: bttv0: i2c attach [client=Philips PAL,ok]
Dec  6 00:22:31 condor kernel: bttv0: Hauppauge eeprom: model=37381,
tuner=Philips FM1236 (2), radio=yes
Dec  6 00:22:31 condor kernel: bttv0: i2c: checking for MSP34xx @ 0x80...
found
Dec  6 00:22:31 condor kernel: bttv0: i2c: checking for TDA9875 @ 0xb0...
not found
Dec  6 00:22:31 condor kernel: bttv0: i2c: checking for TDA7432 @ 0x8a...
not found
Dec  6 00:22:31 condor kernel: tvaudio: TV audio decoder + audio/video mux
driver
Dec  6 00:22:31 condor kernel: tvaudio: known chips:
tda9840,tda9873h,tda9874a,tda9850,tda9855,tea6300,tea6420,tda8425,pic16c54
(PV951)
Dec  6 00:22:31 condor kernel: tvmixer: debug: EEPROM chip
Dec  6 00:22:31 condor kernel: tvmixer: debug: DPL3518
Dec  6 00:22:31 condor kernel: tvmixer: debug: MSP3430G-A1
Dec  6 00:22:31 condor kernel: tvmixer: MSP3430G-A1 (bt848 #0) registered
with minor 16
Dec  6 00:22:31 condor kernel: tvmixer: debug: Philips PAL

My /proc/interrupts:

           CPU0
  0:    8581772          XT-PIC  timer
  1:      37364          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
 10:    4850778          XT-PIC  es1371, usb-uhci, eth0
 11:     747802          XT-PIC  3ware Storage Controller
 12:        448          XT-PIC  bttv
 15:    7419032          XT-PIC  aic7xxx, nvidia
NMI:          0
ERR:          0


-----------------------------------------
Brad Hartin - bhartin@straus-frank.com
Communications Administrator
Straus-Frank Enterprises Limited
Carquest retail/wholesale distributor for
areas in TX, OK, LA, AR, NM, and KS

