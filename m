Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129598AbRBMBnt>; Mon, 12 Feb 2001 20:43:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129654AbRBMBnk>; Mon, 12 Feb 2001 20:43:40 -0500
Received: from breg.mc.mpls.visi.com ([208.42.156.101]:61148 "HELO
	breg.mc.mpls.visi.com") by vger.kernel.org with SMTP
	id <S129598AbRBMBnX>; Mon, 12 Feb 2001 20:43:23 -0500
Date: Mon, 12 Feb 2001 19:43:19 -0600 (CST)
From: Ryan Hayle <hackel@walkingfish.com>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VT82C597 + Maxtor UDMA failures
In-Reply-To: <20010209091657.B1691@suse.cz>
Message-ID: <Pine.GSO.4.21.0102121930560.28579-100000@isis.visi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Vojtech,
Thanks for your response.  I tried using 2.4.2-pre3 and the same problem
occurs, in exactly the same manner.  The only other problem I can identify
is a boot message:

IRQ routing conflict in pirq table for device 00:0a.0

lspci reveals that 00:0a.0 is my network card:

00:0a.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone]

But I'm not sure why that would have any problem, as it works perfectly,
and I don't see any conflicts:

/proc/interrupts:
           CPU0
  0:     416389          XT-PIC  timer
  1:      18840          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  8:          1          XT-PIC  rtc
  9:     135491          XT-PIC  soundblaster
 10:      83005          XT-PIC  eth0
 11:     386543          XT-PIC  nvidia
 12:     121397          XT-PIC  PS/2 Mouse
 14:       3967          XT-PIC  ide0
 15:     249701          XT-PIC  ide1
NMI:          0
ERR:          0

If you would like any other info, or have any ideas, please let me
know.  The cable seems to be fine, and like I said it works okay in
Windows.

Thanks again,
Ryan


On Fri, 9 Feb 2001, Vojtech Pavlik wrote:

> Hi!
> 
> Please try 2.4.2-pre kernels, they have a newer VIA IDE driver.
> 
> Vojtech
> 
> On Wed, Feb 07, 2001 at 03:37:49PM -0600, Ryan Hayle wrote:
> > I'm trying to troubleshoot a failure with my Maxtor hard drive that I have
> > experienced consistantly, even in the 2.2.x kernels (I'm now running
> > 2.2.1-test10, .config is attached).  It detects all of my drives fine:
> > 
> > block: queued sectors max/low 126786kB/95090kB, 384 slots per queue
> > Uniform Multi-Platform E-IDE driver Revision: 6.31
> > ide: Assuming 33MHz system bus speed for PIO modes; override with
> > idebus=xx
> > VP_IDE: IDE controller on PCI bus 00 dev 39
> > VP_IDE: chipset revision 6
> > VP_IDE: not 100% native mode: will probe irqs later
> > VP_IDE: VIA vt82c586b IDE UDMA33 controller on pci0:7.1
> >     ide0: BM-DMA at 0xe000-0xe007, BIOS settings: hda:DMA, hdb:DMA
> >     ide1: BM-DMA at 0xe008-0xe00f, BIOS settings: hdc:DMA, hdd:DMA
> > hda: Maxtor 52049U4, ATA DISK drive
> > hdb: WDC AC31200F, ATA DISK drive
> > ide: Assuming 33MHz system bus speed for PIO modes; override with
> > idebus=xx
> > hdc: Maxtor 90680D4, ATA DISK drive
> > hdd: ATAPI 40X CDROM DRIVE, ATAPI CD/DVD-ROM drive
> > ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> > ide1 at 0x170-0x177,0x376 on irq 15
> > hda: 40020624 sectors (20491 MB) w/2048KiB Cache, CHS=2491/255/63,
> > UDMA(33)
> > hdb: 2503872 sectors (1282 MB) w/64KiB Cache, CHS=621/64/63, DMA
> > hdc: 13281408 sectors (6800 MB) w/256KiB Cache, CHS=13176/16/63, UDMA(33)
> > hdd: ATAPI 40X CD-ROM drive, 128kB Cache, UDMA(33)
> > 
> > And then all the services load up, etc.  Once I log in, though, either in
> > gdm or on the console, it will pause for around 10-15 seconds, and then
> > display this:
> > 
> > hdc: timeout waiting for DMA
> > ide_dmaproc: chipset supported ide_dma_timeout func only: 14
> > hdc: irq timeout: status=0x58 { DriveReady SeekComplete DataRequest }
> > hdc: status timeout: status=0xd0 { Busy }
> > hdc: DMA disabled
> > hdd: DMA disabled
> > hdc: drive not ready for command
> > ide1: reset: success
> > 
> > (hdc is the problem, obviously)  Once this occurs, the system appears to
> > run normally.  I don't really care about hdd (cdrom), although I figure
> > they are probably related somehow.
> > 
> > Windows is able to use UDMA fine on this drive.  Also note that this isn't
> > a UDMA66 drive, and I'm not trying to use it (most of the other posts
> > I've seen with similar problems were related to 66).  
> > 
> > Drives on ide0 seem to run in udma mode just fine, also...
> > 
> > Here's /proc/ide/via:
> > 
> > ----------VIA BusMastering IDE Configuration----------------
> > Driver Version:                     2.1e
> > South Bridge:                       VIA vt82c586b rev 0x47
> > Command register:                   0x7
> > Latency timer:                      64
> > PCI clock:                          33MHz
> > Master Read  Cycle IRDY:            1ws
> > Master Write Cycle IRDY:            1ws
> > FIFO Output Data 1/2 Clock Advance: off
> > BM IDE Status Register Read Retry:  on
> > Max DRDY Pulse Width:               No limit
> > -----------------------Primary IDE-------Secondary IDE------
> > Read DMA FIFO flush:           on                  on
> > End Sect. FIFO flush:          on                  on
> > Prefetch Buffer:               on                  on
> > Post Write Buffer:             on                  on
> > FIFO size:                      8                   8
> > Threshold Prim.:              1/2                 1/2
> > Bytes Per Sector:             512                 512
> > Both channels togth:          yes                 yes
> > -------------------drive0----drive1----drive2----drive3-----
> > BMDMA enabled:        yes       yes        no        no
> > Transfer Mode:       UDMA   DMA/PIO      UDMA      UDMA
> > Address Setup:       30ns      60ns      30ns      30ns
> > Active Pulse:        90ns      90ns      90ns      90ns
> > Recovery Time:       30ns      60ns      30ns      30ns
> > Cycle Time:          60ns     150ns      60ns      60ns
> > Transfer Rate:   33.0MB/s  13.2MB/s  33.0MB/s  33.0MB/s
> > 
> > What I don't understand is, the transfer mode still seems to be "UDMA",
> > but "BMDMA" is not enabled.  Aren't they inter-dependant?  One in the
> > same?  I'm obviously no expert, so any help would be appreciated.
> > 
> > Thanks in advance,
> > Ryan
> > 
> 
> > #
> > # Automatically generated make config: don't edit
> > #
> > CONFIG_X86=y
> > CONFIG_ISA=y
> > # CONFIG_SBUS is not set
> > CONFIG_UID16=y
> > 
> > #
> > # Code maturity level options
> > #
> > CONFIG_EXPERIMENTAL=y
> > 
> > #
> > # Loadable module support
> > #
> > CONFIG_MODULES=y
> > CONFIG_MODVERSIONS=y
> > CONFIG_KMOD=y
> > 
> > #
> > # Processor type and features
> > #
> > # CONFIG_M386 is not set
> > # CONFIG_M486 is not set
> > # CONFIG_M586 is not set
> > # CONFIG_M586TSC is not set
> > # CONFIG_M586MMX is not set
> > # CONFIG_M686 is not set
> > # CONFIG_MPENTIUMIII is not set
> > # CONFIG_MPENTIUM4 is not set
> > CONFIG_MK6=y
> > # CONFIG_MK7 is not set
> > # CONFIG_MCRUSOE is not set
> > # CONFIG_MWINCHIPC6 is not set
> > # CONFIG_MWINCHIP2 is not set
> > # CONFIG_MWINCHIP3D is not set
> > CONFIG_X86_WP_WORKS_OK=y
> > CONFIG_X86_INVLPG=y
> > CONFIG_X86_CMPXCHG=y
> > CONFIG_X86_BSWAP=y
> > CONFIG_X86_POPAD_OK=y
> > CONFIG_X86_L1_CACHE_SHIFT=5
> > CONFIG_X86_ALIGNMENT_16=y
> > CONFIG_X86_TSC=y
> > CONFIG_X86_USE_PPRO_CHECKSUM=y
> > # CONFIG_TOSHIBA is not set
> > # CONFIG_MICROCODE is not set
> > # CONFIG_X86_MSR is not set
> > # CONFIG_X86_CPUID is not set
> > CONFIG_NOHIGHMEM=y
> > # CONFIG_HIGHMEM4G is not set
> > # CONFIG_HIGHMEM64G is not set
> > # CONFIG_MATH_EMULATION is not set
> > CONFIG_MTRR=y
> > # CONFIG_SMP is not set
> > # CONFIG_X86_UP_IOAPIC is not set
> > 
> > #
> > # General setup
> > #
> > CONFIG_NET=y
> > # CONFIG_VISWS is not set
> > CONFIG_PCI=y
> > # CONFIG_PCI_GOBIOS is not set
> > # CONFIG_PCI_GODIRECT is not set
> > CONFIG_PCI_GOANY=y
> > CONFIG_PCI_BIOS=y
> > CONFIG_PCI_DIRECT=y
> > CONFIG_PCI_NAMES=y
> > # CONFIG_EISA is not set
> > # CONFIG_MCA is not set
> > # CONFIG_HOTPLUG is not set
> > # CONFIG_PCMCIA is not set
> > CONFIG_SYSVIPC=y
> > # CONFIG_BSD_PROCESS_ACCT is not set
> > CONFIG_SYSCTL=y
> > CONFIG_KCORE_ELF=y
> > # CONFIG_KCORE_AOUT is not set
> > CONFIG_BINFMT_AOUT=m
> > CONFIG_BINFMT_ELF=y
> > CONFIG_BINFMT_MISC=m
> > CONFIG_PM=y
> > # CONFIG_ACPI is not set
> > # CONFIG_APM is not set
> > 
> > #
> > # Memory Technology Devices (MTD)
> > #
> > # CONFIG_MTD is not set
> > 
> > #
> > # Parallel port support
> > #
> > CONFIG_PARPORT=m
> > CONFIG_PARPORT_PC=m
> > # CONFIG_PARPORT_PC_FIFO is not set
> > # CONFIG_PARPORT_PC_SUPERIO is not set
> > # CONFIG_PARPORT_AMIGA is not set
> > # CONFIG_PARPORT_MFC3 is not set
> > # CONFIG_PARPORT_ATARI is not set
> > # CONFIG_PARPORT_SUNBPP is not set
> > # CONFIG_PARPORT_OTHER is not set
> > CONFIG_PARPORT_1284=y
> > 
> > #
> > # Plug and Play configuration
> > #
> > CONFIG_PNP=y
> > CONFIG_ISAPNP=y
> > 
> > #
> > # Block devices
> > #
> > CONFIG_BLK_DEV_FD=y
> > # CONFIG_BLK_DEV_XD is not set
> > # CONFIG_PARIDE is not set
> > # CONFIG_BLK_CPQ_DA is not set
> > # CONFIG_BLK_CPQ_CISS_DA is not set
> > # CONFIG_BLK_DEV_DAC960 is not set
> > CONFIG_BLK_DEV_LOOP=m
> > # CONFIG_BLK_DEV_NBD is not set
> > # CONFIG_BLK_DEV_RAM is not set
> > 
> > #
> > # Multi-device support (RAID and LVM)
> > #
> > # CONFIG_MD is not set
> > 
> > #
> > # Networking options
> > #
> > CONFIG_PACKET=y
> > # CONFIG_PACKET_MMAP is not set
> > # CONFIG_NETLINK is not set
> > # CONFIG_NETFILTER is not set
> > # CONFIG_FILTER is not set
> > CONFIG_UNIX=y
> > CONFIG_INET=y
> > CONFIG_IP_MULTICAST=y
> > # CONFIG_IP_ADVANCED_ROUTER is not set
> > # CONFIG_IP_PNP is not set
> > # CONFIG_NET_IPIP is not set
> > # CONFIG_NET_IPGRE is not set
> > # CONFIG_IP_MROUTE is not set
> > # CONFIG_INET_ECN is not set
> > # CONFIG_SYN_COOKIES is not set
> > # CONFIG_IPV6 is not set
> > CONFIG_KHTTPD=m
> > # CONFIG_ATM is not set
> > 
> > #
> > #  
> > #
> > # CONFIG_IPX is not set
> > # CONFIG_ATALK is not set
> > # CONFIG_DECNET is not set
> > # CONFIG_BRIDGE is not set
> > # CONFIG_X25 is not set
> > # CONFIG_LAPB is not set
> > # CONFIG_LLC is not set
> > # CONFIG_NET_DIVERT is not set
> > # CONFIG_ECONET is not set
> > # CONFIG_WAN_ROUTER is not set
> > # CONFIG_NET_FASTROUTE is not set
> > # CONFIG_NET_HW_FLOWCONTROL is not set
> > 
> > #
> > # QoS and/or fair queueing
> > #
> > # CONFIG_NET_SCHED is not set
> > 
> > #
> > # Telephony Support
> > #
> > # CONFIG_PHONE is not set
> > 
> > #
> > # ATA/IDE/MFM/RLL support
> > #
> > CONFIG_IDE=y
> > 
> > #
> > # IDE, ATA and ATAPI Block devices
> > #
> > CONFIG_BLK_DEV_IDE=y
> > 
> > #
> > # Please see Documentation/ide.txt for help/info on IDE drives
> > #
> > # CONFIG_BLK_DEV_HD_IDE is not set
> > # CONFIG_BLK_DEV_HD is not set
> > CONFIG_BLK_DEV_IDEDISK=y
> > CONFIG_IDEDISK_MULTI_MODE=y
> > # CONFIG_BLK_DEV_IDEDISK_VENDOR is not set
> > # CONFIG_BLK_DEV_COMMERIAL is not set
> > CONFIG_BLK_DEV_IDECD=y
> > # CONFIG_BLK_DEV_IDETAPE is not set
> > # CONFIG_BLK_DEV_IDEFLOPPY is not set
> > 
> > #
> > # IDE chipset support/bugfixes
> > #
> > # CONFIG_BLK_DEV_CMD640 is not set
> > # CONFIG_BLK_DEV_ISAPNP is not set
> > # CONFIG_BLK_DEV_RZ1000 is not set
> > CONFIG_BLK_DEV_IDEPCI=y
> > # CONFIG_IDEPCI_SHARE_IRQ is not set
> > CONFIG_BLK_DEV_IDEDMA_PCI=y
> > # CONFIG_BLK_DEV_OFFBOARD is not set
> > CONFIG_IDEDMA_PCI_AUTO=y
> > CONFIG_BLK_DEV_IDEDMA=y
> > # CONFIG_IDEDMA_PCI_WIP is not set
> > # CONFIG_BLK_DEV_AEC62XX is not set
> > # CONFIG_BLK_DEV_ALI15X3 is not set
> > # CONFIG_BLK_DEV_AMD7409 is not set
> > # CONFIG_BLK_DEV_CMD64X is not set
> > # CONFIG_BLK_DEV_CY82C693 is not set
> > # CONFIG_BLK_DEV_CS5530 is not set
> > # CONFIG_BLK_DEV_HPT34X is not set
> > # CONFIG_BLK_DEV_HPT366 is not set
> > # CONFIG_BLK_DEV_PIIX is not set
> > # CONFIG_BLK_DEV_NS87415 is not set
> > # CONFIG_BLK_DEV_OPTI621 is not set
> > # CONFIG_BLK_DEV_PDC202XX is not set
> > # CONFIG_BLK_DEV_OSB4 is not set
> > # CONFIG_BLK_DEV_SIS5513 is not set
> > # CONFIG_BLK_DEV_SLC90E66 is not set
> > # CONFIG_BLK_DEV_TRM290 is not set
> > CONFIG_BLK_DEV_VIA82CXXX=y
> > # CONFIG_IDE_CHIPSETS is not set
> > CONFIG_IDEDMA_AUTO=y
> > # CONFIG_IDEDMA_IVB is not set
> > # CONFIG_DMA_NONPCI is not set
> > CONFIG_BLK_DEV_IDE_MODES=y
> > 
> > #
> > # SCSI support
> > #
> > # CONFIG_SCSI is not set
> > 
> > #
> > # IEEE 1394 (FireWire) support
> > #
> > # CONFIG_IEEE1394 is not set
> > 
> > #
> > # I2O device support
> > #
> > # CONFIG_I2O is not set
> > 
> > #
> > # Network device support
> > #
> > CONFIG_NETDEVICES=y
> > 
> > #
> > # ARCnet devices
> > #
> > # CONFIG_ARCNET is not set
> > CONFIG_DUMMY=m
> > # CONFIG_BONDING is not set
> > # CONFIG_EQUALIZER is not set
> > # CONFIG_TUN is not set
> > # CONFIG_NET_SB1000 is not set
> > 
> > #
> > # Ethernet (10 or 100Mbit)
> > #
> > CONFIG_NET_ETHERNET=y
> > CONFIG_NET_VENDOR_3COM=y
> > # CONFIG_EL1 is not set
> > # CONFIG_EL2 is not set
> > # CONFIG_ELPLUS is not set
> > # CONFIG_EL16 is not set
> > # CONFIG_EL3 is not set
> > # CONFIG_3C515 is not set
> > CONFIG_VORTEX=y
> > # CONFIG_LANCE is not set
> > # CONFIG_NET_VENDOR_SMC is not set
> > # CONFIG_NET_VENDOR_RACAL is not set
> > # CONFIG_AT1700 is not set
> > # CONFIG_DEPCA is not set
> > # CONFIG_HP100 is not set
> > # CONFIG_NET_ISA is not set
> > # CONFIG_NET_PCI is not set
> > # CONFIG_NET_POCKET is not set
> > 
> > #
> > # Ethernet (1000 Mbit)
> > #
> > # CONFIG_ACENIC is not set
> > # CONFIG_HAMACHI is not set
> > # CONFIG_YELLOWFIN is not set
> > # CONFIG_SK98LIN is not set
> > # CONFIG_FDDI is not set
> > # CONFIG_HIPPI is not set
> > # CONFIG_PLIP is not set
> > CONFIG_PPP=m
> > # CONFIG_PPP_MULTILINK is not set
> > # CONFIG_PPP_ASYNC is not set
> > # CONFIG_PPP_SYNC_TTY is not set
> > CONFIG_PPP_DEFLATE=m
> > CONFIG_PPP_BSDCOMP=m
> > # CONFIG_PPPOE is not set
> > # CONFIG_SLIP is not set
> > 
> > #
> > # Wireless LAN (non-hamradio)
> > #
> > # CONFIG_NET_RADIO is not set
> > 
> > #
> > # Token Ring devices
> > #
> > # CONFIG_TR is not set
> > # CONFIG_NET_FC is not set
> > # CONFIG_RCPCI is not set
> > # CONFIG_SHAPER is not set
> > 
> > #
> > # Wan interfaces
> > #
> > # CONFIG_WAN is not set
> > 
> > #
> > # Amateur Radio support
> > #
> > # CONFIG_HAMRADIO is not set
> > 
> > #
> > # IrDA (infrared) support
> > #
> > # CONFIG_IRDA is not set
> > 
> > #
> > # ISDN subsystem
> > #
> > # CONFIG_ISDN is not set
> > 
> > #
> > # Old CD-ROM drivers (not SCSI, not IDE)
> > #
> > # CONFIG_CD_NO_IDESCSI is not set
> > 
> > #
> > # Input core support
> > #
> > CONFIG_INPUT=m
> > # CONFIG_INPUT_KEYBDEV is not set
> > # CONFIG_INPUT_MOUSEDEV is not set
> > # CONFIG_INPUT_JOYDEV is not set
> > # CONFIG_INPUT_EVDEV is not set
> > 
> > #
> > # Character devices
> > #
> > CONFIG_VT=y
> > CONFIG_VT_CONSOLE=y
> > CONFIG_SERIAL=y
> > # CONFIG_SERIAL_CONSOLE is not set
> > # CONFIG_SERIAL_EXTENDED is not set
> > # CONFIG_SERIAL_NONSTANDARD is not set
> > CONFIG_UNIX98_PTYS=y
> > CONFIG_UNIX98_PTY_COUNT=512
> > CONFIG_PRINTER=m
> > # CONFIG_LP_CONSOLE is not set
> > # CONFIG_PPDEV is not set
> > 
> > #
> > # I2C support
> > #
> > CONFIG_I2C=m
> > CONFIG_I2C_ALGOBIT=m
> > # CONFIG_I2C_PHILIPSPAR is not set
> > # CONFIG_I2C_ELV is not set
> > # CONFIG_I2C_VELLEMAN is not set
> > # CONFIG_I2C_ALGOPCF is not set
> > # CONFIG_I2C_CHARDEV is not set
> > 
> > #
> > # Mice
> > #
> > # CONFIG_BUSMOUSE is not set
> > CONFIG_MOUSE=y
> > CONFIG_PSMOUSE=y
> > # CONFIG_82C710_MOUSE is not set
> > # CONFIG_PC110_PAD is not set
> > 
> > #
> > # Joysticks
> > #
> > CONFIG_JOYSTICK=y
> > 
> > #
> > # Game port support
> > #
> > # CONFIG_INPUT_NS558 is not set
> > # CONFIG_INPUT_LIGHTNING is not set
> > # CONFIG_INPUT_PCIGAME is not set
> > 
> > #
> > # Gameport joysticks
> > #
> > CONFIG_INPUT_ANALOG=m
> > # CONFIG_INPUT_A3D is not set
> > # CONFIG_INPUT_ADI is not set
> > # CONFIG_INPUT_COBRA is not set
> > # CONFIG_INPUT_GF2K is not set
> > # CONFIG_INPUT_GRIP is not set
> > # CONFIG_INPUT_INTERACT is not set
> > # CONFIG_INPUT_TMDC is not set
> > # CONFIG_INPUT_SIDEWINDER is not set
> > 
> > #
> > # Serial port support
> > #
> > # CONFIG_INPUT_SERPORT is not set
> > 
> > #
> > # Serial port joysticks
> > #
> > # CONFIG_INPUT_WARRIOR is not set
> > # CONFIG_INPUT_MAGELLAN is not set
> > # CONFIG_INPUT_SPACEORB is not set
> > # CONFIG_INPUT_SPACEBALL is not set
> > # CONFIG_INPUT_IFORCE_232 is not set
> > 
> > #
> > # Parallel port joysticks
> > #
> > # CONFIG_INPUT_DB9 is not set
> > # CONFIG_INPUT_GAMECON is not set
> > # CONFIG_INPUT_TURBOGRAFX is not set
> > # CONFIG_QIC02_TAPE is not set
> > 
> > #
> > # Watchdog Cards
> > #
> > # CONFIG_WATCHDOG is not set
> > # CONFIG_INTEL_RNG is not set
> > # CONFIG_NVRAM is not set
> > CONFIG_RTC=m
> > # CONFIG_DTLK is not set
> > # CONFIG_R3964 is not set
> > # CONFIG_APPLICOM is not set
> > 
> > #
> > # Ftape, the floppy tape device driver
> > #
> > # CONFIG_FTAPE is not set
> > # CONFIG_AGP is not set
> > # CONFIG_DRM is not set
> > 
> > #
> > # Multimedia devices
> > #
> > CONFIG_VIDEO_DEV=m
> > 
> > #
> > # Video For Linux
> > #
> > CONFIG_VIDEO_PROC_FS=y
> > # CONFIG_I2C_PARPORT is not set
> > 
> > #
> > # Video Adapters
> > #
> > CONFIG_VIDEO_BT848=m
> > # CONFIG_VIDEO_PMS is not set
> > # CONFIG_VIDEO_BWQCAM is not set
> > # CONFIG_VIDEO_CQCAM is not set
> > # CONFIG_VIDEO_CPIA is not set
> > # CONFIG_VIDEO_SAA5249 is not set
> > # CONFIG_TUNER_3036 is not set
> > # CONFIG_VIDEO_STRADIS is not set
> > # CONFIG_VIDEO_ZORAN is not set
> > # CONFIG_VIDEO_ZR36120 is not set
> > 
> > #
> > # Radio Adapters
> > #
> > # CONFIG_RADIO_CADET is not set
> > # CONFIG_RADIO_RTRACK is not set
> > # CONFIG_RADIO_RTRACK2 is not set
> > # CONFIG_RADIO_AZTECH is not set
> > # CONFIG_RADIO_GEMTEK is not set
> > # CONFIG_RADIO_MAESTRO is not set
> > # CONFIG_RADIO_MIROPCM20 is not set
> > # CONFIG_RADIO_SF16FMI is not set
> > # CONFIG_RADIO_TERRATEC is not set
> > # CONFIG_RADIO_TRUST is not set
> > # CONFIG_RADIO_TYPHOON is not set
> > # CONFIG_RADIO_ZOLTRIX is not set
> > 
> > #
> > # File systems
> > #
> > # CONFIG_QUOTA is not set
> > # CONFIG_AUTOFS_FS is not set
> > CONFIG_AUTOFS4_FS=y
> > # CONFIG_REISERFS_FS is not set
> > # CONFIG_ADFS_FS is not set
> > # CONFIG_AFFS_FS is not set
> > # CONFIG_HFS_FS is not set
> > # CONFIG_BFS_FS is not set
> > CONFIG_FAT_FS=y
> > # CONFIG_MSDOS_FS is not set
> > CONFIG_VFAT_FS=y
> > # CONFIG_EFS_FS is not set
> > CONFIG_JFFS_FS_VERBOSE=0
> > # CONFIG_CRAMFS is not set
> > # CONFIG_RAMFS is not set
> > CONFIG_ISO9660_FS=m
> > CONFIG_JOLIET=y
> > # CONFIG_MINIX_FS is not set
> > # CONFIG_NTFS_FS is not set
> > # CONFIG_HPFS_FS is not set
> > CONFIG_PROC_FS=y
> > # CONFIG_DEVFS_FS is not set
> > CONFIG_DEVPTS_FS=y
> > # CONFIG_QNX4FS_FS is not set
> > # CONFIG_ROMFS_FS is not set
> > CONFIG_EXT2_FS=y
> > # CONFIG_SYSV_FS is not set
> > # CONFIG_UDF_FS is not set
> > # CONFIG_UFS_FS is not set
> > 
> > #
> > # Network File Systems
> > #
> > # CONFIG_CODA_FS is not set
> > # CONFIG_NFS_FS is not set
> > # CONFIG_NFSD is not set
> > # CONFIG_SUNRPC is not set
> > # CONFIG_LOCKD is not set
> > CONFIG_SMB_FS=m
> > CONFIG_SMB_NLS_DEFAULT=y
> > CONFIG_SMB_NLS_REMOTE="cp437"
> > # CONFIG_NCP_FS is not set
> > 
> > #
> > # Partition Types
> > #
> > # CONFIG_PARTITION_ADVANCED is not set
> > CONFIG_MSDOS_PARTITION=y
> > CONFIG_SMB_NLS=y
> > CONFIG_NLS=y
> > 
> > #
> > # Native Language Support
> > #
> > CONFIG_NLS_DEFAULT="iso8859-1"
> > CONFIG_NLS_CODEPAGE_437=m
> > # CONFIG_NLS_CODEPAGE_737 is not set
> > # CONFIG_NLS_CODEPAGE_775 is not set
> > # CONFIG_NLS_CODEPAGE_850 is not set
> > # CONFIG_NLS_CODEPAGE_852 is not set
> > # CONFIG_NLS_CODEPAGE_855 is not set
> > # CONFIG_NLS_CODEPAGE_857 is not set
> > # CONFIG_NLS_CODEPAGE_860 is not set
> > # CONFIG_NLS_CODEPAGE_861 is not set
> > # CONFIG_NLS_CODEPAGE_862 is not set
> > # CONFIG_NLS_CODEPAGE_863 is not set
> > # CONFIG_NLS_CODEPAGE_864 is not set
> > # CONFIG_NLS_CODEPAGE_865 is not set
> > # CONFIG_NLS_CODEPAGE_866 is not set
> > # CONFIG_NLS_CODEPAGE_869 is not set
> > # CONFIG_NLS_CODEPAGE_874 is not set
> > # CONFIG_NLS_CODEPAGE_932 is not set
> > # CONFIG_NLS_CODEPAGE_936 is not set
> > # CONFIG_NLS_CODEPAGE_949 is not set
> > # CONFIG_NLS_CODEPAGE_950 is not set
> > CONFIG_NLS_ISO8859_1=y
> > # CONFIG_NLS_ISO8859_2 is not set
> > # CONFIG_NLS_ISO8859_3 is not set
> > # CONFIG_NLS_ISO8859_4 is not set
> > # CONFIG_NLS_ISO8859_5 is not set
> > # CONFIG_NLS_ISO8859_6 is not set
> > # CONFIG_NLS_ISO8859_7 is not set
> > # CONFIG_NLS_ISO8859_8 is not set
> > # CONFIG_NLS_ISO8859_9 is not set
> > # CONFIG_NLS_ISO8859_14 is not set
> > # CONFIG_NLS_ISO8859_15 is not set
> > # CONFIG_NLS_KOI8_R is not set
> > # CONFIG_NLS_UTF8 is not set
> > 
> > #
> > # Console drivers
> > #
> > CONFIG_VGA_CONSOLE=y
> > CONFIG_VIDEO_SELECT=y
> > # CONFIG_MDA_CONSOLE is not set
> > 
> > #
> > # Frame-buffer support
> > #
> > CONFIG_FB=y
> > CONFIG_DUMMY_CONSOLE=y
> > # CONFIG_FB_RIVA is not set
> > # CONFIG_FB_CLGEN is not set
> > # CONFIG_FB_PM2 is not set
> > # CONFIG_FB_CYBER2000 is not set
> > CONFIG_FB_VESA=y
> > # CONFIG_FB_VGA16 is not set
> > # CONFIG_FB_HGA is not set
> > CONFIG_VIDEO_SELECT=y
> > # CONFIG_FB_MATROX is not set
> > # CONFIG_FB_ATY is not set
> > # CONFIG_FB_ATY128 is not set
> > # CONFIG_FB_3DFX is not set
> > # CONFIG_FB_SIS is not set
> > # CONFIG_FB_VIRTUAL is not set
> > # CONFIG_FBCON_ADVANCED is not set
> > CONFIG_FBCON_CFB8=y
> > CONFIG_FBCON_CFB16=y
> > CONFIG_FBCON_CFB24=y
> > CONFIG_FBCON_CFB32=y
> > # CONFIG_FBCON_FONTWIDTH8_ONLY is not set
> > # CONFIG_FBCON_FONTS is not set
> > CONFIG_FONT_8x8=y
> > CONFIG_FONT_8x16=y
> > 
> > #
> > # Sound
> > #
> > CONFIG_SOUND=y
> > # CONFIG_SOUND_CMPCI is not set
> > # CONFIG_SOUND_EMU10K1 is not set
> > # CONFIG_SOUND_FUSION is not set
> > # CONFIG_SOUND_CS4281 is not set
> > # CONFIG_SOUND_ES1370 is not set
> > # CONFIG_SOUND_ES1371 is not set
> > # CONFIG_SOUND_ESSSOLO1 is not set
> > # CONFIG_SOUND_MAESTRO is not set
> > # CONFIG_SOUND_SONICVIBES is not set
> > # CONFIG_SOUND_TRIDENT is not set
> > # CONFIG_SOUND_MSNDCLAS is not set
> > # CONFIG_SOUND_MSNDPIN is not set
> > # CONFIG_SOUND_VIA82CXXX is not set
> > CONFIG_SOUND_OSS=y
> > # CONFIG_SOUND_TRACEINIT is not set
> > CONFIG_SOUND_DMAP=y
> > # CONFIG_SOUND_AD1816 is not set
> > # CONFIG_SOUND_SGALAXY is not set
> > # CONFIG_SOUND_ADLIB is not set
> > # CONFIG_SOUND_ACI_MIXER is not set
> > # CONFIG_SOUND_CS4232 is not set
> > # CONFIG_SOUND_SSCAPE is not set
> > # CONFIG_SOUND_GUS is not set
> > # CONFIG_SOUND_ICH is not set
> > # CONFIG_SOUND_VMIDI is not set
> > # CONFIG_SOUND_TRIX is not set
> > # CONFIG_SOUND_MSS is not set
> > # CONFIG_SOUND_MPU401 is not set
> > # CONFIG_SOUND_NM256 is not set
> > # CONFIG_SOUND_MAD16 is not set
> > # CONFIG_SOUND_PAS is not set
> > # CONFIG_SOUND_PSS is not set
> > CONFIG_SOUND_SB=y
> > CONFIG_SOUND_AWE32_SYNTH=y
> > # CONFIG_SOUND_WAVEFRONT is not set
> > # CONFIG_SOUND_MAUI is not set
> > CONFIG_SOUND_YM3812=y
> > # CONFIG_SOUND_OPL3SA1 is not set
> > # CONFIG_SOUND_OPL3SA2 is not set
> > # CONFIG_SOUND_YMPCI is not set
> > # CONFIG_SOUND_YMFPCI is not set
> > # CONFIG_SOUND_UART6850 is not set
> > # CONFIG_SOUND_AEDSP16 is not set
> > # CONFIG_SOUND_TVMIXER is not set
> > 
> > #
> > # USB support
> > #
> > # CONFIG_USB is not set
> > 
> > #
> > # Kernel hacking
> > #
> > CONFIG_MAGIC_SYSRQ=y
> 
> 
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
