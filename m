Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261891AbSJDOrX>; Fri, 4 Oct 2002 10:47:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261893AbSJDOqy>; Fri, 4 Oct 2002 10:46:54 -0400
Received: from d06lmsgate-4.uk.ibm.com ([195.212.29.4]:27852 "EHLO
	d06lmsgate-4.uk.ibm.COM") by vger.kernel.org with ESMTP
	id <S261863AbSJDOhi> convert rfc822-to-8bit; Fri, 4 Oct 2002 10:37:38 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] 2.5.40 s390 (6/27): config.
Date: Fri, 4 Oct 2002 16:38:37 +0200
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200210041626.55805.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove some configuration options that don't really make sense.

diff -urN linux-2.5.40/Documentation/s390/CommonIO linux-2.5.40-s390/Documentation/s390/CommonIO
--- linux-2.5.40/Documentation/s390/CommonIO	Tue Oct  1 09:07:40 2002
+++ linux-2.5.40-s390/Documentation/s390/CommonIO	Fri Oct  4 16:15:05 2002
@@ -123,9 +123,6 @@
 
 * /proc/chpids
 
-  This entry will only show up if you specified CONFIG_CHSC=y during kernel
-  config.
-
   This entry serves a dual purpose:
  
   - show which chpids are currently known to Linux and their status (online,
diff -urN linux-2.5.40/arch/s390/Config.help linux-2.5.40-s390/arch/s390/Config.help
--- linux-2.5.40/arch/s390/Config.help	Tue Oct  1 09:07:31 2002
+++ linux-2.5.40-s390/arch/s390/Config.help	Fri Oct  4 16:15:05 2002
@@ -160,25 +160,11 @@
   Select "vm_reader" if you are running under VM/ESA and want
   to IPL the image from the emulated card reader.
 
-CONFIG_FAST_IRQ
-  Select this option in order to get the interrupts processed faster
-  on your S/390 or zSeries machine.  If selected, after an interrupt
-  is processed, the channel subsystem will be asked for other pending
-  interrupts which will also be processed before leaving the interrupt
-  context.  This speeds up the I/O a lot. Say "Y".
-
 CONFIG_MACHCHK_WARNING
   Select this option if you want the machine check handler on IBM S/390 or 
   zSeries to process warning machine checks (e.g. on power failures). 
   If unsure, say "Y".
 
-CONFIG_CHSC
-  Select this option if you want the s390 common I/O layer to use information
-  obtained by channel subsystem calls. This will enable Linux to process link
-  failures and resource accessibility events. Moreover, if you have procfs
-  enabled, you'll be able to toggle chpids logically offline and online. Even
-  if you don't understand what this means, you should say "Y".
-
 CONFIG_PROCESS_DEBUG
   Say Y to print all process fault locations to the console.  This is
   a debugging option; you probably do not want to set it unless you
diff -urN linux-2.5.40/arch/s390/config.in linux-2.5.40-s390/arch/s390/config.in
--- linux-2.5.40/arch/s390/config.in	Tue Oct  1 09:07:35 2002
+++ linux-2.5.40-s390/arch/s390/config.in	Fri Oct  4 16:15:05 2002
@@ -17,22 +17,19 @@
 source init/Config.in
 
 mainmenu_option next_comment
+comment 'Base setup'
 comment 'Processor type and features'
 bool 'Symmetric multi-processing support' CONFIG_SMP
 bool 'IEEE FPU emulation' CONFIG_MATHEMU
-endmenu
 
-mainmenu_option next_comment
-comment 'Base setup'
-bool 'Fast IRQ handling' CONFIG_FAST_IRQ
+comment 'I/O subsystem configuration'
 bool 'Process warning machine checks' CONFIG_MACHCHK_WARNING
-bool 'Use chscs for Common I/O' CONFIG_CHSC
-
 tristate 'QDIO support' CONFIG_QDIO
-  if [ "$CONFIG_QDIO" != "n" ]; then
-    bool '   Performance statistics in /proc' CONFIG_QDIO_PERF_STATS
-  fi
+if [ "$CONFIG_QDIO" != "n" ]; then
+  bool '   Performance statistics in /proc' CONFIG_QDIO_PERF_STATS
+fi
 
+comment 'Misc'
 bool 'Builtin IPL record support' CONFIG_IPL
 if [ "$CONFIG_IPL" = "y" ]; then
   choice 'IPL method generated into head.S' \
@@ -68,7 +65,6 @@
 mainmenu_option next_comment
 comment 'Kernel hacking'
 
-#bool 'Debug kmalloc/kfree' CONFIG_DEBUG_MALLOC
 #if [ "$CONFIG_CTC" = "y" ]; then
 #  bool 'Remote GDB kernel debugging' CONFIG_REMOTE_DEBUG
 #fi
diff -urN linux-2.5.40/arch/s390/defconfig linux-2.5.40-s390/arch/s390/defconfig
--- linux-2.5.40/arch/s390/defconfig	Tue Oct  1 09:07:35 2002
+++ linux-2.5.40-s390/arch/s390/defconfig	Fri Oct  4 16:15:05 2002
@@ -31,19 +31,25 @@
 CONFIG_KMOD=y
 
 #
+# Base setup
+#
+
+#
 # Processor type and features
 #
 CONFIG_SMP=y
 CONFIG_MATHEMU=y
 
 #
-# Base setup
+# I/O subsystem configuration
 #
-CONFIG_FAST_IRQ=y
 CONFIG_MACHCHK_WARNING=y
-CONFIG_CHSC=y
 CONFIG_QDIO=m
 # CONFIG_QDIO_PERF_STATS is not set
+
+#
+# Misc
+#
 CONFIG_IPL=y
 # CONFIG_IPL_TAPE is not set
 CONFIG_IPL_VM=y
@@ -84,9 +90,6 @@
 #
 # CONFIG_SCSI_7000FASST is not set
 # CONFIG_SCSI_ACARD is not set
-# CONFIG_SCSI_AHA152X is not set
-# CONFIG_SCSI_AHA1542 is not set
-# CONFIG_SCSI_AHA1740 is not set
 # CONFIG_SCSI_AIC7XXX is not set
 # CONFIG_SCSI_AIC7XXX_OLD is not set
 # CONFIG_SCSI_DPT_I2O is not set
@@ -114,7 +117,6 @@
 # CONFIG_SCSI_PCI2220I is not set
 # CONFIG_SCSI_PSI240I is not set
 # CONFIG_SCSI_QLOGIC_FAS is not set
-# CONFIG_SCSI_SIM710 is not set
 # CONFIG_SCSI_SYM53C416 is not set
 # CONFIG_SCSI_T128 is not set
 # CONFIG_SCSI_U14_34F is not set
@@ -153,7 +155,7 @@
 CONFIG_MD_RAID1=m
 CONFIG_MD_RAID5=m
 # CONFIG_MD_MULTIPATH is not set
-CONFIG_BLK_DEV_LVM=m
+# CONFIG_BLK_DEV_LVM is not set
 
 #
 # Character device drivers
@@ -226,25 +228,22 @@
 # CONFIG_INET_ECN is not set
 # CONFIG_SYN_COOKIES is not set
 CONFIG_IPV6=m
-# CONFIG_KHTTPD is not set
-# CONFIG_ATM is not set
-# CONFIG_VLAN_8021Q is not set
 
 #
-#  
+#    SCTP Configuration (EXPERIMENTAL)
 #
+CONFIG_IPV6_SCTP__=m
+# CONFIG_IP_SCTP is not set
+# CONFIG_ATM is not set
+# CONFIG_VLAN_8021Q is not set
+# CONFIG_LLC is not set
 # CONFIG_IPX is not set
 # CONFIG_ATALK is not set
-
-#
-# Appletalk devices
-#
 # CONFIG_DEV_APPLETALK is not set
 # CONFIG_DECNET is not set
 # CONFIG_BRIDGE is not set
 # CONFIG_X25 is not set
 # CONFIG_LAPB is not set
-# CONFIG_LLC is not set
 # CONFIG_NET_DIVERT is not set
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
@@ -299,7 +298,7 @@
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 CONFIG_DEVFS_FS=y
-CONFIG_DEVFS_MOUNT=y
+# CONFIG_DEVFS_MOUNT is not set
 # CONFIG_DEVFS_DEBUG is not set
 # CONFIG_DEVPTS_FS is not set
 # CONFIG_QNX4FS_FS is not set
@@ -311,6 +310,9 @@
 # CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
+# CONFIG_XFS_FS is not set
+# CONFIG_XFS_RT is not set
+# CONFIG_XFS_QUOTA is not set
 
 #
 # Network File Systems
@@ -363,6 +365,11 @@
 CONFIG_MAGIC_SYSRQ=y
 
 #
+# Security options
+#
+CONFIG_SECURITY_CAPABILITIES=y
+
+#
 # Library routines
 #
 # CONFIG_CRC32 is not set
diff -urN linux-2.5.40/arch/s390x/Config.help linux-2.5.40-s390/arch/s390x/Config.help
--- linux-2.5.40/arch/s390x/Config.help	Tue Oct  1 09:06:17 2002
+++ linux-2.5.40-s390/arch/s390x/Config.help	Fri Oct  4 16:15:05 2002
@@ -159,25 +159,11 @@
   Select "vm_reader" if you are running under VM/ESA and want
   to IPL the image from the emulated card reader.
 
-CONFIG_FAST_IRQ
-  Select this option in order to get the interrupts processed faster
-  on your S/390 or zSeries machine.  If selected, after an interrupt
-  is processed, the channel subsystem will be asked for other pending
-  interrupts which will also be processed before leaving the interrupt
-  context.  This speeds up the I/O a lot. Say "Y".
-
 CONFIG_MACHCHK_WARNING
   Select this option if you want the machine check handler on IBM S/390 or
   zSeries to process warning machine checks (e.g. on power failures). 
   If unsure, say "Y".
 
-CONFIG_CHSC
-  Select this option if you want the s390 common I/O layer to use information
-  obtained by channel subsystem calls. This will enable Linux to process link
-  failures and resource accessibility events. Moreover, if you have procfs
-  enabled, you'll be able to toggle chpids logically offline and online. Even
-  if you don't understand what this means, you should say "Y".
-
 CONFIG_S390_SUPPORT
   Select this option if you want to enable your system kernel to
   handle system-calls from ELF binaries for 31 bit ESA.  This option
diff -urN linux-2.5.40/arch/s390x/Makefile linux-2.5.40-s390/arch/s390x/Makefile
--- linux-2.5.40/arch/s390x/Makefile	Tue Oct  1 09:07:01 2002
+++ linux-2.5.40-s390/arch/s390x/Makefile	Fri Oct  4 16:15:05 2002
@@ -26,7 +26,7 @@
 
 core-y		+= arch/s390x/mm/ arch/s390x/kernel/
 drivers-y	+= drivers/s390/
-libs-y		+= arch/s390/lib/
+libs-y		+= arch/s390x/lib/
 
 all: image listing
 
diff -urN linux-2.5.40/arch/s390x/config.in linux-2.5.40-s390/arch/s390x/config.in
--- linux-2.5.40/arch/s390x/config.in	Tue Oct  1 09:06:17 2002
+++ linux-2.5.40-s390/arch/s390x/config.in	Fri Oct  4 16:15:05 2002
@@ -17,31 +17,29 @@
 source init/Config.in
 
 mainmenu_option next_comment
+comment 'Base setup'
 comment 'Processor type and features'
 bool 'Symmetric multi-processing support' CONFIG_SMP
 bool 'Kernel support for 31 bit emulation' CONFIG_S390_SUPPORT
 if [ "$CONFIG_S390_SUPPORT" = "y" ]; then
   tristate 'Kernel support for 31 bit ELF binaries' CONFIG_BINFMT_ELF32 
 fi
-endmenu
 
-mainmenu_option next_comment
-comment 'Base setup'
-bool 'Fast IRQ handling' CONFIG_FAST_IRQ
+comment 'I/O subsystem configuration'
 bool 'Process warning machine checks' CONFIG_MACHCHK_WARNING
-bool 'Use chscs for Common I/O' CONFIG_CHSC
-  
 tristate 'QDIO support' CONFIG_QDIO
-  if [ "$CONFIG_QDIO" != "n" ]; then
-    bool '   Performance statistics in /proc' CONFIG_QDIO_PERF_STATS
-  fi
+if [ "$CONFIG_QDIO" != "n" ]; then
+  bool '   Performance statistics in /proc' CONFIG_QDIO_PERF_STATS
+fi
 
+comment 'Misc'
 bool 'Builtin IPL record support' CONFIG_IPL
 if [ "$CONFIG_IPL" = "y" ]; then
   choice 'IPL method generated into head.S' \
           "tape                   CONFIG_IPL_TAPE \
            vm_reader              CONFIG_IPL_VM" tape
 fi
+
 define_bool CONFIG_KCORE_ELF y
 tristate 'Kernel support for ELF binaries' CONFIG_BINFMT_ELF
 tristate 'Kernel support for MISC binaries' CONFIG_BINFMT_MISC
@@ -71,7 +69,6 @@
 mainmenu_option next_comment
 comment 'Kernel hacking'
 
-#bool 'Debug kmalloc/kfree' CONFIG_DEBUG_MALLOC
 #if [ "$CONFIG_CTC" = "y" ]; then
 #  bool 'Remote GDB kernel debugging' CONFIG_REMOTE_DEBUG
 #fi
diff -urN linux-2.5.40/arch/s390x/defconfig linux-2.5.40-s390/arch/s390x/defconfig
--- linux-2.5.40/arch/s390x/defconfig	Tue Oct  1 09:05:46 2002
+++ linux-2.5.40-s390/arch/s390x/defconfig	Fri Oct  4 16:15:05 2002
@@ -31,6 +31,10 @@
 CONFIG_KMOD=y
 
 #
+# Base setup
+#
+
+#
 # Processor type and features
 #
 CONFIG_SMP=y
@@ -38,13 +42,15 @@
 CONFIG_BINFMT_ELF32=y
 
 #
-# Base setup
+# I/O subsystem configuration
 #
-CONFIG_FAST_IRQ=y
 CONFIG_MACHCHK_WARNING=y
-CONFIG_CHSC=y
-CONFIG_QDIO=m
+CONFIG_QDIO=y
 # CONFIG_QDIO_PERF_STATS is not set
+
+#
+# Misc
+#
 CONFIG_IPL=y
 # CONFIG_IPL_TAPE is not set
 CONFIG_IPL_VM=y
@@ -85,9 +91,6 @@
 #
 # CONFIG_SCSI_7000FASST is not set
 # CONFIG_SCSI_ACARD is not set
-# CONFIG_SCSI_AHA152X is not set
-# CONFIG_SCSI_AHA1542 is not set
-# CONFIG_SCSI_AHA1740 is not set
 # CONFIG_SCSI_AIC7XXX is not set
 # CONFIG_SCSI_AIC7XXX_OLD is not set
 # CONFIG_SCSI_DPT_I2O is not set
@@ -115,7 +118,6 @@
 # CONFIG_SCSI_PCI2220I is not set
 # CONFIG_SCSI_PSI240I is not set
 # CONFIG_SCSI_QLOGIC_FAS is not set
-# CONFIG_SCSI_SIM710 is not set
 # CONFIG_SCSI_SYM53C416 is not set
 # CONFIG_SCSI_T128 is not set
 # CONFIG_SCSI_U14_34F is not set
@@ -153,7 +155,7 @@
 CONFIG_MD_RAID1=m
 CONFIG_MD_RAID5=m
 # CONFIG_MD_MULTIPATH is not set
-CONFIG_BLK_DEV_LVM=m
+# CONFIG_BLK_DEV_LVM is not set
 
 #
 # Character device drivers
@@ -225,26 +227,23 @@
 # CONFIG_ARPD is not set
 # CONFIG_INET_ECN is not set
 # CONFIG_SYN_COOKIES is not set
-CONFIG_IPV6=m
-# CONFIG_KHTTPD is not set
-# CONFIG_ATM is not set
-# CONFIG_VLAN_8021Q is not set
+# CONFIG_IPV6 is not set
 
 #
-#  
+#    SCTP Configuration (EXPERIMENTAL)
 #
+CONFIG_IPV6_SCTP__=y
+# CONFIG_IP_SCTP is not set
+# CONFIG_ATM is not set
+# CONFIG_VLAN_8021Q is not set
+# CONFIG_LLC is not set
 # CONFIG_IPX is not set
 # CONFIG_ATALK is not set
-
-#
-# Appletalk devices
-#
 # CONFIG_DEV_APPLETALK is not set
 # CONFIG_DECNET is not set
 # CONFIG_BRIDGE is not set
 # CONFIG_X25 is not set
 # CONFIG_LAPB is not set
-# CONFIG_LLC is not set
 # CONFIG_NET_DIVERT is not set
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
@@ -299,7 +298,7 @@
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 CONFIG_DEVFS_FS=y
-CONFIG_DEVFS_MOUNT=y
+# CONFIG_DEVFS_MOUNT is not set
 # CONFIG_DEVFS_DEBUG is not set
 # CONFIG_DEVPTS_FS is not set
 # CONFIG_QNX4FS_FS is not set
@@ -311,6 +310,9 @@
 # CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
+# CONFIG_XFS_FS is not set
+# CONFIG_XFS_RT is not set
+# CONFIG_XFS_QUOTA is not set
 
 #
 # Network File Systems
@@ -320,12 +322,12 @@
 CONFIG_NFS_FS=y
 # CONFIG_NFS_V3 is not set
 # CONFIG_ROOT_NFS is not set
-# CONFIG_NFSD is not set
+CONFIG_NFSD=y
 # CONFIG_NFSD_V3 is not set
 # CONFIG_NFSD_TCP is not set
 CONFIG_SUNRPC=y
 CONFIG_LOCKD=y
-# CONFIG_EXPORTFS is not set
+CONFIG_EXPORTFS=y
 # CONFIG_SMB_FS is not set
 # CONFIG_NCP_FS is not set
 # CONFIG_NCPFS_PACKET_SIGNING is not set
@@ -363,6 +365,11 @@
 CONFIG_MAGIC_SYSRQ=y
 
 #
+# Security options
+#
+CONFIG_SECURITY_CAPABILITIES=y
+
+#
 # Library routines
 #
 # CONFIG_CRC32 is not set
diff -urN linux-2.5.40/drivers/s390/Makefile linux-2.5.40-s390/drivers/s390/Makefile
--- linux-2.5.40/drivers/s390/Makefile	Tue Oct  1 09:07:00 2002
+++ linux-2.5.40-s390/drivers/s390/Makefile	Fri Oct  4 16:15:05 2002
@@ -9,4 +9,6 @@
 obj-y += s390mach.o s390dyn.o sysinfo.o
 obj-y += block/ char/ misc/ net/ cio/
 
+drivers-y += drivers/s390/built-in.o
+
 include $(TOPDIR)/Rules.make
diff -urN linux-2.5.40/drivers/s390/cio/Makefile linux-2.5.40-s390/drivers/s390/cio/Makefile
--- linux-2.5.40/drivers/s390/cio/Makefile	Tue Oct  1 09:05:46 2002
+++ linux-2.5.40-s390/drivers/s390/cio/Makefile	Fri Oct  4 16:15:05 2002
@@ -3,9 +3,8 @@
 #
 
 obj-y := cio_debug.o # make sure this always comes first
-obj-y += airq.o blacklist.o cio.o ioinfo.o misc.o requestirq.o s390io.o
+obj-y += airq.o blacklist.o cio.o ioinfo.o misc.o requestirq.o s390io.o chsc.o
 
-obj-$(CONFIG_CHSC) += chsc.o
 obj-$(CONFIG_PROC_FS) += proc.o
 
 export-objs += airq.o cio.o ioinfo.o requestirq.o s390io.o
diff -urN linux-2.5.40/drivers/s390/cio/cio.c linux-2.5.40-s390/drivers/s390/cio/cio.c
--- linux-2.5.40/drivers/s390/cio/cio.c	Fri Oct  4 16:14:52 2002
+++ linux-2.5.40-s390/drivers/s390/cio/cio.c	Fri Oct  4 16:15:05 2002
@@ -969,10 +969,7 @@
 		return;
 	}
 	/* endif */
-#ifdef CONFIG_FAST_IRQ
 	do {
-#endif				/* CONFIG_FAST_IRQ */
-
 		/*
 		 * Non I/O-subchannel thin interrupts are processed differently
 		 */
@@ -1008,16 +1005,14 @@
 			irq_exit ();
 		}
 
-#ifdef CONFIG_FAST_IRQ
-
 		/*
 		 * Are more interrupts pending?
 		 * If so, the tpi instruction will update the lowcore 
 		 * to hold the info for the next interrupt.
+		 * We don't do this for VM because a tpi drops the cpu
+		 * out of the sie which costs more cycles than it saves.
 		 */
-	} while (tpi (NULL) != 0);
-
-#endif				/* CONFIG_FAST_IRQ */
+	} while (!MACHINE_IS_VM && tpi (NULL) != 0);
 
 	return;
 }
diff -urN linux-2.5.40/drivers/s390/cio/misc.c linux-2.5.40-s390/drivers/s390/cio/misc.c
--- linux-2.5.40/drivers/s390/cio/misc.c	Tue Oct  1 09:06:57 2002
+++ linux-2.5.40-s390/drivers/s390/cio/misc.c	Fri Oct  4 16:15:05 2002
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/s390io.c
  *   S/390 common I/O routines
- *   $Revision: 1.4 $
+ *   $Revision: 1.5 $
  *
  *    Copyright (C) 1999-2002 IBM Deutschland Entwicklung GmbH,
  *                            IBM Corporation
@@ -212,9 +212,7 @@
 
 			CRW_DEBUG(KERN_NOTICE, 2, 
 				  "source is channel subsystem\n");
-#ifdef CONFIG_CHSC
 			s390_process_css();
-#endif
 			break;
 
 		default:
diff -urN linux-2.5.40/drivers/s390/cio/s390io.c linux-2.5.40-s390/drivers/s390/cio/s390io.c
--- linux-2.5.40/drivers/s390/cio/s390io.c	Fri Oct  4 16:14:52 2002
+++ linux-2.5.40-s390/drivers/s390/cio/s390io.c	Fri Oct  4 16:15:05 2002
@@ -995,10 +995,8 @@
 	int ccode2;		/* condition code for other I/O routines */
 	schib_t *p_schib;
 	int ret;
-#ifdef CONFIG_CHSC
 	int      chp = 0;
 	int      mask;
-#endif /* CONFIG_CHSC */
 
 	char dbf_txt[15];
 
@@ -1121,7 +1119,6 @@
 	ioinfo[irq]->opm = ioinfo[irq]->schib.pmcw.pim
 	    & ioinfo[irq]->schib.pmcw.pam & ioinfo[irq]->schib.pmcw.pom;
 
-#ifdef CONFIG_CHSC
 	if (ioinfo[irq]->opm) {
 		for (chp=0;chp<=7;chp++) {
 			mask = 0x80 >> chp;
@@ -1133,7 +1130,6 @@
 			}
 		}
 	}
-#endif /* CONFIG_CHSC */
 
 	CIO_DEBUG_IFMSG(KERN_INFO, 0,
 			"Detected device %04X "
@@ -1700,11 +1696,9 @@
 	int ccode;
 	__u8 pathmask;
 	__u8 domask;
-#ifdef CONFIG_CHSC
 	int chp;
 	int mask;
 	int old_opm = 0;
-#endif /* CONFIG_CHSC */
 
 	int ret = 0;
 	int i;
@@ -1720,9 +1714,7 @@
 	if (ioinfo[irq]->st) 
 		return -ENODEV;
 
-#ifdef CONFIG_CHSC
 	old_opm = ioinfo[irq]->opm;
-#endif /* CONFIG_CHSC */
 	ccode = stsch (irq, &(ioinfo[irq]->schib));
 
 	if (ccode) {
@@ -1735,7 +1727,6 @@
 		ioinfo[irq]->ui.flags.pgid_supp = 0;
 		ret = 0;
 
-#ifdef CONFIG_CHSC
 		/*
 		 * disable if chpid is logically offline
 		 */
@@ -1781,14 +1772,12 @@
 		} else {
 			ret = 0;
 		}
-#endif /* CONFIG_CHSC */
 		return ret;
 	}
 
 	ioinfo[irq]->opm = ioinfo[irq]->schib.pmcw.pim
 	    & ioinfo[irq]->schib.pmcw.pam & ioinfo[irq]->schib.pmcw.pom;
 
-#ifdef CONFIG_CHSC
 	if (ioinfo[irq]->opm) {
 		for (chp=0;chp<=7;chp++) {
 			mask = 0x80 >> chp;
@@ -1830,7 +1819,6 @@
 				pdevreg->oper_func( irq, pdevreg);
 
 	}
-#endif /* CONFIG_CHSC */
 
 	if ( ioinfo[irq]->ui.flags.pgid_supp == 0 )
 		return( 0);	/* just exit ... */

