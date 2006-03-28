Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751354AbWC1Fuv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751354AbWC1Fuv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 00:50:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751355AbWC1Fuu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 00:50:50 -0500
Received: from gate.crashing.org ([63.228.1.57]:46495 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751354AbWC1Fuu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 00:50:50 -0500
Date: Mon, 27 Mar 2006 23:49:55 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
X-X-Sender: galak@gate.crashing.org
To: Paul Mackerras <paulus@samba.org>
cc: linuxppc-dev@ozlabs.org, <linux-kernel@vger.kernel.org>
Subject: Please pull from '85xx' branch of powerpc
Message-ID: <Pine.LNX.4.44.0603272349001.3955-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull from '85xx' branch of
master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git

to receive the following updates:

 arch/powerpc/Kconfig.debug                 |    5 ---
 arch/powerpc/Makefile                      |    6 ----
 arch/powerpc/configs/mpc8540_ads_defconfig |   43 ++++++++++++++++-------------
 arch/powerpc/kernel/setup_32.c             |    6 ----
 arch/powerpc/platforms/85xx/Kconfig        |    1 
 arch/ppc/Makefile                          |    2 -
 6 files changed, 28 insertions(+), 35 deletions(-)

Kumar Gala:
      powerpc: move math-emu over to arch/powerpc
      powerpc: Make uImage default build output for MPC8540 ADS
      powerpc: remove OCP references

diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
index 9254806..8d48e9e 100644
--- a/arch/powerpc/Kconfig.debug
+++ b/arch/powerpc/Kconfig.debug
@@ -110,11 +110,6 @@ config SERIAL_TEXT_DEBUG
 	depends on 4xx || LOPEC || MV64X60 || PPLUS || PRPMC800 || \
 		PPC_GEN550 || PPC_MPC52xx
 
-config PPC_OCP
-	bool
-	depends on IBM_OCP || XILINX_OCP
-	default y
-
 choice
 	prompt "Early debugging (dangerous)"
 	bool
diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 9586899..6ec84d3 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -129,12 +129,8 @@ core-y				+= arch/powerpc/kernel/ \
 				   arch/powerpc/lib/ \
 				   arch/powerpc/sysdev/ \
 				   arch/powerpc/platforms/
-core-$(CONFIG_MATH_EMULATION)	+= arch/ppc/math-emu/
+core-$(CONFIG_MATH_EMULATION)	+= arch/powerpc/math-emu/
 core-$(CONFIG_XMON)		+= arch/powerpc/xmon/
-core-$(CONFIG_APUS)		+= arch/ppc/amiga/
-drivers-$(CONFIG_8xx)		+= arch/ppc/8xx_io/
-drivers-$(CONFIG_4xx)		+= arch/ppc/4xx_io/
-drivers-$(CONFIG_CPM2)		+= arch/ppc/8260_io/
 
 drivers-$(CONFIG_OPROFILE)	+= arch/powerpc/oprofile/
 
diff --git a/arch/powerpc/configs/mpc8540_ads_defconfig b/arch/powerpc/configs/mpc8540_ads_defconfig
index 2a8290e..7f0780f 100644
--- a/arch/powerpc/configs/mpc8540_ads_defconfig
+++ b/arch/powerpc/configs/mpc8540_ads_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 
-# Sat Jan 14 15:57:54 2006
+# Linux kernel version: 2.6.16
+# Mon Mar 27 23:37:36 2006
 #
 # CONFIG_PPC64 is not set
 CONFIG_PPC32=y
@@ -9,6 +9,7 @@ CONFIG_PPC_MERGE=y
 CONFIG_MMU=y
 CONFIG_GENERIC_HARDIRQS=y
 CONFIG_RWSEM_XCHGADD_ALGORITHM=y
+CONFIG_GENERIC_HWEIGHT=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
 CONFIG_PPC=y
 CONFIG_EARLY_PRINTK=y
@@ -18,6 +19,7 @@ CONFIG_ARCH_MAY_HAVE_PC_FDC=y
 CONFIG_PPC_OF=y
 CONFIG_PPC_UDBG_16550=y
 # CONFIG_GENERIC_TBSYNC is not set
+CONFIG_DEFAULT_UIMAGE=y
 
 #
 # Processor support
@@ -42,7 +44,6 @@ CONFIG_SPE=y
 # Code maturity level options
 #
 CONFIG_EXPERIMENTAL=y
-CONFIG_CLEAN_COMPILE=y
 CONFIG_BROKEN_ON_SMP=y
 CONFIG_INIT_ENV_ARG_LIMIT=32
 
@@ -58,6 +59,7 @@ CONFIG_SYSVIPC=y
 CONFIG_SYSCTL=y
 # CONFIG_AUDIT is not set
 # CONFIG_IKCONFIG is not set
+# CONFIG_RELAY is not set
 CONFIG_INITRAMFS_SOURCE=""
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_EMBEDDED=y
@@ -72,10 +74,6 @@ CONFIG_BASE_FULL=y
 CONFIG_FUTEX=y
 CONFIG_EPOLL=y
 CONFIG_SHMEM=y
-CONFIG_CC_ALIGN_FUNCTIONS=0
-CONFIG_CC_ALIGN_LABELS=0
-CONFIG_CC_ALIGN_LOOPS=0
-CONFIG_CC_ALIGN_JUMPS=0
 CONFIG_SLAB=y
 # CONFIG_TINY_SHMEM is not set
 CONFIG_BASE_SMALL=0
@@ -90,6 +88,8 @@ CONFIG_BASE_SMALL=0
 # Block layer
 #
 # CONFIG_LBD is not set
+# CONFIG_BLK_DEV_IO_TRACE is not set
+# CONFIG_LSF is not set
 
 #
 # IO Schedulers
@@ -183,6 +183,7 @@ CONFIG_NET=y
 #
 # Networking options
 #
+# CONFIG_NETDEBUG is not set
 CONFIG_PACKET=y
 # CONFIG_PACKET_MMAP is not set
 CONFIG_UNIX=y
@@ -220,6 +221,11 @@ CONFIG_TCP_CONG_BIC=y
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
@@ -229,11 +235,6 @@ CONFIG_TCP_CONG_BIC=y
 # CONFIG_ATALK is not set
 # CONFIG_X25 is not set
 # CONFIG_LAPB is not set
-
-#
-# TIPC Configuration (EXPERIMENTAL)
-#
-# CONFIG_TIPC is not set
 # CONFIG_NET_DIVERT is not set
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
@@ -487,6 +488,12 @@ CONFIG_GEN_RTC=y
 # CONFIG_I2C is not set
 
 #
+# SPI support
+#
+# CONFIG_SPI is not set
+# CONFIG_SPI_MASTER is not set
+
+#
 # Dallas's 1-wire bus
 #
 # CONFIG_W1 is not set
@@ -496,6 +503,7 @@ CONFIG_GEN_RTC=y
 #
 CONFIG_HWMON=y
 # CONFIG_HWMON_VID is not set
+# CONFIG_SENSORS_F71805F is not set
 # CONFIG_HWMON_DEBUG_CHIP is not set
 
 #
@@ -503,10 +511,6 @@ CONFIG_HWMON=y
 #
 
 #
-# Multimedia Capabilities Port drivers
-#
-
-#
 # Multimedia devices
 #
 # CONFIG_VIDEO_DEV is not set
@@ -531,6 +535,7 @@ CONFIG_HWMON=y
 #
 # CONFIG_USB_ARCH_HAS_HCD is not set
 # CONFIG_USB_ARCH_HAS_OHCI is not set
+# CONFIG_USB_ARCH_HAS_EHCI is not set
 
 #
 # NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
@@ -551,7 +556,7 @@ CONFIG_HWMON=y
 #
 
 #
-# SN Devices
+# EDAC - error detection and reporting (RAS) (EXPERIMENTAL)
 #
 
 #
@@ -603,7 +608,6 @@ CONFIG_SYSFS=y
 CONFIG_TMPFS=y
 # CONFIG_HUGETLB_PAGE is not set
 CONFIG_RAMFS=y
-# CONFIG_RELAYFS_FS is not set
 # CONFIG_CONFIGFS_FS is not set
 
 #
@@ -658,6 +662,7 @@ CONFIG_PARTITION_ADVANCED=y
 # CONFIG_SGI_PARTITION is not set
 # CONFIG_ULTRIX_PARTITION is not set
 # CONFIG_SUN_PARTITION is not set
+# CONFIG_KARMA_PARTITION is not set
 # CONFIG_EFI_PARTITION is not set
 
 #
@@ -695,6 +700,8 @@ CONFIG_DEBUG_MUTEXES=y
 # CONFIG_DEBUG_INFO is not set
 # CONFIG_DEBUG_FS is not set
 # CONFIG_DEBUG_VM is not set
+# CONFIG_UNWIND_INFO is not set
+CONFIG_FORCED_INLINING=y
 # CONFIG_RCU_TORTURE_TEST is not set
 # CONFIG_DEBUGGER is not set
 # CONFIG_BDI_SWITCH is not set
diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index e39f830..a2c8943 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -351,12 +351,6 @@ void __init setup_arch(char **cmdline_p)
 	do_init_bootmem();
 	if ( ppc_md.progress ) ppc_md.progress("setup_arch: bootmem", 0x3eab);
 
-#ifdef CONFIG_PPC_OCP
-	/* Initialize OCP device list */
-	ocp_early_init();
-	if ( ppc_md.progress ) ppc_md.progress("ocp: exit", 0x3eab);
-#endif
-
 #ifdef CONFIG_DUMMY_CONSOLE
 	conswitchp = &dummy_con;
 #endif
diff --git a/arch/ppc/math-emu/Makefile b/arch/powerpc/math-emu/Makefile
similarity index 100%
rename from arch/ppc/math-emu/Makefile
rename to arch/powerpc/math-emu/Makefile
diff --git a/arch/ppc/math-emu/double.h b/arch/powerpc/math-emu/double.h
similarity index 100%
rename from arch/ppc/math-emu/double.h
rename to arch/powerpc/math-emu/double.h
diff --git a/arch/ppc/math-emu/fabs.c b/arch/powerpc/math-emu/fabs.c
similarity index 100%
rename from arch/ppc/math-emu/fabs.c
rename to arch/powerpc/math-emu/fabs.c
diff --git a/arch/ppc/math-emu/fadd.c b/arch/powerpc/math-emu/fadd.c
similarity index 100%
rename from arch/ppc/math-emu/fadd.c
rename to arch/powerpc/math-emu/fadd.c
diff --git a/arch/ppc/math-emu/fadds.c b/arch/powerpc/math-emu/fadds.c
similarity index 100%
rename from arch/ppc/math-emu/fadds.c
rename to arch/powerpc/math-emu/fadds.c
diff --git a/arch/ppc/math-emu/fcmpo.c b/arch/powerpc/math-emu/fcmpo.c
similarity index 100%
rename from arch/ppc/math-emu/fcmpo.c
rename to arch/powerpc/math-emu/fcmpo.c
diff --git a/arch/ppc/math-emu/fcmpu.c b/arch/powerpc/math-emu/fcmpu.c
similarity index 100%
rename from arch/ppc/math-emu/fcmpu.c
rename to arch/powerpc/math-emu/fcmpu.c
diff --git a/arch/ppc/math-emu/fctiw.c b/arch/powerpc/math-emu/fctiw.c
similarity index 100%
rename from arch/ppc/math-emu/fctiw.c
rename to arch/powerpc/math-emu/fctiw.c
diff --git a/arch/ppc/math-emu/fctiwz.c b/arch/powerpc/math-emu/fctiwz.c
similarity index 100%
rename from arch/ppc/math-emu/fctiwz.c
rename to arch/powerpc/math-emu/fctiwz.c
diff --git a/arch/ppc/math-emu/fdiv.c b/arch/powerpc/math-emu/fdiv.c
similarity index 100%
rename from arch/ppc/math-emu/fdiv.c
rename to arch/powerpc/math-emu/fdiv.c
diff --git a/arch/ppc/math-emu/fdivs.c b/arch/powerpc/math-emu/fdivs.c
similarity index 100%
rename from arch/ppc/math-emu/fdivs.c
rename to arch/powerpc/math-emu/fdivs.c
diff --git a/arch/ppc/math-emu/fmadd.c b/arch/powerpc/math-emu/fmadd.c
similarity index 100%
rename from arch/ppc/math-emu/fmadd.c
rename to arch/powerpc/math-emu/fmadd.c
diff --git a/arch/ppc/math-emu/fmadds.c b/arch/powerpc/math-emu/fmadds.c
similarity index 100%
rename from arch/ppc/math-emu/fmadds.c
rename to arch/powerpc/math-emu/fmadds.c
diff --git a/arch/ppc/math-emu/fmr.c b/arch/powerpc/math-emu/fmr.c
similarity index 100%
rename from arch/ppc/math-emu/fmr.c
rename to arch/powerpc/math-emu/fmr.c
diff --git a/arch/ppc/math-emu/fmsub.c b/arch/powerpc/math-emu/fmsub.c
similarity index 100%
rename from arch/ppc/math-emu/fmsub.c
rename to arch/powerpc/math-emu/fmsub.c
diff --git a/arch/ppc/math-emu/fmsubs.c b/arch/powerpc/math-emu/fmsubs.c
similarity index 100%
rename from arch/ppc/math-emu/fmsubs.c
rename to arch/powerpc/math-emu/fmsubs.c
diff --git a/arch/ppc/math-emu/fmul.c b/arch/powerpc/math-emu/fmul.c
similarity index 100%
rename from arch/ppc/math-emu/fmul.c
rename to arch/powerpc/math-emu/fmul.c
diff --git a/arch/ppc/math-emu/fmuls.c b/arch/powerpc/math-emu/fmuls.c
similarity index 100%
rename from arch/ppc/math-emu/fmuls.c
rename to arch/powerpc/math-emu/fmuls.c
diff --git a/arch/ppc/math-emu/fnabs.c b/arch/powerpc/math-emu/fnabs.c
similarity index 100%
rename from arch/ppc/math-emu/fnabs.c
rename to arch/powerpc/math-emu/fnabs.c
diff --git a/arch/ppc/math-emu/fneg.c b/arch/powerpc/math-emu/fneg.c
similarity index 100%
rename from arch/ppc/math-emu/fneg.c
rename to arch/powerpc/math-emu/fneg.c
diff --git a/arch/ppc/math-emu/fnmadd.c b/arch/powerpc/math-emu/fnmadd.c
similarity index 100%
rename from arch/ppc/math-emu/fnmadd.c
rename to arch/powerpc/math-emu/fnmadd.c
diff --git a/arch/ppc/math-emu/fnmadds.c b/arch/powerpc/math-emu/fnmadds.c
similarity index 100%
rename from arch/ppc/math-emu/fnmadds.c
rename to arch/powerpc/math-emu/fnmadds.c
diff --git a/arch/ppc/math-emu/fnmsub.c b/arch/powerpc/math-emu/fnmsub.c
similarity index 100%
rename from arch/ppc/math-emu/fnmsub.c
rename to arch/powerpc/math-emu/fnmsub.c
diff --git a/arch/ppc/math-emu/fnmsubs.c b/arch/powerpc/math-emu/fnmsubs.c
similarity index 100%
rename from arch/ppc/math-emu/fnmsubs.c
rename to arch/powerpc/math-emu/fnmsubs.c
diff --git a/arch/ppc/math-emu/fres.c b/arch/powerpc/math-emu/fres.c
similarity index 100%
rename from arch/ppc/math-emu/fres.c
rename to arch/powerpc/math-emu/fres.c
diff --git a/arch/ppc/math-emu/frsp.c b/arch/powerpc/math-emu/frsp.c
similarity index 100%
rename from arch/ppc/math-emu/frsp.c
rename to arch/powerpc/math-emu/frsp.c
diff --git a/arch/ppc/math-emu/frsqrte.c b/arch/powerpc/math-emu/frsqrte.c
similarity index 100%
rename from arch/ppc/math-emu/frsqrte.c
rename to arch/powerpc/math-emu/frsqrte.c
diff --git a/arch/ppc/math-emu/fsel.c b/arch/powerpc/math-emu/fsel.c
similarity index 100%
rename from arch/ppc/math-emu/fsel.c
rename to arch/powerpc/math-emu/fsel.c
diff --git a/arch/ppc/math-emu/fsqrt.c b/arch/powerpc/math-emu/fsqrt.c
similarity index 100%
rename from arch/ppc/math-emu/fsqrt.c
rename to arch/powerpc/math-emu/fsqrt.c
diff --git a/arch/ppc/math-emu/fsqrts.c b/arch/powerpc/math-emu/fsqrts.c
similarity index 100%
rename from arch/ppc/math-emu/fsqrts.c
rename to arch/powerpc/math-emu/fsqrts.c
diff --git a/arch/ppc/math-emu/fsub.c b/arch/powerpc/math-emu/fsub.c
similarity index 100%
rename from arch/ppc/math-emu/fsub.c
rename to arch/powerpc/math-emu/fsub.c
diff --git a/arch/ppc/math-emu/fsubs.c b/arch/powerpc/math-emu/fsubs.c
similarity index 100%
rename from arch/ppc/math-emu/fsubs.c
rename to arch/powerpc/math-emu/fsubs.c
diff --git a/arch/ppc/math-emu/lfd.c b/arch/powerpc/math-emu/lfd.c
similarity index 100%
rename from arch/ppc/math-emu/lfd.c
rename to arch/powerpc/math-emu/lfd.c
diff --git a/arch/ppc/math-emu/lfs.c b/arch/powerpc/math-emu/lfs.c
similarity index 100%
rename from arch/ppc/math-emu/lfs.c
rename to arch/powerpc/math-emu/lfs.c
diff --git a/arch/ppc/math-emu/math.c b/arch/powerpc/math-emu/math.c
similarity index 100%
rename from arch/ppc/math-emu/math.c
rename to arch/powerpc/math-emu/math.c
diff --git a/arch/ppc/math-emu/mcrfs.c b/arch/powerpc/math-emu/mcrfs.c
similarity index 100%
rename from arch/ppc/math-emu/mcrfs.c
rename to arch/powerpc/math-emu/mcrfs.c
diff --git a/arch/ppc/math-emu/mffs.c b/arch/powerpc/math-emu/mffs.c
similarity index 100%
rename from arch/ppc/math-emu/mffs.c
rename to arch/powerpc/math-emu/mffs.c
diff --git a/arch/ppc/math-emu/mtfsb0.c b/arch/powerpc/math-emu/mtfsb0.c
similarity index 100%
rename from arch/ppc/math-emu/mtfsb0.c
rename to arch/powerpc/math-emu/mtfsb0.c
diff --git a/arch/ppc/math-emu/mtfsb1.c b/arch/powerpc/math-emu/mtfsb1.c
similarity index 100%
rename from arch/ppc/math-emu/mtfsb1.c
rename to arch/powerpc/math-emu/mtfsb1.c
diff --git a/arch/ppc/math-emu/mtfsf.c b/arch/powerpc/math-emu/mtfsf.c
similarity index 100%
rename from arch/ppc/math-emu/mtfsf.c
rename to arch/powerpc/math-emu/mtfsf.c
diff --git a/arch/ppc/math-emu/mtfsfi.c b/arch/powerpc/math-emu/mtfsfi.c
similarity index 100%
rename from arch/ppc/math-emu/mtfsfi.c
rename to arch/powerpc/math-emu/mtfsfi.c
diff --git a/arch/ppc/math-emu/op-1.h b/arch/powerpc/math-emu/op-1.h
similarity index 100%
rename from arch/ppc/math-emu/op-1.h
rename to arch/powerpc/math-emu/op-1.h
diff --git a/arch/ppc/math-emu/op-2.h b/arch/powerpc/math-emu/op-2.h
similarity index 100%
rename from arch/ppc/math-emu/op-2.h
rename to arch/powerpc/math-emu/op-2.h
diff --git a/arch/ppc/math-emu/op-4.h b/arch/powerpc/math-emu/op-4.h
similarity index 100%
rename from arch/ppc/math-emu/op-4.h
rename to arch/powerpc/math-emu/op-4.h
diff --git a/arch/ppc/math-emu/op-common.h b/arch/powerpc/math-emu/op-common.h
similarity index 100%
rename from arch/ppc/math-emu/op-common.h
rename to arch/powerpc/math-emu/op-common.h
diff --git a/arch/ppc/math-emu/sfp-machine.h b/arch/powerpc/math-emu/sfp-machine.h
similarity index 100%
rename from arch/ppc/math-emu/sfp-machine.h
rename to arch/powerpc/math-emu/sfp-machine.h
diff --git a/arch/ppc/math-emu/single.h b/arch/powerpc/math-emu/single.h
similarity index 100%
rename from arch/ppc/math-emu/single.h
rename to arch/powerpc/math-emu/single.h
diff --git a/arch/ppc/math-emu/soft-fp.h b/arch/powerpc/math-emu/soft-fp.h
similarity index 100%
rename from arch/ppc/math-emu/soft-fp.h
rename to arch/powerpc/math-emu/soft-fp.h
diff --git a/arch/ppc/math-emu/stfd.c b/arch/powerpc/math-emu/stfd.c
similarity index 100%
rename from arch/ppc/math-emu/stfd.c
rename to arch/powerpc/math-emu/stfd.c
diff --git a/arch/ppc/math-emu/stfiwx.c b/arch/powerpc/math-emu/stfiwx.c
similarity index 100%
rename from arch/ppc/math-emu/stfiwx.c
rename to arch/powerpc/math-emu/stfiwx.c
diff --git a/arch/ppc/math-emu/stfs.c b/arch/powerpc/math-emu/stfs.c
similarity index 100%
rename from arch/ppc/math-emu/stfs.c
rename to arch/powerpc/math-emu/stfs.c
diff --git a/arch/ppc/math-emu/types.c b/arch/powerpc/math-emu/types.c
similarity index 100%
rename from arch/ppc/math-emu/types.c
rename to arch/powerpc/math-emu/types.c
diff --git a/arch/ppc/math-emu/udivmodti4.c b/arch/powerpc/math-emu/udivmodti4.c
similarity index 100%
rename from arch/ppc/math-emu/udivmodti4.c
rename to arch/powerpc/math-emu/udivmodti4.c
diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index d3d0ff7..06e3712 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -7,6 +7,7 @@ choice
 
 config MPC8540_ADS
 	bool "Freescale MPC8540 ADS"
+	select DEFAULT_UIMAGE
 	help
 	  This option enables support for the MPC 8540 ADS board
 
diff --git a/arch/ppc/Makefile b/arch/ppc/Makefile
index cde5fa8..87bd063 100644
--- a/arch/ppc/Makefile
+++ b/arch/ppc/Makefile
@@ -69,7 +69,7 @@ core-y				+= arch/ppc/kernel/ arch/power
 core-$(CONFIG_4xx)		+= arch/ppc/platforms/4xx/
 core-$(CONFIG_83xx)		+= arch/ppc/platforms/83xx/
 core-$(CONFIG_85xx)		+= arch/ppc/platforms/85xx/
-core-$(CONFIG_MATH_EMULATION)	+= arch/ppc/math-emu/
+core-$(CONFIG_MATH_EMULATION)	+= arch/powerpc/math-emu/
 core-$(CONFIG_XMON)		+= arch/ppc/xmon/
 core-$(CONFIG_APUS)		+= arch/ppc/amiga/
 drivers-$(CONFIG_8xx)		+= arch/ppc/8xx_io/


