Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263796AbTKKWbt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 17:31:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263805AbTKKWbs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 17:31:48 -0500
Received: from dhcp160178171.columbus.rr.com ([24.160.178.171]:27523 "EHLO
	caphernaum.rivenstone.net") by vger.kernel.org with ESMTP
	id S263796AbTKKWar (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 17:30:47 -0500
Date: Tue, 11 Nov 2003 17:29:33 -0500
To: linux-kernel@vger.kernel.org
Cc: netdev@oss.sgi.com
Subject: [OOPS] TLAN fails on ifconfig with CONFIG_HOTPLUG=n
Message-ID: <20031111222933.GA2868@rivenstone.net>
Mail-Followup-To: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="O5XBE6gyVG5Rl6Rj"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: jhf@rivenstone.net (Joseph Fannin)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--O5XBE6gyVG5Rl6Rj
Content-Type: multipart/mixed; boundary="YZ5djTAD1cGYuMQK"
Content-Disposition: inline


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

  Hello,

    I'm getting an Oops when ifup'ing a Compaq Netelligent card that
uses the tlan driver running 2.6.  The oops causes the ifconfig and
modprobe (invoked by kmod) processes to hang and the network doesn't
come up.

    The oops only happens when CONFIG_HOTPLUG=3Dn.  I've seen the
problem in -test8, test9, and test9-bk11.  This is a Compaq Proliant
5000 with quad PPro processors.  The box has EISA slots so I have
CONFIG_EISA=3Dy but all three NICs are pci Netelligents. =20
=20
   I had thought this was a problem that started in -test9, not
realizing I had turned hotplug support off when updating from -test8.
This might not be that big deal now that the problem is known -- would
it be useful to file this in the kernel Bugzilla to keep track of it?
It looks like tlan.c hasn't been touched in a long time.

I'm subscribed to linux-kernel, but not netdev.  Thanks for any help.

The Oops, dmesg, .config, and lspci -v are attached as plain text:

--=20
Joseph Fannin
jhf@rivenstone.net

"Linus, please apply.  Breaks everything.  But is cool." -- Rusty Russell.

--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="oops.txt"

Nov 11 16:04:07 ctesiphon kernel: ThunderLAN driver v1.15
Nov 11 16:04:07 ctesiphon kernel: TLAN: eth0 irq=11, io=7400, Compaq Netelligent 10/100 TX PCI UTP, Rev. 16
Nov 11 16:04:07 ctesiphon kernel: TLAN: eth1 irq=10, io=5000, Compaq Netelligent 10/100 TX PCI UTP, Rev. 16
Nov 11 16:04:07 ctesiphon kernel: TLAN: eth2 irq=15, io=5010, Compaq Netelligent 10/100 TX PCI UTP, Rev. 16
Nov 11 16:04:07 ctesiphon kernel: TLAN: 3 devices installed, PCI: 3  EISA: 0
Nov 11 16:04:07 ctesiphon kernel: Unable to handle kernel paging request at virtual address e8804830
Nov 11 16:04:07 ctesiphon kernel:  printing eip:
Nov 11 16:04:07 ctesiphon kernel: e8833594
Nov 11 16:04:07 ctesiphon kernel: *pde = 27de6067
Nov 11 16:04:07 ctesiphon kernel: *pte = 00000000
Nov 11 16:04:07 ctesiphon kernel: Oops: 0000 [#1]
Nov 11 16:04:07 ctesiphon kernel: CPU:    1
Nov 11 16:04:07 ctesiphon kernel: EIP:    0060:[__crc_try_to_free_buffers+545803/1321081]    Not tainted
Nov 11 16:04:07 ctesiphon kernel: EFLAGS: 00010292
Nov 11 16:04:07 ctesiphon kernel: EIP is at TLan_PhyDetect+0x14/0x190 [tlan]
Nov 11 16:04:07 ctesiphon kernel: eax: e880482c   ebx: 00000600   ecx: 0000740c   edx: 0000740c
Nov 11 16:04:07 ctesiphon kernel: esi: 00007400   edi: e7709e00   ebp: e7709c00   esp: e743de4c
Nov 11 16:04:07 ctesiphon kernel: ds: 007b   es: 007b   ss: 0068
Nov 11 16:04:07 ctesiphon kernel: Process ifconfig (pid: 123, threadinfo=e743c000 task=e75f8d00)
Nov 11 16:04:07 ctesiphon kernel: Stack: 00000000 d7c6a9fc e72f007b 272f007b ffffffef c01158f4 00000060 00000600
Nov 11 16:04:07 ctesiphon kernel:        00007400 00007408 00007400 e8832ddf e7709c00 e7709e00 e7709c00 00000000
Nov 11 16:04:07 ctesiphon kernel:        e7709c00 e7709e00 00000000 e8830352 e7709c00 00000000 04000000 e8838ce0
Nov 11 16:04:07 ctesiphon kernel: Call Trace:
Nov 11 16:04:07 ctesiphon kernel:  [delay_tsc+20/32] delay_tsc+0x14/0x20
Nov 11 16:04:07 ctesiphon kernel:  [__crc_try_to_free_buffers+543830/1321081] TLan_ResetAdapter+0xff/0x220 [tlan]
Nov 11 16:04:07 ctesiphon kernel:  [__crc_try_to_free_buffers+532937/1321081] TLan_Open+0xb2/0xe0 [tlan]
Nov 11 16:04:07 ctesiphon kernel:  [dev_open+214/272] dev_open+0xd6/0x110
Nov 11 16:04:07 ctesiphon kernel:  [dev_mc_upload+53/96] dev_mc_upload+0x35/0x60
Nov 11 16:04:07 ctesiphon kernel:  [dev_change_flags+83/304] dev_change_flags+0x53/0x130
Nov 11 16:04:07 ctesiphon kernel:  [devinet_ioctl+711/1600] devinet_ioctl+0x2c7/0x640
Nov 11 16:04:07 ctesiphon kernel:  [inet_ioctl+227/304] inet_ioctl+0xe3/0x130
Nov 11 16:04:07 ctesiphon kernel:  [sock_ioctl+310/816] sock_ioctl+0x136/0x330
Nov 11 16:04:07 ctesiphon kernel:  [sys_ioctl+280/720] sys_ioctl+0x118/0x2d0
Nov 11 16:04:07 ctesiphon kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 11 16:04:07 ctesiphon kernel:
Nov 11 16:04:07 ctesiphon kernel: Code: f6 40 04 01 74 13 ba ff ff 00 00 89 97 f8 00 00 00 83 c4 1c

--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-2.6.0-test9.txt"

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
CONFIG_CLEAN_COMPILE=y
CONFIG_STANDALONE=y

#
# General setup
#
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT=15
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_EMBEDDED is not set
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
CONFIG_M686=y
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
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
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_PPRO_FENCE=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
# CONFIG_HPET_TIMER is not set
# CONFIG_HPET_EMULATE_RTC is not set
CONFIG_SMP=y
CONFIG_NR_CPUS=4
CONFIG_PREEMPT=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
# CONFIG_X86_MCE_NONFATAL is not set
# CONFIG_X86_MCE_P4THERMAL is not set
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
CONFIG_MICROCODE=m
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set
# CONFIG_EDD is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
CONFIG_HAVE_DEC_LOCK=y

#
# Power management options (ACPI, APM)
#
# CONFIG_PM is not set

#
# ACPI (Advanced Configuration and Power Interface) Support
#
# CONFIG_ACPI is not set
CONFIG_ACPI_BOOT=y

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
CONFIG_ISA=y
CONFIG_EISA=y
CONFIG_EISA_VLB_PRIMING=y
CONFIG_EISA_PCI_EISA=y
CONFIG_EISA_VIRTUAL_ROOT=y
CONFIG_EISA_NAMES=y
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set
# CONFIG_HOTPLUG is not set

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_MISC=m

#
# Device Drivers
#

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
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_CML1=m
# CONFIG_PARPORT_SERIAL is not set
CONFIG_PARPORT_PC_FIFO=y
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_OTHER is not set
CONFIG_PARPORT_1284=y

#
# Plug and Play support
#
CONFIG_PNP=y
# CONFIG_PNP_DEBUG is not set

#
# Protocols
#
CONFIG_ISAPNP=y
# CONFIG_PNPBIOS is not set

#
# Block devices
#
CONFIG_BLK_DEV_FD=m
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
CONFIG_BLK_CPQ_DA=y
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=m
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_BLK_DEV_INITRD is not set
# CONFIG_LBD is not set

#
# ATA/ATAPI/MFM/RLL support
#
# CONFIG_IDE is not set

#
# SCSI device support
#
CONFIG_SCSI=y
# CONFIG_SCSI_PROC_FS is not set

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=m
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_CHR_DEV_SG=m

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
# CONFIG_SCSI_MULTI_LUN is not set
CONFIG_SCSI_REPORT_LUNS=y
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
# CONFIG_SCSI_AACRAID is not set
CONFIG_SCSI_AIC7XXX=m
CONFIG_AIC7XXX_CMDS_PER_DEVICE=32
CONFIG_AIC7XXX_RESET_DELAY_MS=15000
CONFIG_AIC7XXX_PROBE_EISA_VL=y
# CONFIG_AIC7XXX_BUILD_FIRMWARE is not set
# CONFIG_AIC7XXX_DEBUG_ENABLE is not set
CONFIG_AIC7XXX_DEBUG_MASK=0
# CONFIG_AIC7XXX_REG_PRETTY_PRINT is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_SCSI_MEGARAID is not set
# CONFIG_SCSI_SATA is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_CPQFCTS is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_DTC3280 is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_GENERIC_NCR5380_MMIO is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_NCR53C406A is not set
CONFIG_SCSI_SYM53C8XX_2=y
CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=0
CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=16
CONFIG_SCSI_SYM53C8XX_MAX_TAGS=64
# CONFIG_SCSI_SYM53C8XX_IOMAPPED is not set
# CONFIG_SCSI_PAS16 is not set
# CONFIG_SCSI_PSI240I is not set
# CONFIG_SCSI_QLOGIC_FAS is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_SIM710 is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set

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
# CONFIG_PACKET_MMAP is not set
# CONFIG_NETLINK_DEV is not set
CONFIG_UNIX=y
# CONFIG_NET_KEY is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
CONFIG_INET_ECN=y
CONFIG_SYN_COOKIES=y
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
# CONFIG_IPV6 is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
# CONFIG_NETFILTER is not set

#
# SCTP Configuration (EXPERIMENTAL)
#
CONFIG_IPV6_SCTP__=y
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
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
# CONFIG_TUN is not set
# CONFIG_NET_SB1000 is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
# CONFIG_MII is not set
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set

#
# Tulip family network device support
#
# CONFIG_NET_TULIP is not set
# CONFIG_AT1700 is not set
# CONFIG_DEPCA is not set
# CONFIG_HP100 is not set
# CONFIG_NET_ISA is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_AMD8111_ETH is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_AC3200 is not set
# CONFIG_APRICOT is not set
# CONFIG_B44 is not set
# CONFIG_CS89x0 is not set
# CONFIG_DGRS is not set
# CONFIG_EEPRO100 is not set
# CONFIG_E100 is not set
# CONFIG_LNE390 is not set
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_NE3210 is not set
# CONFIG_ES3210 is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
CONFIG_TLAN=m
# CONFIG_VIA_RHINE is not set
# CONFIG_NET_POCKET is not set

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
# CONFIG_PLIP is not set
# CONFIG_PPP is not set
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
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
# CONFIG_IRDA is not set

#
# Bluetooth support
#
# CONFIG_BT is not set

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
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=800
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=600
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
CONFIG_INPUT_EVDEV=y
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
# CONFIG_SERIO_PARKBD is not set
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
# CONFIG_MOUSE_PS2_SYNAPTICS is not set
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_INPORT is not set
# CONFIG_MOUSE_LOGIBM is not set
# CONFIG_MOUSE_PC110PAD is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
CONFIG_INPUT_PCSPKR=y
# CONFIG_INPUT_UINPUT is not set

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
CONFIG_SERIAL_8250=m
CONFIG_SERIAL_8250_NR_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=m
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
# CONFIG_PPDEV is not set
# CONFIG_TIPAR is not set

#
# I2C support
#
# CONFIG_I2C is not set

#
# I2C Algorithms
#

#
# I2C Hardware Bus support
#

#
# I2C Hardware Sensors Chip support
#
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
CONFIG_WATCHDOG=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_SOFT_WATCHDOG=y
# CONFIG_WDT is not set
# CONFIG_WDTPCI is not set
# CONFIG_PCWATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
# CONFIG_EUROTECH_WDT is not set
# CONFIG_IB700_WDT is not set
# CONFIG_I810_TCO is not set
# CONFIG_MIXCOMWD is not set
# CONFIG_SCx200_WDT is not set
# CONFIG_60XX_WDT is not set
# CONFIG_W83877F_WDT is not set
# CONFIG_MACHZ_WDT is not set
# CONFIG_SC520_WDT is not set
# CONFIG_AMD7XX_TCO is not set
# CONFIG_ALIM7101_WDT is not set
# CONFIG_ALIM1535_WDT is not set
# CONFIG_SC1200_WDT is not set
# CONFIG_WAFER_WDT is not set
# CONFIG_CPU5_WDT is not set
# CONFIG_HW_RANDOM is not set
# CONFIG_NVRAM is not set
CONFIG_RTC=y
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_AGP is not set
# CONFIG_DRM is not set
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set
CONFIG_HANGCHECK_TIMER=y

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set

#
# Graphics support
#
# CONFIG_FB is not set
# CONFIG_VIDEO_SELECT is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y

#
# Sound
#
# CONFIG_SOUND is not set

#
# USB support
#
# CONFIG_USB is not set
# CONFIG_USB_GADGET is not set

#
# File systems
#
CONFIG_EXT2_FS=m
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
# CONFIG_EXT2_FS_SECURITY is not set
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_EXT3_FS_POSIX_ACL=y
# CONFIG_EXT3_FS_SECURITY is not set
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=m
# CONFIG_REISERFS_CHECK is not set
CONFIG_REISERFS_PROC_INFO=y
CONFIG_JFS_FS=m
# CONFIG_JFS_POSIX_ACL is not set
# CONFIG_JFS_DEBUG is not set
CONFIG_JFS_STATISTICS=y
CONFIG_FS_POSIX_ACL=y
CONFIG_XFS_FS=m
# CONFIG_XFS_RT is not set
# CONFIG_XFS_QUOTA is not set
CONFIG_XFS_POSIX_ACL=y
CONFIG_MINIX_FS=m
# CONFIG_ROMFS_FS is not set
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=m
CONFIG_UDF_FS=m

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_NTFS_FS=m
# CONFIG_NTFS_DEBUG is not set
# CONFIG_NTFS_RW is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
# CONFIG_DEVFS_FS is not set
CONFIG_DEVPTS_FS=y
CONFIG_DEVPTS_FS_XATTR=y
# CONFIG_DEVPTS_FS_SECURITY is not set
CONFIG_TMPFS=y
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
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
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
CONFIG_NFS_V4=y
CONFIG_NFS_DIRECTIO=y
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_TCP=y
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=m
CONFIG_SUNRPC=m
CONFIG_SUNRPC_GSS=m
CONFIG_SMB_FS=m
# CONFIG_SMB_NLS_DEFAULT is not set
CONFIG_CIFS=m
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_INTERMEZZO_FS is not set
# CONFIG_AFS_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y

#
# Native Language Support
#
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m
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
CONFIG_NLS_ISO8859_1=m
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
CONFIG_NLS_UTF8=m

#
# Profiling support
#
# CONFIG_PROFILING is not set

#
# Kernel hacking
#
CONFIG_DEBUG_KERNEL=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
# CONFIG_DEBUG_SLAB is not set
# CONFIG_DEBUG_IOVIRT is not set
CONFIG_MAGIC_SYSRQ=y
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_DEBUG_INFO is not set
CONFIG_DEBUG_SPINLOCK_SLEEP=y
# CONFIG_FRAME_POINTER is not set
CONFIG_X86_EXTRA_IRQS=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y

#
# Security options
#
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
# CONFIG_CRYPTO is not set

#
# Library routines
#
CONFIG_CRC32=y
CONFIG_ZLIB_INFLATE=m
CONFIG_X86_SMP=y
CONFIG_X86_HT=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_X86_TRAMPOLINE=y
CONFIG_PC=y

--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="lspci-v.txt"

00:0b.0 PCI bridge: IBM IBM27-82351 (rev 07) (prog-if 00 [Normal decode])
	Flags: bus master, medium devsel, latency 96
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=248
	I/O behind bridge: 00006000-00006fff
	Memory behind bridge: c6e00000-c6efffff
	Prefetchable memory behind bridge: b8000000-bfffffff

00:0c.0 Network controller: Compaq Computer Corporation Netelligent 10/100 (rev 10)
	Flags: bus master, medium devsel, latency 64, IRQ 10
	I/O ports at 5000 [size=16]
	Memory at c6dffff0 (32-bit, non-prefetchable) [size=16]
	Expansion ROM at <unassigned> [disabled] [size=64K]

00:0e.0 Network controller: Compaq Computer Corporation Netelligent 10/100 (rev 10)
	Flags: bus master, medium devsel, latency 64, IRQ 15
	I/O ports at 5010 [size=16]
	Memory at c6dfffe0 (32-bit, non-prefetchable) [size=16]
	Expansion ROM at <unassigned> [disabled] [size=64K]

00:0f.0 Non-VGA unclassified device: Intel Corp. 82375EB (rev 15)
	Flags: bus master, medium devsel, latency 248

00:14.0 RAM memory: Intel Corp. 450KX/GX [Orion] - 82453KX/GX Memory controller (rev 05)
	Flags: fast devsel

00:19.0 Host bridge: Intel Corp. 450KX/GX [Orion] - 82454KX/GX PCI bridge (rev 06)
	Flags: bus master, medium devsel, latency 32

00:1a.0 Host bridge: Intel Corp. 450KX/GX [Orion] - 82454KX/GX PCI bridge (rev 06)
	Flags: bus master, medium devsel, latency 32

01:00.0 Unknown mass storage controller: Compaq Computer Corporation Smart-2/P RAID Controller (rev 03)
	Subsystem: Compaq Computer Corporation Smart-2/P Array Controller
	Flags: bus master, medium devsel, latency 0, IRQ 7
	I/O ports at 6000 [size=256]
	Memory at c6efff00 (32-bit, non-prefetchable) [size=256]
	Memory at b8000000 (32-bit, prefetchable) [size=128M]
	Expansion ROM at <unassigned> [disabled] [size=16K]

02:0a.0 SCSI storage controller: LSI Logic / Symbios Logic 53c825 (rev 02)
	Flags: bus master, medium devsel, latency 255, IRQ 14
	I/O ports at 7000 [size=256]
	Memory at c6ffff00 (32-bit, non-prefetchable) [size=256]

02:0e.0 Network controller: Compaq Computer Corporation Netelligent 10/100 (rev 10)
	Flags: bus master, medium devsel, latency 64, IRQ 11
	I/O ports at 7400 [size=16]
	Memory at c6fffef0 (32-bit, non-prefetchable) [size=16]
	Expansion ROM at <unassigned> [disabled] [size=64K]

02:0f.0 Non-VGA unclassified device: Intel Corp. 82375EB (rev 15)
	Flags: medium devsel


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg.txt"
Content-Transfer-Encoding: quoted-printable

Linux version 2.6.0-test8 (root@ctesiphon) (gcc version 3.3.2 (Debian)) #10=
 SMP Tue Nov 11 15:53:52 EST 2003
Video mode to be used for restore is ffff
BIOS-provided physical RAM map:
 BIOS-88: 0000000000000000 - 000000000009f000 (usable)
 BIOS-88: 0000000000100000 - 0000000001000000 (usable)
user-defined physical RAM map:
 user: 0000000000000000 - 00000000000a0000 (usable)
 user: 0000000000100000 - 0000000028000000 (usable)
640MB LOWMEM available.
found SMP MP-table at 000f4ff0
hm, page 000f4000 reserved twice.
hm, page 000f5000 reserved twice.
hm, page 000fb000 reserved twice.
hm, page 000fc000 reserved twice.
On node 0 totalpages: 163840
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 159744 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI not present.
ACPI: Unable to locate RSDP
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: COMPAQ   Product ID: PROLIANT     APIC at: 0xFEE00000
Processor #3 6:1 APIC version 16
Processor #0 6:1 APIC version 16
Processor #1 6:1 APIC version 16
Processor #2 6:1 APIC version 16
I/O APIC #8 Version 17 at 0xFEC00000.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Processors: 4
Building zonelist for node : 0
Kernel command line: root=3D/dev/sda3 ro rootflags=3Ddata=3Dwriteback,acl,u=
ser_xattr memmap=3Dexactmap memmap=3D640K@0 memmap=3D639M@1M psmouse_imps2
Initializing CPU#0
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 200.167 MHz processor.
Console: colour VGA+ 80x25
Debug: sleeping function called from invalid context at include/asm/semapho=
re.h:119
in_atomic():1, irqs_disabled():1
Call Trace:
 [<c011e280>] __might_sleep+0xa0/0xd0
 [<c01216d9>] acquire_console_sem+0x39/0x60
 [<c0121925>] register_console+0x85/0x1d0
 [<c02ed952>] con_init+0x202/0x240
 [<c0105000>] _stext+0x0/0x70
 [<c02ecdc3>] console_init+0x33/0x40
 [<c02d886f>] start_kernel+0xdf/0x190
 [<c02d84a0>] unknown_bootoption+0x0/0x120

Memory: 645316k/655360k available (1434k kernel code, 9252k reserved, 438k =
data, 396k init, 0k highmem)
Debug: sleeping function called from invalid context at mm/slab.c:1857
in_atomic():1, irqs_disabled():0
Call Trace:
 [<c011e280>] __might_sleep+0xa0/0xd0
 [<c0143d78>] kmem_cache_alloc+0x78/0x80
 [<c0105000>] _stext+0x0/0x70
 [<c0142b9b>] kmem_cache_create+0x7b/0x560
 [<c02e458a>] mem_init+0x17a/0x200
 [<c0105000>] _stext+0x0/0x70
 [<c02e7239>] kmem_cache_init+0x129/0x310
 [<c02d887f>] start_kernel+0xef/0x190
 [<c02d84a0>] unknown_bootoption+0x0/0x120

Calibrating delay loop... 391.16 BogoMIPS
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 0000fbff 00000000 00000000 00000000
CPU:     After vendor identify, caps: 0000fbff 00000000 00000000 00000000
CPU: L1 I cache: 8K, L1 D cache: 8K
CPU: L2 cache: 256K
CPU:     After all inits, caps: 0000f3ff 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU0: Intel Pentium Pro stepping 09
per-CPU timeslice cutoff: 730.25 usecs.
task migration cache decay timeout: 1 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/0 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 399.36 BogoMIPS
CPU:     After generic identify, caps: 0000fbff 00000000 00000000 00000000
CPU:     After vendor identify, caps: 0000fbff 00000000 00000000 00000000
CPU: L1 I cache: 8K, L1 D cache: 8K
CPU: L2 cache: 512K
CPU:     After all inits, caps: 0000f3ff 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel Pentium Pro stepping 09
Booting processor 2/1 eip 2000
Initializing CPU#2
masked ExtINT on CPU#2
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 399.36 BogoMIPS
CPU:     After generic identify, caps: 0000fbff 00000000 00000000 00000000
CPU:     After vendor identify, caps: 0000fbff 00000000 00000000 00000000
CPU: L1 I cache: 8K, L1 D cache: 8K
CPU: L2 cache: 512K
CPU:     After all inits, caps: 0000f3ff 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#2.
CPU2: Intel Pentium Pro stepping 09
Booting processor 3/2 eip 2000
Initializing CPU#3
masked ExtINT on CPU#3
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 398.33 BogoMIPS
CPU:     After generic identify, caps: 0000fbff 00000000 00000000 00000000
CPU:     After vendor identify, caps: 0000fbff 00000000 00000000 00000000
CPU: L1 I cache: 8K, L1 D cache: 8K
CPU: L2 cache: 256K
CPU:     After all inits, caps: 0000f3ff 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#3.
CPU3: Intel Pentium Pro stepping 09
Total of 4 processors activated (1588.22 BogoMIPS).
ENABLING IO-APIC IRQs
Setting 8 in the phys_id_present_map
=2E..changing IO-APIC physical APIC ID to 8 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 8-0 not connected.
=2E.TIMER: vector=3D0x31 pin1=3D2 pin2=3D0
number of MP IRQ sources: 16.
number of IO-APIC #8 registers: 16.
testing the IO APIC.......................
IO APIC #8......
=2E... register #00: 08000000
=2E......    : physical APIC id: 08
=2E......    : Delivery Type: 0
=2E......    : LTS          : 0
=2E... register #01: 000F0011
=2E......     : max redirection entries: 000F
=2E......     : PRQ implemented: 0
=2E......     : IO APIC version: 0011
=2E... register #02: 00000000
=2E......     : arbitration: 00
=2E... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:  =20
 00 000 00  1    0    0   0   0    0    0    00
 01 001 01  0    0    0   0   0    1    1    39
 02 001 01  0    0    0   0   0    1    1    31
 03 001 01  0    0    0   0   0    1    1    41
 04 001 01  0    0    0   0   0    1    1    49
 05 001 01  0    0    0   0   0    1    1    51
 06 001 01  0    0    0   0   0    1    1    59
 07 001 01  1    1    0   0   0    1    1    61
 08 001 01  0    0    0   0   0    1    1    69
 09 001 01  0    0    0   0   0    1    1    71
 0a 001 01  1    1    0   0   0    1    1    79
 0b 001 01  1    1    0   0   0    1    1    81
 0c 001 01  0    0    0   0   0    1    1    89
 0d 001 01  0    0    0   0   0    1    1    91
 0e 001 01  1    1    0   0   0    1    1    99
 0f 001 01  1    1    0   0   0    1    1    A1
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9
IRQ10 -> 0:10
IRQ11 -> 0:11
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
=2E................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
=2E.... CPU clock speed is 199.0958 MHz.
=2E.... host bus clock speed is 66.0652 MHz.
checking TSC synchronization across 4 CPUs: passed.
Starting migration thread for cpu 0
Bringing up 1
CPU 1 IS NOW UP!
Starting migration thread for cpu 1
Bringing up 2
CPU 2 IS NOW UP!
Starting migration thread for cpu 2
Bringing up 3
CPU 3 IS NOW UP!
Starting migration thread for cpu 3
CPUS done 8
NET: Registered protocol family 16
EISA bus registered
PCI: PCI BIOS revision 2.10 entry at 0xf0066, last bus=3D2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
Linux Plug and Play Support v0.97 (c) Adam Belay
SCSI subsystem initialized
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: i440KX/GX host bridge 0000:00:19.0: secondary bus 00
PCI: i440KX/GX host bridge 0000:00:1a.0: secondary bus 02
PCI BIOS passed nonexistent PCI bus 1!
PCI: Device 02:78 not found by BIOS
PCI: Device 00:78 not found by BIOS
PCI: Device 00:a0 not found by BIOS
PCI: Device 00:c8 not found by BIOS
PCI: Device 00:d0 not found by BIOS
Starting balanced_irq
ikconfig 0.7 with /proc/config*
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.12
Software Watchdog Timer: 0.06, soft_margin: 60 sec, nowayout: 0
Hangcheck: starting hangcheck timer 0.5.0 (tick is 180 seconds, margin is 6=
0 seconds).
cpqarray: Device 0xe11 has been found at bus 1 dev 0 func 0
Compaq SMART2 Driver (v 2.4.5)
Found 1 controller(s)
cpqarray: Finding drives on ida0Using anticipatory io scheduler
 (SMART-2/P)
cpqarray ida/c0d0: blksz=3D512 nr_blks=3D53303670
 ida/c0d0: p1 p2 p3 p4
sym0: <825> rev 0x2 at pci 0000:02:0a.0 irq 14
sym0: No NVRAM, ID 7, Fast-10, SE, parity checking
sym0: SCSI BUS has been reset.
scsi0 : sym-2.1.18b
sym0:0: FAST-10 SCSI 10.0 MB/s ST (100.0 ns, offset 8)
  Vendor: HP        Model: 1.050 GB #A1      Rev: 9004
  Type:   Direct-Access                      ANSI SCSI revision: 02
sym0:0:0: tagged command queuing enabled, command queue depth 16.
  Vendor: COMPAQ    Model: CRD-254V          Rev: 1.06
  Type:   CD-ROM                             ANSI SCSI revision: 02
SCSI device sda: 2051460 512-byte hdwr sectors (1050 MB)
SCSI device sda: drive cache: write through
 sda: sda1 sda2 sda3
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
mice: PS/2 mouse device common for all mice
input: PC Speaker
input: PS2++ Logitech Wheel Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Translated Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
EISA: Probing bus 0 at 0000:02:0f.0
EISA: Mainboard CPQ1561 detected.
Cannot allocate resource for EISA slot 5
Cannot allocate resource for EISA slot 6
Cannot allocate resource for EISA slot 7
EISA: Detected 0 cards.
pci_eisa : Could not register EISA root
pci_eisa: probe of 0000:00:0f.0 failed with error -1
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET: Registered protocol family 1
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with writeback data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 396k freed
EXT3 FS on sda3, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
IA-32 Microcode Update Driver: v1.13 <tigran@veritas.com>
microcode: No suitable data for cpu 0
microcode: No suitable data for cpu 1
microcode: No suitable data for cpu 2
microcode: No suitable data for cpu 3
ThunderLAN driver v1.15
TLAN: eth0 irq=3D11, io=3D7400, Compaq Netelligent 10/100 TX PCI UTP, Rev. =
16
TLAN: eth1 irq=3D10, io=3D5000, Compaq Netelligent 10/100 TX PCI UTP, Rev. =
16
TLAN: eth2 irq=3D15, io=3D5010, Compaq Netelligent 10/100 TX PCI UTP, Rev. =
16
TLAN: 3 devices installed, PCI: 3  EISA: 0
Unable to handle kernel paging request at virtual address e8804830
 printing eip:
e8833594
*pde =3D 27de6067
*pte =3D 00000000
Oops: 0000 [#1]
CPU:    2
EIP:    0060:[<e8833594>]    Not tainted
EFLAGS: 00010292
EIP is at TLan_PhyDetect+0x14/0x190 [tlan]
eax: e880482c   ebx: 00000600   ecx: 0000740c   edx: 0000740c
esi: 00007400   edi: e7d8f200   ebp: e7d8f000   esp: e735de4c
ds: 007b   es: 007b   ss: 0068
Process ifconfig (pid: 123, threadinfo=3De735c000 task=3De735f960)
Stack: 00000000 00019717 e72d007b 272d007b ffffffef c01158f6 00000060 00000=
600=20
       00007400 00007408 00007400 e8832ddf e7d8f000 e7d8f200 e7d8f000 00000=
000=20
       e7d8f000 e7d8f200 00000000 e8830352 e7d8f000 00000000 04000000 e8838=
ce0=20
Call Trace:
 [<c01158f6>] delay_tsc+0x16/0x20
 [<e8832ddf>] TLan_ResetAdapter+0xff/0x220 [tlan]
 [<e8830352>] TLan_Open+0xb2/0xe0 [tlan]
 [<c0216106>] dev_open+0xd6/0x110
 [<c021be15>] dev_mc_upload+0x35/0x60
 [<c02178b3>] dev_change_flags+0x53/0x130
 [<c0255857>] devinet_ioctl+0x2c7/0x640
 [<c0258603>] inet_ioctl+0xe3/0x130
 [<c020e626>] sock_ioctl+0x136/0x330
 [<c016e348>] sys_ioctl+0x118/0x2d0
 [<c010957b>] syscall_call+0x7/0xb

Code: f6 40 04 01 74 13 ba ff ff 00 00 89 97 f8 00 00 00 83 c4 1c=20
=20

--YZ5djTAD1cGYuMQK--

--O5XBE6gyVG5Rl6Rj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/sWLNWv4KsgKfSVgRAjneAJ0e1r7UDdxbDf/oVWjk8jY7RDuMOwCfbN2j
sHT/Z3TXOWfuR+acACqnJpc=
=wBQY
-----END PGP SIGNATURE-----

--O5XBE6gyVG5Rl6Rj--
