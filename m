Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283025AbRK1M4B>; Wed, 28 Nov 2001 07:56:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283029AbRK1Mzt>; Wed, 28 Nov 2001 07:55:49 -0500
Received: from ns.caldera.de ([212.34.180.1]:37085 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S283025AbRK1MzZ>;
	Wed, 28 Nov 2001 07:55:25 -0500
Date: Wed, 28 Nov 2001 13:55:08 +0100
From: Christoph Hellwig <hch@caldera.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.1-pre2 does not compile
Message-ID: <20011128135508.A21418@caldera.de>
Mail-Followup-To: Christoph Hellwig <hch@caldera.de>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200111272209.fARM9tk18991@ns.caldera.de> <Pine.LNX.4.33.0111271628430.1629-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0111271628430.1629-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Tue, Nov 27, 2001 at 04:29:17PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2001 at 04:29:17PM -0800, Linus Torvalds wrote:
> 
> On Tue, 27 Nov 2001, Christoph Hellwig wrote:
> >
> > While we are at breaking scsi, would you take a patch to remove the
> > old-style (2.0) scsi error handling completly, forcing drivers still
> > using it to be fixed?  Early 2.5 looks like a good time for that to me..
> 
> I agree, that sounds like a good thing, and as I consider the block layer
> to be one of the major pushes for 2.5.x it makes perfect sense.

Ok, here is the patch:

diff -uNr -Xdontdiff ../master/linux-2.5.1-pre2/drivers/acorn/scsi/arxescsi.h linux/drivers/acorn/scsi/arxescsi.h
--- ../master/linux-2.5.1-pre2/drivers/acorn/scsi/arxescsi.h	Fri May 12 20:21:20 2000
+++ linux/drivers/acorn/scsi/arxescsi.h	Wed Nov 28 13:32:29 2001
@@ -61,7 +61,6 @@
 eh_bus_reset_handler:		fas216_eh_bus_reset,	\
 eh_device_reset_handler:	fas216_eh_device_reset,	\
 eh_abort_handler:		fas216_eh_abort,	\
-use_new_eh_code:		1			\
 	}
 
 #ifndef HOSTS_C
diff -uNr -Xdontdiff ../master/linux-2.5.1-pre2/drivers/acorn/scsi/cumana_2.c linux/drivers/acorn/scsi/cumana_2.c
--- ../master/linux-2.5.1-pre2/drivers/acorn/scsi/cumana_2.c	Sun Nov  4 18:31:57 2001
+++ linux/drivers/acorn/scsi/cumana_2.c	Wed Nov 28 13:32:36 2001
@@ -575,7 +575,6 @@
 	eh_bus_reset_handler:		fas216_eh_bus_reset,
 	eh_device_reset_handler:	fas216_eh_device_reset,
 	eh_abort_handler:		fas216_eh_abort,
-	use_new_eh_code:		1
 };
 
 static int __init cumanascsi2_init(void)
diff -uNr -Xdontdiff ../master/linux-2.5.1-pre2/drivers/acorn/scsi/eesox.c linux/drivers/acorn/scsi/eesox.c
--- ../master/linux-2.5.1-pre2/drivers/acorn/scsi/eesox.c	Sun Nov  4 18:31:57 2001
+++ linux/drivers/acorn/scsi/eesox.c	Wed Nov 28 13:32:41 2001
@@ -577,7 +577,6 @@
 	eh_bus_reset_handler:		fas216_eh_bus_reset,
 	eh_device_reset_handler:	fas216_eh_device_reset,
 	eh_abort_handler:		fas216_eh_abort,
-	use_new_eh_code:		1
 };
 
 static int __init eesox_init(void)
diff -uNr -Xdontdiff ../master/linux-2.5.1-pre2/drivers/acorn/scsi/powertec.c linux/drivers/acorn/scsi/powertec.c
--- ../master/linux-2.5.1-pre2/drivers/acorn/scsi/powertec.c	Sun Nov  4 18:31:57 2001
+++ linux/drivers/acorn/scsi/powertec.c	Wed Nov 28 13:32:46 2001
@@ -477,7 +477,6 @@
 	eh_bus_reset_handler:		fas216_eh_bus_reset,
 	eh_device_reset_handler:	fas216_eh_device_reset,
 	eh_abort_handler:		fas216_eh_abort,
-	use_new_eh_code:		1
 };
 
 static int __init powertecscsi_init(void)
diff -uNr -Xdontdiff ../master/linux-2.5.1-pre2/drivers/message/fusion/mptscsih.h linux/drivers/message/fusion/mptscsih.h
--- ../master/linux-2.5.1-pre2/drivers/message/fusion/mptscsih.h	Sat Jul  7 02:03:11 2001
+++ linux/drivers/message/fusion/mptscsih.h	Wed Nov 28 13:33:00 2001
@@ -198,7 +198,6 @@
 	cmd_per_lun:			MPT_SCSI_CMD_PER_LUN,	\
 	unchecked_isa_dma:		0,			\
 	use_clustering:			ENABLE_CLUSTERING,	\
-	use_new_eh_code:		1			\
 }
 
 #else
diff -uNr -Xdontdiff ../master/linux-2.5.1-pre2/drivers/net/fc/iph5526.c linux/drivers/net/fc/iph5526.c
--- ../master/linux-2.5.1-pre2/drivers/net/fc/iph5526.c	Sun Sep 30 21:26:08 2001
+++ linux/drivers/net/fc/iph5526.c	Wed Nov 28 13:33:15 2001
@@ -3802,7 +3802,6 @@
 		fi->host = host;
 		//host->max_id = MAX_SCSI_TARGETS;
 		host->max_id = 5;
-		host->hostt->use_new_eh_code = 1;
 		host->this_id = tmpt->this_id;
 
 		pci_maddr = pci_resource_start(pdev, 0);
diff -uNr -Xdontdiff ../master/linux-2.5.1-pre2/drivers/scsi/3w-xxxx.h linux/drivers/scsi/3w-xxxx.h
--- ../master/linux-2.5.1-pre2/drivers/scsi/3w-xxxx.h	Fri Nov  9 23:05:02 2001
+++ linux/drivers/scsi/3w-xxxx.h	Wed Nov 28 13:24:40 2001
@@ -461,7 +461,6 @@
 	present : 0,					\
 	unchecked_isa_dma : 0,				\
 	use_clustering : ENABLE_CLUSTERING,		\
- 	use_new_eh_code : 1,				\
 	emulated : 1					\
 }
 #endif /* _3W_XXXX_H */
diff -uNr -Xdontdiff ../master/linux-2.5.1-pre2/drivers/scsi/53c700.c linux/drivers/scsi/53c700.c
--- ../master/linux-2.5.1-pre2/drivers/scsi/53c700.c	Thu Oct 11 18:43:29 2001
+++ linux/drivers/scsi/53c700.c	Wed Nov 28 13:35:07 2001
@@ -267,7 +267,6 @@
 	tpnt->sg_tablesize = NCR_700_SG_SEGMENTS;
 	tpnt->cmd_per_lun = NCR_700_MAX_TAGS;
 	tpnt->use_clustering = DISABLE_CLUSTERING;
-	tpnt->use_new_eh_code = 1;
 	tpnt->proc_info = NCR_700_proc_directory_info;
 	
 	if(tpnt->name == NULL)
diff -uNr -Xdontdiff ../master/linux-2.5.1-pre2/drivers/scsi/Makefile linux/drivers/scsi/Makefile
--- ../master/linux-2.5.1-pre2/drivers/scsi/Makefile	Wed Nov 21 18:59:11 2001
+++ linux/drivers/scsi/Makefile	Wed Nov 28 13:41:00 2001
@@ -133,11 +133,9 @@
 obj-$(CONFIG_CHR_DEV_SG)	+= sg.o
 
 list-multi	:= scsi_mod.o sd_mod.o sr_mod.o initio.o a100u2w.o cpqfc.o
-scsi_mod-objs	:= scsi.o hosts.o scsi_ioctl.o constants.o \
-			scsicam.o scsi_proc.o scsi_error.o \
-			scsi_obsolete.o scsi_queue.o scsi_lib.o \
-			scsi_merge.o scsi_dma.o scsi_scan.o \
-			scsi_syms.o
+scsi_mod-objs	:= scsi.o hosts.o scsi_ioctl.o constants.o scsicam.o \
+			scsi_proc.o scsi_error.o scsi_queue.o scsi_lib.o \
+			scsi_merge.o scsi_dma.o scsi_scan.o scsi_syms.o
 sd_mod-objs	:= sd.o
 sr_mod-objs	:= sr.o sr_ioctl.o sr_vendor.o
 initio-objs	:= ini9100u.o i91uscsi.o
diff -uNr -Xdontdiff ../master/linux-2.5.1-pre2/drivers/scsi/advansys.h linux/drivers/scsi/advansys.h
--- ../master/linux-2.5.1-pre2/drivers/scsi/advansys.h	Fri Jul 20 06:07:47 2001
+++ linux/drivers/scsi/advansys.h	Wed Nov 28 13:28:01 2001
@@ -77,7 +77,6 @@
     release:                    advansys_release, \
     info:                       advansys_info, \
     queuecommand:               advansys_queuecommand, \
-    use_new_eh_code:		1, \
     eh_bus_reset_handler:	advansys_reset, \
     bios_param:                 advansys_biosparam, \
     /* \
diff -uNr -Xdontdiff ../master/linux-2.5.1-pre2/drivers/scsi/aha152x.h linux/drivers/scsi/aha152x.h
--- ../master/linux-2.5.1-pre2/drivers/scsi/aha152x.h	Fri Jul 20 06:08:07 2001
+++ linux/drivers/scsi/aha152x.h	Wed Nov 28 13:28:14 2001
@@ -50,7 +50,6 @@
                   present:			0,			\
                   unchecked_isa_dma:		0,			\
                   use_clustering:		DISABLE_CLUSTERING,	\
-		  use_new_eh_code:		1 }
 #endif
 
 
diff -uNr -Xdontdiff ../master/linux-2.5.1-pre2/drivers/scsi/aha1542.h linux/drivers/scsi/aha1542.h
--- ../master/linux-2.5.1-pre2/drivers/scsi/aha1542.h	Fri Jul 20 06:08:11 2001
+++ linux/drivers/scsi/aha1542.h	Wed Nov 28 13:28:36 2001
@@ -166,7 +166,6 @@
 		     sg_tablesize:		AHA1542_SCATTER, 	\
 		     cmd_per_lun:		AHA1542_CMDLUN, 	\
 		     unchecked_isa_dma:		1, 			\
-		     use_clustering:		ENABLE_CLUSTERING,	\
-		     use_new_eh_code:		1}
-
+		     use_clustering:		ENABLE_CLUSTERING	\
+}
 #endif
diff -uNr -Xdontdiff ../master/linux-2.5.1-pre2/drivers/scsi/aic7xxx/aic7xxx_linux_host.h linux/drivers/scsi/aic7xxx/aic7xxx_linux_host.h
--- ../master/linux-2.5.1-pre2/drivers/scsi/aic7xxx/aic7xxx_linux_host.h	Wed Nov 28 13:20:39 2001
+++ linux/drivers/scsi/aic7xxx/aic7xxx_linux_host.h	Wed Nov 28 13:34:17 2001
@@ -89,7 +89,6 @@
 	present: 0,		/* number of 7xxx's present   */\
 	unchecked_isa_dma: 0,	/* no memory DMA restrictions */\
 	use_clustering: ENABLE_CLUSTERING,			\
-	use_new_eh_code: 1,					\
 	highmem_io: 1						\
 }
 
diff -uNr -Xdontdiff ../master/linux-2.5.1-pre2/drivers/scsi/aic7xxx_old/aic7xxx.h linux/drivers/scsi/aic7xxx_old/aic7xxx.h
--- ../master/linux-2.5.1-pre2/drivers/scsi/aic7xxx_old/aic7xxx.h	Sun Mar  4 23:30:18 2001
+++ linux/drivers/scsi/aic7xxx_old/aic7xxx.h	Wed Nov 28 13:35:21 2001
@@ -55,7 +55,6 @@
 	present: 0,		/* number of 7xxx's present   */\
 	unchecked_isa_dma: 0,	/* no memory DMA restrictions */\
 	use_clustering: ENABLE_CLUSTERING,			\
-	use_new_eh_code: 0					\
 }
 
 extern int aic7xxx_queue(Scsi_Cmnd *, void (*)(Scsi_Cmnd *));
diff -uNr -Xdontdiff ../master/linux-2.5.1-pre2/drivers/scsi/atp870u.h linux/drivers/scsi/atp870u.h
--- ../master/linux-2.5.1-pre2/drivers/scsi/atp870u.h	Fri Jul 20 06:08:56 2001
+++ linux/drivers/scsi/atp870u.h	Wed Nov 28 13:28:45 2001
@@ -65,7 +65,6 @@
 	present: 0,		/* number of 7xxx's present   */\
 	unchecked_isa_dma: 0,	/* no memory DMA restrictions */\
 	use_clustering: ENABLE_CLUSTERING,			\
-	use_new_eh_code: 0					\
 }
 
 #endif
diff -uNr -Xdontdiff ../master/linux-2.5.1-pre2/drivers/scsi/cpqfcTS.h linux/drivers/scsi/cpqfcTS.h
--- ../master/linux-2.5.1-pre2/drivers/scsi/cpqfcTS.h	Sun Aug  5 22:12:41 2001
+++ linux/drivers/scsi/cpqfcTS.h	Wed Nov 28 13:28:56 2001
@@ -38,7 +38,6 @@
  present:                0,                      \
  unchecked_isa_dma:      0,                      \
  use_clustering:         ENABLE_CLUSTERING,      \
- use_new_eh_code:        1			 \
 }
 
 #endif /* CPQFCTS_H */ 
diff -uNr -Xdontdiff ../master/linux-2.5.1-pre2/drivers/scsi/dc390.h linux/drivers/scsi/dc390.h
--- ../master/linux-2.5.1-pre2/drivers/scsi/dc390.h	Fri Jul 20 06:08:49 2001
+++ linux/drivers/scsi/dc390.h	Wed Nov 28 13:29:27 2001
@@ -64,7 +64,6 @@
    this_id:        7,					\
    sg_tablesize:   SG_ALL,				\
    cmd_per_lun:    16,					\
-   NEW_EH						\
    unchecked_isa_dma: 0,				\
    use_clustering: DISABLE_CLUSTERING			\
    }
diff -uNr -Xdontdiff ../master/linux-2.5.1-pre2/drivers/scsi/dpt_i2o.c linux/drivers/scsi/dpt_i2o.c
--- ../master/linux-2.5.1-pre2/drivers/scsi/dpt_i2o.c	Fri Nov  9 23:05:06 2001
+++ linux/drivers/scsi/dpt_i2o.c	Wed Nov 28 13:35:35 2001
@@ -178,7 +178,6 @@
 	adpt_hba* pHba;
 
 	adpt_init();
-	sht->use_new_eh_code = 1;
 
 	PINFO("Detecting Adaptec I2O RAID controllers...\n");
 
diff -uNr -Xdontdiff ../master/linux-2.5.1-pre2/drivers/scsi/dpti.h linux/drivers/scsi/dpti.h
--- ../master/linux-2.5.1-pre2/drivers/scsi/dpti.h	Fri Sep  7 18:28:38 2001
+++ linux/drivers/scsi/dpti.h	Wed Nov 28 13:30:20 2001
@@ -95,7 +95,6 @@
 	sg_tablesize: 0,		/* max scatter-gather cmds    */\
 	cmd_per_lun: 256,		/* cmds per lun (linked cmds) */\
 	use_clustering: ENABLE_CLUSTERING,				\
-	use_new_eh_code: 1,						\
 	proc_name: "dpt_i2o"	/* this is the name of our proc node*/	\
 }
 #endif
diff -uNr -Xdontdiff ../master/linux-2.5.1-pre2/drivers/scsi/eata.h linux/drivers/scsi/eata.h
--- ../master/linux-2.5.1-pre2/drivers/scsi/eata.h	Sun May 20 02:43:06 2001
+++ linux/drivers/scsi/eata.h	Wed Nov 28 13:27:54 2001
@@ -30,7 +30,6 @@
                 this_id:                 7,                                  \
                 unchecked_isa_dma:       1,                                  \
                 use_clustering:          ENABLE_CLUSTERING,                  \
-                use_new_eh_code:         1    /* Enable new error code */    \
              }
 
 #endif
diff -uNr -Xdontdiff ../master/linux-2.5.1-pre2/drivers/scsi/esp.h linux/drivers/scsi/esp.h
--- ../master/linux-2.5.1-pre2/drivers/scsi/esp.h	Mon Sep 18 22:40:17 2000
+++ linux/drivers/scsi/esp.h	Wed Nov 28 13:26:42 2001
@@ -416,7 +416,6 @@
 		sg_tablesize:   SG_ALL,				\
 		cmd_per_lun:    1,				\
 		use_clustering: ENABLE_CLUSTERING,		\
-		use_new_eh_code: 0				\
 }
 
 /* For our interrupt engine. */
diff -uNr -Xdontdiff ../master/linux-2.5.1-pre2/drivers/scsi/fcal.h linux/drivers/scsi/fcal.h
--- ../master/linux-2.5.1-pre2/drivers/scsi/fcal.h	Tue Mar 16 01:11:31 1999
+++ linux/drivers/scsi/fcal.h	Wed Nov 28 13:30:05 2001
@@ -35,7 +35,6 @@
 	sg_tablesize:		1,				\
 	cmd_per_lun:		1,				\
 	use_clustering:		ENABLE_CLUSTERING,		\
-	use_new_eh_code:	FCP_SCSI_USE_NEW_EH_CODE,	\
 	abort:			fcp_old_abort,			\
 	eh_abort_handler:	fcp_scsi_abort,			\
 	eh_device_reset_handler:fcp_scsi_dev_reset,		\
diff -uNr -Xdontdiff ../master/linux-2.5.1-pre2/drivers/scsi/gdth.h linux/drivers/scsi/gdth.h
--- ../master/linux-2.5.1-pre2/drivers/scsi/gdth.h	Fri Sep  7 18:28:37 2001
+++ linux/drivers/scsi/gdth.h	Wed Nov 28 13:29:55 2001
@@ -1060,7 +1060,6 @@
                present:         0,                               \
                unchecked_isa_dma: 1,                             \
                use_clustering:  ENABLE_CLUSTERING,               \
-               use_new_eh_code: 1       /* use new error code */ }    
 
 #elif LINUX_VERSION_CODE >= 0x02015F
 int gdth_bios_param(Disk *,kdev_t,int *);
@@ -1092,7 +1091,6 @@
                present:         0,                               \
                unchecked_isa_dma: 1,                             \
                use_clustering:  ENABLE_CLUSTERING,               \
-               use_new_eh_code: 1       /* use new error code */ }    
 
 #elif LINUX_VERSION_CODE >= 0x010300
 int gdth_bios_param(Disk *,kdev_t,int *);
diff -uNr -Xdontdiff ../master/linux-2.5.1-pre2/drivers/scsi/hosts.h linux/drivers/scsi/hosts.h
--- ../master/linux-2.5.1-pre2/drivers/scsi/hosts.h	Wed Nov 28 13:20:39 2001
+++ linux/drivers/scsi/hosts.h	Wed Nov 28 13:43:27 2001
@@ -280,13 +280,6 @@
     unsigned use_clustering:1;
 
     /*
-     * True if this driver uses the new error handling code.  This flag is
-     * really only temporary until all of the other drivers get converted
-     * to use the new error handling code.
-     */
-    unsigned use_new_eh_code:1;
-
-    /*
      * True for emulated SCSI host adapters (e.g. ATAPI)
      */
     unsigned emulated:1;
diff -uNr -Xdontdiff ../master/linux-2.5.1-pre2/drivers/scsi/imm.h linux/drivers/scsi/imm.h
--- ../master/linux-2.5.1-pre2/drivers/scsi/imm.h	Sat Mar  3 03:38:38 2001
+++ linux/drivers/scsi/imm.h	Wed Nov 28 13:30:14 2001
@@ -175,7 +175,6 @@
                 eh_device_reset_handler:        NULL,                   \
                 eh_bus_reset_handler:           imm_reset,              \
                 eh_host_reset_handler:          imm_reset,              \
-		use_new_eh_code:		1,			\
 		bios_param:		        imm_biosparam,		\
 		this_id:			7,			\
 		sg_tablesize:			SG_ALL,			\
diff -uNr -Xdontdiff ../master/linux-2.5.1-pre2/drivers/scsi/in2000.h linux/drivers/scsi/in2000.h
--- ../master/linux-2.5.1-pre2/drivers/scsi/in2000.h	Fri Jul 20 06:08:18 2001
+++ linux/drivers/scsi/in2000.h	Wed Nov 28 13:27:50 2001
@@ -423,7 +423,6 @@
                   sg_tablesize:    IN2000_SG,           /* scatter-gather table size */ \
                   cmd_per_lun:     IN2000_CPL,          /* commands per lun */ \
                   use_clustering:  DISABLE_CLUSTERING,  /* ENABLE_CLUSTERING may speed things up */ \
-                  use_new_eh_code: 0                    /* new error code - not using it yet */ \
                 }
 
 #endif /* IN2000_H */
diff -uNr -Xdontdiff ../master/linux-2.5.1-pre2/drivers/scsi/ini9100u.h linux/drivers/scsi/ini9100u.h
--- ../master/linux-2.5.1-pre2/drivers/scsi/ini9100u.h	Thu Oct 11 18:43:30 2001
+++ linux/drivers/scsi/ini9100u.h	Wed Nov 28 13:30:29 2001
@@ -115,7 +115,6 @@
 	present:	0, \
 	unchecked_isa_dma: 0, \
 	use_clustering:	ENABLE_CLUSTERING, \
- use_new_eh_code: 0 \
 }
 
 #define VIRT_TO_BUS(i)  (unsigned int) virt_to_bus((void *)(i))
diff -uNr -Xdontdiff ../master/linux-2.5.1-pre2/drivers/scsi/inia100.h linux/drivers/scsi/inia100.h
--- ../master/linux-2.5.1-pre2/drivers/scsi/inia100.h	Thu Oct 11 18:43:30 2001
+++ linux/drivers/scsi/inia100.h	Wed Nov 28 13:30:35 2001
@@ -110,7 +110,6 @@
 	present:	0, \
 	unchecked_isa_dma: 0, \
 	use_clustering:	ENABLE_CLUSTERING, \
- use_new_eh_code: 0 \
 }
 
 #define VIRT_TO_BUS(i)  (unsigned int) virt_to_bus((void *)(i))
diff -uNr -Xdontdiff ../master/linux-2.5.1-pre2/drivers/scsi/ips.h linux/drivers/scsi/ips.h
--- ../master/linux-2.5.1-pre2/drivers/scsi/ips.h	Sun Sep 30 21:26:08 2001
+++ linux/drivers/scsi/ips.h	Wed Nov 28 13:24:56 2001
@@ -472,7 +472,6 @@
     present : 0,                          \
     unchecked_isa_dma : 0,                \
     use_clustering : ENABLE_CLUSTERING,   \
-    use_new_eh_code : 1                   \
 }
 #endif
 
diff -uNr -Xdontdiff ../master/linux-2.5.1-pre2/drivers/scsi/mac53c94.h linux/drivers/scsi/mac53c94.h
--- ../master/linux-2.5.1-pre2/drivers/scsi/mac53c94.h	Tue Sep 19 17:31:53 2000
+++ linux/drivers/scsi/mac53c94.h	Wed Nov 28 13:30:51 2001
@@ -28,7 +28,6 @@
 	sg_tablesize:	SG_ALL,				\
 	cmd_per_lun:	1,				\
 	use_clustering:	DISABLE_CLUSTERING,		\
-	use_new_eh_code: 1,				\
 }
 
 /*
diff -uNr -Xdontdiff ../master/linux-2.5.1-pre2/drivers/scsi/mac_esp.h linux/drivers/scsi/mac_esp.h
--- ../master/linux-2.5.1-pre2/drivers/scsi/mac_esp.h	Mon Jul 10 07:51:43 2000
+++ linux/drivers/scsi/mac_esp.h	Wed Nov 28 13:27:37 2001
@@ -35,7 +35,6 @@
 			    sg_tablesize:	SG_ALL, \
 			    cmd_per_lun:	1, \
 			    use_clustering:	DISABLE_CLUSTERING, \
-			    use_new_eh_code:	0 }
 
 #endif /* MAC_ESP_H */
 
diff -uNr -Xdontdiff ../master/linux-2.5.1-pre2/drivers/scsi/mesh.h linux/drivers/scsi/mesh.h
--- ../master/linux-2.5.1-pre2/drivers/scsi/mesh.h	Tue Sep 19 17:31:53 2000
+++ linux/drivers/scsi/mesh.h	Wed Nov 28 13:27:45 2001
@@ -28,7 +28,6 @@
 	sg_tablesize:	SG_ALL,				\
 	cmd_per_lun:	2,				\
 	use_clustering:	DISABLE_CLUSTERING,		\
-	use_new_eh_code: 1,				\
 }
 
 /*
diff -uNr -Xdontdiff ../master/linux-2.5.1-pre2/drivers/scsi/pci2000.h linux/drivers/scsi/pci2000.h
--- ../master/linux-2.5.1-pre2/drivers/scsi/pci2000.h	Fri Jul 20 06:07:53 2001
+++ linux/drivers/scsi/pci2000.h	Wed Nov 28 13:27:22 2001
@@ -218,7 +218,6 @@
 	present:	0,						\
 	unchecked_isa_dma:0,						\
 	use_clustering:	DISABLE_CLUSTERING,				\
-	use_new_eh_code:0						\
 }
 
 #endif
diff -uNr -Xdontdiff ../master/linux-2.5.1-pre2/drivers/scsi/pci2220i.h linux/drivers/scsi/pci2220i.h
--- ../master/linux-2.5.1-pre2/drivers/scsi/pci2220i.h	Fri Jul 20 06:07:54 2001
+++ linux/drivers/scsi/pci2220i.h	Wed Nov 28 13:27:28 2001
@@ -56,6 +56,5 @@
 	present:		0,			\
 	unchecked_isa_dma:	0,			\
 	use_clustering:		DISABLE_CLUSTERING,	\
-	use_new_eh_code:	0			\
 }
 #endif
diff -uNr -Xdontdiff ../master/linux-2.5.1-pre2/drivers/scsi/pcmcia/nsp_cs.c linux/drivers/scsi/pcmcia/nsp_cs.c
--- ../master/linux-2.5.1-pre2/drivers/scsi/pcmcia/nsp_cs.c	Thu Oct 11 18:04:57 2001
+++ linux/drivers/scsi/pcmcia/nsp_cs.c	Wed Nov 28 13:35:46 2001
@@ -149,7 +149,6 @@
 /*	present:		0,*/
 /*	unchecked_isa_dma:	0,*/
 	use_clustering:		DISABLE_CLUSTERING,
-	use_new_eh_code:	0,
 /*	emulated:		0,*/
 };
 
diff -uNr -Xdontdiff ../master/linux-2.5.1-pre2/drivers/scsi/pluto.h linux/drivers/scsi/pluto.h
--- ../master/linux-2.5.1-pre2/drivers/scsi/pluto.h	Thu Jan 27 21:53:32 2000
+++ linux/drivers/scsi/pluto.h	Wed Nov 28 13:27:08 2001
@@ -53,7 +53,6 @@
 	sg_tablesize:		1,				\
 	cmd_per_lun:		1,				\
 	use_clustering:		ENABLE_CLUSTERING,		\
-	use_new_eh_code:	FCP_SCSI_USE_NEW_EH_CODE,	\
 	abort:			fcp_old_abort,			\
 	eh_abort_handler:	fcp_scsi_abort,			\
 	eh_device_reset_handler:fcp_scsi_dev_reset,		\
diff -uNr -Xdontdiff ../master/linux-2.5.1-pre2/drivers/scsi/ppa.h linux/drivers/scsi/ppa.h
--- ../master/linux-2.5.1-pre2/drivers/scsi/ppa.h	Sat Mar  3 03:38:39 2001
+++ linux/drivers/scsi/ppa.h	Wed Nov 28 13:26:46 2001
@@ -183,7 +183,6 @@
 		eh_device_reset_handler:	NULL,			\
 		eh_bus_reset_handler:		ppa_reset,		\
 		eh_host_reset_handler:		ppa_reset,		\
-		use_new_eh_code:		1,			\
 		bios_param:			ppa_biosparam,		\
 		this_id:			-1,			\
 		sg_tablesize:			SG_ALL,			\
diff -uNr -Xdontdiff ../master/linux-2.5.1-pre2/drivers/scsi/qla1280.h linux/drivers/scsi/qla1280.h
--- ../master/linux-2.5.1-pre2/drivers/scsi/qla1280.h	Mon Sep 17 22:16:31 2001
+++ linux/drivers/scsi/qla1280.h	Wed Nov 28 13:27:15 2001
@@ -1726,7 +1726,6 @@
 	present: 0,		/* number of 7xxx's present   */\
 	unchecked_isa_dma: 0,	/* no memory DMA restrictions */\
 	use_clustering: ENABLE_CLUSTERING,			\
-	use_new_eh_code: 0,					\
 	emulated: 0					        \
 }
 #endif
diff -uNr -Xdontdiff ../master/linux-2.5.1-pre2/drivers/scsi/qlogicfc.c linux/drivers/scsi/qlogicfc.c
--- ../master/linux-2.5.1-pre2/drivers/scsi/qlogicfc.c	Wed Nov 28 13:20:39 2001
+++ linux/drivers/scsi/qlogicfc.c	Wed Nov 28 13:36:21 2001
@@ -734,7 +734,6 @@
  			scsi_set_pci_device(host, pdev);
 			host->max_id = QLOGICFC_MAX_ID + 1;
 			host->max_lun = QLOGICFC_MAX_LUN;
-			host->hostt->use_new_eh_code = 1;
 			hostdata = (struct isp2x00_hostdata *) host->hostdata;
 
 			memset(hostdata, 0, sizeof(struct isp2x00_hostdata));
diff -uNr -Xdontdiff ../master/linux-2.5.1-pre2/drivers/scsi/qlogicpti.h linux/drivers/scsi/qlogicpti.h
--- ../master/linux-2.5.1-pre2/drivers/scsi/qlogicpti.h	Tue Dec 21 07:06:42 1999
+++ linux/drivers/scsi/qlogicpti.h	Wed Nov 28 13:27:03 2001
@@ -524,7 +524,6 @@
 	sg_tablesize:	QLOGICPTI_MAX_SG(QLOGICPTI_REQ_QUEUE_LEN), \
 	cmd_per_lun:	1,					   \
 	use_clustering:	ENABLE_CLUSTERING,			   \
-	use_new_eh_code: 0					   \
 }
 
 /* For our interrupt engine. */
diff -uNr -Xdontdiff ../master/linux-2.5.1-pre2/drivers/scsi/scsi.c linux/drivers/scsi/scsi.c
--- ../master/linux-2.5.1-pre2/drivers/scsi/scsi.c	Wed Nov 28 13:20:39 2001
+++ linux/drivers/scsi/scsi.c	Wed Nov 28 13:39:40 2001
@@ -151,14 +151,6 @@
 void scsi_build_commandblocks(Scsi_Device * SDpnt);
 
 /*
- * These are the interface to the old error handling code.  It should go away
- * someday soon.
- */
-extern void scsi_old_done(Scsi_Cmnd * SCpnt);
-extern void scsi_old_times_out(Scsi_Cmnd * SCpnt);
-
-
-/*
  * Function:    scsi_initialize_queue()
  *
  * Purpose:     Selects queue handler function for a device.
@@ -670,12 +662,8 @@
 			mdelay(1 + 999 / HZ);
 		host->resetting = 0;
 	}
-	if (host->hostt->use_new_eh_code) {
-		scsi_add_timer(SCpnt, SCpnt->timeout_per_command, scsi_times_out);
-	} else {
-		scsi_add_timer(SCpnt, SCpnt->timeout_per_command,
-			       scsi_old_times_out);
-	}
+
+	scsi_add_timer(SCpnt, SCpnt->timeout_per_command, scsi_times_out);
 
 	/*
 	 * We will use a queued command if possible, otherwise we will emulate the
@@ -692,50 +680,27 @@
 		SCSI_LOG_MLQUEUE(3, printk("queuecommand : routine at %p\n",
 					   host->hostt->queuecommand));
 		/*
-		 * Use the old error handling code if we haven't converted the driver
-		 * to use the new one yet.  Note - only the new queuecommand variant
-		 * passes a meaningful return value.
+		 * Before we queue this command, check if the command
+		 * length exceeds what the host adapter can handle.
 		 */
-		if (host->hostt->use_new_eh_code) {
-			/*
-			 * Before we queue this command, check if the command
-			 * length exceeds what the host adapter can handle.
-			 */
-			if (CDB_SIZE(SCpnt) <= SCpnt->host->max_cmd_len) {
-				spin_lock_irqsave(&host->host_lock, flags);
-				rtn = host->hostt->queuecommand(SCpnt, scsi_done);
-				spin_unlock_irqrestore(&host->host_lock, flags);
-				if (rtn != 0) {
-					scsi_delete_timer(SCpnt);
-					scsi_mlqueue_insert(SCpnt, SCSI_MLQUEUE_HOST_BUSY);
-					SCSI_LOG_MLQUEUE(3, printk("queuecommand : request rejected\n"));                                
-				}
-			} else {
-				SCSI_LOG_MLQUEUE(3, printk("queuecommand : command too long.\n"));
-				SCpnt->result = (DID_ABORT << 16);
-				spin_lock_irqsave(&host->host_lock, flags);
-				scsi_done(SCpnt);
-				spin_unlock_irqrestore(&host->host_lock, flags);
-				rtn = 1;
-
+		if (CDB_SIZE(SCpnt) <= SCpnt->host->max_cmd_len) {
+			spin_lock_irqsave(&host->host_lock, flags);
+			rtn = host->hostt->queuecommand(SCpnt, scsi_done);
+			spin_unlock_irqrestore(&host->host_lock, flags);
+			if (rtn != 0) {
+				scsi_delete_timer(SCpnt);
+				scsi_mlqueue_insert(SCpnt, SCSI_MLQUEUE_HOST_BUSY);
+				SCSI_LOG_MLQUEUE(3,
+				   printk("queuecommand : request rejected\n"));                                
 			}
 		} else {
-			/*
-			 * Before we queue this command, check if the command
-			 * length exceeds what the host adapter can handle.
-			 */
-			if (CDB_SIZE(SCpnt) <= SCpnt->host->max_cmd_len) {
-				spin_lock_irqsave(&host->host_lock, flags);
-				host->hostt->queuecommand(SCpnt, scsi_old_done);
-				spin_unlock_irqrestore(&host->host_lock, flags);
-			} else {
-				SCSI_LOG_MLQUEUE(3, printk("queuecommand : command too long.\n"));
-				SCpnt->result = (DID_ABORT << 16);
-				spin_lock_irqsave(&host->host_lock, flags);
-				scsi_old_done(SCpnt);
-				spin_unlock_irqrestore(&host->host_lock, flags);
-				rtn = 1;
-			}
+			SCSI_LOG_MLQUEUE(3,
+				printk("queuecommand : command too long.\n"));
+			SCpnt->result = (DID_ABORT << 16);
+			spin_lock_irqsave(&host->host_lock, flags);
+			scsi_done(SCpnt);
+			spin_unlock_irqrestore(&host->host_lock, flags);
+			rtn = 1;
 		}
 	} else {
 		int temp;
@@ -755,11 +720,7 @@
 		       host->host_no, temp, host->hostt->command);
                 spin_lock_irqsave(&host->host_lock, flags);
 #endif
-		if (host->hostt->use_new_eh_code) {
-			scsi_done(SCpnt);
-		} else {
-			scsi_old_done(SCpnt);
-		}
+		scsi_done(SCpnt);
                 spin_unlock_irqrestore(&host->host_lock, flags);
 	}
 	SCSI_LOG_MLQUEUE(3, printk("leaving scsi_dispatch_cmnd()\n"));
@@ -1886,19 +1847,12 @@
 
 	/* The detect routine must carefully spinunlock/spinlock if 
 	   it enables interrupts, since all interrupt handlers do 
-	   spinlock as well.
-	   All lame drivers are going to fail due to the following 
-	   spinlock. For the time beeing let's use it only for drivers 
-	   using the new scsi code. NOTE: the detect routine could
-	   redefine the value tpnt->use_new_eh_code. (DB, 13 May 1998) */
+	   spinlock as well.  */
 
 	/*
 	 * detect should do its own locking
 	 */
-	if (tpnt->use_new_eh_code) {
-		tpnt->present = tpnt->detect(tpnt);
-	} else
-		tpnt->present = tpnt->detect(tpnt);
+	tpnt->present = tpnt->detect(tpnt);
 
 	if (tpnt->present) {
 		if (pcount == next_scsi_host) {
@@ -1932,7 +1886,7 @@
 		 * handle error correction.
 		 */
 		for (shpnt = scsi_hostlist; shpnt; shpnt = shpnt->next) {
-			if (shpnt->hostt == tpnt && shpnt->hostt->use_new_eh_code) {
+			if (shpnt->hostt == tpnt) {
 				DECLARE_MUTEX_LOCKED(sem);
 
 				shpnt->eh_notify = &sem;
@@ -2140,7 +2094,6 @@
 	 */
 	for (shpnt = scsi_hostlist; shpnt; shpnt = shpnt->next) {
 		if (shpnt->hostt == tpnt
-		    && shpnt->hostt->use_new_eh_code
 		    && shpnt->ehandler != NULL) {
 			DECLARE_MUTEX_LOCKED(sem);
 
diff -uNr -Xdontdiff ../master/linux-2.5.1-pre2/drivers/scsi/scsi.h linux/drivers/scsi/scsi.h
--- ../master/linux-2.5.1-pre2/drivers/scsi/scsi.h	Wed Nov 28 13:20:39 2001
+++ linux/drivers/scsi/scsi.h	Wed Nov 28 13:43:27 2001
@@ -387,12 +387,6 @@
 #define SYNC_RESET      0x40
 
 /*
- * This is the crap from the old error handling code.  We have it in a special
- * place so that we can more easily delete it later on.
- */
-#include "scsi_obsolete.h"
-
-/*
  * Add some typedefs so that we can prototyope a bunch of the functions.
  */
 typedef struct scsi_device Scsi_Device;
diff -uNr -Xdontdiff ../master/linux-2.5.1-pre2/drivers/scsi/scsi_debug.h linux/drivers/scsi/scsi_debug.h
--- ../master/linux-2.5.1-pre2/drivers/scsi/scsi_debug.h	Mon Dec 11 22:19:52 2000
+++ linux/drivers/scsi/scsi_debug.h	Wed Nov 28 13:26:53 2001
@@ -37,6 +37,5 @@
 		    cmd_per_lun:       3,			\
 		    unchecked_isa_dma: 0,			\
 		    use_clustering:    ENABLE_CLUSTERING,	\
-		    use_new_eh_code:   1,			\
 }
 #endif
diff -uNr -Xdontdiff ../master/linux-2.5.1-pre2/drivers/scsi/scsi_obsolete.c linux/drivers/scsi/scsi_obsolete.c
--- ../master/linux-2.5.1-pre2/drivers/scsi/scsi_obsolete.c	Wed Nov 28 13:20:39 2001
+++ linux/drivers/scsi/scsi_obsolete.c	Thu Jan  1 01:00:00 1970
@@ -1,1119 +0,0 @@
-/*
- *  scsi_obsolete.c Copyright (C) 1992 Drew Eckhardt
- *         Copyright (C) 1993, 1994, 1995 Eric Youngdale
- *
- *  generic mid-level SCSI driver
- *      Initial versions: Drew Eckhardt
- *      Subsequent revisions: Eric Youngdale
- *
- *  <drew@colorado.edu>
- *
- *  Bug correction thanks go to :
- *      Rik Faith <faith@cs.unc.edu>
- *      Tommy Thorn <tthorn>
- *      Thomas Wuensche <tw@fgb1.fgb.mw.tu-muenchen.de>
- *
- *  Modified by Eric Youngdale eric@andante.org to
- *  add scatter-gather, multiple outstanding request, and other
- *  enhancements.
- *
- *  Native multichannel, wide scsi, /proc/scsi and hot plugging
- *  support added by Michael Neuffer <mike@i-connect.net>
- *
- *  Major improvements to the timeout, abort, and reset processing,
- *  as well as performance modifications for large queue depths by
- *  Leonard N. Zubkoff <lnz@dandelion.com>
- *
- *  Improved compatibility with 2.0 behaviour by Manfred Spraul
- *  <masp0008@stud.uni-sb.de>
- */
-
-/*
- *#########################################################################
- *#########################################################################
- *#########################################################################
- *#########################################################################
- *              NOTE - NOTE - NOTE - NOTE - NOTE - NOTE - NOTE
- *
- *#########################################################################
- *#########################################################################
- *#########################################################################
- *#########################################################################
- *
- * This file contains the 'old' scsi error handling.  It is only present
- * while the new error handling code is being debugged, and while the low
- * level drivers are being converted to use the new code.  Once the last
- * driver uses the new code this *ENTIRE* file will be nuked.
- */
-
-#define __NO_VERSION__
-#include <linux/module.h>
-
-#include <linux/sched.h>
-#include <linux/timer.h>
-#include <linux/string.h>
-#include <linux/slab.h>
-#include <linux/ioport.h>
-#include <linux/kernel.h>
-#include <linux/stat.h>
-#include <linux/blk.h>
-#include <linux/interrupt.h>
-#include <linux/delay.h>
-
-#include <asm/system.h>
-#include <asm/irq.h>
-#include <asm/dma.h>
-
-#include "scsi.h"
-#include "hosts.h"
-#include "constants.h"
-
-#undef USE_STATIC_SCSI_MEMORY
-
-/*
-   static const char RCSid[] = "$Header: /mnt/ide/home/eric/CVSROOT/linux/drivers/scsi/scsi_obsolete.c,v 1.1 1997/05/18 23:27:21 eric Exp $";
- */
-
-
-#define INTERNAL_ERROR (panic ("Internal error in file %s, line %d.\n", __FILE__, __LINE__))
-
-
-static int scsi_abort(Scsi_Cmnd *, int code);
-static int scsi_reset(Scsi_Cmnd *, unsigned int);
-
-extern void scsi_old_done(Scsi_Cmnd * SCpnt);
-int update_timeout(Scsi_Cmnd *, int);
-extern void scsi_old_times_out(Scsi_Cmnd * SCpnt);
-
-extern int scsi_dispatch_cmd(Scsi_Cmnd * SCpnt);
-
-#define SCSI_BLOCK(HOST) (HOST->can_queue && HOST->host_busy >= HOST->can_queue)
-
-static unsigned char generic_sense[6] =
-{REQUEST_SENSE, 0, 0, 0, 255, 0};
-
-/*
- *  This is the number  of clock ticks we should wait before we time out
- *  and abort the command.  This is for  where the scsi.c module generates
- *  the command, not where it originates from a higher level, in which
- *  case the timeout is specified there.
- *
- *  ABORT_TIMEOUT and RESET_TIMEOUT are the timeouts for RESET and ABORT
- *  respectively.
- */
-
-#ifdef DEBUG_TIMEOUT
-static void scsi_dump_status(void);
-#endif
-
-
-#ifdef DEBUG
-#define SCSI_TIMEOUT (5*HZ)
-#else
-#define SCSI_TIMEOUT (2*HZ)
-#endif
-
-#ifdef DEBUG
-#define SENSE_TIMEOUT SCSI_TIMEOUT
-#define ABORT_TIMEOUT SCSI_TIMEOUT
-#define RESET_TIMEOUT SCSI_TIMEOUT
-#else
-#define SENSE_TIMEOUT (5*HZ/10)
-#define RESET_TIMEOUT (5*HZ/10)
-#define ABORT_TIMEOUT (5*HZ/10)
-#endif
-
-
-/* Do not call reset on error if we just did a reset within 15 sec. */
-#define MIN_RESET_PERIOD (15*HZ)
-
-
-
-/*
- *  Flag bits for the internal_timeout array
- */
-#define IN_ABORT  1
-#define IN_RESET  2
-#define IN_RESET2 4
-#define IN_RESET3 8
-
-/*
- * This is our time out function, called when the timer expires for a
- * given host adapter.  It will attempt to abort the currently executing
- * command, that failing perform a kernel panic.
- */
-
-void scsi_old_times_out(Scsi_Cmnd * SCpnt)
-{
-	struct Scsi_Host *host = SCpnt->host;
-	unsigned long flags;
-
-	spin_lock_irqsave(&host->host_lock, flags);
-
-	/* Set the serial_number_at_timeout to the current serial_number */
-	SCpnt->serial_number_at_timeout = SCpnt->serial_number;
-
-	switch (SCpnt->internal_timeout & (IN_ABORT | IN_RESET | IN_RESET2 | IN_RESET3)) {
-	case NORMAL_TIMEOUT:
-		{
-#ifdef DEBUG_TIMEOUT
-			scsi_dump_status();
-#endif
-		}
-
-		if (!scsi_abort(SCpnt, DID_TIME_OUT))
-			break;
-	case IN_ABORT:
-		printk("SCSI host %d abort (pid %ld) timed out - resetting\n",
-		       host->host_no, SCpnt->pid);
-		if (!scsi_reset(SCpnt, SCSI_RESET_ASYNCHRONOUS))
-			break;
-	case IN_RESET:
-	case (IN_ABORT | IN_RESET):
-		/* This might be controversial, but if there is a bus hang,
-		 * you might conceivably want the machine up and running
-		 * esp if you have an ide disk.
-		 */
-		printk("SCSI host %d channel %d reset (pid %ld) timed out - "
-		       "trying harder\n",
-		       host->host_no, SCpnt->channel, SCpnt->pid);
-		SCpnt->internal_timeout &= ~IN_RESET;
-		SCpnt->internal_timeout |= IN_RESET2;
-		scsi_reset(SCpnt,
-		 SCSI_RESET_ASYNCHRONOUS | SCSI_RESET_SUGGEST_BUS_RESET);
-		break;
-	case IN_RESET2:
-	case (IN_ABORT | IN_RESET2):
-		/* Obviously the bus reset didn't work.
-		 * Let's try even harder and call for an HBA reset.
-		 * Maybe the HBA itself crashed and this will shake it loose.
-		 */
-		printk("SCSI host %d reset (pid %ld) timed out - trying to shake it loose\n",
-		       host->host_no, SCpnt->pid);
-		SCpnt->internal_timeout &= ~(IN_RESET | IN_RESET2);
-		SCpnt->internal_timeout |= IN_RESET3;
-		scsi_reset(SCpnt,
-		SCSI_RESET_ASYNCHRONOUS | SCSI_RESET_SUGGEST_HOST_RESET);
-		break;
-
-	default:
-		printk("SCSI host %d reset (pid %ld) timed out again -\n",
-		       host->host_no, SCpnt->pid);
-		printk("probably an unrecoverable SCSI bus or device hang.\n");
-		break;
-
-	}
-	spin_unlock_irqrestore(&host->host_lock, flags);
-
-}
-
-/*
- *  From what I can find in scsi_obsolete.c, this function is only called
- *  by scsi_old_done and scsi_reset.  Both of these functions run with the
- *  host_lock already held, so we need do nothing here about grabbing
- *  any locks.
- */
-static void scsi_request_sense(Scsi_Cmnd * SCpnt)
-{
-	SCpnt->flags |= WAS_SENSE | ASKED_FOR_SENSE;
-	update_timeout(SCpnt, SENSE_TIMEOUT);
-
-	memcpy((void *) SCpnt->cmnd, (void *) generic_sense,
-	       sizeof(generic_sense));
-	memset((void *) SCpnt->sense_buffer, 0,
-	       sizeof(SCpnt->sense_buffer));
-
-	if (SCpnt->device->scsi_level <= SCSI_2)
-		SCpnt->cmnd[1] = SCpnt->lun << 5;
-	SCpnt->cmnd[4] = sizeof(SCpnt->sense_buffer);
-
-	SCpnt->request_buffer = &SCpnt->sense_buffer;
-	SCpnt->request_bufflen = sizeof(SCpnt->sense_buffer);
-	SCpnt->use_sg = 0;
-	SCpnt->cmd_len = COMMAND_SIZE(SCpnt->cmnd[0]);
-	SCpnt->result = 0;
-	SCpnt->sc_data_direction = SCSI_DATA_READ;
-
-        /*
-         * Ugly, ugly.  The newer interfaces all assume that the lock
-         * isn't held.  Mustn't disappoint, or we deadlock the system.
-         */
-        spin_unlock_irq(&SCpnt->host->host_lock);
-	scsi_dispatch_cmd(SCpnt);
-        spin_lock_irq(&SCpnt->host->host_lock);
-}
-
-
-
-
-static int check_sense(Scsi_Cmnd * SCpnt)
-{
-	/* If there is no sense information, request it.  If we have already
-	 * requested it, there is no point in asking again - the firmware must
-	 * be confused.
-	 */
-	if (((SCpnt->sense_buffer[0] & 0x70) >> 4) != 7) {
-		if (!(SCpnt->flags & ASKED_FOR_SENSE))
-			return SUGGEST_SENSE;
-		else
-			return SUGGEST_RETRY;
-	}
-	SCpnt->flags &= ~ASKED_FOR_SENSE;
-
-#ifdef DEBUG_INIT
-	printk("scsi%d, channel%d : ", SCpnt->host->host_no, SCpnt->channel);
-	print_sense("", SCpnt);
-	printk("\n");
-#endif
-	if (SCpnt->sense_buffer[2] & 0xe0)
-		return SUGGEST_ABORT;
-
-	switch (SCpnt->sense_buffer[2] & 0xf) {
-	case NO_SENSE:
-		return 0;
-	case RECOVERED_ERROR:
-		return SUGGEST_IS_OK;
-
-	case ABORTED_COMMAND:
-		return SUGGEST_RETRY;
-	case NOT_READY:
-	case UNIT_ATTENTION:
-		/*
-		 * If we are expecting a CC/UA because of a bus reset that we
-		 * performed, treat this just as a retry.  Otherwise this is
-		 * information that we should pass up to the upper-level driver
-		 * so that we can deal with it there.
-		 */
-		if (SCpnt->device->expecting_cc_ua) {
-			SCpnt->device->expecting_cc_ua = 0;
-			return SUGGEST_RETRY;
-		}
-		return SUGGEST_ABORT;
-
-		/* these three are not supported */
-	case COPY_ABORTED:
-	case VOLUME_OVERFLOW:
-	case MISCOMPARE:
-
-	case MEDIUM_ERROR:
-		return SUGGEST_REMAP;
-	case BLANK_CHECK:
-	case DATA_PROTECT:
-	case HARDWARE_ERROR:
-	case ILLEGAL_REQUEST:
-	default:
-		return SUGGEST_ABORT;
-	}
-}
-
-/* This function is the mid-level interrupt routine, which decides how
- *  to handle error conditions.  Each invocation of this function must
- *  do one and *only* one of the following:
- *
- *  (1) Call last_cmnd[host].done.  This is done for fatal errors and
- *      normal completion, and indicates that the handling for this
- *      request is complete.
- *  (2) Call internal_cmnd to requeue the command.  This will result in
- *      scsi_done being called again when the retry is complete.
- *  (3) Call scsi_request_sense.  This asks the host adapter/drive for
- *      more information about the error condition.  When the information
- *      is available, scsi_done will be called again.
- *  (4) Call reset().  This is sort of a last resort, and the idea is that
- *      this may kick things loose and get the drive working again.  reset()
- *      automatically calls scsi_request_sense, and thus scsi_done will be
- *      called again once the reset is complete.
- *
- *      If none of the above actions are taken, the drive in question
- *      will hang. If more than one of the above actions are taken by
- *      scsi_done, then unpredictable behavior will result.
- */
-void scsi_old_done(Scsi_Cmnd * SCpnt)
-{
-	int status = 0;
-	int exit = 0;
-	int checked;
-	int oldto;
-	struct Scsi_Host *host = SCpnt->host;
-        Scsi_Device * device = SCpnt->device;
-	int result = SCpnt->result;
-	SCpnt->serial_number = 0;
-	SCpnt->serial_number_at_timeout = 0;
-	oldto = update_timeout(SCpnt, 0);
-
-#ifdef DEBUG_TIMEOUT
-	if (result)
-		printk("Non-zero result in scsi_done %x %d:%d\n",
-		       result, SCpnt->target, SCpnt->lun);
-#endif
-
-	/* If we requested an abort, (and we got it) then fix up the return
-	 *  status to say why
-	 */
-	if (host_byte(result) == DID_ABORT && SCpnt->abort_reason)
-		SCpnt->result = result = (result & 0xff00ffff) |
-		    (SCpnt->abort_reason << 16);
-
-
-#define CMD_FINISHED 0
-#define MAYREDO  1
-#define REDO     3
-#define PENDING  4
-
-#ifdef DEBUG
-	printk("In scsi_done(host = %d, result = %06x)\n", host->host_no, result);
-#endif
-
-	if (SCpnt->flags & SYNC_RESET) {
-		/*
-		   * The behaviou of scsi_reset(SYNC) was changed in 2.1.? .
-		   * The scsi mid-layer does a REDO after every sync reset, the driver
-		   * must not do that any more. In order to prevent old drivers from
-		   * crashing, all scsi_done() calls during sync resets are ignored.
-		 */
-		printk("scsi%d: device driver called scsi_done() "
-		       "for a synchronous reset.\n", SCpnt->host->host_no);
-		return;
-	}
-	if (SCpnt->flags & WAS_SENSE) {
-		SCpnt->use_sg = SCpnt->old_use_sg;
-		SCpnt->cmd_len = SCpnt->old_cmd_len;
-		SCpnt->sc_data_direction = SCpnt->sc_old_data_direction;
-		SCpnt->underflow = SCpnt->old_underflow;
-	}
-	switch (host_byte(result)) {
-	case DID_OK:
-		if (status_byte(result) && (SCpnt->flags & WAS_SENSE))
-			/* Failed to obtain sense information */
-		{
-			SCpnt->flags &= ~WAS_SENSE;
-#if 0				/* This cannot possibly be correct. */
-			SCpnt->internal_timeout &= ~SENSE_TIMEOUT;
-#endif
-
-			if (!(SCpnt->flags & WAS_RESET)) {
-				printk("scsi%d : channel %d target %d lun %d request sense"
-				       " failed, performing reset.\n",
-				       SCpnt->host->host_no, SCpnt->channel, SCpnt->target,
-				       SCpnt->lun);
-				scsi_reset(SCpnt, SCSI_RESET_SYNCHRONOUS);
-				status = REDO;
-				break;
-			} else {
-				exit = (DRIVER_HARD | SUGGEST_ABORT);
-				status = CMD_FINISHED;
-			}
-		} else
-			switch (msg_byte(result)) {
-			case COMMAND_COMPLETE:
-				switch (status_byte(result)) {
-				case GOOD:
-					if (SCpnt->flags & WAS_SENSE) {
-#ifdef DEBUG
-						printk("In scsi_done, GOOD status, COMMAND COMPLETE, "
-						       "parsing sense information.\n");
-#endif
-						SCpnt->flags &= ~WAS_SENSE;
-#if 0				/* This cannot possibly be correct. */
-						SCpnt->internal_timeout &= ~SENSE_TIMEOUT;
-#endif
-
-						switch (checked = check_sense(SCpnt)) {
-						case SUGGEST_SENSE:
-						case 0:
-#ifdef DEBUG
-							printk("NO SENSE.  status = REDO\n");
-#endif
-							update_timeout(SCpnt, oldto);
-							status = REDO;
-							break;
-						case SUGGEST_IS_OK:
-							break;
-						case SUGGEST_REMAP:
-#ifdef DEBUG
-							printk("SENSE SUGGEST REMAP - status = CMD_FINISHED\n");
-#endif
-							status = CMD_FINISHED;
-							exit = DRIVER_SENSE | SUGGEST_ABORT;
-							break;
-						case SUGGEST_RETRY:
-#ifdef DEBUG
-							printk("SENSE SUGGEST RETRY - status = MAYREDO\n");
-#endif
-							status = MAYREDO;
-							exit = DRIVER_SENSE | SUGGEST_RETRY;
-							break;
-						case SUGGEST_ABORT:
-#ifdef DEBUG
-							printk("SENSE SUGGEST ABORT - status = CMD_FINISHED");
-#endif
-							status = CMD_FINISHED;
-							exit = DRIVER_SENSE | SUGGEST_ABORT;
-							break;
-						default:
-							printk("Internal error %s %d \n", __FILE__,
-							       __LINE__);
-						}
-					}
-					/* end WAS_SENSE */
-					else {
-#ifdef DEBUG
-						printk("COMMAND COMPLETE message returned, "
-						       "status = CMD_FINISHED. \n");
-#endif
-						exit = DRIVER_OK;
-						status = CMD_FINISHED;
-					}
-					break;
-
-				case CHECK_CONDITION:
-				case COMMAND_TERMINATED:
-					switch (check_sense(SCpnt)) {
-					case 0:
-						update_timeout(SCpnt, oldto);
-						status = REDO;
-						break;
-					case SUGGEST_REMAP:
-						status = CMD_FINISHED;
-						exit = DRIVER_SENSE | SUGGEST_ABORT;
-						break;
-					case SUGGEST_RETRY:
-						status = MAYREDO;
-						exit = DRIVER_SENSE | SUGGEST_RETRY;
-						break;
-					case SUGGEST_ABORT:
-						status = CMD_FINISHED;
-						exit = DRIVER_SENSE | SUGGEST_ABORT;
-						break;
-					case SUGGEST_SENSE:
-						scsi_request_sense(SCpnt);
-						status = PENDING;
-						break;
-					}
-					break;
-
-				case CONDITION_GOOD:
-				case INTERMEDIATE_GOOD:
-				case INTERMEDIATE_C_GOOD:
-					break;
-
-				case BUSY:
-				case QUEUE_FULL:
-					update_timeout(SCpnt, oldto);
-					status = REDO;
-					break;
-
-				case RESERVATION_CONFLICT:
-					printk("scsi%d, channel %d : RESERVATION CONFLICT performing"
-					       " reset.\n", SCpnt->host->host_no, SCpnt->channel);
-					scsi_reset(SCpnt, SCSI_RESET_SYNCHRONOUS);
-					status = REDO;
-					break;
-				default:
-					printk("Internal error %s %d \n"
-					 "status byte = %d \n", __FILE__,
-					  __LINE__, status_byte(result));
-
-				}
-				break;
-			default:
-				panic("scsi: unsupported message byte %d received\n",
-				      msg_byte(result));
-			}
-		break;
-	case DID_TIME_OUT:
-#ifdef DEBUG
-		printk("Host returned DID_TIME_OUT - ");
-#endif
-
-		if (SCpnt->flags & WAS_TIMEDOUT) {
-#ifdef DEBUG
-			printk("Aborting\n");
-#endif
-			/*
-			   Allow TEST_UNIT_READY and INQUIRY commands to timeout early
-			   without causing resets.  All other commands should be retried.
-			 */
-			if (SCpnt->cmnd[0] != TEST_UNIT_READY &&
-			    SCpnt->cmnd[0] != INQUIRY)
-				status = MAYREDO;
-			exit = (DRIVER_TIMEOUT | SUGGEST_ABORT);
-		} else {
-#ifdef DEBUG
-			printk("Retrying.\n");
-#endif
-			SCpnt->flags |= WAS_TIMEDOUT;
-			SCpnt->internal_timeout &= ~IN_ABORT;
-			status = REDO;
-		}
-		break;
-	case DID_BUS_BUSY:
-	case DID_PARITY:
-		status = REDO;
-		break;
-	case DID_NO_CONNECT:
-#ifdef DEBUG
-		printk("Couldn't connect.\n");
-#endif
-		exit = (DRIVER_HARD | SUGGEST_ABORT);
-		break;
-	case DID_ERROR:
-		status = MAYREDO;
-		exit = (DRIVER_HARD | SUGGEST_ABORT);
-		break;
-	case DID_BAD_TARGET:
-	case DID_ABORT:
-		exit = (DRIVER_INVALID | SUGGEST_ABORT);
-		break;
-	case DID_RESET:
-		if (SCpnt->flags & IS_RESETTING) {
-			SCpnt->flags &= ~IS_RESETTING;
-			status = REDO;
-			break;
-		}
-		if (msg_byte(result) == GOOD &&
-		    status_byte(result) == CHECK_CONDITION) {
-			switch (check_sense(SCpnt)) {
-			case 0:
-				update_timeout(SCpnt, oldto);
-				status = REDO;
-				break;
-			case SUGGEST_REMAP:
-			case SUGGEST_RETRY:
-				status = MAYREDO;
-				exit = DRIVER_SENSE | SUGGEST_RETRY;
-				break;
-			case SUGGEST_ABORT:
-				status = CMD_FINISHED;
-				exit = DRIVER_SENSE | SUGGEST_ABORT;
-				break;
-			case SUGGEST_SENSE:
-				scsi_request_sense(SCpnt);
-				status = PENDING;
-				break;
-			}
-		} else {
-			status = REDO;
-			exit = SUGGEST_RETRY;
-		}
-		break;
-	default:
-		exit = (DRIVER_ERROR | SUGGEST_DIE);
-	}
-
-	switch (status) {
-	case CMD_FINISHED:
-	case PENDING:
-		break;
-	case MAYREDO:
-#ifdef DEBUG
-		printk("In MAYREDO, allowing %d retries, have %d\n",
-		       SCpnt->allowed, SCpnt->retries);
-#endif
-		if ((++SCpnt->retries) < SCpnt->allowed) {
-			if ((SCpnt->retries >= (SCpnt->allowed >> 1))
-			    && !(SCpnt->host->resetting && time_before(jiffies, SCpnt->host->last_reset + MIN_RESET_PERIOD))
-			    && !(SCpnt->flags & WAS_RESET)) {
-				printk("scsi%d channel %d : resetting for second half of retries.\n",
-				   SCpnt->host->host_no, SCpnt->channel);
-				scsi_reset(SCpnt, SCSI_RESET_SYNCHRONOUS);
-				/* fall through to REDO */
-			}
-		} else {
-			status = CMD_FINISHED;
-			break;
-		}
-		/* fall through to REDO */
-
-	case REDO:
-
-		if (SCpnt->flags & WAS_SENSE)
-			scsi_request_sense(SCpnt);
-		else {
-			memcpy((void *) SCpnt->cmnd,
-			       (void *) SCpnt->data_cmnd,
-			       sizeof(SCpnt->data_cmnd));
-			memset((void *) SCpnt->sense_buffer, 0,
-			       sizeof(SCpnt->sense_buffer));
-			SCpnt->request_buffer = SCpnt->buffer;
-			SCpnt->request_bufflen = SCpnt->bufflen;
-			SCpnt->use_sg = SCpnt->old_use_sg;
-			SCpnt->cmd_len = SCpnt->old_cmd_len;
-			SCpnt->sc_data_direction = SCpnt->sc_old_data_direction;
-			SCpnt->underflow = SCpnt->old_underflow;
-			SCpnt->result = 0;
-                        /*
-                         * Ugly, ugly.  The newer interfaces all
-                         * assume that the lock isn't held.  Mustn't
-                         * disappoint, or we deadlock the system.  
-                         */
-			spin_unlock_irq(&host->host_lock);
-			scsi_dispatch_cmd(SCpnt);
-			spin_lock_irq(&host->host_lock);
-		}
-		break;
-	default:
-		INTERNAL_ERROR;
-	}
-
-	if (status == CMD_FINISHED) {
-		Scsi_Request *SRpnt;
-#ifdef DEBUG
-		printk("Calling done function - at address %p\n", SCpnt->done);
-#endif
-		host->host_busy--;	/* Indicate that we are free */
-                device->device_busy--;	/* Decrement device usage counter. */
-
-		SCpnt->result = result | ((exit & 0xff) << 24);
-		SCpnt->use_sg = SCpnt->old_use_sg;
-		SCpnt->cmd_len = SCpnt->old_cmd_len;
-		SCpnt->sc_data_direction = SCpnt->sc_old_data_direction;
-		SCpnt->underflow = SCpnt->old_underflow;
-                /*
-                 * The upper layers assume the lock isn't held.  We mustn't
-                 * disappoint them.  When the new error handling code is in
-                 * use, the upper code is run from a bottom half handler, so
-                 * it isn't an issue.
-                 */
-                spin_unlock_irq(&host->host_lock);
-		SRpnt = SCpnt->sc_request;
-		if( SRpnt != NULL ) {
-			SRpnt->sr_result = SRpnt->sr_command->result;
-			if( SRpnt->sr_result != 0 ) {
-				memcpy(SRpnt->sr_sense_buffer,
-				       SRpnt->sr_command->sense_buffer,
-				       sizeof(SRpnt->sr_sense_buffer));
-			}
-		}
-
-		SCpnt->done(SCpnt);
-                spin_lock_irq(&host->host_lock);
-	}
-#undef CMD_FINISHED
-#undef REDO
-#undef MAYREDO
-#undef PENDING
-}
-
-/*
- * The scsi_abort function interfaces with the abort() function of the host
- * we are aborting, and causes the current command to not complete.  The
- * caller should deal with any error messages or status returned on the
- * next call.
- *
- * This will not be called reentrantly for a given host.
- */
-
-/*
- * Since we're nice guys and specified that abort() and reset()
- * can be non-reentrant.  The internal_timeout flags are used for
- * this.
- */
-
-
-static int scsi_abort(Scsi_Cmnd * SCpnt, int why)
-{
-	int oldto;
-	struct Scsi_Host *host = SCpnt->host;
-
-	while (1) {
-
-		/*
-		 * Protect against races here.  If the command is done, or we are
-		 * on a different command forget it.
-		 */
-		if (SCpnt->serial_number != SCpnt->serial_number_at_timeout) {
-			return 0;
-		}
-		if (SCpnt->internal_timeout & IN_ABORT) {
-			spin_unlock_irq(&host->host_lock);
-			while (SCpnt->internal_timeout & IN_ABORT)
-				barrier();
-			spin_lock_irq(&host->host_lock);
-		} else {
-			SCpnt->internal_timeout |= IN_ABORT;
-			oldto = update_timeout(SCpnt, ABORT_TIMEOUT);
-
-			if ((SCpnt->flags & IS_RESETTING) && SCpnt->device->soft_reset) {
-				/* OK, this command must have died when we did the
-				 *  reset.  The device itself must have lied.
-				 */
-				printk("Stale command on %d %d:%d appears to have died when"
-				       " the bus was reset\n",
-				       SCpnt->channel, SCpnt->target, SCpnt->lun);
-			}
-			if (!host->host_busy) {
-				SCpnt->internal_timeout &= ~IN_ABORT;
-				update_timeout(SCpnt, oldto);
-				return 0;
-			}
-			printk("scsi : aborting command due to timeout : pid %lu, scsi%d,"
-			       " channel %d, id %d, lun %d ",
-			       SCpnt->pid, SCpnt->host->host_no, (int) SCpnt->channel,
-			       (int) SCpnt->target, (int) SCpnt->lun);
-			print_command(SCpnt->cmnd);
-			if (SCpnt->serial_number != SCpnt->serial_number_at_timeout)
-				return 0;
-			SCpnt->abort_reason = why;
-			switch (host->hostt->abort(SCpnt)) {
-				/* We do not know how to abort.  Try waiting another
-				 * time increment and see if this helps. Set the
-				 * WAS_TIMEDOUT flag set so we do not try this twice
-				 */
-			case SCSI_ABORT_BUSY:	/* Tough call - returning 1 from
-						 * this is too severe
-						 */
-			case SCSI_ABORT_SNOOZE:
-				if (why == DID_TIME_OUT) {
-					SCpnt->internal_timeout &= ~IN_ABORT;
-					if (SCpnt->flags & WAS_TIMEDOUT) {
-						return 1;	/* Indicate we cannot handle this.
-								 * We drop down into the reset handler
-								 * and try again
-								 */
-					} else {
-						SCpnt->flags |= WAS_TIMEDOUT;
-						oldto = SCpnt->timeout_per_command;
-						update_timeout(SCpnt, oldto);
-					}
-				}
-				return 0;
-			case SCSI_ABORT_PENDING:
-				if (why != DID_TIME_OUT) {
-					update_timeout(SCpnt, oldto);
-				}
-				return 0;
-			case SCSI_ABORT_SUCCESS:
-				/* We should have already aborted this one.  No
-				 * need to adjust timeout
-				 */
-				SCpnt->internal_timeout &= ~IN_ABORT;
-				return 0;
-			case SCSI_ABORT_NOT_RUNNING:
-				SCpnt->internal_timeout &= ~IN_ABORT;
-				update_timeout(SCpnt, 0);
-				return 0;
-			case SCSI_ABORT_ERROR:
-			default:
-				SCpnt->internal_timeout &= ~IN_ABORT;
-				return 1;
-			}
-		}
-	}
-}
-
-
-/* Mark a single SCSI Device as having been reset. */
-
-static inline void scsi_mark_device_reset(Scsi_Device * Device)
-{
-	Device->was_reset = 1;
-	Device->expecting_cc_ua = 1;
-}
-
-
-/* Mark all SCSI Devices on a specific Host as having been reset. */
-
-void scsi_mark_host_reset(struct Scsi_Host *Host)
-{
-	Scsi_Cmnd *SCpnt;
-	Scsi_Device *SDpnt;
-
-	for (SDpnt = Host->host_queue; SDpnt; SDpnt = SDpnt->next) {
-		for (SCpnt = SDpnt->device_queue; SCpnt; SCpnt = SCpnt->next)
-			scsi_mark_device_reset(SCpnt->device);
-	}
-}
-
-
-/* Mark all SCSI Devices on a specific Host Bus as having been reset. */
-
-static void scsi_mark_bus_reset(struct Scsi_Host *Host, int channel)
-{
-	Scsi_Cmnd *SCpnt;
-	Scsi_Device *SDpnt;
-
-	for (SDpnt = Host->host_queue; SDpnt; SDpnt = SDpnt->next) {
-		for (SCpnt = SDpnt->device_queue; SCpnt; SCpnt = SCpnt->next)
-			if (SCpnt->channel == channel)
-				scsi_mark_device_reset(SCpnt->device);
-	}
-}
-
-
-static int scsi_reset(Scsi_Cmnd * SCpnt, unsigned int reset_flags)
-{
-	int temp;
-	Scsi_Cmnd *SCpnt1;
-	Scsi_Device *SDpnt;
-	struct Scsi_Host *host = SCpnt->host;
-
-	printk("SCSI bus is being reset for host %d channel %d.\n",
-	       host->host_no, SCpnt->channel);
-
-#if 0
-	/*
-	 * First of all, we need to make a recommendation to the low-level
-	 * driver as to whether a BUS_DEVICE_RESET should be performed,
-	 * or whether we should do a full BUS_RESET.  There is no simple
-	 * algorithm here - we basically use a series of heuristics
-	 * to determine what we should do.
-	 */
-	SCpnt->host->suggest_bus_reset = FALSE;
-
-	/*
-	 * First see if all of the active devices on the bus have
-	 * been jammed up so that we are attempting resets.  If so,
-	 * then suggest a bus reset.  Forcing a bus reset could
-	 * result in some race conditions, but no more than
-	 * you would usually get with timeouts.  We will cross
-	 * that bridge when we come to it.
-	 *
-	 * This is actually a pretty bad idea, since a sequence of
-	 * commands will often timeout together and this will cause a
-	 * Bus Device Reset followed immediately by a SCSI Bus Reset.
-	 * If all of the active devices really are jammed up, the
-	 * Bus Device Reset will quickly timeout and scsi_times_out
-	 * will follow up with a SCSI Bus Reset anyway.
-	 */
-	SCpnt1 = host->host_queue;
-	while (SCpnt1) {
-		if (SCpnt1->request.rq_status != RQ_INACTIVE
-		    && (SCpnt1->flags & (WAS_RESET | IS_RESETTING)) == 0)
-			break;
-		SCpnt1 = SCpnt1->next;
-	}
-	if (SCpnt1 == NULL) {
-		reset_flags |= SCSI_RESET_SUGGEST_BUS_RESET;
-	}
-	/*
-	 * If the code that called us is suggesting a hard reset, then
-	 * definitely request it.  This usually occurs because a
-	 * BUS_DEVICE_RESET times out.
-	 *
-	 * Passing reset_flags along takes care of this automatically.
-	 */
-	if (reset_flags & SCSI_RESET_SUGGEST_BUS_RESET) {
-		SCpnt->host->suggest_bus_reset = TRUE;
-	}
-#endif
-
-	while (1) {
-
-		/*
-		 * Protect against races here.  If the command is done, or we are
-		 * on a different command forget it.
-		 */
-		if (reset_flags & SCSI_RESET_ASYNCHRONOUS)
-			if (SCpnt->serial_number != SCpnt->serial_number_at_timeout) {
-				return 0;
-			}
-		if (SCpnt->internal_timeout & IN_RESET) {
-			spin_unlock_irq(&host->host_lock);
-			while (SCpnt->internal_timeout & IN_RESET)
-				barrier();
-			spin_lock_irq(&host->host_lock);
-		} else {
-			SCpnt->internal_timeout |= IN_RESET;
-			update_timeout(SCpnt, RESET_TIMEOUT);
-
-			if (reset_flags & SCSI_RESET_SYNCHRONOUS)
-				SCpnt->flags |= SYNC_RESET;
-			if (host->host_busy) {
-				for (SDpnt = host->host_queue; SDpnt; SDpnt = SDpnt->next) {
-					SCpnt1 = SDpnt->device_queue;
-					while (SCpnt1) {
-						if (SCpnt1->request.rq_status != RQ_INACTIVE) {
-#if 0
-							if (!(SCpnt1->flags & IS_RESETTING) &&
-							    !(SCpnt1->internal_timeout & IN_ABORT))
-								scsi_abort(SCpnt1, DID_RESET);
-#endif
-							SCpnt1->flags |= (WAS_RESET | IS_RESETTING);
-						}
-						SCpnt1 = SCpnt1->next;
-					}
-				}
-
-				host->last_reset = jiffies;
-				host->resetting = 1;
-				/*
-				 * I suppose that the host reset callback will not play
-				 * with the resetting field. We have just set the resetting
-				 * flag here. -arca
-				 */
-				temp = host->hostt->reset(SCpnt, reset_flags);
-				/*
-				   This test allows the driver to introduce an additional bus
-				   settle time delay by setting last_reset up to 20 seconds in
-				   the future.  In the normal case where the driver does not
-				   modify last_reset, it must be assumed that the actual bus
-				   reset occurred immediately prior to the return to this code,
-				   and so last_reset must be updated to the current time, so
-				   that the delay in internal_cmnd will guarantee at least a
-				   MIN_RESET_DELAY bus settle time.
-				 */
-				if (host->last_reset - jiffies > 20UL * HZ)
-					host->last_reset = jiffies;
-			} else {
-				host->host_busy++;
-				host->last_reset = jiffies;
-				host->resetting = 1;
-				SCpnt->flags |= (WAS_RESET | IS_RESETTING);
-				/*
-				 * I suppose that the host reset callback will not play
-				 * with the resetting field. We have just set the resetting
-				 * flag here. -arca
-				 */
-				temp = host->hostt->reset(SCpnt, reset_flags);
-				if (time_before(host->last_reset, jiffies) ||
-				    (time_after(host->last_reset, jiffies + 20 * HZ)))
-					host->last_reset = jiffies;
-				host->host_busy--;
-			}
-			if (reset_flags & SCSI_RESET_SYNCHRONOUS)
-				SCpnt->flags &= ~SYNC_RESET;
-
-#ifdef DEBUG
-			printk("scsi reset function returned %d\n", temp);
-#endif
-
-			/*
-			 * Now figure out what we need to do, based upon
-			 * what the low level driver said that it did.
-			 * If the result is SCSI_RESET_SUCCESS, SCSI_RESET_PENDING,
-			 * or SCSI_RESET_WAKEUP, then the low level driver did a
-			 * bus device reset or bus reset, so we should go through
-			 * and mark one or all of the devices on that bus
-			 * as having been reset.
-			 */
-			switch (temp & SCSI_RESET_ACTION) {
-			case SCSI_RESET_SUCCESS:
-				if (temp & SCSI_RESET_HOST_RESET)
-					scsi_mark_host_reset(host);
-				else if (temp & SCSI_RESET_BUS_RESET)
-					scsi_mark_bus_reset(host, SCpnt->channel);
-				else
-					scsi_mark_device_reset(SCpnt->device);
-				SCpnt->internal_timeout &= ~(IN_RESET | IN_RESET2 | IN_RESET3);
-				return 0;
-			case SCSI_RESET_PENDING:
-				if (temp & SCSI_RESET_HOST_RESET)
-					scsi_mark_host_reset(host);
-				else if (temp & SCSI_RESET_BUS_RESET)
-					scsi_mark_bus_reset(host, SCpnt->channel);
-				else
-					scsi_mark_device_reset(SCpnt->device);
-			case SCSI_RESET_NOT_RUNNING:
-				return 0;
-			case SCSI_RESET_PUNT:
-				SCpnt->internal_timeout &= ~(IN_RESET | IN_RESET2 | IN_RESET3);
-				scsi_request_sense(SCpnt);
-				return 0;
-			case SCSI_RESET_WAKEUP:
-				if (temp & SCSI_RESET_HOST_RESET)
-					scsi_mark_host_reset(host);
-				else if (temp & SCSI_RESET_BUS_RESET)
-					scsi_mark_bus_reset(host, SCpnt->channel);
-				else
-					scsi_mark_device_reset(SCpnt->device);
-				SCpnt->internal_timeout &= ~(IN_RESET | IN_RESET2 | IN_RESET3);
-				scsi_request_sense(SCpnt);
-				/*
-				 * If a bus reset was performed, we
-				 * need to wake up each and every command
-				 * that was active on the bus or if it was a HBA
-				 * reset all active commands on all channels
-				 */
-				if (temp & SCSI_RESET_HOST_RESET) {
-					for (SDpnt = host->host_queue; SDpnt; SDpnt = SDpnt->next) {
-						SCpnt1 = SDpnt->device_queue;
-						while (SCpnt1) {
-							if (SCpnt1->request.rq_status != RQ_INACTIVE
-							    && SCpnt1 != SCpnt)
-								scsi_request_sense(SCpnt1);
-							SCpnt1 = SCpnt1->next;
-						}
-					}
-				} else if (temp & SCSI_RESET_BUS_RESET) {
-					for (SDpnt = host->host_queue; SDpnt; SDpnt = SDpnt->next) {
-						SCpnt1 = SDpnt->device_queue;
-						while (SCpnt1) {
-							if (SCpnt1->request.rq_status != RQ_INACTIVE
-							&& SCpnt1 != SCpnt
-							    && SCpnt1->channel == SCpnt->channel)
-								scsi_request_sense(SCpnt);
-							SCpnt1 = SCpnt1->next;
-						}
-					}
-				}
-				return 0;
-			case SCSI_RESET_SNOOZE:
-				/* In this case, we set the timeout field to 0
-				 * so that this command does not time out any more,
-				 * and we return 1 so that we get a message on the
-				 * screen.
-				 */
-				SCpnt->internal_timeout &= ~(IN_RESET | IN_RESET2 | IN_RESET3);
-				update_timeout(SCpnt, 0);
-				/* If you snooze, you lose... */
-			case SCSI_RESET_ERROR:
-			default:
-				return 1;
-			}
-
-			return temp;
-		}
-	}
-}
-
-/*
- * The strategy is to cause the timer code to call scsi_times_out()
- * when the soonest timeout is pending.
- * The arguments are used when we are queueing a new command, because
- * we do not want to subtract the time used from this time, but when we
- * set the timer, we want to take this value into account.
- */
-
-int update_timeout(Scsi_Cmnd * SCset, int timeout)
-{
-	int rtn;
-
-	/*
-	 * We are using the new error handling code to actually register/deregister
-	 * timers for timeout.
-	 */
-
-	if (!timer_pending(&SCset->eh_timeout)) {
-		rtn = 0;
-	} else {
-		rtn = SCset->eh_timeout.expires - jiffies;
-	}
-
-	if (timeout == 0) {
-		scsi_delete_timer(SCset);
-	} else {
-		scsi_add_timer(SCset, timeout, scsi_old_times_out);
-	}
-
-	return rtn;
-}
-
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-indent-level: 4
- * c-brace-imaginary-offset: 0
- * c-brace-offset: -4
- * c-argdecl-indent: 4
- * c-label-offset: -4
- * c-continued-statement-offset: 4
- * c-continued-brace-offset: 0
- * indent-tabs-mode: nil
- * tab-width: 8
- * End:
- */
diff -uNr -Xdontdiff ../master/linux-2.5.1-pre2/drivers/scsi/scsi_obsolete.h linux/drivers/scsi/scsi_obsolete.h
--- ../master/linux-2.5.1-pre2/drivers/scsi/scsi_obsolete.h	Sat Sep  4 19:48:46 1999
+++ linux/drivers/scsi/scsi_obsolete.h	Thu Jan  1 01:00:00 1970
@@ -1,106 +0,0 @@
-/*
- *  scsi_obsolete.h Copyright (C) 1997 Eric Youngdale
- *
- */
-
-#ifndef _SCSI_OBSOLETE_H
-#define _SCSI_OBSOLETE_H
-
-/*
- * These are the return codes for the abort and reset functions.  The mid-level
- * code uses these to decide what to do next.  Each of the low level abort
- * and reset functions must correctly indicate what it has done.
- * The descriptions are written from the point of view of the mid-level code,
- * so that the return code is telling the mid-level drivers exactly what
- * the low level driver has already done, and what remains to be done.
- */
-
-/* We did not do anything.  
- * Wait some more for this command to complete, and if this does not work, 
- * try something more serious. */
-#define SCSI_ABORT_SNOOZE 0
-
-/* This means that we were able to abort the command.  We have already
- * called the mid-level done function, and do not expect an interrupt that 
- * will lead to another call to the mid-level done function for this command */
-#define SCSI_ABORT_SUCCESS 1
-
-/* We called for an abort of this command, and we should get an interrupt 
- * when this succeeds.  Thus we should not restore the timer for this
- * command in the mid-level abort function. */
-#define SCSI_ABORT_PENDING 2
-
-/* Unable to abort - command is currently on the bus.  Grin and bear it. */
-#define SCSI_ABORT_BUSY 3
-
-/* The command is not active in the low level code. Command probably
- * finished. */
-#define SCSI_ABORT_NOT_RUNNING 4
-
-/* Something went wrong.  The low level driver will indicate the correct
- * error condition when it calls scsi_done, so the mid-level abort function
- * can simply wait until this comes through */
-#define SCSI_ABORT_ERROR 5
-
-/* We do not know how to reset the bus, or we do not want to.  Bummer.
- * Anyway, just wait a little more for the command in question, and hope that
- * it eventually finishes.  If it never finishes, the SCSI device could
- * hang, so use this with caution. */
-#define SCSI_RESET_SNOOZE 0
-
-/* We do not know how to reset the bus, or we do not want to.  Bummer.
- * We have given up on this ever completing.  The mid-level code will
- * request sense information to decide how to proceed from here. */
-#define SCSI_RESET_PUNT 1
-
-/* This means that we were able to reset the bus.  We have restarted all of
- * the commands that should be restarted, and we should be able to continue
- * on normally from here.  We do not expect any interrupts that will return
- * DID_RESET to any of the other commands in the host_queue, and the mid-level
- * code does not need to do anything special to keep the commands alive. 
- * If a hard reset was performed then all outstanding commands on the
- * bus have been restarted. */
-#define SCSI_RESET_SUCCESS 2
-
-/* We called for a reset of this bus, and we should get an interrupt 
- * when this succeeds.  Each command should get its own status
- * passed up to scsi_done, but this has not happened yet. 
- * If a hard reset was performed, then we expect an interrupt
- * for *each* of the outstanding commands that will have the
- * effect of restarting the commands.
- */
-#define SCSI_RESET_PENDING 3
-
-/* We did a reset, but do not expect an interrupt to signal DID_RESET.
- * This tells the upper level code to request the sense info, and this
- * should keep the command alive. */
-#define SCSI_RESET_WAKEUP 4
-
-/* The command is not active in the low level code. Command probably
-   finished. */
-#define SCSI_RESET_NOT_RUNNING 5
-
-/* Something went wrong, and we do not know how to fix it. */
-#define SCSI_RESET_ERROR 6
-
-#define SCSI_RESET_SYNCHRONOUS		0x01
-#define SCSI_RESET_ASYNCHRONOUS		0x02
-#define SCSI_RESET_SUGGEST_BUS_RESET	0x04
-#define SCSI_RESET_SUGGEST_HOST_RESET	0x08
-/*
- * This is a bitmask that is ored with one of the above codes.
- * It tells the mid-level code that we did a hard reset.
- */
-#define SCSI_RESET_BUS_RESET 0x100
-/*
- * This is a bitmask that is ored with one of the above codes.
- * It tells the mid-level code that we did a host adapter reset.
- */
-#define SCSI_RESET_HOST_RESET 0x200
-/*
- * Used to mask off bits and to obtain the basic action that was
- * performed.  
- */
-#define SCSI_RESET_ACTION   0xff
-
-#endif				/* SCSI_OBSOLETE_H */
diff -uNr -Xdontdiff ../master/linux-2.5.1-pre2/drivers/scsi/scsi_syms.c linux/drivers/scsi/scsi_syms.c
--- ../master/linux-2.5.1-pre2/drivers/scsi/scsi_syms.c	Tue Jul  3 00:27:56 2001
+++ linux/drivers/scsi/scsi_syms.c	Wed Nov 28 13:39:16 2001
@@ -54,7 +54,6 @@
 EXPORT_SYMBOL(scsi_release_command);
 EXPORT_SYMBOL(print_Scsi_Cmnd);
 EXPORT_SYMBOL(scsi_block_when_processing_errors);
-EXPORT_SYMBOL(scsi_mark_host_reset);
 EXPORT_SYMBOL(scsi_ioctl_send_command);
 #if defined(CONFIG_SCSI_LOGGING)	/* { */
 EXPORT_SYMBOL(scsi_logging_level);
diff -uNr -Xdontdiff ../master/linux-2.5.1-pre2/drivers/scsi/sim710.h linux/drivers/scsi/sim710.h
--- ../master/linux-2.5.1-pre2/drivers/scsi/sim710.h	Fri Jul 20 06:07:45 2001
+++ linux/drivers/scsi/sim710.h	Wed Nov 28 13:25:18 2001
@@ -38,7 +38,6 @@
 		      sg_tablesize:		128,		 	\
 		      cmd_per_lun:		1,		 	\
 		      use_clustering:		DISABLE_CLUSTERING,	\
-		      use_new_eh_code:		1}
 
 #ifndef HOSTS_C
 
diff -uNr -Xdontdiff ../master/linux-2.5.1-pre2/drivers/scsi/sym53c8xx_2/sym53c8xx.h linux/drivers/scsi/sym53c8xx_2/sym53c8xx.h
--- ../master/linux-2.5.1-pre2/drivers/scsi/sym53c8xx_2/sym53c8xx.h	Wed Nov 28 13:20:39 2001
+++ linux/drivers/scsi/sym53c8xx_2/sym53c8xx.h	Wed Nov 28 13:36:10 2001
@@ -109,7 +109,6 @@
 	release:		sym53c8xx_release,			\
 	info:			sym53c8xx_info, 			\
 	queuecommand:		sym53c8xx_queue_command,		\
-	use_new_eh_code:	1,					\
 	eh_abort_handler:	sym53c8xx_eh_abort_handler,		\
 	eh_device_reset_handler:sym53c8xx_eh_device_reset_handler,	\
 	eh_bus_reset_handler:	sym53c8xx_eh_bus_reset_handler,		\
diff -uNr -Xdontdiff ../master/linux-2.5.1-pre2/drivers/scsi/u14-34f.h linux/drivers/scsi/u14-34f.h
--- ../master/linux-2.5.1-pre2/drivers/scsi/u14-34f.h	Sun May 20 02:43:06 2001
+++ linux/drivers/scsi/u14-34f.h	Wed Nov 28 13:25:12 2001
@@ -30,7 +30,6 @@
                 this_id:                 7,                                  \
                 unchecked_isa_dma:       1,                                  \
                 use_clustering:          ENABLE_CLUSTERING,                  \
-                use_new_eh_code:         1    /* Enable new error code */    \
                 }
 
 #endif
diff -uNr -Xdontdiff ../master/linux-2.5.1-pre2/drivers/scsi/wd7000.h linux/drivers/scsi/wd7000.h
--- ../master/linux-2.5.1-pre2/drivers/scsi/wd7000.h	Fri Jul 20 06:08:46 2001
+++ linux/drivers/scsi/wd7000.h	Wed Nov 28 13:25:04 2001
@@ -57,6 +57,5 @@
 	cmd_per_lun:		1,				\
 	unchecked_isa_dma:	1,				\
 	use_clustering:		ENABLE_CLUSTERING,		\
-	use_new_eh_code:	0				\
 }
 #endif
diff -uNr -Xdontdiff ../master/linux-2.5.1-pre2/drivers/usb/hpusbscsi.h linux/drivers/usb/hpusbscsi.h
--- ../master/linux-2.5.1-pre2/drivers/usb/hpusbscsi.h	Fri Oct  5 21:04:51 2001
+++ linux/drivers/usb/hpusbscsi.h	Wed Nov 28 13:33:51 2001
@@ -73,7 +73,6 @@
 	present:		0,
 	unchecked_isa_dma:	FALSE,
 	use_clustering:		TRUE,
-	use_new_eh_code:	TRUE,
 	emulated:		TRUE
 };
 
diff -uNr -Xdontdiff ../master/linux-2.5.1-pre2/drivers/usb/microtek.c linux/drivers/usb/microtek.c
--- ../master/linux-2.5.1-pre2/drivers/usb/microtek.c	Fri Oct  5 21:04:51 2001
+++ linux/drivers/usb/microtek.c	Wed Nov 28 13:33:37 2001
@@ -760,7 +760,6 @@
 	present:		0,
 	unchecked_isa_dma:	FALSE,
 	use_clustering:		TRUE,
-	use_new_eh_code:	TRUE,
 	emulated:		TRUE
 };
 
diff -uNr -Xdontdiff ../master/linux-2.5.1-pre2/drivers/usb/storage/scsiglue.c linux/drivers/usb/storage/scsiglue.c
--- ../master/linux-2.5.1-pre2/drivers/usb/storage/scsiglue.c	Sun Nov 11 19:01:32 2001
+++ linux/drivers/usb/storage/scsiglue.c	Wed Nov 28 13:33:57 2001
@@ -388,7 +388,6 @@
 	present:		0,
 	unchecked_isa_dma:	FALSE,
 	use_clustering:		TRUE,
-	use_new_eh_code:	TRUE,
 	emulated:		TRUE
 };
 
