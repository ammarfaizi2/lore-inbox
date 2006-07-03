Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750978AbWGCM2v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750978AbWGCM2v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 08:28:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750915AbWGCM2v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 08:28:51 -0400
Received: from crystal.sipsolutions.net ([195.210.38.204]:26324 "EHLO
	sipsolutions.net") by vger.kernel.org with ESMTP id S1750789AbWGCM2t
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 08:28:49 -0400
Subject: [PATCH] fix up front-LED Kconfig
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Mon, 03 Jul 2006 14:28:14 +0200
Message-Id: <1151929694.20701.35.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
X-sips-origin: submit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rather long patch, apparently no one has updated the pmac32_defconfig in
a while.

---
This patch fixes the front-LED Kconfig issues I introduced while
creating it. Apparently having a dependency isn't enough to have the
select not evaluated or something like that.

The patch also changes the default configuration for pmac32 select the
default for the LED to be the IDE trigger. While I was at it, I
completely updated the defconfig and also added snd-aoa to it.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>

diff --git a/arch/powerpc/configs/pmac32_defconfig b/arch/powerpc/configs/pmac32_defconfig
index addc793..3545af9 100644
--- a/arch/powerpc/configs/pmac32_defconfig
+++ b/arch/powerpc/configs/pmac32_defconfig
@@ -1,16 +1,18 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.17-rc5
-# Mon May 29 14:47:49 2006
+# Linux kernel version: 2.6.17
+# Mon Jul  3 14:20:49 2006
 #
 # CONFIG_PPC64 is not set
 CONFIG_PPC32=y
 CONFIG_PPC_MERGE=y
 CONFIG_MMU=y
 CONFIG_GENERIC_HARDIRQS=y
+CONFIG_IRQ_PER_CPU=y
 CONFIG_RWSEM_XCHGADD_ALGORITHM=y
 CONFIG_GENERIC_HWEIGHT=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_GENERIC_FIND_NEXT_BIT=y
 CONFIG_PPC=y
 CONFIG_EARLY_PRINTK=y
 CONFIG_GENERIC_NVRAM=y
@@ -29,6 +31,7 @@ # CONFIG_PPC_52xx is not set
 # CONFIG_PPC_82xx is not set
 # CONFIG_PPC_83xx is not set
 # CONFIG_PPC_85xx is not set
+# CONFIG_PPC_86xx is not set
 # CONFIG_40x is not set
 # CONFIG_44x is not set
 # CONFIG_8xx is not set
@@ -39,6 +42,7 @@ CONFIG_ALTIVEC=y
 CONFIG_PPC_STD_MMU=y
 CONFIG_PPC_STD_MMU_32=y
 # CONFIG_SMP is not set
+CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 
 #
 # Code maturity level options
@@ -72,10 +76,12 @@ CONFIG_PRINTK=y
 CONFIG_BUG=y
 CONFIG_ELF_CORE=y
 CONFIG_BASE_FULL=y
+CONFIG_RT_MUTEXES=y
 CONFIG_FUTEX=y
 CONFIG_EPOLL=y
 CONFIG_SHMEM=y
 CONFIG_SLAB=y
+CONFIG_VM_EVENT_COUNTERS=y
 # CONFIG_TINY_SHMEM is not set
 CONFIG_BASE_SMALL=0
 # CONFIG_SLOB is not set
@@ -119,6 +125,9 @@ # CONFIG_EMBEDDED6xx is not set
 # CONFIG_APUS is not set
 # CONFIG_PPC_CHRP is not set
 CONFIG_PPC_PMAC=y
+# CONFIG_PPC_CELL is not set
+# CONFIG_PPC_CELL_NATIVE is not set
+# CONFIG_UDBG_RTAS_CONSOLE is not set
 CONFIG_MPIC=y
 # CONFIG_PPC_RTAS is not set
 # CONFIG_MMIO_NVRAM is not set
@@ -154,6 +163,7 @@ # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
 CONFIG_BINFMT_ELF=y
 CONFIG_BINFMT_MISC=m
+CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
 # CONFIG_KEXEC is not set
 CONFIG_ARCH_FLATMEM_ENABLE=y
 CONFIG_SELECT_MEMORY_MODEL=y
@@ -164,6 +174,7 @@ CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_RESOURCES_64BIT is not set
 CONFIG_PROC_DEVICETREE=y
 # CONFIG_CMDLINE_BOOL is not set
 CONFIG_PM=y
@@ -182,6 +193,7 @@ # CONFIG_PPC_I8259 is not set
 CONFIG_PPC_INDIRECT_PCI=y
 CONFIG_PCI=y
 CONFIG_PCI_DOMAINS=y
+# CONFIG_PCIEPORTBUS is not set
 # CONFIG_PCI_DEBUG is not set
 
 #
@@ -256,6 +268,8 @@ CONFIG_INET_ESP=y
 # CONFIG_INET_IPCOMP is not set
 # CONFIG_INET_XFRM_TUNNEL is not set
 # CONFIG_INET_TUNNEL is not set
+# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
+# CONFIG_INET_XFRM_MODE_TUNNEL is not set
 CONFIG_INET_DIAG=y
 CONFIG_INET_TCP_DIAG=y
 # CONFIG_TCP_CONG_ADVANCED is not set
@@ -268,6 +282,7 @@ # CONFIG_IP_VS is not set
 # CONFIG_IPV6 is not set
 # CONFIG_INET6_XFRM_TUNNEL is not set
 # CONFIG_INET6_TUNNEL is not set
+# CONFIG_NETWORK_SECMARK is not set
 CONFIG_NETFILTER=y
 # CONFIG_NETFILTER_DEBUG is not set
 
@@ -292,9 +307,11 @@ CONFIG_NETFILTER_XT_MATCH_MARK=m
 CONFIG_NETFILTER_XT_MATCH_POLICY=m
 CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
 CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
+# CONFIG_NETFILTER_XT_MATCH_QUOTA is not set
 CONFIG_NETFILTER_XT_MATCH_REALM=m
 CONFIG_NETFILTER_XT_MATCH_SCTP=m
 CONFIG_NETFILTER_XT_MATCH_STATE=m
+# CONFIG_NETFILTER_XT_MATCH_STATISTIC is not set
 CONFIG_NETFILTER_XT_MATCH_STRING=m
 CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
 
@@ -313,6 +330,7 @@ CONFIG_IP_NF_TFTP=m
 CONFIG_IP_NF_AMANDA=m
 CONFIG_IP_NF_PPTP=m
 CONFIG_IP_NF_H323=m
+# CONFIG_IP_NF_SIP is not set
 # CONFIG_IP_NF_QUEUE is not set
 CONFIG_IP_NF_IPTABLES=m
 CONFIG_IP_NF_MATCH_IPRANGE=m
@@ -457,6 +475,7 @@ # CONFIG_SMC_IRCC_FIR is not set
 # CONFIG_ALI_FIR is not set
 # CONFIG_VLSI_FIR is not set
 # CONFIG_VIA_FIR is not set
+# CONFIG_MCS_FIR is not set
 CONFIG_BT=m
 CONFIG_BT_L2CAP=m
 CONFIG_BT_SCO=m
@@ -500,6 +519,7 @@ # CONFIG_STANDALONE is not set
 CONFIG_PREVENT_FIRMWARE_BUILD=y
 CONFIG_FW_LOADER=y
 # CONFIG_DEBUG_DRIVER is not set
+# CONFIG_SYS_HYPERVISOR is not set
 
 #
 # Connector - unified userspace <-> kernelspace linker
@@ -600,7 +620,6 @@ # CONFIG_BLK_DEV_VIA82CXXX is not set
 CONFIG_BLK_DEV_IDE_PMAC=y
 CONFIG_BLK_DEV_IDE_PMAC_ATA100FIRST=y
 CONFIG_BLK_DEV_IDEDMA_PMAC=y
-CONFIG_BLK_DEV_IDE_PMAC_BLINK=y
 # CONFIG_IDE_ARM is not set
 CONFIG_BLK_DEV_IDEDMA=y
 # CONFIG_IDEDMA_IVB is not set
@@ -661,6 +680,7 @@ # CONFIG_MEGARAID_NEWGEN is not set
 # CONFIG_MEGARAID_LEGACY is not set
 # CONFIG_MEGARAID_SAS is not set
 # CONFIG_SCSI_SATA is not set
+# CONFIG_SCSI_HPTIOP is not set
 # CONFIG_SCSI_BUSLOGIC is not set
 # CONFIG_SCSI_DMX3191D is not set
 # CONFIG_SCSI_EATA is not set
@@ -705,9 +725,7 @@ CONFIG_MD_LINEAR=m
 CONFIG_MD_RAID0=m
 CONFIG_MD_RAID1=m
 CONFIG_MD_RAID10=m
-CONFIG_MD_RAID5=m
-CONFIG_MD_RAID5_RESHAPE=y
-CONFIG_MD_RAID6=m
+# CONFIG_MD_RAID456 is not set
 CONFIG_MD_MULTIPATH=m
 CONFIG_MD_FAULTY=m
 CONFIG_BLK_DEV_DM=m
@@ -750,7 +768,6 @@ # Protocol Drivers
 #
 CONFIG_IEEE1394_VIDEO1394=m
 CONFIG_IEEE1394_SBP2=m
-# CONFIG_IEEE1394_SBP2_PHYS_DMA is not set
 # CONFIG_IEEE1394_ETH1394 is not set
 CONFIG_IEEE1394_DV1394=m
 CONFIG_IEEE1394_RAWIO=m
@@ -766,9 +783,12 @@ #
 CONFIG_ADB=y
 CONFIG_ADB_CUDA=y
 CONFIG_ADB_PMU=y
+CONFIG_ADB_PMU_LED=y
+CONFIG_ADB_PMU_LED_IDE=y
 CONFIG_PMAC_APM_EMU=m
 CONFIG_PMAC_MEDIABAY=y
 CONFIG_PMAC_BACKLIGHT=y
+CONFIG_PMAC_BACKLIGHT_LEGACY=y
 CONFIG_INPUT_ADBHID=y
 CONFIG_MAC_EMUMOUSEBTN=y
 CONFIG_THERM_WINDTUNNEL=m
@@ -858,6 +878,7 @@ #
 # CONFIG_CHELSIO_T1 is not set
 # CONFIG_IXGB is not set
 # CONFIG_S2IO is not set
+# CONFIG_MYRI10GE is not set
 
 #
 # Token Ring devices
@@ -908,6 +929,7 @@ #
 # Prism GT/Duette 802.11(a/b/g) PCI/Cardbus support
 #
 CONFIG_PRISM54=m
+# CONFIG_USB_ZD1201 is not set
 # CONFIG_HOSTAP is not set
 CONFIG_NET_WIRELESS=y
 
@@ -998,6 +1020,7 @@ #
 CONFIG_VT=y
 CONFIG_VT_CONSOLE=y
 CONFIG_HW_CONSOLE=y
+# CONFIG_VT_HW_CONSOLE_BINDING is not set
 # CONFIG_SERIAL_NONSTANDARD is not set
 
 #
@@ -1029,6 +1052,7 @@ #
 # Watchdog Cards
 #
 # CONFIG_WATCHDOG is not set
+# CONFIG_HW_RANDOM is not set
 CONFIG_NVRAM=y
 CONFIG_GEN_RTC=y
 # CONFIG_GEN_RTC_X is not set
@@ -1040,6 +1064,7 @@ #
 # Ftape, the floppy tape device driver
 #
 CONFIG_AGP=m
+# CONFIG_AGP_SIS is not set
 # CONFIG_AGP_VIA is not set
 CONFIG_AGP_UNINORTH=m
 CONFIG_DRM=m
@@ -1092,6 +1117,7 @@ # CONFIG_I2C_PIIX4 is not set
 CONFIG_I2C_POWERMAC=y
 # CONFIG_I2C_MPC is not set
 # CONFIG_I2C_NFORCE2 is not set
+# CONFIG_I2C_OCORES is not set
 # CONFIG_I2C_PARPORT_LIGHT is not set
 # CONFIG_I2C_PROSAVAGE is not set
 # CONFIG_I2C_SAVAGE4 is not set
@@ -1156,12 +1182,13 @@ # CONFIG_USB_DABUSB is not set
 #
 # Graphics support
 #
+# CONFIG_FIRMWARE_EDID is not set
 CONFIG_FB=y
 CONFIG_FB_CFB_FILLRECT=y
 CONFIG_FB_CFB_COPYAREA=y
 CONFIG_FB_CFB_IMAGEBLIT=y
 CONFIG_FB_MACMODES=y
-CONFIG_FB_FIRMWARE_EDID=y
+CONFIG_FB_BACKLIGHT=y
 CONFIG_FB_MODE_HELPERS=y
 CONFIG_FB_TILEBLITTING=y
 # CONFIG_FB_CIRRUS is not set
@@ -1178,6 +1205,7 @@ # CONFIG_FB_VGA16 is not set
 # CONFIG_FB_S1D13XXX is not set
 CONFIG_FB_NVIDIA=y
 CONFIG_FB_NVIDIA_I2C=y
+CONFIG_FB_NVIDIA_BACKLIGHT=y
 # CONFIG_FB_RIVA is not set
 CONFIG_FB_MATROX=y
 CONFIG_FB_MATROX_MILLENIUM=y
@@ -1187,12 +1215,15 @@ # CONFIG_FB_MATROX_I2C is not set
 # CONFIG_FB_MATROX_MULTIHEAD is not set
 CONFIG_FB_RADEON=y
 CONFIG_FB_RADEON_I2C=y
+CONFIG_FB_RADEON_BACKLIGHT=y
 # CONFIG_FB_RADEON_DEBUG is not set
 CONFIG_FB_ATY128=y
+CONFIG_FB_ATY128_BACKLIGHT=y
 CONFIG_FB_ATY=y
 CONFIG_FB_ATY_CT=y
 # CONFIG_FB_ATY_GENERIC_LCD is not set
 CONFIG_FB_ATY_GX=y
+CONFIG_FB_ATY_BACKLIGHT=y
 # CONFIG_FB_SAVAGE is not set
 # CONFIG_FB_SIS is not set
 # CONFIG_FB_NEOMAGIC is not set
@@ -1221,7 +1252,11 @@ CONFIG_LOGO=y
 CONFIG_LOGO_LINUX_MONO=y
 CONFIG_LOGO_LINUX_VGA16=y
 CONFIG_LOGO_LINUX_CLUT224=y
-# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
+CONFIG_BACKLIGHT_LCD_SUPPORT=y
+CONFIG_BACKLIGHT_CLASS_DEVICE=y
+CONFIG_BACKLIGHT_DEVICE=y
+CONFIG_LCD_CLASS_DEVICE=m
+CONFIG_LCD_DEVICE=y
 
 #
 # Sound
@@ -1278,6 +1313,18 @@ # CONFIG_SND_CA0106 is not set
 # CONFIG_SND_CMIPCI is not set
 # CONFIG_SND_CS4281 is not set
 # CONFIG_SND_CS46XX is not set
+# CONFIG_SND_DARLA20 is not set
+# CONFIG_SND_GINA20 is not set
+# CONFIG_SND_LAYLA20 is not set
+# CONFIG_SND_DARLA24 is not set
+# CONFIG_SND_GINA24 is not set
+# CONFIG_SND_LAYLA24 is not set
+# CONFIG_SND_MONA is not set
+# CONFIG_SND_MIA is not set
+# CONFIG_SND_ECHO3G is not set
+# CONFIG_SND_INDIGO is not set
+# CONFIG_SND_INDIGOIO is not set
+# CONFIG_SND_INDIGODJ is not set
 # CONFIG_SND_EMU10K1 is not set
 # CONFIG_SND_EMU10K1X is not set
 # CONFIG_SND_ENS1370 is not set
@@ -1315,6 +1362,17 @@ CONFIG_SND_POWERMAC=m
 CONFIG_SND_POWERMAC_AUTO_DRC=y
 
 #
+# Apple Onboard Audio driver
+#
+CONFIG_SND_AOA=m
+CONFIG_SND_AOA_FABRIC_LAYOUT=m
+CONFIG_SND_AOA_ONYX=m
+CONFIG_SND_AOA_TAS=m
+CONFIG_SND_AOA_TOONIE=m
+CONFIG_SND_AOA_SOUNDBUS=m
+CONFIG_SND_AOA_SOUNDBUS_I2S=m
+
+#
 # USB devices
 #
 CONFIG_SND_USB_AUDIO=m
@@ -1355,6 +1413,7 @@ #
 CONFIG_USB_EHCI_HCD=m
 CONFIG_USB_EHCI_SPLIT_ISO=y
 CONFIG_USB_EHCI_ROOT_HUB_TT=y
+# CONFIG_USB_EHCI_TT_NEWSCHED is not set
 # CONFIG_USB_ISP116X_HCD is not set
 CONFIG_USB_OHCI_HCD=y
 # CONFIG_USB_OHCI_BIG_ENDIAN is not set
@@ -1431,7 +1490,6 @@ # CONFIG_USB_NET_PLUSB is not set
 # CONFIG_USB_NET_RNDIS_HOST is not set
 # CONFIG_USB_NET_CDC_SUBSET is not set
 CONFIG_USB_NET_ZAURUS=m
-# CONFIG_USB_ZD1201 is not set
 CONFIG_USB_MON=y
 
 #
@@ -1499,10 +1557,12 @@ # CONFIG_USB_RIO500 is not set
 # CONFIG_USB_LEGOTOWER is not set
 # CONFIG_USB_LCD is not set
 # CONFIG_USB_LED is not set
+# CONFIG_USB_CY7C63 is not set
 # CONFIG_USB_CYTHERM is not set
 # CONFIG_USB_PHIDGETKIT is not set
 # CONFIG_USB_PHIDGETSERVO is not set
 # CONFIG_USB_IDMOUSE is not set
+CONFIG_USB_APPLEDISPLAY=m
 # CONFIG_USB_SISUSBVGA is not set
 # CONFIG_USB_LD is not set
 # CONFIG_USB_TEST is not set
@@ -1524,7 +1584,8 @@ # CONFIG_MMC is not set
 #
 # LED devices
 #
-# CONFIG_NEW_LEDS is not set
+CONFIG_NEW_LEDS=y
+CONFIG_LEDS_CLASS=y
 
 #
 # LED drivers
@@ -1533,6 +1594,10 @@ #
 #
 # LED Triggers
 #
+CONFIG_LEDS_TRIGGERS=y
+# CONFIG_LEDS_TRIGGER_TIMER is not set
+CONFIG_LEDS_TRIGGER_IDE_DISK=y
+# CONFIG_LEDS_TRIGGER_HEARTBEAT is not set
 
 #
 # InfiniBand support
@@ -1549,6 +1614,19 @@ #
 # CONFIG_RTC_CLASS is not set
 
 #
+# DMA Engine support
+#
+# CONFIG_DMA_ENGINE is not set
+
+#
+# DMA Clients
+#
+
+#
+# DMA Devices
+#
+
+#
 # File systems
 #
 CONFIG_EXT2_FS=y
@@ -1569,6 +1647,7 @@ # CONFIG_OCFS2_FS is not set
 # CONFIG_MINIX_FS is not set
 # CONFIG_ROMFS_FS is not set
 CONFIG_INOTIFY=y
+CONFIG_INOTIFY_USER=y
 # CONFIG_QUOTA is not set
 CONFIG_DNOTIFY=y
 # CONFIG_AUTOFS_FS is not set
@@ -1649,6 +1728,7 @@ # CONFIG_RPCSEC_GSS_SPKM3 is not set
 CONFIG_SMB_FS=m
 # CONFIG_SMB_NLS_DEFAULT is not set
 # CONFIG_CIFS is not set
+# CONFIG_CIFS_DEBUG2 is not set
 # CONFIG_NCP_FS is not set
 # CONFIG_CODA_FS is not set
 # CONFIG_AFS_FS is not set
@@ -1732,6 +1812,7 @@ CONFIG_TEXTSEARCH=y
 CONFIG_TEXTSEARCH_KMP=m
 CONFIG_TEXTSEARCH_BM=m
 CONFIG_TEXTSEARCH_FSM=m
+CONFIG_PLIST=y
 
 #
 # Instrumentation Support
@@ -1744,12 +1825,15 @@ # Kernel hacking
 #
 # CONFIG_PRINTK_TIME is not set
 # CONFIG_MAGIC_SYSRQ is not set
+# CONFIG_UNUSED_SYMBOLS is not set
 CONFIG_DEBUG_KERNEL=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_DETECT_SOFTLOCKUP=y
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_DEBUG_SLAB is not set
 # CONFIG_DEBUG_MUTEXES is not set
+# CONFIG_DEBUG_RT_MUTEXES is not set
+# CONFIG_RT_MUTEX_TESTER is not set
 # CONFIG_DEBUG_SPINLOCK is not set
 # CONFIG_DEBUG_SPINLOCK_SLEEP is not set
 # CONFIG_DEBUG_KOBJECT is not set
@@ -1763,11 +1847,7 @@ CONFIG_XMON=y
 CONFIG_XMON_DEFAULT=y
 # CONFIG_BDI_SWITCH is not set
 CONFIG_BOOTX_TEXT=y
-# CONFIG_PPC_EARLY_DEBUG_LPAR is not set
-# CONFIG_PPC_EARLY_DEBUG_G5 is not set
-# CONFIG_PPC_EARLY_DEBUG_RTAS is not set
-# CONFIG_PPC_EARLY_DEBUG_MAPLE is not set
-# CONFIG_PPC_EARLY_DEBUG_ISERIES is not set
+# CONFIG_PPC_EARLY_DEBUG is not set
 
 #
 # Security options
diff --git a/drivers/ide/Kconfig b/drivers/ide/Kconfig
index d1266fe..53bba41 100644
--- a/drivers/ide/Kconfig
+++ b/drivers/ide/Kconfig
@@ -773,20 +773,6 @@ config BLK_DEV_IDEDMA_PMAC
 	  to transfer data to and from memory.  Saying Y is safe and improves
 	  performance.
 
-config BLK_DEV_IDE_PMAC_BLINK
-	bool "Blink laptop LED on drive activity (DEPRECATED)"
-	depends on BLK_DEV_IDE_PMAC && ADB_PMU
-	select ADB_PMU_LED
-	select LEDS_TRIGGERS
-	select LEDS_TRIGGER_IDE_DISK
-	help
-	  This option enables the use of the sleep LED as a hard drive
-	  activity LED.
-	  This option is deprecated, it only selects ADB_PMU_LED and
-	  LEDS_TRIGGER_IDE_DISK and changes the code in the new led class
-	  device to default to the ide-disk trigger (which should be set
-	  from userspace via sysfs).
-
 config BLK_DEV_IDE_SWARM
 	tristate "IDE for Sibyte evaluation boards"
 	depends on SIBYTE_SB1xxx_SOC
diff --git a/drivers/macintosh/Kconfig b/drivers/macintosh/Kconfig
index 54f3f6b..dc60038 100644
--- a/drivers/macintosh/Kconfig
+++ b/drivers/macintosh/Kconfig
@@ -90,6 +90,15 @@ config ADB_PMU_LED
 	  and the ide-disk LED trigger and configure appropriately through
 	  sysfs.
 
+config ADB_PMU_LED_IDE
+	bool "Use front LED as IDE LED by default"
+	depends on ADB_PMU_LED
+	select LEDS_TRIGGERS
+	select LEDS_TRIGGER_IDE_DISK
+	help
+	  This option makes the front LED default to the IDE trigger
+	  so that it blinks on IDE activity.
+
 config PMAC_SMU
 	bool "Support for SMU  based PowerMacs"
 	depends on PPC_PMAC64
diff --git a/drivers/macintosh/via-pmu-led.c b/drivers/macintosh/via-pmu-led.c
index af8375e..5189d54 100644
--- a/drivers/macintosh/via-pmu-led.c
+++ b/drivers/macintosh/via-pmu-led.c
@@ -74,7 +74,7 @@ static void pmu_led_set(struct led_class
 
 static struct led_classdev pmu_led = {
 	.name = "pmu-front-led",
-#ifdef CONFIG_BLK_DEV_IDE_PMAC_BLINK
+#ifdef CONFIG_ADB_PMU_LED_IDE
 	.default_trigger = "ide-disk",
 #endif
 	.brightness_set = pmu_led_set,


