Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262796AbTIAK1J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 06:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262804AbTIAK1I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 06:27:08 -0400
Received: from k-kdom.nishanet.com ([65.125.12.2]:49165 "EHLO
	mail2k.k-kdom.nishanet.com") by vger.kernel.org with ESMTP
	id S262796AbTIAK0L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 06:26:11 -0400
Message-ID: <3F531BEF.6020905@boxho.com>
Date: Mon, 01 Sep 2003 06:14:07 -0400
From: Resident Boxholder <resid@boxho.com>
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: undisclosed-recipients:;
Subject: Re: IDE PCI cards IOAPIC "spurious 8259a" irq15(SMBus nforce2)
References: <3F4EA30C.CEA49F2F@vtc.edu.hk>	 <1062150643.26753.4.camel@dhcp23.swansea.linux.org.uk>	 <3F4F5C9A.5BAA1542@vtc.edu.hk> <200308311443.55543.hpj@urpla.net>	 <3F5287BC.48A1BCE6@vtc.edu.hk>  <3F52E0B3.2090001@boxho.com> <1062402710.13083.2.camel@dhcp23.swansea.linux.org.uk>
In-Reply-To: <1062402710.13083.2.camel@dhcp23.swansea.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

MSI K7N2-Delta(mcp-t) nforce2 mboard

Alan Cox wrote:

>some nforce boards that have problems with SI3112 at least
>
> See the nForce & SI680 notes on the silicon image website

Thanks, didn't see anything there about nforce.
IOAPIC is involved in these crashes.

CONFIG_X86_UP_APIC=y
# CONFIG_X86_UP_IOAPIC is not set        <---most important!!
CONFIG_X86_LOCAL_APIC=y

Just now I got reasonably stable by kernel config with IOAPIC not set
and using a siig SiI680 card. Just before that the two promise cards were
crashing incessantly with message
 "spurious 8259a interrupt on irq15" which is SMBus(IOAPIC?)
preceding actions that involved files or disks, fsck or copies or compiles

I took promise cards out(no kern compile possible with promise in!), put 
more
stable siimage.c siig SiI680 card back in and unset the IOAPIC kernel option
and as always hdparm the unmask to off for CMD6?0 SiI680 as documented
siimage.h siimage.c

hdparm -d1 -c1 -u0 -p9 -X70 [the sii dev]

I had tried taking the amd74xx code out and running only promise or only 
sii680
but those didn't work. However the promise-only setup revealed the IOAPIC
clash, though to take advantage of it I had to put sii680 back in and it 
co-exists
with mbo nforce amd74xx for two of the four drives(two on siig). Along 
the way
I observed improvement by turning off usb, onboard eth, onboard audio, 
serial,
parallel, onboard sata(haven't tried). Maybe with the new usb code and this
IOAPIC off setup I can get usb and audio and ethernet to work. I have the
nvidia code for 2.6.0-test6 from http://www.minion.de/nvidia.html but
havent gotten X installed yet.  Linux 2.6 (2.6.0-test4) updated 08/23/2003

-Bob D

#
# Automatically generated make config: don't edit
#
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
# CONFIG_BROKEN is not set

#
# General setup
#
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT=14
# CONFIG_IKCONFIG is not set
CONFIG_EMBEDDED=y
CONFIG_KALLSYMS=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y

#
# Processor type and features
#
CONFIG_X86_PC=y
# CONFIG_X86_VOYAGER is not set
# CONFIG_X86_NUMAQ is not set
# CONFIG_X86_SUMMIT is not set
# CONFIG_X86_BIGSMP is not set
# CONFIG_X86_VISWS is not set
# CONFIG_X86_GENERICARCH is not set
# CONFIG_X86_ES7000 is not set
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
CONFIG_MK7=y
# CONFIG_MK8 is not set
# CONFIG_MELAN is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_USE_3DNOW=y
CONFIG_HUGETLB_PAGE=y
# CONFIG_SMP is not set
CONFIG_PREEMPT=y
CONFIG_X86_UP_APIC=y
# CONFIG_X86_UP_IOAPIC is not set
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
CONFIG_X86_MCE_P4THERMAL=y
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_EDD=y
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=y
# CONFIG_HIGHMEM64G is not set
CONFIG_HIGHMEM=y
CONFIG_HIGHPTE=y
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
CONFIG_HAVE_DEC_LOCK=y

#
# Power management options (ACPI, APM)
#
CONFIG_PM=y
# CONFIG_SOFTWARE_SUSPEND is not set

#
# ACPI (Advanced Configuration and Power Interface) Support
#
CONFIG_ACPI_HT=y
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
# CONFIG_ACPI_SLEEP is not set
# CONFIG_ACPI_AC is not set
# CONFIG_ACPI_BATTERY is not set
CONFIG_ACPI_BUTTON=y
# CONFIG_ACPI_FAN is not set
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_TOSHIBA is not set
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_BUS=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y

#
# APM (Advanced Power Management) BIOS Support
#
# CONFIG_APM is not set

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
# CONFIG_PCI_LEGACY_PROC is not set
CONFIG_PCI_NAMES=y
# CONFIG_ISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set
# CONFIG_HOTPLUG is not set

#
# Executable file formats
#
CONFIG_KCORE_ELF=y
# CONFIG_KCORE_AOUT is not set
CONFIG_BINFMT_ELF=y
# CONFIG_BINFMT_AOUT is not set
CONFIG_BINFMT_MISC=y

#
# Generic Driver Options
#

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
# CONFIG_PARPORT is not set

#
# Plug and Play support
#
CONFIG_PNP=y
CONFIG_PNP_DEBUG=y

#
# Protocols
#
# CONFIG_ISAPNP is not set
CONFIG_PNPBIOS=y

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_CRYPTOLOOP=y
CONFIG_BLK_DEV_NBD=y
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=0
CONFIG_BLK_DEV_INITRD=y
# CONFIG_LBD is not set

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
# CONFIG_IDEDISK_STROKE is not set
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
CONFIG_BLK_DEV_IDESCSI=y
# CONFIG_IDE_TASK_IOCTL is not set
# CONFIG_IDE_TASKFILE_IO is not set

#
# IDE chipset support/bugfixes
#
# CONFIG_BLK_DEV_CMD640 is not set
CONFIG_BLK_DEV_IDEPNP=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_BLK_DEV_GENERIC=y
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDE_TCQ is not set
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
# CONFIG_IDEDMA_PCI_WIP is not set
CONFIG_BLK_DEV_ADMA=y
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
CONFIG_BLK_DEV_AMD74XX=y
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_SC1200 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
CONFIG_BLK_DEV_PDC202XX_NEW=y
CONFIG_PDC202XX_FORCE=y
# CONFIG_BLK_DEV_SVWKS is not set
CONFIG_BLK_DEV_SIIMAGE=y
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_DMA_NONPCI is not set
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
CONFIG_SCSI=y

#
# SCSI support type (disk, tape, CD-ROM)
#
# CONFIG_BLK_DEV_SD is not set
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
# CONFIG_BLK_DEV_SR is not set
CONFIG_CHR_DEV_SG=y

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_REPORT_LUNS=y
CONFIG_SCSI_CONSTANTS=y
# CONFIG_SCSI_LOGGING is not set

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_MEGARAID is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_CPQFCTS is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_SYM53C8XX is not set
# CONFIG_SCSI_PCI2000 is not set
# CONFIG_SCSI_PCI2220I is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set

#
# Multi-device support (RAID and LVM)
#
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
# CONFIG_MD_LINEAR is not set
CONFIG_MD_RAID0=y
# CONFIG_MD_RAID1 is not set
# CONFIG_MD_RAID5 is not set
# CONFIG_MD_MULTIPATH is not set
# CONFIG_BLK_DEV_DM is not set

#
# Fusion MPT device support
#

#
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set

#
# Networking support
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_NETLINK_DEV=y
CONFIG_UNIX=y
# CONFIG_NET_KEY is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_FWMARK=y
CONFIG_IP_ROUTE_NAT=y
# CONFIG_IP_ROUTE_MULTIPATH is not set
# CONFIG_IP_ROUTE_TOS is not set
CONFIG_IP_ROUTE_VERBOSE=y
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
CONFIG_IP_MROUTE=y
# CONFIG_IP_PIMSM_V1 is not set
# CONFIG_IP_PIMSM_V2 is not set
# CONFIG_ARPD is not set
# CONFIG_INET_ECN is not set
CONFIG_SYN_COOKIES=y
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set

#
# IP: Virtual Server Configuration
#
# CONFIG_IP_VS is not set
# CONFIG_IPV6 is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set

#
# IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=y
CONFIG_IP_NF_FTP=y
# CONFIG_IP_NF_IRC is not set
# CONFIG_IP_NF_TFTP is not set
# CONFIG_IP_NF_AMANDA is not set
CONFIG_IP_NF_QUEUE=y
CONFIG_IP_NF_IPTABLES=y
CONFIG_IP_NF_MATCH_LIMIT=y
# CONFIG_IP_NF_MATCH_MAC is not set
CONFIG_IP_NF_MATCH_PKTTYPE=y
CONFIG_IP_NF_MATCH_MARK=y
CONFIG_IP_NF_MATCH_MULTIPORT=y
# CONFIG_IP_NF_MATCH_TOS is not set
CONFIG_IP_NF_MATCH_RECENT=y
# CONFIG_IP_NF_MATCH_ECN is not set
# CONFIG_IP_NF_MATCH_DSCP is not set
# CONFIG_IP_NF_MATCH_AH_ESP is not set
CONFIG_IP_NF_MATCH_LENGTH=y
CONFIG_IP_NF_MATCH_TTL=y
CONFIG_IP_NF_MATCH_TCPMSS=y
CONFIG_IP_NF_MATCH_HELPER=y
CONFIG_IP_NF_MATCH_STATE=y
CONFIG_IP_NF_MATCH_CONNTRACK=y
CONFIG_IP_NF_MATCH_UNCLEAN=y
# CONFIG_IP_NF_MATCH_OWNER is not set
CONFIG_IP_NF_FILTER=y
CONFIG_IP_NF_TARGET_REJECT=y
# CONFIG_IP_NF_TARGET_MIRROR is not set
CONFIG_IP_NF_NAT=y
CONFIG_IP_NF_NAT_NEEDED=y
# CONFIG_IP_NF_TARGET_MASQUERADE is not set
CONFIG_IP_NF_TARGET_REDIRECT=y
CONFIG_IP_NF_NAT_LOCAL=y
# CONFIG_IP_NF_NAT_SNMP_BASIC is not set
CONFIG_IP_NF_NAT_FTP=y
CONFIG_IP_NF_MANGLE=y
CONFIG_IP_NF_TARGET_TOS=y
# CONFIG_IP_NF_TARGET_ECN is not set
# CONFIG_IP_NF_TARGET_DSCP is not set
CONFIG_IP_NF_TARGET_MARK=y
CONFIG_IP_NF_TARGET_LOG=y
CONFIG_IP_NF_TARGET_ULOG=y
CONFIG_IP_NF_TARGET_TCPMSS=y
# CONFIG_IP_NF_ARPTABLES is not set

#
# SCTP Configuration (EXPERIMENTAL)
#
CONFIG_IPV6_SCTP__=y
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_LLC is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
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
# Network testing
#
# CONFIG_NET_PKTGEN is not set
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
# CONFIG_DUMMY is not set
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
CONFIG_TUN=y
# CONFIG_ETHERTAP is not set
# CONFIG_NET_SB1000 is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
# CONFIG_MII is not set
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_NET_VENDOR_3COM is not set

#
# Tulip family network device support
#
# CONFIG_NET_TULIP is not set
# CONFIG_HP100 is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_AMD8111_ETH is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_B44 is not set
# CONFIG_DGRS is not set
# CONFIG_EEPRO100 is not set
# CONFIG_E100 is not set
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_8139CP is not set
CONFIG_8139TOO=y
# CONFIG_8139TOO_PIO is not set
# CONFIG_8139TOO_TUNE_TWISTER is not set
# CONFIG_8139TOO_8129 is not set
# CONFIG_8139_OLD_RX_RESET is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SIS190 is not set
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set

#
# Ethernet (10000 Mbit)
#
# CONFIG_IXGB is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Token Ring devices (depends on LLC=y)
#
# CONFIG_NET_FC is not set
# CONFIG_RCPCI is not set
# CONFIG_SHAPER is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set

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
# CONFIG_ISDN_BOOL is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

#
# Input I/O drivers
#
# CONFIG_GAMEPORT is not set
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
# CONFIG_SERIO_SERPORT is not set
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PCIPS2 is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_CONSOLE is not set
CONFIG_SERIAL_8250_ACPI=y
CONFIG_SERIAL_8250_EXTENDED=y
# CONFIG_SERIAL_8250_MANY_PORTS is not set
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
# CONFIG_SERIAL_8250_MULTIPORT is not set
# CONFIG_SERIAL_8250_RSA is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=32

#
# I2C support
#
CONFIG_I2C=y
# CONFIG_I2C_ALGOBIT is not set
# CONFIG_I2C_ALGOPCF is not set
CONFIG_I2C_CHARDEV=y

#
# I2C Hardware Sensors Mainboard support
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_I801 is not set
CONFIG_I2C_NFORCE2=y
# CONFIG_I2C_PIIX4 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_VIAPRO is not set

#
# I2C Hardware Sensors Chip support
#
# CONFIG_SENSORS_ADM1021 is not set
# CONFIG_SENSORS_IT87 is not set
# CONFIG_SENSORS_LM75 is not set
# CONFIG_SENSORS_LM85 is not set
# CONFIG_SENSORS_LM78 is not set
# CONFIG_SENSORS_VIA686A is not set
# CONFIG_SENSORS_W83781D is not set
# CONFIG_I2C_SENSOR is not set

#
# Mice
#
# CONFIG_BUSMOUSE is not set
# CONFIG_QIC02_TAPE is not set

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_HW_RANDOM is not set
CONFIG_NVRAM=y
CONFIG_RTC=y
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=y
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_ATI is not set
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_AMD_8151 is not set
# CONFIG_AGP_INTEL is not set
CONFIG_AGP_NVIDIA=y
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_SWORKS is not set
# CONFIG_AGP_VIA is not set
CONFIG_DRM=y
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_GAMMA is not set
# CONFIG_DRM_R128 is not set
# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_MGA is not set
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set
# CONFIG_HANGCHECK_TIMER is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set

#
# File systems
#
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
# CONFIG_EXT2_FS_POSIX_ACL is not set
# CONFIG_EXT2_FS_SECURITY is not set
# CONFIG_EXT3_FS is not set
# CONFIG_JBD is not set
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=y
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
# CONFIG_JFS_FS is not set
# CONFIG_XFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=y

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=y
CONFIG_UDF_FS=y

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_DEVFS_FS=y
CONFIG_DEVFS_MOUNT=y
# CONFIG_DEVFS_DEBUG is not set
# CONFIG_DEVPTS_FS is not set
# CONFIG_TMPFS is not set
# CONFIG_HUGETLBFS is not set
CONFIG_RAMFS=y

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
# CONFIG_NFS_V4 is not set
CONFIG_NFSD=y
CONFIG_NFSD_V3=y
# CONFIG_NFSD_V4 is not set
CONFIG_NFSD_TCP=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=y
CONFIG_SUNRPC=y
# CONFIG_SUNRPC_GSS is not set
# CONFIG_SMB_FS is not set
# CONFIG_CIFS is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_INTERMEZZO_FS is not set
# CONFIG_AFS_FS is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_OSF_PARTITION is not set
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
# CONFIG_MAC_PARTITION is not set
CONFIG_MSDOS_PARTITION=y
# CONFIG_BSD_DISKLABEL is not set
# CONFIG_MINIX_SUBPARTITION is not set
# CONFIG_SOLARIS_X86_PARTITION is not set
# CONFIG_UNIXWARE_DISKLABEL is not set
# CONFIG_LDM_PARTITION is not set
# CONFIG_NEC98_PARTITION is not set
# CONFIG_SGI_PARTITION is not set
# CONFIG_ULTRIX_PARTITION is not set
# CONFIG_SUN_PARTITION is not set
# CONFIG_EFI_PARTITION is not set
CONFIG_NLS=y

#
# Native Language Support
#
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ISO8859_1=y
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_UTF8 is not set

#
# Graphics support
#
CONFIG_FB=y
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
CONFIG_FB_VESA=y
CONFIG_VIDEO_SELECT=y
# CONFIG_FB_HGA is not set
CONFIG_FB_RIVA=y
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_VIRTUAL is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_PCI_CONSOLE=y
CONFIG_FONTS=y
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_FONT_6x11=y
# CONFIG_FONT_PEARL_8x8 is not set
# CONFIG_FONT_ACORN_8x8 is not set
# CONFIG_FONT_MINI_4x6 is not set
# CONFIG_FONT_SUN8x16 is not set
# CONFIG_FONT_SUN12x22 is not set

#
# Logo configuration
#
CONFIG_LOGO=y
CONFIG_LOGO_LINUX_MONO=y
CONFIG_LOGO_LINUX_VGA16=y
CONFIG_LOGO_LINUX_CLUT224=y

#
# Sound
#
CONFIG_SOUND=y

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=y
CONFIG_SND_SEQUENCER=y
# CONFIG_SND_SEQ_DUMMY is not set
# CONFIG_SND_OSSEMUL is not set
CONFIG_SND_RTCTIMER=y
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set

#
# Generic devices
#
# CONFIG_SND_DUMMY is not set
CONFIG_SND_VIRMIDI=y
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_SERIAL_U16550 is not set
CONFIG_SND_MPU401=y

#
# PCI devices
#
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_EMU10K1 is not set
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_YMFPCI is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
CONFIG_SND_INTEL8X0=y
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_VIA82XX is not set
# CONFIG_SND_VX222 is not set

#
# ALSA USB devices
#
# CONFIG_SND_USB_AUDIO is not set

#
# Open Sound System
#
# CONFIG_SOUND_PRIME is not set

#
# USB support
#
CONFIG_USB=y
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
CONFIG_USB_BANDWIDTH=y
# CONFIG_USB_DYNAMIC_MINORS is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_OHCI_HCD=y
# CONFIG_USB_UHCI_HCD is not set

#
# USB Device Class drivers
#
# CONFIG_USB_AUDIO is not set
# CONFIG_USB_BLUETOOTH_TTY is not set
# CONFIG_USB_MIDI is not set
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
CONFIG_USB_STORAGE=y
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_DPCM is not set
# CONFIG_USB_STORAGE_HP8200e is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set

#
# USB Human Interface Devices (HID)
#
CONFIG_USB_HID=y
CONFIG_USB_HIDINPUT=y
# CONFIG_HID_FF is not set
# CONFIG_USB_HIDDEV is not set
# CONFIG_USB_AIPTEK is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_KBTAB is not set
# CONFIG_USB_POWERMATE is not set
# CONFIG_USB_XPAD is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_SCANNER is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USB_HPUSBSCSI is not set

#
# USB Multimedia devices
#
# CONFIG_USB_DABUSB is not set

#
# Video4Linux support is needed for USB Multimedia device support
#

#
# USB Network adaptors
#
# CONFIG_USB_AX8817X is not set
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_USBNET is not set

#
# USB port drivers
#

#
# USB Serial Converter support
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_TIGL is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_BRLVGER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_TEST is not set
# CONFIG_USB_GADGET is not set

#
# Bluetooth support
#
# CONFIG_BT is not set

#
# Profiling support
#
# CONFIG_PROFILING is not set

#
# Kernel hacking
#
# CONFIG_DEBUG_KERNEL is not set
CONFIG_DEBUG_SPINLOCK_SLEEP=y
CONFIG_FRAME_POINTER=y
CONFIG_X86_EXTRA_IRQS=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y

#
# Security options
#
CONFIG_SECURITY=y
CONFIG_SECURITY_NETWORK=y
CONFIG_SECURITY_CAPABILITIES=y
# CONFIG_SECURITY_ROOTPLUG is not set
# CONFIG_SECURITY_SELINUX is not set

#
# Cryptographic options
#
CONFIG_CRYPTO=y
# CONFIG_CRYPTO_HMAC is not set
# CONFIG_CRYPTO_NULL is not set
# CONFIG_CRYPTO_MD4 is not set
# CONFIG_CRYPTO_MD5 is not set
# CONFIG_CRYPTO_SHA1 is not set
# CONFIG_CRYPTO_SHA256 is not set
# CONFIG_CRYPTO_SHA512 is not set
# CONFIG_CRYPTO_DES is not set
# CONFIG_CRYPTO_BLOWFISH is not set
# CONFIG_CRYPTO_TWOFISH is not set
# CONFIG_CRYPTO_SERPENT is not set
# CONFIG_CRYPTO_AES is not set
# CONFIG_CRYPTO_CAST5 is not set
# CONFIG_CRYPTO_CAST6 is not set
# CONFIG_CRYPTO_DEFLATE is not set
# CONFIG_CRYPTO_TEST is not set

#
# Library routines
#
CONFIG_CRC32=y
CONFIG_ZLIB_INFLATE=y
CONFIG_X86_BIOS_REBOOT=y

no obvious error output--

Sep  1 04:40:21 where syslogd 1.4.1#10: restart.
Sep  1 04:40:21 where kernel: klogd 1.4.1#10, log source = /proc/kmsg 
started.
Sep  1 04:40:21 where kernel: Cannot find map file.
Sep  1 04:40:21 where kernel: No module symbols loaded - kernel modules 
not enabled.
Sep  1 04:40:21 where kernel: ck architecture supported.
Sep  1 04:40:21 where kernel: Intel machine check reporting enabled on 
CPU#0.
Sep  1 04:40:21 where kernel: CPU: AMD Athlon(tm) XP 3000+ stepping 00
Sep  1 04:40:21 where kernel: Enabling fast FPU save and restore... done.
Sep  1 04:40:21 where kernel: Enabling unmasked SIMD FPU exception 
support... done.
Sep  1 04:40:21 where kernel: Checking 'hlt' instruction... OK.
Sep  1 04:40:21 where kernel: POSIX conformance testing by UNIFIX
Sep  1 04:40:21 where kernel: enabled ExtINT on CPU#0
Sep  1 04:40:21 where kernel: ESR value before enabling vector: 00000000
Sep  1 04:40:21 where kernel: ESR value after enabling vector: 00000000
Sep  1 04:40:21 where kernel: Using local APIC timer interrupts.
Sep  1 04:40:21 where kernel: calibrating APIC timer ...
Sep  1 04:40:21 where kernel: ..... CPU clock speed is 2171.0277 MHz.
Sep  1 04:40:21 where kernel: ..... host bus clock speed is 334.0042 MHz.
Sep  1 04:40:21 where kernel: Initializing RT netlink socket
Sep  1 04:40:21 where kernel: PCI: PCI BIOS revision 2.10 entry at 
0xfb9a0, last bus=3
Sep  1 04:40:21 where kernel: PCI: Using configuration type 1
Sep  1 04:40:21 where kernel: mtrr: v2.0 (20020519)
Sep  1 04:40:21 where kernel: BIO: pool of 256 setup, 14Kb (56 bytes/bio)
Sep  1 04:40:21 where kernel: biovec pool[0]:   1 bvecs: 256 entries (12 
bytes)
Sep  1 04:40:21 where kernel: biovec pool[1]:   4 bvecs: 256 entries (48 
bytes)
Sep  1 04:40:21 where kernel: biovec pool[2]:  16 bvecs: 256 entries 
(192 bytes)
Sep  1 04:40:21 where kernel: biovec pool[3]:  64 bvecs: 256 entries 
(768 bytes)
Sep  1 04:40:21 where kernel: biovec pool[4]: 128 bvecs: 256 entries 
(1536 bytes)
Sep  1 04:40:21 where kernel: biovec pool[5]: 256 bvecs: 256 entries 
(3072 bytes)
Sep  1 04:40:21 where kernel: ACPI: Subsystem revision 20030813
Sep  1 04:40:21 where kernel: spurious 8259A interrupt: IRQ7.
Sep  1 04:40:21 where kernel: ACPI: Interpreter enabled
Sep  1 04:40:21 where kernel: ACPI: Using PIC for interrupt routing
Sep  1 04:40:21 where kernel: ACPI: PCI Root Bridge [PCI0] (00:00)
Sep  1 04:40:21 where kernel: PCI: Probing PCI hardware (bus 00)
Sep  1 04:40:21 where kernel: ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 
5 6 7 *10 11 12 14 15)
Sep  1 04:40:21 where kernel: ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 
5 6 7 10 11 12 14 15, disabled)
Sep  1 04:40:21 where kernel: ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 
5 6 7 10 *11 12 14 15)
Sep  1 04:40:21 where kernel: ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 
*5 6 7 10 11 12 14 15)
Sep  1 04:40:21 where kernel: ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 
5 6 7 10 11 12 14 15, disabled)
Sep  1 04:40:21 where kernel: ACPI: PCI Interrupt Link [LUBA] (IRQs 3 4 
5 6 7 10 *11 12 14 15)
Sep  1 04:40:21 where kernel: ACPI: PCI Interrupt Link [LUBB] (IRQs 3 *4 
5 6 7 10 11 12 14 15)
Sep  1 04:40:21 where kernel: ACPI: PCI Interrupt Link [LMAC] (IRQs 3 4 
5 6 7 10 11 12 14 15, disabled)
Sep  1 04:40:21 where kernel: ACPI: PCI Interrupt Link [LAPU] (IRQs 3 4 
5 6 7 10 11 12 14 15, disabled)
Sep  1 04:40:21 where kernel: ACPI: PCI Interrupt Link [LACI] (IRQs 3 4 
5 6 7 10 11 12 14 15, disabled)
Sep  1 04:40:21 where kernel: ACPI: PCI Interrupt Link [LMCI] (IRQs 3 4 
5 6 7 10 11 12 14 15, disabled)
Sep  1 04:40:21 where kernel: ACPI: PCI Interrupt Link [LSMB] (IRQs 3 4 
5 6 7 *10 11 12 14 15)
Sep  1 04:40:21 where kernel: ACPI: PCI Interrupt Link [LUB2] (IRQs 3 4 
5 6 *7 10 11 12 14 15)
Sep  1 04:40:21 where kernel: ACPI: PCI Interrupt Link [LFIR] (IRQs 3 4 
5 6 7 10 11 12 14 15, disabled)
Sep  1 04:40:21 where kernel: ACPI: PCI Interrupt Link [L3CM] (IRQs 3 4 
5 6 7 10 11 12 14 15, disabled)
Sep  1 04:40:21 where kernel: ACPI: PCI Interrupt Link [LIDE] (IRQs 3 4 
5 6 7 10 11 12 14 15, disabled)
Sep  1 04:40:21 where kernel: ACPI: PCI Interrupt Link [APC1] (IRQs *16)
Sep  1 04:40:21 where kernel: ACPI: PCI Interrupt Link [APC2] (IRQs 17, 
disabled)
Sep  1 04:40:21 where kernel: ACPI: PCI Interrupt Link [APC3] (IRQs *18)
Sep  1 04:40:21 where kernel: ACPI: PCI Interrupt Link [APC4] (IRQs *19)
Sep  1 04:40:21 where kernel: ACPI: PCI Interrupt Link [APC5] (IRQs 16, 
disabled)
Sep  1 04:40:21 where kernel: ACPI: PCI Interrupt Link [APCF] (IRQs 20 
21 22, disabled)
Sep  1 04:40:21 where kernel: ACPI: PCI Interrupt Link [APCG] (IRQs 20 
21 22, disabled)
Sep  1 04:40:21 where kernel: ACPI: PCI Interrupt Link [APCH] (IRQs 20 
21 22, disabled)
Sep  1 04:40:21 where kernel: ACPI: PCI Interrupt Link [APCI] (IRQs 20 
21 22, disabled)
Sep  1 04:40:21 where kernel: ACPI: PCI Interrupt Link [APCJ] (IRQs 20 
21 22, disabled)
Sep  1 04:40:21 where kernel: ACPI: PCI Interrupt Link [APCK] (IRQs 20 
21 22, disabled)
Sep  1 04:40:21 where kernel: ACPI: PCI Interrupt Link [APCS] (IRQs *23)
Sep  1 04:40:21 where kernel: ACPI: PCI Interrupt Link [APCL] (IRQs 20 
21 22, disabled)
Sep  1 04:40:21 where kernel: ACPI: PCI Interrupt Link [APCM] (IRQs 20 
21 22, disabled)
Sep  1 04:40:21 where kernel: ACPI: PCI Interrupt Link [AP3C] (IRQs 20 
21 22, disabled)
Sep  1 04:40:21 where kernel: ACPI: PCI Interrupt Link [APCZ] (IRQs 20 
21 22, disabled)
Sep  1 04:40:21 where kernel: Linux Plug and Play Support v0.97 (c) Adam 
Belay
Sep  1 04:40:21 where kernel: PnPBIOS: Scanning system for PnP BIOS 
support...
Sep  1 04:40:21 where kernel: PnPBIOS: Found PnP BIOS installation 
structure at 0xc00fc450
Sep  1 04:40:21 where kernel: PnPBIOS: PnP BIOS version 1.0, entry 
0xf0000:0xc480, dseg 0xf0000
Sep  1 04:40:21 where kernel: PnPBIOS: 13 nodes reported by PnP BIOS; 13 
recorded by driver
Sep  1 04:40:21 where kernel: SCSI subsystem initialized
Sep  1 04:40:21 where kernel: drivers/usb/core/usb.c: registered new 
driver usbfs
Sep  1 04:40:21 where kernel: drivers/usb/core/usb.c: registered new 
driver hub
Sep  1 04:40:21 where kernel: ACPI: PCI Interrupt Link [LSMB] enabled at 
IRQ 5
Sep  1 04:40:21 where kernel: ACPI: PCI Interrupt Link [LNK1] enabled at 
IRQ 10
Sep  1 04:40:21 where kernel: ACPI: PCI Interrupt Link [LNK3] enabled at 
IRQ 11
Sep  1 04:40:21 where kernel: ACPI: PCI Interrupt Link [LNK4] enabled at 
IRQ 5
Sep  1 04:40:21 where kernel: PCI: Using ACPI for IRQ routing
Sep  1 04:40:21 where kernel: PCI: if you experience problems, try using 
option 'pci=noacpi' or even 'acpi=off'
Sep  1 04:40:21 where kernel: pty: 256 Unix98 ptys configured
Sep  1 04:40:21 where kernel: Machine check exception polling timer started.
Sep  1 04:40:21 where kernel: Total HugeTLB memory allocated, 0
Sep  1 04:40:21 where kernel: highmem bounce pool size: 64 pages
Sep  1 04:40:21 where kernel: devfs: v1.22 (20021013) Richard Gooch 
(rgooch@atnf.csiro.au)
Sep  1 04:40:21 where kernel: devfs: boot_options: 0x1
Sep  1 04:40:21 where kernel: Installing knfsd (copyright (C) 1996 
okir@monad.swb.de).
Sep  1 04:40:21 where kernel: udf: registering filesystem
Sep  1 04:40:21 where kernel: Initializing Cryptographic API
Sep  1 04:40:21 where kernel: ACPI: Power Button (FF) [PWRF]
Sep  1 04:40:21 where kernel: ACPI: Processor [CPU0] (supports C1)
Sep  1 04:40:21 where kernel: ACPI: Thermal Zone [THRM] (31 C)
Sep  1 04:40:21 where kernel: Real Time Clock Driver v1.11a
Sep  1 04:40:21 where kernel: Non-volatile memory driver v1.2
Sep  1 04:40:21 where kernel: Linux agpgart interface v0.100 (c) Dave Jones
Sep  1 04:40:21 where kernel: agpgart: Detected NVIDIA nForce2 chipset
Sep  1 04:40:21 where kernel: agpgart: Maximum main memory to use for 
agp memory: 941M
Sep  1 04:40:21 where kernel: agpgart: AGP aperture is 64M @ 0xd8000000
Sep  1 04:40:21 where kernel: Serial: 8250/16550 driver $Revision: 1.90 
$ IRQ sharing enabled
Sep  1 04:40:21 where kernel: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Sep  1 04:40:21 where kernel: Using anticipatory scheduling elevator
Sep  1 04:40:21 where kernel: Floppy drive(s): fd0 is 1.44M
Sep  1 04:40:21 where kernel: FDC 0 is a post-1991 82077
Sep  1 04:40:21 where kernel: RAMDISK driver initialized: 16 RAM disks 
of 0K size 1024 blocksize
Sep  1 04:40:21 where kernel: loop: loaded (max 8 devices)
Sep  1 04:40:21 where kernel: nbd: registered device at major 43
Sep  1 04:40:21 where kernel: Universal TUN/TAP device driver 1.5 
(C)1999-2002 Maxim Krasnyansky
Sep  1 04:40:21 where kernel: Uniform Multi-Platform E-IDE driver 
Revision: 7.00alpha2
Sep  1 04:40:21 where kernel: ide: Assuming 33MHz system bus speed for 
PIO modes; override with idebus=xx
Sep  1 04:40:21 where kernel: NFORCE2: IDE controller at PCI slot 
0000:00:09.0
Sep  1 04:40:21 where kernel: NFORCE2: chipset revision 162
Sep  1 04:40:21 where kernel: NFORCE2: not 100%% native mode: will probe 
irqs later
Sep  1 04:40:21 where kernel: AMD_IDE: Bios didn't set cable bits 
correctly. Enabling workaround.
Sep  1 04:40:21 where kernel: AMD_IDE: Bios didn't set cable bits 
correctly. Enabling workaround.
Sep  1 04:40:21 where kernel: ide: Assuming 33MHz system bus speed for 
PIO modes; override with idebus=xx
Sep  1 04:40:21 where kernel: AMD_IDE: 0000:00:09.0 (rev a2) UDMA100 
controller on pci0000:00:09.0
Sep  1 04:40:21 where kernel:     ide0: BM-DMA at 0xf000-0xf007, BIOS 
settings: hda:DMA, hdb:DMA
Sep  1 04:40:21 where kernel:     ide1: BM-DMA at 0xf008-0xf00f, BIOS 
settings: hdc:DMA, hdd:DMA
Sep  1 04:40:21 where kernel: hda: Maxtor 6Y060P0, ATA DISK drive
Sep  1 04:40:21 where kernel: hda: IRQ probe failed (0xfcba)
Sep  1 04:40:21 where kernel: hdb: IRQ probe failed (0xfcba)
Sep  1 04:40:21 where kernel: hdb: IRQ probe failed (0xfcba)
Sep  1 04:40:21 where kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Sep  1 04:40:21 where kernel: hdc: Maxtor 6Y060P0, ATA DISK drive
Sep  1 04:40:21 where kernel: ide1 at 0x170-0x177,0x376 on irq 15
Sep  1 04:40:21 where kernel: SiI680: IDE controller at PCI slot 
0000:01:07.0
Sep  1 04:40:21 where kernel: SiI680: chipset revision 2
Sep  1 04:40:21 where kernel: SiI680: BASE CLOCK == 133
Sep  1 04:40:21 where kernel: SiI680: 100%% native mode on irq 10
Sep  1 04:40:21 where kernel:     ide2: MMIO-DMA at 
0xf884d000-0xf884d007, BIOS settings: hde:pio, hdf:pio
Sep  1 04:40:21 where kernel:     ide3: MMIO-DMA at 
0xf884d008-0xf884d00f, BIOS settings: hdg:pio, hdh:pio
Sep  1 04:40:21 where kernel: hde: Maxtor 6Y060P0, ATA DISK drive
Sep  1 04:40:21 where kernel: ide2 at 0xf884d080-0xf884d087,0xf884d08a 
on irq 10
Sep  1 04:40:21 where kernel: hdg: Maxtor 6Y060P0, ATA DISK drive
Sep  1 04:40:21 where kernel: ide3 at 0xf884d0c0-0xf884d0c7,0xf884d0ca 
on irq 10
Sep  1 04:40:21 where kernel: hda: max request size: 128KiB
Sep  1 04:40:21 where kernel: hda: 120103200 sectors (61492 MB) 
w/7936KiB Cache, CHS=65535/16/63, UDMA(100)
Sep  1 04:40:21 where kernel:  /dev/ide/host0/bus0/target0/lun0: p1 p2 
p3 p4 < p5 p6 p7 >
Sep  1 04:40:21 where kernel: hdc: max request size: 128KiB
Sep  1 04:40:21 where kernel: hdc: 120103200 sectors (61492 MB) 
w/7936KiB Cache, CHS=65535/16/63, UDMA(100)
Sep  1 04:40:21 where kernel:  /dev/ide/host0/bus1/target0/lun0: p1 p2 
p3 p4 < p5 p6 p7 >
Sep  1 04:40:21 where kernel: hde: max request size: 64KiB
Sep  1 04:40:21 where kernel: hde: 120103200 sectors (61492 MB) 
w/7936KiB Cache, CHS=65535/16/63, UDMA(133)
Sep  1 04:40:21 where kernel:  /dev/ide/host2/bus0/target0/lun0: p1 p2 
p3 p4 < p5 p6 p7 >
Sep  1 04:40:21 where kernel: hdg: max request size: 64KiB
Sep  1 04:40:21 where kernel: hdg: 120103200 sectors (61492 MB) 
w/7936KiB Cache, CHS=65535/16/63, UDMA(133)
Sep  1 04:40:21 where kernel:  /dev/ide/host2/bus1/target0/lun0: p1 p2 
p3 p4 < p5 p6 p7 >
Sep  1 04:40:21 where kernel: Initializing USB Mass Storage driver...
Sep  1 04:40:21 where kernel: drivers/usb/core/usb.c: registered new 
driver usb-storage
Sep  1 04:40:21 where kernel: USB Mass Storage support registered.
Sep  1 04:40:21 where kernel: drivers/usb/core/usb.c: registered new 
driver hid
Sep  1 04:40:21 where kernel: drivers/usb/input/hid-core.c: v2.0:USB HID 
core driver
Sep  1 04:40:21 where kernel: mice: PS/2 mouse device common for all mice
Sep  1 04:40:21 where kernel: input: ImExPS/2 Logitech Explorer Mouse on 
isa0060/serio1
Sep  1 04:40:21 where kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Sep  1 04:40:21 where kernel: input: AT Set 2 keyboard on isa0060/serio0
Sep  1 04:40:21 where kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Sep  1 04:40:21 where kernel: i2c /dev entries driver module version 
2.7.0 (20021208)
Sep  1 04:40:21 where kernel: i2c_adapter i2c-0: nForce2 SMBus adapter 
at 0x5000
Sep  1 04:40:21 where kernel: i2c_adapter i2c-1: nForce2 SMBus adapter 
at 0x5040
Sep  1 04:40:21 where kernel: md: raid0 personality registered as nr 2
Sep  1 04:40:21 where kernel: md: md driver 0.90.0 MAX_MD_DEVS=256, 
MD_SB_DISKS=27
Sep  1 04:40:21 where kernel: Advanced Linux Sound Architecture Driver 
Version 0.9.6 (Wed Aug 20 20:27:13 2003 UTC).
Sep  1 04:40:21 where kernel: specify port
Sep  1 04:40:21 where kernel: ALSA device list:
Sep  1 04:40:21 where kernel:   #0: Virtual MIDI Card 1
Sep  1 04:40:21 where kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Sep  1 04:40:21 where kernel: IP: routing cache hash table of 8192 
buckets, 64Kbytes
Sep  1 04:40:21 where kernel: TCP: Hash tables configured (established 
262144 bind 65536)
Sep  1 04:40:21 where kernel: Linux IP multicast router 0.06 plus PIM-SM
Sep  1 04:40:21 where kernel: ip_conntrack version 2.1 (8191 buckets, 
65528 max) - 296 bytes per conntrack
Sep  1 04:40:21 where kernel: ip_tables: (C) 2000-2002 Netfilter core team
Sep  1 04:40:21 where kernel: ipt_recent v0.3.1: Stephen Frost 
<sfrost@snowman.net>.  http://snowman.net/projects/ipt_recent/
Sep  1 04:40:21 where kernel: NET4: Unix domain sockets 1.0/SMP for 
Linux NET4.0.
Sep  1 04:40:21 where kernel: BIOS EDD facility v0.09 2003-Jan-22, 4 
devices found
Sep  1 04:40:21 where kernel: md: Autodetecting RAID arrays.
Sep  1 04:40:21 where kernel: md: autorun ...
Sep  1 04:40:21 where kernel: md: ... autorun DONE.
Sep  1 04:40:21 where kernel: found reiserfs format "3.6" with standard 
journal
Sep  1 04:40:21 where kernel: Reiserfs journal params: device hdc1, size 
8192, journal first block 18, max trans len 1024, max batch 900, max 
commit age 30, max trans age 30
Sep  1 04:40:21 where kernel: reiserfs: checking transaction log (hdc1) 
for (hdc1)
Sep  1 04:40:21 where kernel: Using r5 hash to sort names
Sep  1 04:40:21 where kernel: VFS: Mounted root (reiserfs filesystem).
Sep  1 04:40:21 where kernel: Mounted devfs on /dev
Sep  1 04:40:21 where kernel: Freeing unused kernel memory: 372k freed
Sep  1 04:40:21 where kernel: blk: queue f7c6cc00, I/O limit 4095Mb 
(mask 0xffffffff)
Sep  1 04:40:21 where kernel: blk: queue f7c6c400, I/O limit 4095Mb 
(mask 0xffffffff)
Sep  1 04:40:21 where kernel: Adding 1999864k swap on 
/dev/ide/host0/bus0/target0/lun0/part2.  Priority:-1 extents:1
Sep  1 04:40:21 where kernel: Adding 1999864k swap on 
/dev/ide/host0/bus1/target0/lun0/part2.  Priority:-2 extents:1
Sep  1 04:40:21 where kernel: Adding 1999864k swap on 
/dev/ide/host2/bus0/target0/lun0/part2.  Priority:-3 extents:1
Sep  1 04:40:21 where kernel: Adding 1999864k swap on 
/dev/ide/host2/bus1/target0/lun0/part2.  Priority:-4 extents:1
Sep  1 04:40:21 where kernel: md: md0 stopped.
Sep  1 04:40:21 where kernel: md: bind<hdc3>
Sep  1 04:40:21 where kernel: md: bind<hde3>
Sep  1 04:40:21 where kernel: md: bind<hdg3>
Sep  1 04:40:21 where kernel: md: bind<hda3>
Sep  1 04:40:21 where kernel: md0: setting max_sectors to 128, segment 
boundary to 32767
Sep  1 04:40:21 where kernel: raid0: looking at hda3
Sep  1 04:40:21 where kernel: raid0:   comparing hda3(6000000) with 
hda3(6000000)
Sep  1 04:40:21 where kernel: raid0:   END
Sep  1 04:40:21 where kernel: raid0:   ==> UNIQUE
Sep  1 04:40:21 where kernel: raid0: 1 zones
Sep  1 04:40:21 where kernel: raid0: looking at hdg3
Sep  1 04:40:21 where kernel: raid0:   comparing hdg3(6000000) with 
hda3(6000000)
Sep  1 04:40:21 where kernel: raid0:   EQUAL
Sep  1 04:40:21 where kernel: raid0: looking at hde3
Sep  1 04:40:21 where kernel: raid0:   comparing hde3(6000000) with 
hda3(6000000)
Sep  1 04:40:21 where kernel: raid0:   EQUAL
Sep  1 04:40:21 where kernel: raid0: looking at hdc3
Sep  1 04:40:21 where kernel: raid0:   comparing hdc3(6000000) with 
hda3(6000000)
Sep  1 04:40:21 where kernel: raid0:   EQUAL
Sep  1 04:40:21 where kernel: raid0: FINAL 1 zones
Sep  1 04:40:21 where kernel: raid0: done.
Sep  1 04:40:21 where kernel: raid0 : md_size is 24000000 blocks.
Sep  1 04:40:21 where kernel: raid0 : conf->hash_spacing is 24000000 blocks.
Sep  1 04:40:21 where kernel: raid0 : nb_zone is 1.
Sep  1 04:40:21 where kernel: raid0 : Allocating 4 bytes for hash.
Sep  1 04:40:21 where kernel: md: md1 stopped.
Sep  1 04:40:21 where kernel: md: bind<hdc5>
Sep  1 04:40:21 where kernel: md: bind<hde5>
Sep  1 04:40:21 where kernel: md: bind<hdg5>
Sep  1 04:40:21 where kernel: md: bind<hda5>
Sep  1 04:40:21 where kernel: md1: setting max_sectors to 128, segment 
boundary to 32767
Sep  1 04:40:21 where kernel: raid0: looking at hda5
Sep  1 04:40:21 where kernel: raid0:   comparing hda5(4000128) with 
hda5(4000128)
Sep  1 04:40:21 where kernel: raid0:   END
Sep  1 04:40:21 where kernel: raid0:   ==> UNIQUE
Sep  1 04:40:21 where kernel: raid0: 1 zones
Sep  1 04:40:21 where kernel: raid0: looking at hdg5
Sep  1 04:40:21 where kernel: raid0:   comparing hdg5(4000128) with 
hda5(4000128)
Sep  1 04:40:21 where kernel: raid0:   EQUAL
Sep  1 04:40:21 where kernel: raid0: looking at hde5
Sep  1 04:40:21 where kernel: raid0:   comparing hde5(4000128) with 
hda5(4000128)
Sep  1 04:40:21 where kernel: raid0:   EQUAL
Sep  1 04:40:21 where kernel: raid0: looking at hdc5
Sep  1 04:40:21 where kernel: raid0:   comparing hdc5(4000128) with 
hda5(4000128)
Sep  1 04:40:21 where kernel: raid0:   EQUAL
Sep  1 04:40:21 where kernel: raid0: FINAL 1 zones
Sep  1 04:40:21 where kernel: raid0: done.
Sep  1 04:40:21 where kernel: raid0 : md_size is 16000512 blocks.
Sep  1 04:40:21 where kernel: raid0 : conf->hash_spacing is 16000512 blocks.
Sep  1 04:40:21 where kernel: raid0 : nb_zone is 1.
Sep  1 04:40:21 where kernel: raid0 : Allocating 4 bytes for hash.
Sep  1 04:40:21 where kernel: md: md2 stopped.
Sep  1 04:40:21 where kernel: md: bind<hdc6>
Sep  1 04:40:21 where kernel: md: bind<hde6>
Sep  1 04:40:21 where kernel: md: bind<hdg6>
Sep  1 04:40:21 where kernel: md: bind<hda6>
Sep  1 04:40:21 where kernel: md2: setting max_sectors to 128, segment 
boundary to 32767
Sep  1 04:40:21 where kernel: raid0: looking at hda6
Sep  1 04:40:21 where kernel: raid0:   comparing hda6(1999744) with 
hda6(1999744)
Sep  1 04:40:21 where kernel: raid0:   END
Sep  1 04:40:21 where kernel: raid0:   ==> UNIQUE
Sep  1 04:40:21 where kernel: raid0: 1 zones
Sep  1 04:40:21 where kernel: raid0: looking at hdg6
Sep  1 04:40:21 where kernel: raid0:   comparing hdg6(1999744) with 
hda6(1999744)
Sep  1 04:40:21 where kernel: raid0:   EQUAL
Sep  1 04:40:21 where kernel: raid0: looking at hde6
Sep  1 04:40:21 where kernel: raid0:   comparing hde6(1999744) with 
hda6(1999744)
Sep  1 04:40:21 where kernel: raid0:   EQUAL
Sep  1 04:40:21 where kernel: raid0: looking at hdc6
Sep  1 04:40:21 where kernel: raid0:   comparing hdc6(1999744) with 
hda6(1999744)
Sep  1 04:40:21 where kernel: raid0:   EQUAL
Sep  1 04:40:21 where kernel: raid0: FINAL 1 zones
Sep  1 04:40:21 where kernel: raid0: done.
Sep  1 04:40:21 where kernel: raid0 : md_size is 7998976 blocks.
Sep  1 04:40:21 where kernel: raid0 : conf->hash_spacing is 7998976 blocks.
Sep  1 04:40:21 where kernel: raid0 : nb_zone is 1.
Sep  1 04:40:21 where kernel: raid0 : Allocating 4 bytes for hash.
Sep  1 04:40:21 where kernel: md: md3 stopped.
Sep  1 04:40:21 where kernel: md: bind<hdc7>
Sep  1 04:40:21 where kernel: md: bind<hde7>
Sep  1 04:40:21 where kernel: md: bind<hdg7>
Sep  1 04:40:21 where kernel: md: bind<hda7>
Sep  1 04:40:21 where kernel: md3: setting max_sectors to 128, segment 
boundary to 32767
Sep  1 04:40:21 where kernel: raid0: looking at hda7
Sep  1 04:40:21 where kernel: raid0:   comparing hda7(38051392) with 
hda7(38051392)
Sep  1 04:40:21 where kernel: raid0:   END
Sep  1 04:40:21 where kernel: raid0:   ==> UNIQUE
Sep  1 04:40:21 where kernel: raid0: 1 zones
Sep  1 04:40:21 where kernel: raid0: looking at hdg7
Sep  1 04:40:21 where kernel: raid0:   comparing hdg7(38051392) with 
hda7(38051392)
Sep  1 04:40:21 where kernel: raid0:   EQUAL
Sep  1 04:40:21 where kernel: raid0: looking at hde7
Sep  1 04:40:21 where kernel: raid0:   comparing hde7(38051392) with 
hda7(38051392)
Sep  1 04:40:21 where kernel: raid0:   EQUAL
Sep  1 04:40:21 where kernel: raid0: looking at hdc7
Sep  1 04:40:21 where kernel: raid0:   comparing hdc7(38051392) with 
hda7(38051392)
Sep  1 04:40:21 where kernel: raid0:   EQUAL
Sep  1 04:40:21 where kernel: raid0: FINAL 1 zones
Sep  1 04:40:21 where kernel: raid0: done.
Sep  1 04:40:21 where kernel: raid0 : md_size is 152205568 blocks.
Sep  1 04:40:21 where kernel: raid0 : conf->hash_spacing is 152205568 
blocks.
Sep  1 04:40:21 where kernel: raid0 : nb_zone is 1.
Sep  1 04:40:21 where kernel: raid0 : Allocating 4 bytes for hash.
Sep  1 04:40:21 where kernel: found reiserfs format "3.6" with standard 
journal
Sep  1 04:40:21 where kernel: Reiserfs journal params: device hda1, size 
8192, journal first block 18, max trans len 1024, max batch 900, max 
commit age 30, max trans age 30
Sep  1 04:40:21 where kernel: reiserfs: checking transaction log (hda1) 
for (hda1)
Sep  1 04:40:21 where kernel: Using r5 hash to sort names
Sep  1 04:40:21 where kernel: found reiserfs format "3.6" with standard 
journal
Sep  1 04:40:21 where kernel: Reiserfs journal params: device hde1, size 
8192, journal first block 18, max trans len 1024, max batch 900, max 
commit age 30, max trans age 30
Sep  1 04:40:21 where kernel: reiserfs: checking transaction log (hde1) 
for (hde1)
Sep  1 04:40:21 where kernel: Using r5 hash to sort names
Sep  1 04:40:21 where kernel: found reiserfs format "3.6" with standard 
journal
Sep  1 04:40:21 where kernel: Reiserfs journal params: device hdg1, size 
8192, journal first block 18, max trans len 1024, max batch 900, max 
commit age 30, max trans age 30
Sep  1 04:40:21 where kernel: reiserfs: checking transaction log (hdg1) 
for (hdg1)
Sep  1 04:40:21 where kernel: Using r5 hash to sort names
Sep  1 04:40:21 where kernel: found reiserfs format "3.6" with standard 
journal
Sep  1 04:40:21 where kernel: Reiserfs journal params: device md2, size 
8192, journal first block 18, max trans len 1024, max batch 900, max 
commit age 30, max trans age 30
Sep  1 04:40:21 where kernel: reiserfs: checking transaction log (md2) 
for (md2)
Sep  1 04:40:21 where kernel: Using r5 hash to sort names


