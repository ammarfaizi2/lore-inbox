Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261832AbVDOPNA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261832AbVDOPNA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 11:13:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261833AbVDOPLe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 11:11:34 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:29202 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261832AbVDOPKa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 11:10:30 -0400
Date: Fri, 15 Apr 2005 17:10:29 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: achim_leubner@adaptec.com, James.Bottomley@SteelEye.com,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/scsi/gdth.c: cleanups
Message-ID: <20050415151029.GF5456@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following cleanups:
- make some needlessly global functions static
- remove one more kernel 2.2 #ifdef

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 28 Feb 2005

 drivers/scsi/gdth.c |   24 ++++++++++++------------
 drivers/scsi/gdth.h |   41 -----------------------------------------
 2 files changed, 12 insertions(+), 53 deletions(-)

--- linux-2.6.11-rc4-mm1-full/drivers/scsi/gdth.h.old	2005-02-28 18:25:09.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/scsi/gdth.h	2005-02-28 18:31:38.000000000 +0100
@@ -1029,51 +1029,10 @@
 
 /* function prototyping */
 
-int gdth_detect(Scsi_Host_Template *);
-int gdth_release(struct Scsi_Host *);
-int gdth_queuecommand(Scsi_Cmnd *,void (*done)(Scsi_Cmnd *));
-const char *gdth_info(struct Scsi_Host *);
-
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
-int gdth_bios_param(struct scsi_device *,struct block_device *,sector_t,int *);
 int gdth_proc_info(struct Scsi_Host *, char *,char **,off_t,int,int);
-#elif LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
-int gdth_bios_param(Disk *,kdev_t,int *);
-int gdth_proc_info(char *,char **,off_t,int,int,int);
 #else
-int gdth_bios_param(Disk *,kdev_t,int *);
-extern struct proc_dir_entry proc_scsi_gdth;
 int gdth_proc_info(char *,char **,off_t,int,int,int);
-int gdth_abort(Scsi_Cmnd *);
-int gdth_reset(Scsi_Cmnd *,unsigned int); 
-#define GDTH { proc_dir:        &proc_scsi_gdth,                 \
-               proc_info:       gdth_proc_info,                  \
-               name:            "GDT SCSI Disk Array Controller",\
-               detect:          gdth_detect,                     \
-               release:         gdth_release,                    \
-               info:            gdth_info,                       \
-               command:         NULL,                            \
-               queuecommand:    gdth_queuecommand,               \
-               eh_abort_handler: gdth_eh_abort,                  \
-               eh_device_reset_handler: gdth_eh_device_reset,    \
-               eh_bus_reset_handler: gdth_eh_bus_reset,          \
-               eh_host_reset_handler: gdth_eh_host_reset,        \
-               abort:           gdth_abort,                      \
-               reset:           gdth_reset,                      \
-               bios_param:      gdth_bios_param,                 \
-               can_queue:       GDTH_MAXCMDS,                    \
-               this_id:         -1,                              \
-               sg_tablesize:    GDTH_MAXSG,                      \
-               cmd_per_lun:     GDTH_MAXC_P_L,                   \
-               present:         0,                               \
-               unchecked_isa_dma: 1,                             \
-               use_clustering:  ENABLE_CLUSTERING,               \
-               use_new_eh_code: 1       /* use new error code */ }    
 #endif
 
-int gdth_eh_abort(Scsi_Cmnd *scp);
-int gdth_eh_device_reset(Scsi_Cmnd *scp);
-int gdth_eh_bus_reset(Scsi_Cmnd *scp);
-int gdth_eh_host_reset(Scsi_Cmnd *scp);
-
 #endif
--- linux-2.6.11-rc4-mm1-full/drivers/scsi/gdth.c.old	2005-02-28 18:25:50.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/scsi/gdth.c	2005-02-28 18:44:14.000000000 +0100
@@ -4034,7 +4034,7 @@
 }
 
 #ifdef GDTH_STATISTICS
-void gdth_timeout(ulong data)
+static void gdth_timeout(ulong data)
 {
     ulong32 i;
     Scsi_Cmnd *nscp;
@@ -4062,7 +4062,7 @@
 }
 #endif
 
-void __init internal_setup(char *str,int *ints)
+static void __init internal_setup(char *str,int *ints)
 {
     int i, argc;
     char *cur_str, *argv;
@@ -4153,7 +4153,7 @@
     return 1;
 }
 
-int __init gdth_detect(Scsi_Host_Template *shtp)
+static int __init gdth_detect(Scsi_Host_Template *shtp)
 {
     struct Scsi_Host *shp;
     gdth_pci_str pcistr[MAXHA];
@@ -4604,7 +4604,7 @@
 }
 
 
-int gdth_release(struct Scsi_Host *shp)
+static int gdth_release(struct Scsi_Host *shp)
 {
     int hanum;
     gdth_ha_str *ha;
@@ -4691,7 +4691,7 @@
     return("");
 }
 
-const char *gdth_info(struct Scsi_Host *shp)
+static const char *gdth_info(struct Scsi_Host *shp)
 {
     int hanum;
     gdth_ha_str *ha;
@@ -4704,19 +4704,19 @@
 }
 
 /* new error handling */
-int gdth_eh_abort(Scsi_Cmnd *scp)
+static int gdth_eh_abort(Scsi_Cmnd *scp)
 {
     TRACE2(("gdth_eh_abort()\n"));
     return FAILED;
 }
 
-int gdth_eh_device_reset(Scsi_Cmnd *scp)
+static int gdth_eh_device_reset(Scsi_Cmnd *scp)
 {
     TRACE2(("gdth_eh_device_reset()\n"));
     return FAILED;
 }
 
-int gdth_eh_bus_reset(Scsi_Cmnd *scp)
+static int gdth_eh_bus_reset(Scsi_Cmnd *scp)
 {
     int i, hanum;
     gdth_ha_str *ha;
@@ -4770,7 +4770,7 @@
     return SUCCESS;
 }
 
-int gdth_eh_host_reset(Scsi_Cmnd *scp)
+static int gdth_eh_host_reset(Scsi_Cmnd *scp)
 {
     TRACE2(("gdth_eh_host_reset()\n"));
     return FAILED;
@@ -4778,9 +4778,9 @@
 
 
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
-int gdth_bios_param(struct scsi_device *sdev,struct block_device *bdev,sector_t cap,int *ip)
+static int gdth_bios_param(struct scsi_device *sdev,struct block_device *bdev,sector_t cap,int *ip)
 #else
-int gdth_bios_param(Disk *disk,kdev_t dev,int *ip)
+static int gdth_bios_param(Disk *disk,kdev_t dev,int *ip)
 #endif
 {
     unchar b, t;
@@ -4818,7 +4818,7 @@
 }
 
 
-int gdth_queuecommand(Scsi_Cmnd *scp,void (*done)(Scsi_Cmnd *))
+static int gdth_queuecommand(Scsi_Cmnd *scp,void (*done)(Scsi_Cmnd *))
 {
     int hanum;
     int priority;

