Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264189AbTE0VVj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 17:21:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264199AbTE0VVi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 17:21:38 -0400
Received: from toulouse-2-a7-62-147-37-116.dial.proxad.net ([62.147.37.116]:7296
	"EHLO albireo.free.fr") by vger.kernel.org with ESMTP
	id S264189AbTE0VUh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 17:20:37 -0400
Message-Id: <200305272133.h4RLXlN1000712@albireo.free.fr>
Date: Tue, 27 May 2003 23:33:47 +0200 (CEST)
From: frahm@irsamc.ups-tlse.fr
Reply-To: frahm@irsamc.ups-tlse.fr
Subject: 2.4.21-rc5: DMA disabled for IDE Cdrom, works with 2.4.20
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.21-rc5: DMA disabled for IDE Cdrom, works with 2.4.20


I cannot use DMA for my IDE Cdrom (/dev/hdb) with kernel version 2.4.21-rc5 
(same problem with 2.4.21-rc1, 2.4.21-rc2, 2.4.21-rc3, 2.4.21-rc4 and 
2.4.21-rc2-ac3). 
When I activate DMA by "hdparm -d1 /dev/hdb" (or by using the appropriate 
config-options for compiling the kernel) this seems to work but when I try to 
mount a standard iso-cdrom the machine is blocked for about 15-20 seconds 
and DMA on /dev/hdb is disabled (but the mount has succeeded). 
The kernel provides the following messages (dmesg-output):

hdb: DMA interrupt recovery
hdb: lost interrupt
hdb: status timeout: status=0xd0 { Busy }
hdb: status timeout: error=0x00
hdb: DMA disabled
hdb: drive not ready for command
hdb: ATAPI reset complete
ISO 9660 Extensions: RRIP_1991A

Sometimes the mount attempt may actually completely freeze the system 
instead of only disabling DMA. I have the impression that this happens when 
it coincides with some hard-disk activity. In principle, DMA for the 
harddisk alone (on /dev/hda) seems to work properly. 

I have an ASUS-P3B-F motherboard with a PIII 500 Mhz and an Intel PIIX4 
chipset (the manual gives PIIX4E chipset, more details in dmesg-output 
appended below). I did NOT configure Local APIC and put PIIXn 
chipset support in the kernel. I understand that there may be some 
hardware-problem/bug but DMA for the cdrom (and harddisk) works correctly 
with the latest stable kernel versions 2.4.20 / 2.2.25. 
(I have also an SCSI CD-writer on an Adaptec AHA-7850 SCSI-adapter which 
seems to work fine with the aic7xxx-driver.) 

I have appended below: 
- output of ver_linux 
- output of dmesg
- /proc/iomem
- /proc/interrupts
- /proc/pci
- .config (only lines with "=[y|m]")


Klaus Frahm,

e-mail : frahm@irsamc.ups-tlse.fr.

PS. I am also testing the 2.4.21-rc-series on another computer 
with an ALI15X3-chipset. There is no DMA-problem but the CD-rom 
is actually a DVD-rom and attached to the device /dev/hdc 
(instead of /dev/hdb). 
I am not subscribed to the mailing list and any cc to me for a reply 
would be nice. In any case, I regularly check the archive on the web.


------------------------------------------------------------
--- output of ver_linux:
------------------------------------------------------------
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux albireo 2.4.21-rc5 #1 Tue May 27 22:40:09 CEST 2003 i686 unknown
 
Gnu C                  egcs-2.91.66
Gnu make               3.77
binutils               2.9.1.0.25
util-linux             2.11z
mount                  2.11z
modutils               2.4.25
e2fsprogs              1.33
pcmcia-cs              3.1.3
PPP                    2.4.1
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 2.0.2
Net-tools              1.53
Kbd                    0.99
Sh-utils               2.0
Modules Loaded         ipt_MASQUERADE ipt_LOG ipt_state iptable_filter ip_nat_ftp iptable_nat ip_conntrack_irc ip_conntrack_ftp ip_conntrack ip_tables
------------------------------------------------------------
--- output of dmesg:
------------------------------------------------------------
Linux version 2.4.21-rc5 (frahm@albireo) (gcc version 3.2.2) #1 Tue May 27 22:40:09 CEST 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000027ffc000 (usable)
 BIOS-e820: 0000000027ffc000 - 0000000027fff000 (ACPI data)
 BIOS-e820: 0000000027fff000 - 0000000028000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
639MB LOWMEM available.
On node 0 totalpages: 163836
zone(0): 4096 pages.
zone(1): 159740 pages.
zone(2): 0 pages.
Kernel command line: BOOT_IMAGE=test ro root=301
Initializing CPU#0
Detected 501.146 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 999.42 BogoMIPS
Memory: 645212k/655344k available (1758k kernel code, 9744k reserved, 589k data, 112k init, 0k highmem)
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 65536 (order: 6, 262144 bytes)
Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383f9ff 00000000 00000000 00000000
CPU:             Common caps: 0383f9ff 00000000 00000000 00000000
CPU: Intel Pentium III (Katmai) stepping 03
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
PCI: PCI BIOS revision 2.10 entry at 0xf08b0, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router PIIX [8086/7110] at 00:04.0
Limiting direct PCI/PCI transfers.
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16)
Starting kswapd
Journalled Block Device driver loaded
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
PCI: Found IRQ 5 for device 00:0d.0
PCI: Sharing IRQ 5 with 00:04.2
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
See Documentation/networking/vortex.txt
00:0d.0: 3Com PCI 3c905C Tornado at 0xa800. Vers LK1.1.16
 00:04:75:ad:66:a6, IRQ 5
  product code 564e rev 00.6 date 07-09-02
  Internal config register is 1800000, transceivers 0xa.
  8K byte-wide RAM 5:3 Rx:Tx split, autoselect/Autonegotiate interface.
  MII transceiver found at address 24, status 7809.
  Enabling bus-master transmits and whole-frame receives.
00:0d.0: scatter/gather enabled. h/w checksums enabled
PPP generic driver version 2.4.2
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 564M
agpgart: Detected Intel 440BX chipset
agpgart: AGP aperture is 64M @ 0xe4000000
[drm] Initialized tdfx 1.0.0 20010216 on minor 0
[drm] AGP 0.99 on Intel 440BX @ 0xe4000000 64MB
[drm] Initialized radeon 1.1.1 20010405 on minor 1
[drm] AGP 0.99 on Intel 440BX @ 0xe4000000 64MB
[drm] Initialized i810 1.2.0 20010920 on minor 2
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller at PCI slot 00:04.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xb800-0xb807, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xb808-0xb80f, BIOS settings: hdc:pio, hdd:pio
hda: WDC WD136AA, ATA DISK drive
hdb: SONY CDU4811, ATAPI CD/DVD-ROM drive
blk: queue c038ec20, I/O limit 4095Mb (mask 0xffffffff)
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 26564832 sectors (13601 MB) w/2048KiB Cache, CHS=1653/255/63, UDMA(33)
hdb: attached ide-cdrom driver.
hdb: ATAPI 48X CD-ROM drive, 120kB Cache
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda: hda1 hda2 hda3 < hda5 hda6 hda7 hda8 hda9 hda10 >
SCSI subsystem driver Revision: 1.00
kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2
es1371: version v0.32 time 22:46:04 May 27 2003
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
usb.c: registered new driver hub
host/uhci.c: USB Universal Host Controller Interface driver v1.1
PCI: Found IRQ 5 for device 00:04.2
PCI: Sharing IRQ 5 with 00:0d.0
host/uhci.c: USB UHCI at I/O 0xb400, IRQ 5
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
ds: no socket drivers loaded!
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 112k freed
Adding Swap: 530136k swap-space (priority -1)
ip_tables: (C) 2000-2002 Netfilter core team
ip_conntrack version 2.1 (5119 buckets, 40952 max) - 292 bytes per conntrack
hdb: DMA interrupt recovery
hdb: lost interrupt
hdb: status timeout: status=0xd0 { Busy }
hdb: status timeout: error=0x00
hdb: DMA disabled
hdb: drive not ready for command
hdb: ATAPI reset complete
ISO 9660 Extensions: RRIP_1991A
------------------------------------------------------------
--- /proc/iomem
------------------------------------------------------------
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-27ffbfff : System RAM
  00100000-002b7a85 : Kernel code
  002b7a86-0034aedf : Kernel data
27ffc000-27ffefff : ACPI Tables
27fff000-27ffffff : ACPI Non-volatile Storage
e0800000-e080007f : 3Com Corporation 3c905C-TX/TX-M [Tornado]
e1000000-e1000fff : Adaptec AHA-7850
e1800000-e3dfffff : PCI Bus #01
  e1800000-e1800fff : ATI Technologies Inc 3D Rage Pro AGP 1X/2X
  e2000000-e2ffffff : ATI Technologies Inc 3D Rage Pro AGP 1X/2X
e3f00000-e3ffffff : PCI Bus #01
e4000000-e7ffffff : Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge
ffff0000-ffffffff : reserved
------------------------------------------------------------
--- /proc/interrupts
------------------------------------------------------------
           CPU0       
  0:      21114          XT-PIC  timer
  1:        536          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  5:          0          XT-PIC  usb-uhci, eth0
 12:          8          XT-PIC  PS/2 Mouse
 14:       2693          XT-PIC  ide0
NMI:          0 
ERR:          0
------------------------------------------------------------
--- /proc/pci
------------------------------------------------------------
PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge (rev 3).
      Master Capable.  Latency=64.  
      Prefetchable 32 bit memory at 0xe4000000 [0xe7ffffff].
  Bus  0, device   1, function  0:
    PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge (rev 3).
      Master Capable.  Latency=64.  Min Gnt=136.
  Bus  0, device   4, function  0:
    ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 2).
  Bus  0, device   4, function  1:
    IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 1).
      Master Capable.  Latency=32.  
      I/O at 0xb800 [0xb80f].
  Bus  0, device   4, function  2:
    USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 1).
      IRQ 5.
      Master Capable.  Latency=32.  
      I/O at 0xb400 [0xb41f].
  Bus  0, device   4, function  3:
    Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 2).
      IRQ 9.
  Bus  0, device  10, function  0:
    SCSI storage controller: Adaptec AHA-7850 (rev 3).
      IRQ 10.
      Master Capable.  Latency=32.  Min Gnt=4.Max Lat=4.
      I/O at 0xb000 [0xb0ff].
      Non-prefetchable 32 bit memory at 0xe1000000 [0xe1000fff].
  Bus  0, device  13, function  0:
    Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] (rev 120).
      IRQ 5.
      Master Capable.  Latency=32.  Min Gnt=10.Max Lat=10.
      I/O at 0xa800 [0xa87f].
      Non-prefetchable 32 bit memory at 0xe0800000 [0xe080007f].
  Bus  1, device   0, function  0:
    VGA compatible controller: ATI Technologies Inc 3D Rage Pro AGP 1X/2X (rev 92).
      IRQ 11.
      Master Capable.  Latency=64.  Min Gnt=8.
      Non-prefetchable 32 bit memory at 0xe2000000 [0xe2ffffff].
      I/O at 0xd800 [0xd8ff].
      Non-prefetchable 32 bit memory at 0xe1800000 [0xe1800fff].
------------------------------------------------------------
--- .config (only lines with "=[y|m]")
------------------------------------------------------------
CONFIG_X86=y
CONFIG_UID16=y
CONFIG_MODULES=y
CONFIG_KMOD=y
CONFIG_MPENTIUMIII=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_HAS_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_F00F_WORKS_OK=y
CONFIG_X86_MCE=y
CONFIG_NOHIGHMEM=y
CONFIG_X86_TSC=y
CONFIG_NET=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_ISA=y
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
CONFIG_PM=y
CONFIG_APM=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_CML1=m
CONFIG_PARPORT_SERIAL=m
CONFIG_PNP=y
CONFIG_ISAPNP=y
CONFIG_BLK_DEV_FD=y
CONFIG_PARIDE=m
CONFIG_PARIDE_PARPORT=m
CONFIG_PARIDE_PD=m
CONFIG_PARIDE_PCD=m
CONFIG_PARIDE_PF=m
CONFIG_PARIDE_PT=m
CONFIG_PARIDE_PG=m
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_RAM=m
CONFIG_PACKET=y
CONFIG_NETFILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_NAT=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_TOS=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_ROUTE_LARGE_TABLES=y
CONFIG_IP_PNP=y
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE=m
CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_IRC=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_PKTTYPE=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_DSCP=m
CONFIG_IP_NF_MATCH_AH_ESP=m
CONFIG_IP_NF_MATCH_LENGTH=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_MATCH_TCPMSS=m
CONFIG_IP_NF_MATCH_HELPER=m
CONFIG_IP_NF_MATCH_STATE=m
CONFIG_IP_NF_MATCH_CONNTRACK=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_NAT_LOCAL=y
CONFIG_IP_NF_NAT_IRC=m
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_DSCP=m
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_ULOG=m
CONFIG_IP_NF_TARGET_TCPMSS=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_COMPAT_IPCHAINS=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_COMPAT_IPFWADM=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECS=m
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDEFLOPPY=m
CONFIG_BLK_DEV_IDESCSI=m
CONFIG_BLK_DEV_CMD640=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_GENERIC=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_ADMA100=y
CONFIG_BLK_DEV_PIIX=y
CONFIG_BLK_DEV_RZ1000=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=y
CONFIG_BLK_DEV_SR=m
CONFIG_CHR_DEV_SG=m
CONFIG_SCSI_DEBUG_QUEUES=y
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_AIC7XXX=m
CONFIG_SCSI_AIC7XXX_OLD=m
CONFIG_SCSI_SYM53C8XX=y
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
CONFIG_TUN=m
CONFIG_NET_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
CONFIG_VORTEX=y
CONFIG_NET_PCI=y
CONFIG_EEPRO100=y
CONFIG_PPP=y
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_BSDCOMP=m
CONFIG_NET_PCMCIA=y
CONFIG_PCMCIA_PCNET=y
CONFIG_NET_PCMCIA_RADIO=y
CONFIG_PCMCIA_RAYCS=y
CONFIG_INPUT=m
CONFIG_INPUT_KEYBDEV=m
CONFIG_INPUT_MOUSEDEV=m
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=m
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_SERIAL_EXTENDED=y
CONFIG_SERIAL_SHARE_IRQ=y
CONFIG_SERIAL_NONSTANDARD=y
CONFIG_STALDRV=y
CONFIG_STALLION=m
CONFIG_ISTALLION=m
CONFIG_UNIX98_PTYS=y
CONFIG_MOUSE=y
CONFIG_PSMOUSE=y
CONFIG_AGP=y
CONFIG_AGP_INTEL=y
CONFIG_AGP_I810=y
CONFIG_AGP_VIA=y
CONFIG_AGP_AMD=y
CONFIG_AGP_SIS=y
CONFIG_AGP_ALI=y
CONFIG_DRM=y
CONFIG_DRM_NEW=y
CONFIG_DRM_TDFX=y
CONFIG_DRM_RADEON=y
CONFIG_DRM_I810=y
CONFIG_DRM_I810_XFREE_41=y
CONFIG_AUTOFS4_FS=y
CONFIG_EXT3_FS=y
CONFIG_JBD=y
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_UMSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=y
CONFIG_MINIX_FS=m
CONFIG_NTFS_FS=m
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y
CONFIG_NFS_FS=y
CONFIG_NFSD=y
CONFIG_NFSD_V3=y
CONFIG_SUNRPC=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_SMB_FS=m
CONFIG_MSDOS_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y
CONFIG_VGA_CONSOLE=y
CONFIG_SOUND=y
CONFIG_SOUND_ES1371=y
CONFIG_SOUND_OSS=m
CONFIG_USB=y
CONFIG_USB_UHCI_ALT=y
CONFIG_USB_AUDIO=m
CONFIG_USB_EMI26=m
CONFIG_USB_MIDI=m
CONFIG_USB_STORAGE=m
CONFIG_USB_ACM=m
CONFIG_USB_PRINTER=m
CONFIG_USB_HID=m
CONFIG_USB_DC2XX=m
CONFIG_USB_SCANNER=m
CONFIG_USB_MICROTEK=m
CONFIG_USB_TIGL=m
CONFIG_USB_LCD=m
CONFIG_ZLIB_INFLATE=m
CONFIG_ZLIB_DEFLATE=m


