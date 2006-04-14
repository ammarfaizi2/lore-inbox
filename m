Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751364AbWDNSDL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751364AbWDNSDL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 14:03:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751360AbWDNSDK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 14:03:10 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:15593 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1751359AbWDNSDJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 14:03:09 -0400
Date: Fri, 14 Apr 2006 20:03:01 +0200
From: Pavel Machek <pavel@ucw.cz>
To: rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>, patches@arm.linux.org.uk
Subject: Fix collie compilation
Message-ID: <20060414180300.GA23060@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Fix collie compilation with current defconfig, and then fix defconfig
to have something at least remotely useful.

Signed-off-by: Pavel Machek <pavel@suse.cz>
PATCH FOLLOWS
KernelVersion: 2.6.17-rc1-git

diff --git a/arch/arm/configs/collie_defconfig b/arch/arm/configs/collie_defconfig
index c9aa878..074c47a 100644
--- a/arch/arm/configs/collie_defconfig
+++ b/arch/arm/configs/collie_defconfig
@@ -1,21 +1,21 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.14-rc3
-# Sun Oct  9 16:55:14 2005
+# Linux kernel version: 2.6.17-rc1
+# Fri Apr 14 19:09:52 2006
 #
 CONFIG_ARM=y
 CONFIG_MMU=y
-CONFIG_UID16=y
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
+CONFIG_GENERIC_HWEIGHT=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_ARCH_MTD_XIP=y
+CONFIG_VECTORS_BASE=0xffff0000
 
 #
 # Code maturity level options
 #
 CONFIG_EXPERIMENTAL=y
-CONFIG_CLEAN_COMPILE=y
 CONFIG_BROKEN_ON_SMP=y
-CONFIG_LOCK_KERNEL=y
 CONFIG_INIT_ENV_ARG_LIMIT=32
 
 #
@@ -23,45 +23,58 @@ CONFIG_INIT_ENV_ARG_LIMIT=32
 #
 CONFIG_LOCALVERSION=""
 CONFIG_LOCALVERSION_AUTO=y
-CONFIG_SWAP=y
+# CONFIG_SWAP is not set
 CONFIG_SYSVIPC=y
 # CONFIG_POSIX_MQUEUE is not set
-CONFIG_BSD_PROCESS_ACCT=y
-# CONFIG_BSD_PROCESS_ACCT_V3 is not set
+# CONFIG_BSD_PROCESS_ACCT is not set
 CONFIG_SYSCTL=y
 # CONFIG_AUDIT is not set
-CONFIG_HOTPLUG=y
-CONFIG_KOBJECT_UEVENT=y
 # CONFIG_IKCONFIG is not set
+# CONFIG_RELAY is not set
 CONFIG_INITRAMFS_SOURCE=""
+CONFIG_UID16=y
+# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_EMBEDDED=y
 CONFIG_KALLSYMS=y
 # CONFIG_KALLSYMS_ALL is not set
 # CONFIG_KALLSYMS_EXTRA_PASS is not set
+CONFIG_HOTPLUG=y
 CONFIG_PRINTK=y
 CONFIG_BUG=y
-CONFIG_BASE_FULL=y
+CONFIG_ELF_CORE=y
+# CONFIG_BASE_FULL is not set
 CONFIG_FUTEX=y
-CONFIG_EPOLL=y
-# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
+# CONFIG_EPOLL is not set
 CONFIG_SHMEM=y
-CONFIG_CC_ALIGN_FUNCTIONS=0
-CONFIG_CC_ALIGN_LABELS=0
-CONFIG_CC_ALIGN_LOOPS=0
-CONFIG_CC_ALIGN_JUMPS=0
+# CONFIG_SLAB is not set
+CONFIG_DOUBLEFAULT=y
 # CONFIG_TINY_SHMEM is not set
-CONFIG_BASE_SMALL=0
+CONFIG_BASE_SMALL=1
+CONFIG_SLOB=y
+CONFIG_OBSOLETE_INTERMODULE=y
 
 #
 # Loadable module support
 #
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-CONFIG_MODULE_FORCE_UNLOAD=y
-CONFIG_OBSOLETE_MODPARM=y
-CONFIG_MODVERSIONS=y
-# CONFIG_MODULE_SRCVERSION_ALL is not set
-CONFIG_KMOD=y
+# CONFIG_MODULES is not set
+
+#
+# Block layer
+#
+# CONFIG_BLK_DEV_IO_TRACE is not set
+
+#
+# IO Schedulers
+#
+CONFIG_IOSCHED_NOOP=y
+CONFIG_IOSCHED_AS=y
+# CONFIG_IOSCHED_DEADLINE is not set
+# CONFIG_IOSCHED_CFQ is not set
+CONFIG_DEFAULT_AS=y
+# CONFIG_DEFAULT_DEADLINE is not set
+# CONFIG_DEFAULT_CFQ is not set
+# CONFIG_DEFAULT_NOOP is not set
+CONFIG_DEFAULT_IOSCHED="anticipatory"
 
 #
 # System Type
@@ -70,11 +83,13 @@ CONFIG_KMOD=y
 # CONFIG_ARCH_CLPS711X is not set
 # CONFIG_ARCH_CO285 is not set
 # CONFIG_ARCH_EBSA110 is not set
+# CONFIG_ARCH_EP93XX is not set
 # CONFIG_ARCH_FOOTBRIDGE is not set
 # CONFIG_ARCH_INTEGRATOR is not set
 # CONFIG_ARCH_IOP3XX is not set
 # CONFIG_ARCH_IXP4XX is not set
 # CONFIG_ARCH_IXP2000 is not set
+# CONFIG_ARCH_IXP23XX is not set
 # CONFIG_ARCH_L7200 is not set
 # CONFIG_ARCH_PXA is not set
 # CONFIG_ARCH_RPC is not set
@@ -84,9 +99,11 @@ CONFIG_ARCH_SA1100=y
 # CONFIG_ARCH_LH7A40X is not set
 # CONFIG_ARCH_OMAP is not set
 # CONFIG_ARCH_VERSATILE is not set
+# CONFIG_ARCH_REALVIEW is not set
 # CONFIG_ARCH_IMX is not set
 # CONFIG_ARCH_H720X is not set
 # CONFIG_ARCH_AAEC2000 is not set
+# CONFIG_ARCH_AT91RM9200 is not set
 
 #
 # SA11x0 Implementations
@@ -128,20 +145,32 @@ CONFIG_SHARP_SCOOP=y
 # Bus support
 #
 CONFIG_ISA=y
-CONFIG_ISA_DMA_API=y
 
 #
 # PCCARD (PCMCIA/CardBus) support
 #
-# CONFIG_PCCARD is not set
+CONFIG_PCCARD=y
+CONFIG_PCMCIA_DEBUG=y
+CONFIG_PCMCIA=y
+CONFIG_PCMCIA_LOAD_CIS=y
+CONFIG_PCMCIA_IOCTL=y
+
+#
+# PC-card bridges
+#
+# CONFIG_I82365 is not set
+# CONFIG_TCIC is not set
+CONFIG_PCMCIA_SA1100=y
 
 #
 # Kernel Features
 #
-# CONFIG_SMP is not set
-CONFIG_PREEMPT=y
+# CONFIG_PREEMPT is not set
 # CONFIG_NO_IDLE_HZ is not set
+CONFIG_HZ=100
+# CONFIG_AEABI is not set
 CONFIG_ARCH_DISCONTIGMEM_ENABLE=y
+CONFIG_NODES_SHIFT=2
 CONFIG_SELECT_MEMORY_MODEL=y
 # CONFIG_FLATMEM_MANUAL is not set
 CONFIG_DISCONTIGMEM_MANUAL=y
@@ -150,6 +179,7 @@ CONFIG_DISCONTIGMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 CONFIG_NEED_MULTIPLE_NODES=y
 # CONFIG_SPARSEMEM_STATIC is not set
+CONFIG_SPLIT_PTLOCK_CPUS=4096
 # CONFIG_LEDS is not set
 CONFIG_ALIGNMENT_TRAP=y
 
@@ -158,7 +188,7 @@ CONFIG_ALIGNMENT_TRAP=y
 #
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
-CONFIG_CMDLINE="console=ttyS0,115200n8 console=tty1 noinitrd root=/dev/mtdblock2 rootfstype=jffs2   debug"
+CONFIG_CMDLINE="noinitrd root=/dev/mtdblock2 rootfstype=jffs2 fbcon=rotate:1"
 # CONFIG_XIP_KERNEL is not set
 
 #
@@ -181,14 +211,16 @@ CONFIG_FPE_NWFPE=y
 # Userspace binary formats
 #
 CONFIG_BINFMT_ELF=y
-CONFIG_BINFMT_AOUT=m
-CONFIG_BINFMT_MISC=m
+# CONFIG_BINFMT_AOUT is not set
+# CONFIG_BINFMT_MISC is not set
 # CONFIG_ARTHUR is not set
 
 #
 # Power management options
 #
 CONFIG_PM=y
+CONFIG_PM_LEGACY=y
+# CONFIG_PM_DEBUG is not set
 CONFIG_APM=y
 
 #
@@ -199,6 +231,7 @@ CONFIG_NET=y
 #
 # Networking options
 #
+# CONFIG_NETDEBUG is not set
 CONFIG_PACKET=y
 CONFIG_PACKET_MMAP=y
 CONFIG_UNIX=y
@@ -211,16 +244,19 @@ CONFIG_IP_FIB_HASH=y
 # CONFIG_NET_IPIP is not set
 # CONFIG_NET_IPGRE is not set
 # CONFIG_ARPD is not set
-CONFIG_SYN_COOKIES=y
+# CONFIG_SYN_COOKIES is not set
 # CONFIG_INET_AH is not set
 # CONFIG_INET_ESP is not set
 # CONFIG_INET_IPCOMP is not set
+# CONFIG_INET_XFRM_TUNNEL is not set
 # CONFIG_INET_TUNNEL is not set
 CONFIG_INET_DIAG=y
 CONFIG_INET_TCP_DIAG=y
 # CONFIG_TCP_CONG_ADVANCED is not set
 CONFIG_TCP_CONG_BIC=y
 # CONFIG_IPV6 is not set
+# CONFIG_INET6_XFRM_TUNNEL is not set
+# CONFIG_INET6_TUNNEL is not set
 # CONFIG_NETFILTER is not set
 
 #
@@ -232,6 +268,11 @@ CONFIG_TCP_CONG_BIC=y
 # SCTP Configuration (EXPERIMENTAL)
 #
 # CONFIG_IP_SCTP is not set
+
+#
+# TIPC Configuration (EXPERIMENTAL)
+#
+# CONFIG_TIPC is not set
 # CONFIG_ATM is not set
 # CONFIG_BRIDGE is not set
 # CONFIG_VLAN_8021Q is not set
@@ -244,8 +285,11 @@ CONFIG_TCP_CONG_BIC=y
 # CONFIG_NET_DIVERT is not set
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
+
+#
+# QoS and/or fair queueing
+#
 # CONFIG_NET_SCHED is not set
-# CONFIG_NET_CLS_ROUTE is not set
 
 #
 # Network testing
@@ -265,10 +309,15 @@ CONFIG_TCP_CONG_BIC=y
 #
 CONFIG_STANDALONE=y
 CONFIG_PREVENT_FIRMWARE_BUILD=y
-CONFIG_FW_LOADER=m
+CONFIG_FW_LOADER=y
 # CONFIG_DEBUG_DRIVER is not set
 
 #
+# Connector - unified userspace <-> kernelspace linker
+#
+# CONFIG_CONNECTOR is not set
+
+#
 # Memory Technology Devices (MTD)
 #
 CONFIG_MTD=y
@@ -287,32 +336,49 @@ CONFIG_MTD_BLOCK=y
 # CONFIG_FTL is not set
 # CONFIG_NFTL is not set
 # CONFIG_INFTL is not set
+# CONFIG_RFD_FTL is not set
 
 #
 # RAM/ROM/Flash chip drivers
 #
-# CONFIG_MTD_CFI is not set
-# CONFIG_MTD_JEDECPROBE is not set
-CONFIG_MTD_MAP_BANK_WIDTH_1=y
-CONFIG_MTD_MAP_BANK_WIDTH_2=y
+CONFIG_MTD_CFI=y
+CONFIG_MTD_JEDECPROBE=y
+CONFIG_MTD_GEN_PROBE=y
+CONFIG_MTD_CFI_ADV_OPTIONS=y
+CONFIG_MTD_CFI_NOSWAP=y
+# CONFIG_MTD_CFI_BE_BYTE_SWAP is not set
+# CONFIG_MTD_CFI_LE_BYTE_SWAP is not set
+CONFIG_MTD_CFI_GEOMETRY=y
+# CONFIG_MTD_MAP_BANK_WIDTH_1 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_2 is not set
 CONFIG_MTD_MAP_BANK_WIDTH_4=y
 # CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
 # CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
 # CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
-CONFIG_MTD_CFI_I1=y
-CONFIG_MTD_CFI_I2=y
-# CONFIG_MTD_CFI_I4 is not set
+# CONFIG_MTD_CFI_I1 is not set
+# CONFIG_MTD_CFI_I2 is not set
+CONFIG_MTD_CFI_I4=y
 # CONFIG_MTD_CFI_I8 is not set
+# CONFIG_MTD_OTP is not set
+CONFIG_MTD_CFI_INTELEXT=y
+# CONFIG_MTD_CFI_AMDSTD is not set
+# CONFIG_MTD_CFI_STAA is not set
+CONFIG_MTD_CFI_UTIL=y
 # CONFIG_MTD_RAM is not set
 # CONFIG_MTD_ROM is not set
 # CONFIG_MTD_ABSENT is not set
 CONFIG_MTD_OBSOLETE_CHIPS=y
 CONFIG_MTD_SHARP=y
+# CONFIG_MTD_XIP is not set
 
 #
 # Mapping drivers for chip access
 #
 # CONFIG_MTD_COMPLEX_MAPPINGS is not set
+# CONFIG_MTD_PHYSMAP is not set
+# CONFIG_MTD_ARM_INTEGRATOR is not set
+CONFIG_MTD_SA1100=y
+# CONFIG_MTD_IMPA7 is not set
 # CONFIG_MTD_PLATRAM is not set
 
 #
@@ -321,7 +387,6 @@ CONFIG_MTD_SHARP=y
 # CONFIG_MTD_SLRAM is not set
 # CONFIG_MTD_PHRAM is not set
 # CONFIG_MTD_MTDRAM is not set
-# CONFIG_MTD_BLKMTD is not set
 # CONFIG_MTD_BLOCK2MTD is not set
 
 #
@@ -337,6 +402,11 @@ CONFIG_MTD_SHARP=y
 # CONFIG_MTD_NAND is not set
 
 #
+# OneNAND Flash Device Drivers
+#
+# CONFIG_MTD_ONENAND is not set
+
+#
 # Parallel port support
 #
 # CONFIG_PARPORT is not set
@@ -349,7 +419,6 @@ CONFIG_MTD_SHARP=y
 #
 # Block devices
 #
-# CONFIG_BLK_DEV_XD is not set
 # CONFIG_BLK_DEV_COW_COMMON is not set
 CONFIG_BLK_DEV_LOOP=y
 # CONFIG_BLK_DEV_CRYPTOLOOP is not set
@@ -359,20 +428,35 @@ CONFIG_BLK_DEV_RAM_COUNT=16
 CONFIG_BLK_DEV_RAM_SIZE=1024
 CONFIG_BLK_DEV_INITRD=y
 # CONFIG_CDROM_PKTCDVD is not set
+# CONFIG_ATA_OVER_ETH is not set
 
 #
-# IO Schedulers
+# ATA/ATAPI/MFM/RLL support
 #
-CONFIG_IOSCHED_NOOP=y
-CONFIG_IOSCHED_AS=y
-CONFIG_IOSCHED_DEADLINE=y
-CONFIG_IOSCHED_CFQ=y
-CONFIG_ATA_OVER_ETH=m
+CONFIG_IDE=y
+CONFIG_BLK_DEV_IDE=y
 
 #
-# ATA/ATAPI/MFM/RLL support
+# Please see Documentation/ide.txt for help/info on IDE drives
 #
-# CONFIG_IDE is not set
+# CONFIG_BLK_DEV_IDE_SATA is not set
+CONFIG_BLK_DEV_IDEDISK=y
+CONFIG_IDEDISK_MULTI_MODE=y
+CONFIG_BLK_DEV_IDECS=y
+# CONFIG_BLK_DEV_IDECD is not set
+# CONFIG_BLK_DEV_IDETAPE is not set
+# CONFIG_BLK_DEV_IDEFLOPPY is not set
+# CONFIG_IDE_TASK_IOCTL is not set
+
+#
+# IDE chipset support/bugfixes
+#
+CONFIG_IDE_GENERIC=y
+# CONFIG_IDE_ARM is not set
+# CONFIG_IDE_CHIPSETS is not set
+# CONFIG_BLK_DEV_IDEDMA is not set
+# CONFIG_IDEDMA_AUTO is not set
+# CONFIG_BLK_DEV_HD is not set
 
 #
 # SCSI device support
@@ -402,6 +486,39 @@ CONFIG_ATA_OVER_ETH=m
 # Network device support
 #
 # CONFIG_NETDEVICES is not set
+# CONFIG_DUMMY is not set
+# CONFIG_BONDING is not set
+# CONFIG_EQUALIZER is not set
+# CONFIG_TUN is not set
+
+#
+# PHY device support
+#
+
+#
+# Ethernet (10 or 100Mbit)
+#
+# CONFIG_NET_ETHERNET is not set
+
+#
+# Ethernet (1000 Mbit)
+#
+
+#
+# Ethernet (10000 Mbit)
+#
+CONFIG_PPP=y
+# CONFIG_PPP_MULTILINK is not set
+# CONFIG_PPP_FILTER is not set
+CONFIG_PPP_ASYNC=y
+# CONFIG_PPP_SYNC_TTY is not set
+# CONFIG_PPP_DEFLATE is not set
+# CONFIG_PPP_BSDCOMP is not set
+# CONFIG_PPP_MPPE is not set
+# CONFIG_PPPOE is not set
+# CONFIG_SLIP is not set
+# CONFIG_SHAPER is not set
+# CONFIG_NETCONSOLE is not set
 # CONFIG_NETPOLL is not set
 # CONFIG_NET_POLL_CONTROLLER is not set
 
@@ -424,7 +541,7 @@ CONFIG_INPUT_TSDEV=y
 CONFIG_INPUT_TSDEV_SCREEN_X=240
 CONFIG_INPUT_TSDEV_SCREEN_Y=320
 CONFIG_INPUT_EVDEV=y
-CONFIG_INPUT_EVBUG=y
+# CONFIG_INPUT_EVBUG is not set
 
 #
 # Input Device Drivers
@@ -438,7 +555,11 @@ CONFIG_KEYBOARD_LOCOMO=y
 # CONFIG_KEYBOARD_NEWTON is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_INPUT_JOYSTICK is not set
-# CONFIG_INPUT_TOUCHSCREEN is not set
+CONFIG_INPUT_TOUCHSCREEN=y
+# CONFIG_TOUCHSCREEN_GUNZE is not set
+# CONFIG_TOUCHSCREEN_ELO is not set
+# CONFIG_TOUCHSCREEN_MTOUCH is not set
+# CONFIG_TOUCHSCREEN_MK712 is not set
 # CONFIG_INPUT_MISC is not set
 
 #
@@ -461,7 +582,16 @@ CONFIG_HW_CONSOLE=y
 #
 # Serial drivers
 #
-# CONFIG_SERIAL_8250 is not set
+CONFIG_SERIAL_8250=y
+# CONFIG_SERIAL_8250_CONSOLE is not set
+CONFIG_SERIAL_8250_CS=y
+CONFIG_SERIAL_8250_NR_UARTS=4
+CONFIG_SERIAL_8250_RUNTIME_UARTS=4
+CONFIG_SERIAL_8250_EXTENDED=y
+# CONFIG_SERIAL_8250_MANY_PORTS is not set
+# CONFIG_SERIAL_8250_SHARE_IRQ is not set
+# CONFIG_SERIAL_8250_DETECT_IRQ is not set
+# CONFIG_SERIAL_8250_RSA is not set
 
 #
 # Non-8250 serial port support
@@ -483,94 +613,48 @@ CONFIG_UNIX98_PTYS=y
 #
 # CONFIG_WATCHDOG is not set
 # CONFIG_NVRAM is not set
-# CONFIG_RTC is not set
 # CONFIG_DTLK is not set
 # CONFIG_R3964 is not set
 
 #
 # Ftape, the floppy tape device driver
 #
-# CONFIG_RAW_DRIVER is not set
 
 #
-# TPM devices
+# PCMCIA character devices
 #
+# CONFIG_SYNCLINK_CS is not set
+# CONFIG_CARDMAN_4000 is not set
+# CONFIG_CARDMAN_4040 is not set
+# CONFIG_RAW_DRIVER is not set
 
 #
-# I2C support
+# TPM devices
 #
-CONFIG_I2C=m
-# CONFIG_I2C_CHARDEV is not set
+# CONFIG_TCG_TPM is not set
+# CONFIG_TELCLOCK is not set
 
 #
-# I2C Algorithms
+# I2C support
 #
-CONFIG_I2C_ALGOBIT=m
-# CONFIG_I2C_ALGOPCF is not set
-# CONFIG_I2C_ALGOPCA is not set
+# CONFIG_I2C is not set
 
 #
-# I2C Hardware Bus support
+# SPI support
 #
-# CONFIG_I2C_ELEKTOR is not set
-# CONFIG_I2C_PARPORT_LIGHT is not set
-# CONFIG_I2C_STUB is not set
-# CONFIG_I2C_PCA_ISA is not set
+# CONFIG_SPI is not set
+# CONFIG_SPI_MASTER is not set
 
 #
-# Miscellaneous I2C Chip support
+# Dallas's 1-wire bus
 #
-# CONFIG_SENSORS_DS1337 is not set
-# CONFIG_SENSORS_DS1374 is not set
-# CONFIG_SENSORS_EEPROM is not set
-# CONFIG_SENSORS_PCF8574 is not set
-# CONFIG_SENSORS_PCA9539 is not set
-# CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_RTC8564 is not set
-# CONFIG_SENSORS_MAX6875 is not set
-# CONFIG_I2C_DEBUG_CORE is not set
-# CONFIG_I2C_DEBUG_ALGO is not set
-# CONFIG_I2C_DEBUG_BUS is not set
-# CONFIG_I2C_DEBUG_CHIP is not set
+# CONFIG_W1 is not set
 
 #
 # Hardware Monitoring support
 #
-CONFIG_HWMON=y
+# CONFIG_HWMON is not set
 # CONFIG_HWMON_VID is not set
-# CONFIG_SENSORS_ADM1021 is not set
-# CONFIG_SENSORS_ADM1025 is not set
-# CONFIG_SENSORS_ADM1026 is not set
-# CONFIG_SENSORS_ADM1031 is not set
-# CONFIG_SENSORS_ADM9240 is not set
-# CONFIG_SENSORS_ASB100 is not set
-# CONFIG_SENSORS_ATXP1 is not set
-# CONFIG_SENSORS_DS1621 is not set
-# CONFIG_SENSORS_FSCHER is not set
-# CONFIG_SENSORS_FSCPOS is not set
-# CONFIG_SENSORS_GL518SM is not set
-# CONFIG_SENSORS_GL520SM is not set
-# CONFIG_SENSORS_IT87 is not set
-# CONFIG_SENSORS_LM63 is not set
-# CONFIG_SENSORS_LM75 is not set
-# CONFIG_SENSORS_LM77 is not set
-# CONFIG_SENSORS_LM78 is not set
-# CONFIG_SENSORS_LM80 is not set
-# CONFIG_SENSORS_LM83 is not set
-# CONFIG_SENSORS_LM85 is not set
-# CONFIG_SENSORS_LM87 is not set
-# CONFIG_SENSORS_LM90 is not set
-# CONFIG_SENSORS_LM92 is not set
-# CONFIG_SENSORS_MAX1619 is not set
-# CONFIG_SENSORS_PC87360 is not set
-# CONFIG_SENSORS_SMSC47M1 is not set
-# CONFIG_SENSORS_SMSC47B397 is not set
-# CONFIG_SENSORS_W83781D is not set
-# CONFIG_SENSORS_W83792D is not set
-# CONFIG_SENSORS_W83L785TS is not set
-# CONFIG_SENSORS_W83627HF is not set
-# CONFIG_SENSORS_W83627EHF is not set
-# CONFIG_HWMON_DEBUG_CHIP is not set
 
 #
 # Misc devices
@@ -579,42 +663,33 @@ CONFIG_HWMON=y
 #
 # Multimedia Capabilities Port drivers
 #
-# CONFIG_MCP_SA11X0 is not set
+CONFIG_MCP=y
+CONFIG_MCP_SA11X0=y
+CONFIG_MCP_UCB1200=y
+CONFIG_MCP_UCB1200_TS=y
 
 #
-# Multimedia devices
+# LED devices
 #
-CONFIG_VIDEO_DEV=m
+CONFIG_NEW_LEDS=y
+CONFIG_LEDS_CLASS=y
 
 #
-# Video For Linux
+# LED drivers
 #
+CONFIG_LEDS_LOCOMO=y
 
 #
-# Video Adapters
+# LED Triggers
 #
-# CONFIG_VIDEO_PMS is not set
-# CONFIG_VIDEO_CPIA is not set
-# CONFIG_VIDEO_SAA5246A is not set
-# CONFIG_VIDEO_SAA5249 is not set
-# CONFIG_TUNER_3036 is not set
-# CONFIG_VIDEO_OVCAMCHIP is not set
+CONFIG_LEDS_TRIGGERS=y
+CONFIG_LEDS_TRIGGER_TIMER=y
+CONFIG_LEDS_TRIGGER_IDE_DISK=y
 
 #
-# Radio Adapters
+# Multimedia devices
 #
-# CONFIG_RADIO_CADET is not set
-# CONFIG_RADIO_RTRACK is not set
-# CONFIG_RADIO_RTRACK2 is not set
-# CONFIG_RADIO_AZTECH is not set
-# CONFIG_RADIO_GEMTEK is not set
-# CONFIG_RADIO_MAESTRO is not set
-# CONFIG_RADIO_SF16FMI is not set
-# CONFIG_RADIO_SF16FMR2 is not set
-# CONFIG_RADIO_TERRATEC is not set
-# CONFIG_RADIO_TRUST is not set
-# CONFIG_RADIO_TYPHOON is not set
-# CONFIG_RADIO_ZOLTRIX is not set
+# CONFIG_VIDEO_DEV is not set
 
 #
 # Digital Video Broadcasting Devices
@@ -628,8 +703,8 @@ CONFIG_FB=y
 CONFIG_FB_CFB_FILLRECT=y
 CONFIG_FB_CFB_COPYAREA=y
 CONFIG_FB_CFB_IMAGEBLIT=y
-CONFIG_FB_SOFT_CURSOR=y
 # CONFIG_FB_MACMODES is not set
+# CONFIG_FB_FIRMWARE_EDID is not set
 CONFIG_FB_MODE_HELPERS=y
 # CONFIG_FB_TILEBLITTING is not set
 CONFIG_FB_SA1100=y
@@ -643,14 +718,15 @@ CONFIG_FB_SA1100=y
 # CONFIG_MDA_CONSOLE is not set
 CONFIG_DUMMY_CONSOLE=y
 CONFIG_FRAMEBUFFER_CONSOLE=y
+CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
 CONFIG_FONTS=y
-CONFIG_FONT_8x8=y
+# CONFIG_FONT_8x8 is not set
 # CONFIG_FONT_8x16 is not set
 # CONFIG_FONT_6x11 is not set
 # CONFIG_FONT_7x14 is not set
 # CONFIG_FONT_PEARL_8x8 is not set
 # CONFIG_FONT_ACORN_8x8 is not set
-# CONFIG_FONT_MINI_4x6 is not set
+CONFIG_FONT_MINI_4x6=y
 # CONFIG_FONT_SUN8x16 is not set
 # CONFIG_FONT_SUN12x22 is not set
 # CONFIG_FONT_10x18 is not set
@@ -659,7 +735,11 @@ CONFIG_FONT_8x8=y
 # Logo configuration
 #
 # CONFIG_LOGO is not set
-# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
+CONFIG_BACKLIGHT_LCD_SUPPORT=y
+CONFIG_BACKLIGHT_CLASS_DEVICE=y
+CONFIG_BACKLIGHT_DEVICE=y
+CONFIG_LCD_CLASS_DEVICE=y
+CONFIG_LCD_DEVICE=y
 
 #
 # Sound
@@ -671,20 +751,17 @@ CONFIG_FONT_8x8=y
 #
 CONFIG_USB_ARCH_HAS_HCD=y
 # CONFIG_USB_ARCH_HAS_OHCI is not set
+# CONFIG_USB_ARCH_HAS_EHCI is not set
 # CONFIG_USB is not set
 
 #
+# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
+#
+
+#
 # USB Gadget Support
 #
-CONFIG_USB_GADGET=y
-# CONFIG_USB_GADGET_DEBUG_FILES is not set
-# CONFIG_USB_GADGET_NET2280 is not set
-# CONFIG_USB_GADGET_PXA2XX is not set
-# CONFIG_USB_GADGET_GOKU is not set
-# CONFIG_USB_GADGET_LH7A40X is not set
-# CONFIG_USB_GADGET_OMAP is not set
-# CONFIG_USB_GADGET_DUMMY_HCD is not set
-# CONFIG_USB_GADGET_DUALSPEED is not set
+# CONFIG_USB_GADGET is not set
 
 #
 # MMC/SD Card support
@@ -692,23 +769,24 @@ CONFIG_USB_GADGET=y
 # CONFIG_MMC is not set
 
 #
+# Real Time Clock
+#
+CONFIG_RTC_LIB=y
+# CONFIG_RTC_CLASS is not set
+
+#
 # File systems
 #
-CONFIG_EXT2_FS=y
-CONFIG_EXT2_FS_XATTR=y
-CONFIG_EXT2_FS_POSIX_ACL=y
-CONFIG_EXT2_FS_SECURITY=y
-# CONFIG_EXT2_FS_XIP is not set
+# CONFIG_EXT2_FS is not set
 # CONFIG_EXT3_FS is not set
-# CONFIG_JBD is not set
-CONFIG_FS_MBCACHE=y
 # CONFIG_REISERFS_FS is not set
 # CONFIG_JFS_FS is not set
-CONFIG_FS_POSIX_ACL=y
+# CONFIG_FS_POSIX_ACL is not set
 # CONFIG_XFS_FS is not set
+# CONFIG_OCFS2_FS is not set
 # CONFIG_MINIX_FS is not set
 CONFIG_ROMFS_FS=y
-CONFIG_INOTIFY=y
+# CONFIG_INOTIFY is not set
 # CONFIG_QUOTA is not set
 # CONFIG_DNOTIFY is not set
 # CONFIG_AUTOFS_FS is not set
@@ -725,7 +803,7 @@ CONFIG_INOTIFY=y
 # DOS/FAT/NT Filesystems
 #
 CONFIG_FAT_FS=y
-CONFIG_MSDOS_FS=y
+# CONFIG_MSDOS_FS is not set
 CONFIG_VFAT_FS=y
 CONFIG_FAT_DEFAULT_CODEPAGE=437
 CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
@@ -739,7 +817,7 @@ CONFIG_SYSFS=y
 CONFIG_TMPFS=y
 # CONFIG_HUGETLB_PAGE is not set
 CONFIG_RAMFS=y
-# CONFIG_RELAYFS_FS is not set
+# CONFIG_CONFIGFS_FS is not set
 
 #
 # Miscellaneous filesystems
@@ -755,11 +833,12 @@ CONFIG_RAMFS=y
 CONFIG_JFFS2_FS=y
 CONFIG_JFFS2_FS_DEBUG=0
 CONFIG_JFFS2_FS_WRITEBUFFER=y
+# CONFIG_JFFS2_SUMMARY is not set
 # CONFIG_JFFS2_COMPRESSION_OPTIONS is not set
 CONFIG_JFFS2_ZLIB=y
 CONFIG_JFFS2_RTIME=y
 # CONFIG_JFFS2_RUBIN is not set
-CONFIG_CRAMFS=y
+# CONFIG_CRAMFS is not set
 # CONFIG_VXFS_FS is not set
 # CONFIG_HPFS_FS is not set
 # CONFIG_QNX4FS_FS is not set
@@ -789,7 +868,7 @@ CONFIG_MSDOS_PARTITION=y
 #
 CONFIG_NLS=y
 CONFIG_NLS_DEFAULT="cp437"
-CONFIG_NLS_CODEPAGE_437=m
+CONFIG_NLS_CODEPAGE_437=y
 # CONFIG_NLS_CODEPAGE_737 is not set
 # CONFIG_NLS_CODEPAGE_775 is not set
 # CONFIG_NLS_CODEPAGE_850 is not set
@@ -813,7 +892,7 @@ CONFIG_NLS_CODEPAGE_437=m
 # CONFIG_NLS_CODEPAGE_1250 is not set
 # CONFIG_NLS_CODEPAGE_1251 is not set
 # CONFIG_NLS_ASCII is not set
-CONFIG_NLS_ISO8859_1=m
+CONFIG_NLS_ISO8859_1=y
 # CONFIG_NLS_ISO8859_2 is not set
 # CONFIG_NLS_ISO8859_3 is not set
 # CONFIG_NLS_ISO8859_4 is not set
@@ -826,7 +905,7 @@ CONFIG_NLS_ISO8859_1=m
 # CONFIG_NLS_ISO8859_15 is not set
 # CONFIG_NLS_KOI8_R is not set
 # CONFIG_NLS_KOI8_U is not set
-CONFIG_NLS_UTF8=m
+# CONFIG_NLS_UTF8 is not set
 
 #
 # Profiling support
@@ -837,20 +916,23 @@ CONFIG_NLS_UTF8=m
 # Kernel hacking
 #
 # CONFIG_PRINTK_TIME is not set
-CONFIG_DEBUG_KERNEL=y
 CONFIG_MAGIC_SYSRQ=y
+CONFIG_DEBUG_KERNEL=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_DETECT_SOFTLOCKUP=y
+# CONFIG_DETECT_SOFTLOCKUP is not set
 # CONFIG_SCHEDSTATS is not set
-# CONFIG_DEBUG_SLAB is not set
-CONFIG_DEBUG_PREEMPT=y
+CONFIG_DEBUG_MUTEXES=y
 # CONFIG_DEBUG_SPINLOCK is not set
 # CONFIG_DEBUG_SPINLOCK_SLEEP is not set
 # CONFIG_DEBUG_KOBJECT is not set
 # CONFIG_DEBUG_BUGVERBOSE is not set
 # CONFIG_DEBUG_INFO is not set
 # CONFIG_DEBUG_FS is not set
+# CONFIG_DEBUG_VM is not set
 CONFIG_FRAME_POINTER=y
+# CONFIG_UNWIND_INFO is not set
+CONFIG_FORCED_INLINING=y
+# CONFIG_RCU_TORTURE_TEST is not set
 # CONFIG_DEBUG_USER is not set
 # CONFIG_DEBUG_WAITQ is not set
 CONFIG_DEBUG_ERRORS=y
@@ -874,7 +956,7 @@ CONFIG_DEBUG_ERRORS=y
 #
 # Library routines
 #
-# CONFIG_CRC_CCITT is not set
+CONFIG_CRC_CCITT=y
 # CONFIG_CRC16 is not set
 CONFIG_CRC32=y
 # CONFIG_LIBCRC32C is not set
diff --git a/arch/arm/mach-sa1100/collie.c b/arch/arm/mach-sa1100/collie.c
index be589ce..9aa6cde 100644
--- a/arch/arm/mach-sa1100/collie.c
+++ b/arch/arm/mach-sa1100/collie.c
@@ -295,7 +295,9 @@ static void __init collie_init(void)
 	LCM_DAC |= (LCM_DAC_SCLOEB | LCM_DAC_SDAOEB); /* init DAC */
 #endif
 
+#ifdef CONFIG_PCMCIA_SA1100
 	platform_scoop_config = &collie_pcmcia_config;
+#endif
 
 	ret = platform_add_devices(devices, ARRAY_SIZE(devices));
 	if (ret) {

-- 
Thanks for all the (sleeping) penguins.
