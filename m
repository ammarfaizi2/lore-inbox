Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277258AbRJLGz7>; Fri, 12 Oct 2001 02:55:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277260AbRJLGzp>; Fri, 12 Oct 2001 02:55:45 -0400
Received: from smtprt15.wanadoo.fr ([193.252.19.210]:3050 "EHLO
	smtprt15.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S277258AbRJLGz1>; Fri, 12 Oct 2001 02:55:27 -0400
Content-Type: text/plain; charset=US-ASCII
From: Duncan Sands <duncan.sands@math.u-psud.fr>
To: linux-kernel@vger.kernel.org
Subject: xine pauses with recent (not -ac) kernels
Date: Fri, 12 Oct 2001 08:55:28 +0200
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01101208552800.00838@baldrick>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: xine pauses with recent (not -ac) kernels

Problem: using xine to view an (encrypted) DVD, xine is slow to move
on to the second .vob file: at the end of the first file, it at best
waits a few seconds with a black screen and consuming no CPU, before
moving on to the second file, but sometimes it waits for a long time.

Correct behaviour: the second .vob file starts playing at once.

I think this is a kernel problem because it did not occur up to
2.4.9.  The problem appeared between 2.4.10-pre10 and 2.4.10-pre13.
It is present in 2.4.12.  It doesn't seem to occur in any -ac kernels.

linux-2.4.9 : correct
...
linux-2.4.10-pre10 : correct
linux-2.4.10-pre11 : fails to compile
linux-2.4.10-pre12 : oops during system init
linux-2.4.10-pre13 : problem present
...
linux-2.4.12 : problem present

If I replay the DVD several times, the length of the pause varies, and
sometimes it does not occur at all.

Any ideas?

Duncan.

PS: Please CC replies to me.

PPS: xine output, syslog extract, .config and XFree86.0.log follow:

Here is what xine outputs:

X-Video settings: HUE, SATURATION, BRIGHTNESS, CONTRAST, COLORKEY, .
Using MMX for IDCT transform
Using 3DNOW for motion compensation
xine: could not connect to socket
xine: No such file or directory
Could not read Disc Key: Input/output error
N/A, invalidating: Input/output error
N/A, invalidating: Input/output error
N/A, invalidating: Input/output error
Authenticate title: Input/output error
Could not read Disc Key: Input/output error
N/A, invalidating: Input/output error
N/A, invalidating: Input/output error
N/A, invalidating: Input/output error
Authenticate title: Input/output error
Could not read Disc Key: Input/output error
N/A, invalidating: Input/output error
N/A, invalidating: Input/output error
N/A, invalidating: Input/output error
Authenticate title: Input/output error
This is xine - a free video player v0.4.3
(c) 2000, 2001 by G. Bartsch and the xine project team
Allocating 2000 buffers of 4096 bytes in one chunk (alignment = 2048)
No extra demux plugins found in /usr/lib/xine/plugins
xine_init: demuxer initialized
found yuy2 format
found yv12 format
video_out_xv: using Xvideo port 50 for hw scaling
Using X Window System video extension for video output.
set_image_format_xv(): width=720, height=405, ratio=3
scaled picture size : 720 x 405 (corr_factor: 1.000000)
video_out_xv: reset_xv
xine_init: video thread created
xine_init: SPU thread created
All audio drivers init failed - no audio.
xine_init: audio thread created
input plugin found : 
/usr/lib/xine/plugins/input_stdin_fifo.so(input_stdin_fifo.so)
input plugin found : /usr/lib/xine/plugins/input_file.so(input_file.so)
input plugin found : /usr/lib/xine/plugins/input_net.so(input_net.so)
input plugin found : /usr/lib/xine/plugins/input_vcd.so(input_vcd.so)
input_dvd: unable to open raw dvd drive (/dev/rdvd): No such file or directory
input plugin found : /usr/lib/xine/plugins/input_dvd.so(input_dvd.so)
xine_init: plugins loaded
input_dvd: get_autoplay_list
Using ifo VTS_02_0.IFO
xine open dvd://t0c0t0, start pos = 0
input dvd : input_plugin_open >dvd://t0c0t0<
input dvd : input_plugin_open media type correct. file name is t0c0t0
IFO-mode playing title 0 from chapter 0 -> chapter 0
Using ifo VTS_02_0.IFO
input length : 33259520
Attempting to obtain CLUT
select audio channel : 0
set_image_format_xv(): width=720, height=576, ratio=3
scaled picture size : 1023 x 576 (corr_factor: 1.422222)
video_out_xv: reset_xv
200 frames delivered, 14 frames skipped, 19 frames discarded
200 frames delivered, 0 frames skipped, 0 frames discarded
200 frames delivered, 0 frames skipped, 0 frames discarded
200 frames delivered, 0 frames skipped, 0 frames discarded
demux_mpeg_block: checking if we can branch to dvd://t0c1t1
input_dvd: is_branch_possible to dvd://t0c1t1 ?
input_dvd: branching is possible
demux_mpeg_block: branching
input dvd : input_plugin_open >dvd://t0c1t1<
input dvd : input_plugin_open media type correct. file name is t0c1t1
IFO-mode playing title 0 from chapter 1 -> chapter 1
###############################
## THIS IS WHERE XINE PAUSES ##
###############################
Using ifo VTS_02_0.IFO
input length : 125788160
329 frames delivered, 1 frames skipped, 143 frames discarded
vo exit
video_out_xv: reset_xv

I get the following messages in syslog (even for good kernels):

Oct 12 08:28:34 baldrick kernel: VFS: Disk change detected on device 
ide1(22,0)
Oct 12 08:28:34 baldrick kernel: hdc: packet command error: status=0x51 { 
DriveReady SeekComplete Error }
Oct 12 08:28:34 baldrick kernel: hdc: packet command error: error=0x50
Oct 12 08:28:34 baldrick kernel: ATAPI device hdc:
Oct 12 08:28:34 baldrick kernel:   Error: Illegal request -- (Sense key=0x05)
Oct 12 08:28:34 baldrick kernel:   Invalid field in command packet -- 
(asc=0x24, ascq=0x00)
Oct 12 08:28:34 baldrick kernel:   The failed "Report Key" packet command 
was: 
Oct 12 08:28:34 baldrick kernel:   "a4 00 00 00 00 00 00 00 00 00 3f 00 "
Oct 12 08:28:34 baldrick kernel:   Error in command packet byte 10 bit 0
Oct 12 08:28:34 baldrick kernel: hdc: packet command error: status=0x51 { 
DriveReady SeekComplete Error }
Oct 12 08:28:34 baldrick kernel: hdc: packet command error: error=0x50
Oct 12 08:28:34 baldrick kernel: ATAPI device hdc:
Oct 12 08:28:34 baldrick kernel:   Error: Illegal request -- (Sense key=0x05)
Oct 12 08:28:34 baldrick kernel:   Invalid field in command packet -- 
(asc=0x24, ascq=0x00)
Oct 12 08:28:34 baldrick kernel:   The failed "Report Key" packet command 
was: 
Oct 12 08:28:34 baldrick kernel:   "a4 00 00 00 00 00 00 00 00 00 7f 00 "
Oct 12 08:28:34 baldrick kernel:   Error in command packet byte 10 bit 0
Oct 12 08:28:34 baldrick kernel: hdc: packet command error: status=0x51 { 
DriveReady SeekComplete Error }

and so on for a long time.

Here is my .config:

#
# Automatically generated make config: don't edit
#
CONFIG_X86=y
CONFIG_ISA=y
# CONFIG_SBUS is not set
CONFIG_UID16=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y

#
# Loadable module support
#
CONFIG_MODULES=y
# CONFIG_MODVERSIONS is not set
CONFIG_KMOD=y

#
# Processor type and features
#
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUM4 is not set
CONFIG_MK6=y
# CONFIG_MK7 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
# CONFIG_RWSEM_GENERIC_SPINLOCK is not set
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_ALIGNMENT_16=y
CONFIG_X86_TSC=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
# CONFIG_TOSHIBA is not set
# CONFIG_MICROCODE is not set
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
# CONFIG_SMP is not set
# CONFIG_X86_UP_APIC is not set
# CONFIG_X86_UP_IOAPIC is not set

#
# General setup
#
CONFIG_NET=y
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
CONFIG_HOTPLUG=y

#
# PCMCIA/CardBus support
#
# CONFIG_PCMCIA is not set
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
# CONFIG_KCORE_AOUT is not set
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=m
# CONFIG_PM is not set
# CONFIG_ACPI is not set
# CONFIG_APM is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
# CONFIG_PARPORT is not set

#
# Plug and Play configuration
#
# CONFIG_PNP is not set
# CONFIG_ISAPNP is not set
# CONFIG_PNPBIOS is not set

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
CONFIG_BLK_DEV_LOOP=y
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_BLK_DEV_INITRD is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set
# CONFIG_BLK_DEV_MD is not set
# CONFIG_MD_LINEAR is not set
# CONFIG_MD_RAID0 is not set
# CONFIG_MD_RAID1 is not set
# CONFIG_MD_RAID5 is not set
# CONFIG_MD_MULTIPATH is not set
# CONFIG_BLK_DEV_LVM is not set

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_MMAP is not set
CONFIG_NETLINK=y
# CONFIG_RTNETLINK is not set
CONFIG_NETLINK_DEV=m
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set
# CONFIG_FILTER is not set
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_INET_ECN is not set
CONFIG_SYN_COOKIES=y

#
#   IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_FTP=m
# CONFIG_IP_NF_QUEUE is not set
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_TCPMSS=m
CONFIG_IP_NF_MATCH_STATE=m
# CONFIG_IP_NF_MATCH_UNCLEAN is not set
# CONFIG_IP_NF_MATCH_OWNER is not set
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
# CONFIG_IP_NF_TARGET_MIRROR is not set
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_TCPMSS=m
# CONFIG_IP_NF_COMPAT_IPCHAINS is not set
# CONFIG_IP_NF_COMPAT_IPFWADM is not set
# CONFIG_IPV6 is not set
# CONFIG_KHTTPD is not set
CONFIG_ATM=y
# CONFIG_ATM_CLIP is not set
# CONFIG_ATM_LANE is not set

#
#  
#
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_LLC is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set
# CONFIG_PHONE_IXJ is not set
# CONFIG_PHONE_IXJ_PCMCIA is not set

#
# ATA/IDE/MFM/RLL support
#
CONFIG_IDE=y

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=y
# CONFIG_IDEDISK_MULTI_MODE is not set
# CONFIG_BLK_DEV_IDEDISK_VENDOR is not set
# CONFIG_BLK_DEV_IDEDISK_FUJITSU is not set
# CONFIG_BLK_DEV_IDEDISK_IBM is not set
# CONFIG_BLK_DEV_IDEDISK_MAXTOR is not set
# CONFIG_BLK_DEV_IDEDISK_QUANTUM is not set
# CONFIG_BLK_DEV_IDEDISK_SEAGATE is not set
# CONFIG_BLK_DEV_IDEDISK_WD is not set
# CONFIG_BLK_DEV_COMMERIAL is not set
# CONFIG_BLK_DEV_TIVO is not set
# CONFIG_BLK_DEV_IDECS is not set
CONFIG_BLK_DEV_IDECD=m
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
CONFIG_BLK_DEV_IDESCSI=m

#
# IDE chipset support/bugfixes
#
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
# CONFIG_BLK_DEV_ISAPNP is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_BLK_DEV_ADMA=y
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_PCI_WIP is not set
# CONFIG_IDEDMA_NEW_DRIVE_LISTINGS is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_AEC62XX_TUNING is not set
CONFIG_BLK_DEV_ALI15X3=y
# CONFIG_WDC_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_AMD74XX_OVERRIDE is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_HPT34X_AUTODMA is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_PIIX_TUNING is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_PDC202XX is not set
# CONFIG_PDC202XX_BURST is not set
# CONFIG_PDC202XX_FORCE is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_CHIPSETS is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_IDEDMA_IVB is not set
# CONFIG_DMA_NONPCI is not set
CONFIG_BLK_DEV_IDE_MODES=y
# CONFIG_BLK_DEV_ATARAID is not set
# CONFIG_BLK_DEV_ATARAID_PDC is not set
# CONFIG_BLK_DEV_ATARAID_HPT is not set

#
# SCSI support
#
CONFIG_SCSI=m

#
# SCSI support type (disk, tape, CD-ROM)
#
# CONFIG_BLK_DEV_SD is not set
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=m
# CONFIG_BLK_DEV_SR_VENDOR is not set
CONFIG_SR_EXTRA_DEVS=2
CONFIG_CHR_DEV_SG=m

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
# CONFIG_SCSI_DEBUG_QUEUES is not set
# CONFIG_SCSI_MULTI_LUN is not set
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_7000FASST is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
# CONFIG_SCSI_AHA1542 is not set
# CONFIG_SCSI_AHA1740 is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_MEGARAID is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_CPQFCTS is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_DTC3280 is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_DMA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_NCR53C7xx is not set
# CONFIG_SCSI_NCR53C8XX is not set
# CONFIG_SCSI_SYM53C8XX is not set
# CONFIG_SCSI_PAS16 is not set
# CONFIG_SCSI_PCI2000 is not set
# CONFIG_SCSI_PCI2220I is not set
# CONFIG_SCSI_PSI240I is not set
# CONFIG_SCSI_QLOGIC_FAS is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_SEAGATE is not set
# CONFIG_SCSI_SIM710 is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set
# CONFIG_SCSI_DEBUG is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set
# CONFIG_FUSION_BOOT is not set
# CONFIG_FUSION_ISENSE is not set
# CONFIG_FUSION_CTL is not set
# CONFIG_FUSION_LAN is not set

#
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set
# CONFIG_I2O_PCI is not set
# CONFIG_I2O_BLOCK is not set
# CONFIG_I2O_LAN is not set
# CONFIG_I2O_SCSI is not set
# CONFIG_I2O_PROC is not set

#
# Network device support
#
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
CONFIG_DUMMY=y
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_ETHERTAP is not set

#
# Ethernet (10 or 100Mbit)
#
# CONFIG_NET_ETHERNET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_MYRI_SBUS is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_SK98LIN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
CONFIG_PPP=y
# CONFIG_PPP_MULTILINK is not set
# CONFIG_PPP_FILTER is not set
CONFIG_PPP_ASYNC=y
# CONFIG_PPP_SYNC_TTY is not set
CONFIG_PPP_DEFLATE=y
CONFIG_PPP_BSDCOMP=y
# CONFIG_PPPOE is not set
# CONFIG_SLIP is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set
# CONFIG_NET_FC is not set
# CONFIG_RCPCI is not set
# CONFIG_SHAPER is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# ATM drivers
#
# CONFIG_ATM_TCP is not set
# CONFIG_ATM_ENI is not set
# CONFIG_ATM_FIRESTREAM is not set
# CONFIG_ATM_ZATM is not set
# CONFIG_ATM_NICSTAR is not set
# CONFIG_ATM_AMBASSADOR is not set
# CONFIG_ATM_HORIZON is not set
# CONFIG_ATM_IA is not set
# CONFIG_ATM_FORE200E_MAYBE is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
# CONFIG_IRDA is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Input core support
#
# CONFIG_INPUT is not set
# CONFIG_INPUT_KEYBDEV is not set
# CONFIG_INPUT_MOUSEDEV is not set
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_EVDEV is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
# CONFIG_SERIAL_CONSOLE is not set
# CONFIG_SERIAL_EXTENDED is not set
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256

#
# I2C support
#
# CONFIG_I2C is not set

#
# Mice
#
# CONFIG_BUSMOUSE is not set
CONFIG_MOUSE=y
CONFIG_PSMOUSE=y
# CONFIG_82C710_MOUSE is not set
# CONFIG_PC110_PAD is not set

#
# Joysticks
#
# CONFIG_INPUT_GAMEPORT is not set

#
# Input core support is needed for gameports
#

#
# Input core support is needed for joysticks
#
# CONFIG_QIC02_TAPE is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_INTEL_RNG is not set
# CONFIG_NVRAM is not set
CONFIG_RTC=m
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=y
# CONFIG_AGP_INTEL is not set
# CONFIG_AGP_I810 is not set
# CONFIG_AGP_VIA is not set
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_SIS is not set
CONFIG_AGP_ALI=y
# CONFIG_AGP_SWORKS is not set
CONFIG_DRM=y
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_GAMMA is not set
CONFIG_DRM_R128=y
# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_I810 is not set
# CONFIG_DRM_MGA is not set

#
# Multimedia devices
#
CONFIG_VIDEO_DEV=m

#
# Video For Linux
#
CONFIG_VIDEO_PROC_FS=y
# CONFIG_I2C_PARPORT is not set

#
# Video Adapters
#
# CONFIG_VIDEO_PMS is not set
# CONFIG_VIDEO_CPIA is not set
# CONFIG_VIDEO_SAA5249 is not set
# CONFIG_TUNER_3036 is not set
# CONFIG_VIDEO_STRADIS is not set
# CONFIG_VIDEO_ZORAN is not set
# CONFIG_VIDEO_ZR36120 is not set
# CONFIG_VIDEO_MEYE is not set

#
# Radio Adapters
#
# CONFIG_RADIO_CADET is not set
# CONFIG_RADIO_RTRACK is not set
# CONFIG_RADIO_RTRACK2 is not set
# CONFIG_RADIO_AZTECH is not set
# CONFIG_RADIO_GEMTEK is not set
# CONFIG_RADIO_GEMTEK_PCI is not set
# CONFIG_RADIO_MAXIRADIO is not set
# CONFIG_RADIO_MAESTRO is not set
# CONFIG_RADIO_MIROPCM20 is not set
# CONFIG_RADIO_MIROPCM20_RDS is not set
# CONFIG_RADIO_SF16FMI is not set
# CONFIG_RADIO_TERRATEC is not set
# CONFIG_RADIO_TRUST is not set
# CONFIG_RADIO_TYPHOON is not set
# CONFIG_RADIO_ZOLTRIX is not set

#
# File systems
#
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set
# CONFIG_REISERFS_FS is not set
# CONFIG_REISERFS_CHECK is not set
# CONFIG_ADFS_FS is not set
# CONFIG_ADFS_FS_RW is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BFS_FS is not set
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
# CONFIG_UMSDOS_FS is not set
CONFIG_VFAT_FS=m
# CONFIG_EFS_FS is not set
# CONFIG_JFFS_FS is not set
# CONFIG_JFFS2_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_TMPFS is not set
# CONFIG_RAMFS is not set
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
# CONFIG_MINIX_FS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_NTFS_RW is not set
# CONFIG_HPFS_FS is not set
CONFIG_PROC_FS=y
CONFIG_DEVFS_FS=y
# CONFIG_DEVFS_MOUNT is not set
# CONFIG_DEVFS_DEBUG is not set
# CONFIG_DEVPTS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX4FS_RW is not set
# CONFIG_ROMFS_FS is not set
CONFIG_EXT2_FS=y
# CONFIG_SYSV_FS is not set
# CONFIG_UDF_FS is not set
# CONFIG_UDF_RW is not set
# CONFIG_UFS_FS is not set
# CONFIG_UFS_FS_WRITE is not set

#
# Network File Systems
#
# CONFIG_CODA_FS is not set
# CONFIG_NFS_FS is not set
# CONFIG_NFS_V3 is not set
# CONFIG_ROOT_NFS is not set
# CONFIG_NFSD is not set
# CONFIG_NFSD_V3 is not set
# CONFIG_SUNRPC is not set
# CONFIG_LOCKD is not set
# CONFIG_SMB_FS is not set
# CONFIG_NCP_FS is not set
# CONFIG_NCPFS_PACKET_SIGNING is not set
# CONFIG_NCPFS_IOCTL_LOCKING is not set
# CONFIG_NCPFS_STRONG is not set
# CONFIG_NCPFS_NFS_NS is not set
# CONFIG_NCPFS_OS2_NS is not set
# CONFIG_NCPFS_SMALLDOS is not set
# CONFIG_NCPFS_NLS is not set
# CONFIG_NCPFS_EXTRAS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
# CONFIG_SMB_NLS is not set
CONFIG_NLS=y

#
# Native Language Support
#
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_UTF8=m

#
# Console drivers
#
CONFIG_VGA_CONSOLE=y
# CONFIG_VIDEO_SELECT is not set
# CONFIG_MDA_CONSOLE is not set

#
# Frame-buffer support
#
# CONFIG_FB is not set

#
# Sound
#
CONFIG_SOUND=y
# CONFIG_SOUND_BT878 is not set
# CONFIG_SOUND_CMPCI is not set
# CONFIG_SOUND_EMU10K1 is not set
# CONFIG_MIDI_EMU10K1 is not set
# CONFIG_SOUND_FUSION is not set
# CONFIG_SOUND_CS4281 is not set
# CONFIG_SOUND_ES1370 is not set
# CONFIG_SOUND_ES1371 is not set
# CONFIG_SOUND_ESSSOLO1 is not set
# CONFIG_SOUND_MAESTRO is not set
# CONFIG_SOUND_MAESTRO3 is not set
# CONFIG_SOUND_ICH is not set
# CONFIG_SOUND_RME96XX is not set
# CONFIG_SOUND_SONICVIBES is not set
# CONFIG_SOUND_TRIDENT is not set
# CONFIG_SOUND_MSNDCLAS is not set
# CONFIG_SOUND_MSNDPIN is not set
# CONFIG_SOUND_VIA82CXXX is not set
# CONFIG_MIDI_VIA82CXXX is not set
# CONFIG_SOUND_OSS is not set
# CONFIG_SOUND_TVMIXER is not set

#
# USB support
#
CONFIG_USB=m
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
# CONFIG_USB_BANDWIDTH is not set

#
# USB Controllers
#
CONFIG_USB_UHCI=m
CONFIG_USB_UHCI_ALT=m
# CONFIG_USB_OHCI is not set

#
# USB Device Class drivers
#
# CONFIG_USB_AUDIO is not set
# CONFIG_USB_BLUETOOTH is not set
# CONFIG_USB_STORAGE is not set
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set

#
# USB Human Interface Devices (HID)
#

#
#   Input core support is needed for USB HID
#

#
# USB Imaging devices
#
# CONFIG_USB_DC2XX is not set
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_SCANNER is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USB_HPUSBSCSI is not set

#
# USB Multimedia devices
#
# CONFIG_USB_IBMCAM is not set
# CONFIG_USB_OV511 is not set
# CONFIG_USB_PWC is not set
# CONFIG_USB_SE401 is not set
# CONFIG_USB_DSBR is not set
# CONFIG_USB_DABUSB is not set

#
# USB Network adaptors
#
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_CATC is not set
# CONFIG_USB_CDCETHER is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_USBNET is not set

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set

#
# USB Serial Converter support
#
# CONFIG_USB_SERIAL is not set

#
# USB misc drivers
#
# CONFIG_USB_RIO500 is not set

#
# Bluetooth support
#
# CONFIG_BLUEZ is not set

#
# Kernel hacking
#
# CONFIG_DEBUG_KERNEL is not set

Here is XFree86.0.log:

This is a pre-release version of XFree86, and is not supported in any
way.  Bugs may be reported to XFree86@XFree86.Org and patches submitted
to fixes@XFree86.Org.  Before reporting bugs in pre-release versions,
please check the latest version in the XFree86 CVS repository
(http://www.XFree86.Org/cvs)

XFree86 Version 4.1.0.1 / X Window System
(protocol Version 11, revision 0, vendor release 6510)
Release Date: xx August 2001
	If the server is older than 6-12 months, or if your card is
	newer than the above date, look for a newer version before
	reporting problems.  (See http://www.XFree86.Org/FAQ)
Build Operating System: Linux 2.4.7 i686 [ELF] 
Module Loader present
(==) Log file: "/var/log/XFree86.0.log", Time: Fri Oct 12 08:27:13 2001
(==) Using config file: "/etc/X11/XF86Config-4"
Markers: (--) probed, (**) from config file, (==) default setting,
         (++) from command line, (!!) notice, (II) informational,
         (WW) warning, (EE) error, (NI) not implemented, (??) unknown.
(==) ServerLayout "Default Layout"
(**) |-->Screen "Default Screen" (0)
(**) |   |-->Monitor "Vision Master Pro 410"
(**) |   |-->Device "All-In-Wonder 128"
(**) |-->Input Device "Default Keyboard"
(**) Option "XkbRules" "xfree86"
(**) XKB: rules: "xfree86"
(**) Option "XkbModel" "pc104"
(**) XKB: model: "pc104"
(**) Option "XkbLayout" "us"
(**) XKB: layout: "us"
(==) Keyboard: CustomKeycode disabled
(**) |-->Input Device "Default Mouse"
(WW) The directory "/usr/lib/X11/fonts/defoma/TrueType" does not exist.
	Entry deleted from font path.
(WW) The directory "/usr/lib/X11/fonts/defoma/CID" does not exist.
	Entry deleted from font path.
(WW) `fonts.dir' not found (or not valid) in "/usr/lib/X11/fonts/cyrillic".
	Entry deleted from font path.
	(Run 'mkfontdir' on "/usr/lib/X11/fonts/cyrillic").
(**) FontPath set to 
"unix/:7100,/usr/lib/X11/fonts/misc,/usr/lib/X11/fonts/100dpi/:unscaled,/usr/lib/X11/fonts/75dpi/:unscaled,/usr/lib/X11/fonts/Type1,/usr/lib/X11/fonts/Speedo,/usr/lib/X11/fonts/100dpi,/usr/lib/X11/fonts/75dpi"
(==) RgbPath set to "/usr/X11R6/lib/X11/rgb"
(==) ModulePath set to "/usr/X11R6/lib/modules"
(--) using VT number 7

(WW) Cannot open APM
(II) Module ABI versions:
	XFree86 ANSI C Emulation: 0.1
	XFree86 Video Driver: 0.4
	XFree86 XInput driver : 0.2
	XFree86 Server Extension : 0.1
	XFree86 Font Renderer : 0.2
(II) Loader running on linux
(II) LoadModule: "bitmap"
(II) Loading /usr/X11R6/lib/modules/fonts/libbitmap.a
(II) Module bitmap: vendor="The XFree86 Project"
	compiled for 4.1.0.1, module version = 1.0.0
	Module class: XFree86 Font Renderer
	ABI class: XFree86 Font Renderer, version 0.2
(II) Loading font Bitmap
(II) LoadModule: "pcidata"
(II) Loading /usr/X11R6/lib/modules/libpcidata.a
(II) Module pcidata: vendor="The XFree86 Project"
	compiled for 4.1.0.1, module version = 0.1.0
	ABI class: XFree86 Video Driver, version 0.4
(II) PCI: Probing config type using method 1
(II) PCI: Config type is 1
(II) PCI: stages = 0x03, oldVal1 = 0x800058c0, mode1Res1 = 0x80000000
(II) PCI: PCI scan (all values are in hex)
(II) PCI: 00:00:0: chip 10b9,1541 card 10b9,1541 rev 04 class 06,00,00 hdr 00
(II) PCI: 00:01:0: chip 10b9,5243 card 0000,0000 rev 04 class 06,04,00 hdr 01
(II) PCI: 00:03:0: chip 10b9,7101 card 10b9,7101 rev 00 class 06,80,00 hdr 00
(II) PCI: 00:07:0: chip 10b9,1533 card 0000,0000 rev c3 class 06,01,00 hdr 00
(II) PCI: 00:0a:0: chip 1013,6003 card 153b,112e rev 01 class 04,01,00 hdr 00
(II) PCI: 00:0b:0: chip 1106,3038 card 0925,1234 rev 04 class 0c,03,00 hdr 00
(II) PCI: 00:0f:0: chip 10b9,5229 card 0000,0000 rev c1 class 01,01,8a hdr 00
(II) PCI: 01:00:0: chip 1002,5246 card 1002,0068 rev 00 class 03,00,00 hdr 00
(II) PCI: End of PCI scan
(II) LoadModule: "scanpci"
(II) Loading /usr/X11R6/lib/modules/libscanpci.a
(II) Module scanpci: vendor="The XFree86 Project"
	compiled for 4.1.0.1, module version = 0.1.0
	ABI class: XFree86 Video Driver, version 0.4
(II) UnloadModule: "scanpci"
(II) Unloading /usr/X11R6/lib/modules/libscanpci.a
(II) Host-to-PCI bridge:
(II) PCI-to-ISA bridge:
(II) PCI-to-PCI bridge:
(II) Bus 0: bridge is at (0:0:0), (-1,0,0), BCTRL: 0x08 (VGA_EN is set)
(II) Bus 0 I/O range:
	[0] -1 0	0x00000000 - 0x0000ffff (0x10000) IX[B]
(II) Bus 0 non-prefetchable memory range:
	[0] -1 0	0x00000000 - 0xffffffff (0x0) MX[B]
(II) Bus 0 prefetchable memory range:
	[0] -1 0	0x00000000 - 0xffffffff (0x0) MX[B]
(II) Bus 1: bridge is at (0:1:0), (0,1,1), BCTRL: 0x08 (VGA_EN is set)
(II) Bus 1 I/O range:
	[0] -1 0	0x0000d000 - 0x0000dfff (0x1000) IX[B]
(II) Bus 1 non-prefetchable memory range:
	[0] -1 0	0xdb800000 - 0xdbffffff (0x800000) MX[B]
(II) Bus 1 prefetchable memory range:
	[0] -1 0	0xe3f00000 - 0xe7ffffff (0x4100000) MX[B]
(II) Bus -1: bridge is at (0:7:0), (0,-1,0), BCTRL: 0x08 (VGA_EN is set)
(II) Bus -1 I/O range:
(II) Bus -1 non-prefetchable memory range:
(II) Bus -1 prefetchable memory range:
(--) PCI:*(1:0:0) ATI Rage 128 RF rev 0, Mem @ 0xe4000000/26, 0xdb800000/14, 
I/O @ 0xd800/8, BIOS @ 0xe3fe0000/17
(II) Addressable bus resource ranges are
	[0] -1 0	0x00000000 - 0xffffffff (0x0) MX[B]
	[1] -1 0	0x00000000 - 0x0000ffff (0x10000) IX[B]
(II) OS-reported resource ranges:
	[0] -1 0	0xffe00000 - 0xffffffff (0x200000) MX[B](B)
	[1] -1 0	0x00100000 - 0x3fffffff (0x3ff00000) MX[B]E(B)
	[2] -1 0	0x000f0000 - 0x000fffff (0x10000) MX[B]
	[3] -1 0	0x000c0000 - 0x000effff (0x30000) MX[B]
	[4] -1 0	0x00000000 - 0x0009ffff (0xa0000) MX[B]
	[5] -1 0	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[6] -1 0	0x00000000 - 0x000000ff (0x100) IX[B]
(II) Active PCI resource ranges:
	[0] -1 0	0xda000000 - 0xda0fffff (0x100000) MX[B]
	[1] -1 0	0xda800000 - 0xda800fff (0x1000) MX[B]
	[2] -1 0	0xdc000000 - 0xdfffffff (0x4000000) MX[B]
	[3] -1 0	0xe3fe0000 - 0xe3ffffff (0x20000) MX[B](B)
	[4] -1 0	0xdb800000 - 0xdb803fff (0x4000) MX[B](B)
	[5] -1 0	0xe4000000 - 0xe7ffffff (0x4000000) MX[B](B)
	[6] -1 0	0x0000b400 - 0x0000b40f (0x10) IX[B]
	[7] -1 0	0x0000b800 - 0x0000b81f (0x20) IX[B]
	[8] -1 0	0x0000d800 - 0x0000d8ff (0x100) IX[B](B)
(II) Active PCI resource ranges after removing overlaps:
	[0] -1 0	0xda000000 - 0xda0fffff (0x100000) MX[B]
	[1] -1 0	0xda800000 - 0xda800fff (0x1000) MX[B]
	[2] -1 0	0xdc000000 - 0xdfffffff (0x4000000) MX[B]
	[3] -1 0	0xe3fe0000 - 0xe3ffffff (0x20000) MX[B](B)
	[4] -1 0	0xdb800000 - 0xdb803fff (0x4000) MX[B](B)
	[5] -1 0	0xe4000000 - 0xe7ffffff (0x4000000) MX[B](B)
	[6] -1 0	0x0000b400 - 0x0000b40f (0x10) IX[B]
	[7] -1 0	0x0000b800 - 0x0000b81f (0x20) IX[B]
	[8] -1 0	0x0000d800 - 0x0000d8ff (0x100) IX[B](B)
(II) OS-reported resource ranges after removing overlaps with PCI:
	[0] -1 0	0xffe00000 - 0xffffffff (0x200000) MX[B](B)
	[1] -1 0	0x00100000 - 0x3fffffff (0x3ff00000) MX[B]E(B)
	[2] -1 0	0x000f0000 - 0x000fffff (0x10000) MX[B]
	[3] -1 0	0x000c0000 - 0x000effff (0x30000) MX[B]
	[4] -1 0	0x00000000 - 0x0009ffff (0xa0000) MX[B]
	[5] -1 0	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[6] -1 0	0x00000000 - 0x000000ff (0x100) IX[B]
(II) All system resource ranges:
	[0] -1 0	0xffe00000 - 0xffffffff (0x200000) MX[B](B)
	[1] -1 0	0x00100000 - 0x3fffffff (0x3ff00000) MX[B]E(B)
	[2] -1 0	0x000f0000 - 0x000fffff (0x10000) MX[B]
	[3] -1 0	0x000c0000 - 0x000effff (0x30000) MX[B]
	[4] -1 0	0x00000000 - 0x0009ffff (0xa0000) MX[B]
	[5] -1 0	0xda000000 - 0xda0fffff (0x100000) MX[B]
	[6] -1 0	0xda800000 - 0xda800fff (0x1000) MX[B]
	[7] -1 0	0xdc000000 - 0xdfffffff (0x4000000) MX[B]
	[8] -1 0	0xe3fe0000 - 0xe3ffffff (0x20000) MX[B](B)
	[9] -1 0	0xdb800000 - 0xdb803fff (0x4000) MX[B](B)
	[10] -1 0	0xe4000000 - 0xe7ffffff (0x4000000) MX[B](B)
	[11] -1 0	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[12] -1 0	0x00000000 - 0x000000ff (0x100) IX[B]
	[13] -1 0	0x0000b400 - 0x0000b40f (0x10) IX[B]
	[14] -1 0	0x0000b800 - 0x0000b81f (0x20) IX[B]
	[15] -1 0	0x0000d800 - 0x0000d8ff (0x100) IX[B](B)
(II) LoadModule: "ddc"
(II) Loading /usr/X11R6/lib/modules/libddc.a
(II) Module ddc: vendor="The XFree86 Project"
	compiled for 4.1.0.1, module version = 1.0.0
	ABI class: XFree86 Video Driver, version 0.4
(II) LoadModule: "GLcore"
(II) Loading /usr/X11R6/lib/modules/extensions/libGLcore.a
(II) Module GLcore: vendor="The XFree86 Project"
	compiled for 4.1.0.1, module version = 1.0.0
	ABI class: XFree86 Server Extension, version 0.1
(II) LoadModule: "dbe"
(II) Loading /usr/X11R6/lib/modules/extensions/libdbe.a
(II) Module dbe: vendor="The XFree86 Project"
	compiled for 4.1.0.1, module version = 1.0.0
	Module class: XFree86 Server Extension
	ABI class: XFree86 Server Extension, version 0.1
(II) Loading extension DOUBLE-BUFFER
(II) LoadModule: "dri"
(II) Loading /usr/X11R6/lib/modules/extensions/libdri.a
(II) Module dri: vendor="The XFree86 Project"
	compiled for 4.1.0.1, module version = 1.0.0
	ABI class: XFree86 Server Extension, version 0.1
(II) Loading sub module "drm"
(II) LoadModule: "drm"
(II) Loading /usr/X11R6/lib/modules/linux/libdrm.a
(II) Module drm: vendor="The XFree86 Project"
	compiled for 4.1.0.1, module version = 1.0.0
	ABI class: XFree86 Server Extension, version 0.1
(II) Loading extension XFree86-DRI
(II) LoadModule: "extmod"
(II) Loading /usr/X11R6/lib/modules/extensions/libextmod.a
(II) Module extmod: vendor="The XFree86 Project"
	compiled for 4.1.0.1, module version = 1.0.0
	Module class: XFree86 Server Extension
	ABI class: XFree86 Server Extension, version 0.1
(II) Loading extension SHAPE
(II) Loading extension MIT-SUNDRY-NONSTANDARD
(II) Loading extension BIG-REQUESTS
(II) Loading extension SYNC
(II) Loading extension MIT-SCREEN-SAVER
(II) Loading extension XC-MISC
(II) Loading extension XFree86-VidModeExtension
(II) Loading extension XFree86-Misc
(II) Loading extension XFree86-DGA
(II) Loading extension DPMS
(II) Loading extension FontCache
(II) Loading extension TOG-CUP
(II) Loading extension Extended-Visual-Information
(II) Loading extension XVideo
(II) Loading extension XVideo-MotionCompensation
(II) LoadModule: "glx"
(II) Loading /usr/X11R6/lib/modules/extensions/libglx.a
(II) Module glx: vendor="The XFree86 Project"
	compiled for 4.1.0.1, module version = 1.0.0
	ABI class: XFree86 Server Extension, version 0.1
(II) Loading sub module "GLcore"
(II) LoadModule: "GLcore"
(II) Reloading /usr/X11R6/lib/modules/extensions/libGLcore.a
(II) Loading extension GLX
(II) LoadModule: "pex5"
(II) Loading /usr/X11R6/lib/modules/extensions/libpex5.a
(II) Module pex5: vendor="The XFree86 Project"
	compiled for 4.1.0.1, module version = 1.0.0
	Module class: XFree86 Server Extension
	ABI class: XFree86 Server Extension, version 0.1
(II) Loading extension X3D-PEX
(II) LoadModule: "record"
(II) Loading /usr/X11R6/lib/modules/extensions/librecord.a
(II) Module record: vendor="The XFree86 Project"
	compiled for 4.1.0.1, module version = 1.13.0
	Module class: XFree86 Server Extension
	ABI class: XFree86 Server Extension, version 0.1
(II) Loading extension RECORD
(II) LoadModule: "xie"
(II) Loading /usr/X11R6/lib/modules/extensions/libxie.a
(II) Module xie: vendor="The XFree86 Project"
	compiled for 4.1.0.1, module version = 1.0.0
	Module class: XFree86 Server Extension
	ABI class: XFree86 Server Extension, version 0.1
(II) Loading extension XIE
(II) LoadModule: "bitmap"
(II) Reloading /usr/X11R6/lib/modules/fonts/libbitmap.a
(II) Loading font Bitmap
(II) LoadModule: "freetype"
(II) Loading /usr/X11R6/lib/modules/fonts/libfreetype.a
(II) Module freetype: vendor="The XFree86 Project"
	compiled for 4.1.0.1, module version = 1.1.9
	Module class: XFree86 Font Renderer
	ABI class: XFree86 Font Renderer, version 0.2
(II) Loading font FreeType
(II) LoadModule: "speedo"
(II) Loading /usr/X11R6/lib/modules/fonts/libspeedo.a
(II) Module speedo: vendor="The XFree86 Project"
	compiled for 4.1.0.1, module version = 1.0.0
	Module class: XFree86 Font Renderer
	ABI class: XFree86 Font Renderer, version 0.2
(II) Loading font Speedo
(II) LoadModule: "type1"
(II) Loading /usr/X11R6/lib/modules/fonts/libtype1.a
(II) Module type1: vendor="The XFree86 Project"
	compiled for 4.1.0.1, module version = 1.0.0
	Module class: XFree86 Font Renderer
	ABI class: XFree86 Font Renderer, version 0.2
(II) Loading font Type1
(II) Loading font CID
(II) LoadModule: "vbe"
(II) Loading /usr/X11R6/lib/modules/libvbe.a
(II) Module vbe: vendor="The XFree86 Project"
	compiled for 4.1.0.1, module version = 1.0.0
	ABI class: XFree86 Video Driver, version 0.4
(II) LoadModule: "int10"
(II) Loading /usr/X11R6/lib/modules/linux/libint10.a
(II) Module int10: vendor="The XFree86 Project"
	compiled for 4.1.0.1, module version = 1.0.0
	ABI class: XFree86 Video Driver, version 0.4
(II) LoadModule: "i2c"
(II) Loading /usr/X11R6/lib/modules/libi2c.a
(II) Module i2c: vendor="The XFree86 Project"
	compiled for 4.1.0.1, module version = 1.2.0
	ABI class: XFree86 Video Driver, version 0.4
(II) LoadModule: "v4l"
(II) Loading /usr/X11R6/lib/modules/drivers/linux/v4l_drv.o
(II) Module v4l: vendor="The XFree86 Project"
	compiled for 4.1.0.1, module version = 0.0.1
	ABI class: XFree86 Video Driver, version 0.4
(II) LoadModule: "r128"
(II) Loading /usr/X11R6/lib/modules/drivers/r128_drv.o
(II) Module r128: vendor="The XFree86 Project"
	compiled for 4.1.0.1, module version = 4.0.1
	Module class: XFree86 Video Driver
	ABI class: XFree86 Video Driver, version 0.4
(II) LoadModule: "ati"
(II) Loading /usr/X11R6/lib/modules/drivers/ati_drv.o
(II) Module ati: vendor="The XFree86 Project"
	compiled for 4.1.0.1, module version = 6.4.0
	Module class: XFree86 Video Driver
	ABI class: XFree86 Video Driver, version 0.4
(II) LoadModule: "mouse"
(II) Loading /usr/X11R6/lib/modules/input/mouse_drv.o
(II) Module mouse: vendor="The XFree86 Project"
	compiled for 4.1.0.1, module version = 1.0.0
	Module class: XFree86 XInput Driver
	ABI class: XFree86 XInput driver, version 0.2
(II) v4l driver for Video4Linux
(II) ATI: ATI driver (version 6.4.0) for chipsets: ati, ativga
(II) R128: Driver for ATI Rage 128 chipsets: ATI Rage 128 RE (PCI),
	ATI Rage 128 RF (AGP), ATI Rage 128 RG (AGP), ATI Rage 128 RK (PCI),
	ATI Rage 128 RL (AGP), ATI Rage 128 Pro PD (PCI),
	ATI Rage 128 Pro PF (AGP), ATI Rage 128 Mobility LE (PCI),
	ATI Rage 128 Mobility LF (AGP), ATI Rage 128 Mobility MF (AGP),
	ATI Rage 128 Mobility ML (AGP)
(II) RADEON: Driver for ATI Radeon chipsets: ATI Radeon QD (AGP),
	ATI Radeon QE (AGP), ATI Radeon QF (AGP), ATI Radeon QG (AGP),
	ATI Radeon VE (AGP)
(II) Primary Device is: PCI 01:00:0
(--) Chipset ATI Rage 128 RF (AGP) found
(II) Loading sub module "r128"
(II) LoadModule: "r128"
(II) Reloading /usr/X11R6/lib/modules/drivers/r128_drv.o
(II) resource ranges after xf86ClaimFixedResources() call:
	[0] -1 0	0xffe00000 - 0xffffffff (0x200000) MX[B](B)
	[1] -1 0	0x00100000 - 0x3fffffff (0x3ff00000) MX[B]E(B)
	[2] -1 0	0x000f0000 - 0x000fffff (0x10000) MX[B]
	[3] -1 0	0x000c0000 - 0x000effff (0x30000) MX[B]
	[4] -1 0	0x00000000 - 0x0009ffff (0xa0000) MX[B]
	[5] -1 0	0xda000000 - 0xda0fffff (0x100000) MX[B]
	[6] -1 0	0xda800000 - 0xda800fff (0x1000) MX[B]
	[7] -1 0	0xdc000000 - 0xdfffffff (0x4000000) MX[B]
	[8] -1 0	0xe3fe0000 - 0xe3ffffff (0x20000) MX[B](B)
	[9] -1 0	0xdb800000 - 0xdb803fff (0x4000) MX[B](B)
	[10] -1 0	0xe4000000 - 0xe7ffffff (0x4000000) MX[B](B)
	[11] -1 0	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[12] -1 0	0x00000000 - 0x000000ff (0x100) IX[B]
	[13] -1 0	0x0000b400 - 0x0000b40f (0x10) IX[B]
	[14] -1 0	0x0000b800 - 0x0000b81f (0x20) IX[B]
	[15] -1 0	0x0000d800 - 0x0000d8ff (0x100) IX[B](B)
(II) resource ranges after probing:
	[0] -1 0	0xffe00000 - 0xffffffff (0x200000) MX[B](B)
	[1] -1 0	0x00100000 - 0x3fffffff (0x3ff00000) MX[B]E(B)
	[2] -1 0	0x000f0000 - 0x000fffff (0x10000) MX[B]
	[3] -1 0	0x000c0000 - 0x000effff (0x30000) MX[B]
	[4] -1 0	0x00000000 - 0x0009ffff (0xa0000) MX[B]
	[5] -1 0	0xda000000 - 0xda0fffff (0x100000) MX[B]
	[6] -1 0	0xda800000 - 0xda800fff (0x1000) MX[B]
	[7] -1 0	0xdc000000 - 0xdfffffff (0x4000000) MX[B]
	[8] -1 0	0xe3fe0000 - 0xe3ffffff (0x20000) MX[B](B)
	[9] -1 0	0xdb800000 - 0xdb803fff (0x4000) MX[B](B)
	[10] -1 0	0xe4000000 - 0xe7ffffff (0x4000000) MX[B](B)
	[11] 0 0	0x000a0000 - 0x000affff (0x10000) MS[B]
	[12] 0 0	0x000b0000 - 0x000b7fff (0x8000) MS[B]
	[13] 0 0	0x000b8000 - 0x000bffff (0x8000) MS[B]
	[14] -1 0	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[15] -1 0	0x00000000 - 0x000000ff (0x100) IX[B]
	[16] -1 0	0x0000b400 - 0x0000b40f (0x10) IX[B]
	[17] -1 0	0x0000b800 - 0x0000b81f (0x20) IX[B]
	[18] -1 0	0x0000d800 - 0x0000d8ff (0x100) IX[B](B)
	[19] 0 0	0x000003b0 - 0x000003bb (0xc) IS[B]
	[20] 0 0	0x000003c0 - 0x000003df (0x20) IS[B]
(II) Setting vga for screen 0.
(II) Loading sub module "vgahw"
(II) LoadModule: "vgahw"
(II) Loading /usr/X11R6/lib/modules/libvgahw.a
(II) Module vgahw: vendor="The XFree86 Project"
	compiled for 4.1.0.1, module version = 0.1.0
	ABI class: XFree86 Video Driver, version 0.4
(II) R128(0): PCI bus 1 card 0 func 0
(**) R128(0): Depth 16, (--) framebuffer bpp 16
(II) R128(0): Pixel depth = 16 bits stored in 2 bytes (16 bpp pixmaps)
(==) R128(0): Default visual is TrueColor
(==) R128(0): RGB weight 565
(II) R128(0): Using 6 bits per RGB (8 bit DAC)
(II) Loading sub module "int10"
(II) LoadModule: "int10"
(II) Reloading /usr/X11R6/lib/modules/linux/libint10.a
(II) R128(0): initializing int10
(II) R128(0): Primary V_BIOS segment is: 0xc000
(--) R128(0): Chipset: "ATI Rage 128 RF (AGP)" (ChipID = 0x5246)
(--) R128(0): Linear framebuffer at 0xe4000000
(--) R128(0): MMIO registers at 0xdb800000
(--) R128(0): BIOS at 0xe3fe0000
(--) R128(0): VideoRAM: 16384 kByte (128-bit SDR SGRAM 1:1)
(II) R128(0): PLL parameters: rf=2950 rd=65 min=12500 max=25000; xclk=9000
(II) Loading sub module "ddc"
(II) LoadModule: "ddc"
(II) Reloading /usr/X11R6/lib/modules/libddc.a
(II) Loading sub module "vbe"
(II) LoadModule: "vbe"
(II) Reloading /usr/X11R6/lib/modules/libvbe.a
(II) R128(0): VESA BIOS detected
(II) R128(0): VESA VBE Version 2.0
(II) R128(0): VESA VBE Total Mem: 16384 kB
(II) R128(0): VESA VBE OEM: ATI RAGE128
(II) R128(0): VESA VBE OEM Software Rev: 1.0
(II) R128(0): VESA VBE OEM Vendor: ATI Technologies Inc.
(II) R128(0): VESA VBE OEM Product: R128
(II) R128(0): VESA VBE OEM Product Rev: 01.00
(II) Loading sub module "ddc"
(II) LoadModule: "ddc"
(II) Reloading /usr/X11R6/lib/modules/libddc.a
(II) R128(0): VESA VBE DDC supported
(II) R128(0): VESA VBE DDC Level 2
(II) R128(0): VESA VBE DDC transfer in appr. 2 sec.
(II) R128(0): VESA VBE DDC read successfully
(II) R128(0): Manufacturer: IVM  Model: 1740  Serial#: 0
(II) R128(0): Year: 1999  Week: 47
(II) R128(0): EDID Version: 1.1
(II) R128(0): Analog Display Input,  Input Voltage Level: 0.700/0.300 V
(II) R128(0): Sync:  Separate  Composite  SyncOnGreen
(II) R128(0): Max H-Image Size [cm]: horiz.: 32  vert.: 24
(II) R128(0): Gamma: 2.48
(II) R128(0): DPMS capabilities: StandBy Suspend Off; RGB/Color Display
(II) R128(0): redX: 0.625 redY: 0.340   greenX: 0.290 greenY: 0.605
(II) R128(0): blueX: 0.150 blueY: 0.070   whiteX: 0.283 whiteY: 0.297
(II) R128(0): Supported VESA Video Modes:
(II) R128(0): 720x400@70Hz
(II) R128(0): 640x480@60Hz
(II) R128(0): 640x480@67Hz
(II) R128(0): 640x480@72Hz
(II) R128(0): 640x480@75Hz
(II) R128(0): 800x600@56Hz
(II) R128(0): 800x600@60Hz
(II) R128(0): 800x600@72Hz
(II) R128(0): 800x600@75Hz
(II) R128(0): 832x624@75Hz
(II) R128(0): 1024x768@60Hz
(II) R128(0): 1024x768@70Hz
(II) R128(0): 1024x768@75Hz
(II) R128(0): 1280x1024@75Hz
(II) R128(0): 1152x870@75Hz
(II) R128(0): Manufacturer's mask: 0
(II) R128(0): Supported Future Video Modes:
(II) R128(0): #0: hsize: 1600  vsize 1200  refresh: 75  vid: 20393
(II) R128(0):  
(II) R128(0):  
(II) R128(0):  
(II) R128(0):  
(==) R128(0): Using gamma correction (1.0, 1.0, 1.0)
(II) R128(0): Vision Master Pro 410: Using hsync range of 27.00-96.00 kHz
(II) R128(0): Vision Master Pro 410: Using vrefresh range of 50.00-160.00 Hz
(II) R128(0): Clock range:  12.50 to 250.00 MHz
(II) R128(0): Not using default mode "1600x1200" (hsync out of range)
(II) R128(0): Not using default mode "1792x1344" (bad mode 
clock/interlace/doublescan)
(II) R128(0): Not using default mode "1856x1392" (bad mode 
clock/interlace/doublescan)
(II) R128(0): Not using default mode "1920x1440" (bad mode 
clock/interlace/doublescan)
(--) R128(0): Virtual size is 1024x768 (pitch 1024)
(**) R128(0): Default mode "1024x768": 94.5 MHz, 68.7 kHz, 85.0 Hz
(II) R128(0): Modeline "1024x768"   94.50  1024 1072 1168 1376  768 769 772 
808 +hsync +vsync
(**) R128(0): Default mode "800x600": 56.3 MHz, 53.7 kHz, 85.1 Hz
(II) R128(0): Modeline "800x600"   56.30  800 832 896 1048  600 601 604 631 
+hsync +vsync
(**) R128(0): Default mode "640x480": 36.0 MHz, 43.3 kHz, 85.0 Hz
(II) R128(0): Modeline "640x480"   36.00  640 696 752 832  480 481 484 509 
-hsync -vsync
(++) R128(0): DPI set to (100, 100)
(II) Loading sub module "fb"
(II) LoadModule: "fb"
(II) Loading /usr/X11R6/lib/modules/libfb.a
(II) Module fb: vendor="The XFree86 Project"
	compiled for 4.1.0.1, module version = 1.0.0
	ABI class: XFree86 ANSI C Emulation, version 0.1
(II) Loading sub module "ramdac"
(II) LoadModule: "ramdac"
(II) Loading /usr/X11R6/lib/modules/libramdac.a
(II) Module ramdac: vendor="The XFree86 Project"
	compiled for 4.1.0.1, module version = 0.1.0
	ABI class: XFree86 Video Driver, version 0.4
(II) Loading sub module "xaa"
(II) LoadModule: "xaa"
(II) Loading /usr/X11R6/lib/modules/libxaa.a
(II) Module xaa: vendor="The XFree86 Project"
	compiled for 4.1.0.1, module version = 1.0.0
	ABI class: XFree86 Video Driver, version 0.4
(II) do I need RAC?  No, I don't.
(II) resource ranges after preInit:
	[0] 0 0	0xdb800000 - 0xdb803fff (0x4000) MS[B]
	[1] 0 0	0xe4000000 - 0xe7ffffff (0x4000000) MS[B]
	[2] -1 0	0xffe00000 - 0xffffffff (0x200000) MX[B](B)
	[3] -1 0	0x00100000 - 0x3fffffff (0x3ff00000) MX[B]E(B)
	[4] -1 0	0x000f0000 - 0x000fffff (0x10000) MX[B]
	[5] -1 0	0x000c0000 - 0x000effff (0x30000) MX[B]
	[6] -1 0	0x00000000 - 0x0009ffff (0xa0000) MX[B]
	[7] -1 0	0xda000000 - 0xda0fffff (0x100000) MX[B]
	[8] -1 0	0xda800000 - 0xda800fff (0x1000) MX[B]
	[9] -1 0	0xdc000000 - 0xdfffffff (0x4000000) MX[B]
	[10] -1 0	0xe3fe0000 - 0xe3ffffff (0x20000) MX[B](B)
	[11] -1 0	0xdb800000 - 0xdb803fff (0x4000) MX[B](B)
	[12] -1 0	0xe4000000 - 0xe7ffffff (0x4000000) MX[B](B)
	[13] 0 0	0x000a0000 - 0x000affff (0x10000) MS[B]
	[14] 0 0	0x000b0000 - 0x000b7fff (0x8000) MS[B]
	[15] 0 0	0x000b8000 - 0x000bffff (0x8000) MS[B]
	[16] 0 0	0x0000d800 - 0x0000d8ff (0x100) IS[B]
	[17] -1 0	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[18] -1 0	0x00000000 - 0x000000ff (0x100) IX[B]
	[19] -1 0	0x0000b400 - 0x0000b40f (0x10) IX[B]
	[20] -1 0	0x0000b800 - 0x0000b81f (0x20) IX[B]
	[21] -1 0	0x0000d800 - 0x0000d8ff (0x100) IX[B](B)
	[22] 0 0	0x000003b0 - 0x000003bb (0xc) IS[B]
	[23] 0 0	0x000003c0 - 0x000003df (0x20) IS[B]
(==) R128(0): Write-combining range (0xe4000000,0x1000000)
(II) R128(0): [drm] created "r128" driver at busid "PCI:1:0:0"
(II) R128(0): [drm] added 4096 byte SAREA at 0xcc8c0000
(II) R128(0): [drm] mapped SAREA 0xcc8c0000 to 0x40016000
(II) R128(0): [drm] framebuffer handle = 0xe4000000
(II) R128(0): [drm] added 1 reserved context for kernel
(II) R128(0): [agp] Mode 0x1c000201 [AGP 0x10b9/0x1541; Card 0x1002/0x5246]
(II) R128(0): [agp] 8192 kB allocated with handle 0xcd8e7000
(II) R128(0): [agp] ring handle = 0xdc000000
(II) R128(0): [agp] Ring mapped at 0x4121c000
(II) R128(0): [agp] ring read ptr handle = 0xdc101000
(II) R128(0): [agp] Ring read ptr mapped at 0x40017000
(II) R128(0): [agp] vertex/indirect buffers handle = 0xdc102000
(II) R128(0): [agp] Vertex/indirect buffers mapped at 0x4131d000
(II) R128(0): [agp] AGP texture map handle = 0xdc302000
(II) R128(0): [agp] AGP Texture map mapped at 0x4151d000
(II) R128(0): [drm] register handle = 0xdb800000
(II) R128(0): [dri] Visual configs initialized
(II) R128(0): CCE in BM mode
(II) R128(0): Using 8 MB AGP aperture
(II) R128(0): Using 1 MB for the ring buffer
(II) R128(0): Using 2 MB for vertex/indirect buffers
(II) R128(0): Using 5 MB for AGP textures
(II) R128(0): Memory manager initialized to (0,0) (1024,3840)
(II) R128(0): Reserved area from (0,768) to (1024,770)
(II) R128(0): Largest offscreen area available: 1024 x 3070
(II) R128(0): Reserved back buffer from (0,770) to (1024,1538)
(II) R128(0): Reserved depth buffer from (0,1538) to (1024,2307)
(II) R128(0): Reserved depth span from (0,2306) offset 0x481000
(II) R128(0): Reserved 8704 kb for textures at offset 0x780000
(==) R128(0): Backing store disabled
(==) R128(0): Silken mouse enabled
(II) R128(0): Using XFree86 Acceleration Architecture (XAA)
	Screen to screen bit blits
	Solid filled rectangles
	8x8 mono pattern filled rectangles
	Indirect CPU to Screen color expansion
	Solid Lines
	Dashed Lines
	Scanline Image Writes
	Offscreen Pixmaps
	Setting up tile and stipple cache:
		32 128x128 slots
		14 256x256 slots
(II) R128(0): Acceleration enabled
(II) R128(0): Using hardware cursor (scanline 4614)
(II) R128(0): Largest offscreen area available: 1024 x 1531
(**) Option "dpms"
(**) R128(0): DPMS enabled
(II) R128(0): Dotclock is 94.5 Mhz, setting ecp_div to 0
(II) R128(0): 0x55 0xaa
(II) R128(0): VIDEO BIOS TABLE OFFSETS: bios_header=0x0110 mm_table=0x01ba
(II) R128(0): MM_TABLE: 01-0c-05-11-05-00-00-23-00-01-03-02-00-00
(II) Loading sub module "i2c"
(II) LoadModule: "i2c"
(II) Reloading /usr/X11R6/lib/modules/libi2c.a
(II) R128(0): I2C bus "Rage 128 multimedia bus" initialized.
(II) R128(0): *** 0x8682bbc versus 0x8682bbc
(II) Loading sub module "fi1236"
(II) LoadModule: "fi1236"
(II) Loading /usr/X11R6/lib/modules/multimedia/fi1236_drv.o
(II) Module fi1236: vendor="The XFree86 Project"
	compiled for 4.1.0.1, module version = 1.0.0
	ABI class: XFree86 Video Driver, version 0.4
(II) R128(0): I2C device "Rage 128 multimedia bus:FI12xx Tuner" registered.
(II) R128(0): Detected FI1216MF device at 0xc6
(II) Loading sub module "bt829"
(II) LoadModule: "bt829"
(II) Loading /usr/X11R6/lib/modules/multimedia/bt829_drv.o
(II) Module bt829: vendor="The XFree86 Project"
	compiled for 4.1.0.1, module version = 1.0.0
	ABI class: XFree86 Video Driver, version 0.4
(II) R128(0): I2C device "Rage 128 multimedia bus:bt829a/b video decoder, 
revision 8" registered.
(II) Loading sub module "msp3430"
(II) LoadModule: "msp3430"
(II) Loading /usr/X11R6/lib/modules/multimedia/msp3430_drv.o
(II) Module msp3430: vendor="The XFree86 Project"
	compiled for 4.1.0.1, module version = 1.0.0
	ABI class: XFree86 Video Driver, version 0.4
(II) Loading sub module "tda9850"
(II) LoadModule: "tda9850"
(II) Loading /usr/X11R6/lib/modules/multimedia/tda9850_drv.o
(II) Module tda9850: vendor="The XFree86 Project"
	compiled for 4.1.0.1, module version = 1.0.0
	ABI class: XFree86 Video Driver, version 0.4
(II) Loading sub module "tda8425"
(II) LoadModule: "tda8425"
(II) Loading /usr/X11R6/lib/modules/multimedia/tda8425_drv.o
(II) Module tda8425: vendor="The XFree86 Project"
	compiled for 4.1.0.1, module version = 1.0.0
	ABI class: XFree86 Video Driver, version 0.4
(II) R128(0): X context handle = 0x00000001
(II) R128(0): [drm] installed DRM signal handler
(II) R128(0): [DRI] installation complete
(II) R128(0): [drm] Added 128 16384 byte vertex/indirect buffers
(II) R128(0): [drm] Mapped 128 vertex/indirect buffers
(II) R128(0): Direct rendering enabled
(II) Setting vga for screen 0.
(II) Initializing built-in extension MIT-SHM
(II) Initializing built-in extension XInputExtension
(II) Initializing built-in extension XTEST
(II) Initializing built-in extension XKEYBOARD
(II) Initializing built-in extension LBX
(II) Initializing built-in extension XC-APPGROUP
(II) Initializing built-in extension SECURITY
(II) Initializing built-in extension XINERAMA
(II) Initializing built-in extension XFree86-Bigfont
(II) Initializing built-in extension RENDER
(II) Keyboard "Default Keyboard" handled by legacy driver
(**) Option "Protocol" "PS/2"
(**) Default Mouse: Protocol: "PS/2"
(**) Default Mouse: Core Pointer
(**) Option "Device" "/dev/misc/psaux"
(==) Default Mouse: Buttons: 3
(II) XINPUT: Adding extended input device "Default Mouse" (type: MOUSE)
(II) R128(0): StopVideo 
(II) R128(0): StopVideo 
(II) R128(0): StopVideo cleanup
(II) R128(0): StopVideo 
(II) R128(0): StopVideo cleanup
(II) R128(0): StopVideo 
(II) R128(0): StopVideo cleanup
