Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261518AbVC0UWz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261518AbVC0UWz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 15:22:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261523AbVC0UWy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 15:22:54 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:10512 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261517AbVC0UVl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 15:21:41 -0500
Date: Sun, 27 Mar 2005 22:21:39 +0200
From: Adrian Bunk <bunk@stusta.de>
To: James.Bottomley@SteelEye.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] SCSI: cleanups
Message-ID: <20050327202139.GQ4285@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following cleanups:
- make needlessly global code static
- remove the following unused functions:
  - scsi.h: print_driverbyte
  - scsi.h: print_hostbyte
- #if 0 the following unused functions:
  - constants.c: scsi_print_hostbyte
  - constants.c: scsi_print_driverbyte
- remove the following unneeded EXPORT_SYMBOL's:
  - hosts.c: scsi_host_lookup
  - scsi.c: scsi_device_cancel
  - scsi_lib.c: scsi_device_resume

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/scsi/constants.c   |    4 ++++
 drivers/scsi/hosts.c       |    3 +--
 drivers/scsi/scsi.c        |    7 ++++---
 drivers/scsi/scsi.h        |    8 --------
 drivers/scsi/scsi_debug.c  |    2 +-
 drivers/scsi/scsi_lib.c    |    5 ++---
 drivers/scsi/scsi_priv.h   |    4 ----
 drivers/scsi/scsi_sysfs.c  |    5 ++---
 include/scsi/scsi_dbg.h    |    2 --
 include/scsi/scsi_device.h |    1 -
 10 files changed, 14 insertions(+), 27 deletions(-)

--- linux-2.6.11-rc4-mm1-full/drivers/scsi/scsi.h.old	2005-02-28 18:18:22.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/scsi/scsi.h	2005-03-01 00:58:19.000000000 +0100
@@ -80,14 +80,6 @@
 {
 	return scsi_print_req_sense(devclass, req);
 }
-static inline void print_driverbyte(int scsiresult)
-{
-	return scsi_print_driverbyte(scsiresult);
-}
-static inline void print_hostbyte(int scsiresult)
-{
-	return scsi_print_hostbyte(scsiresult);
-}
 static inline void print_status(unsigned char status)
 {
 	return scsi_print_status(status);
--- linux-2.6.11-rc4-mm1-full/include/scsi/scsi_dbg.h.old	2005-02-28 18:17:32.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/include/scsi/scsi_dbg.h	2005-03-01 01:01:25.000000000 +0100
@@ -11,8 +11,6 @@
 extern void __scsi_print_sense(const char *name,
 			       const unsigned char *sense_buffer,
 			       int sense_len);
-extern void scsi_print_driverbyte(int);
-extern void scsi_print_hostbyte(int);
 extern void scsi_print_status(unsigned char);
 extern int scsi_print_msg(const unsigned char *);
 extern const char *scsi_sense_key_string(unsigned char);
--- linux-2.6.11-rc4-mm1-full/drivers/scsi/constants.c.old	2005-02-28 18:17:46.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/scsi/constants.c	2005-03-01 01:00:37.000000000 +0100
@@ -1393,6 +1393,8 @@
 }
 EXPORT_SYMBOL(scsi_print_command);
 
+#if 0
+
 #ifdef CONFIG_SCSI_CONSTANTS
 
 static const char * hostbyte_table[]={
@@ -1446,3 +1448,5 @@
 	printk("Driverbyte=0x%02x ", driver_byte(scsiresult));
 }
 #endif
+
+#endif  /*  0  */
--- linux-2.6.11-rc4-mm1-full/drivers/scsi/hosts.c.old	2005-02-28 18:33:14.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/scsi/hosts.c	2005-03-01 00:58:19.000000000 +0100
@@ -56,7 +56,7 @@
  * @shost:	pointer to struct Scsi_Host
  * recovery:	recovery requested to run.
  **/
-void scsi_host_cancel(struct Scsi_Host *shost, int recovery)
+static void scsi_host_cancel(struct Scsi_Host *shost, int recovery)
 {
 	struct scsi_device *sdev;
 
@@ -362,7 +362,6 @@
 
 	return shost;
 }
-EXPORT_SYMBOL(scsi_host_lookup);
 
 /**
  * scsi_host_get - inc a Scsi_Host ref count
--- linux-2.6.11-rc4-mm1-full/drivers/scsi/scsi_priv.h.old	2005-02-28 19:59:30.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/scsi/scsi_priv.h	2005-03-01 00:58:19.000000000 +0100
@@ -66,8 +66,6 @@
 extern int scsi_dispatch_cmd(struct scsi_cmnd *cmd);
 extern int scsi_setup_command_freelist(struct Scsi_Host *shost);
 extern void scsi_destroy_command_freelist(struct Scsi_Host *shost);
-extern void scsi_done(struct scsi_cmnd *cmd);
-extern int scsi_retry_command(struct scsi_cmnd *cmd);
 extern int scsi_insert_special_req(struct scsi_request *sreq, int);
 extern void scsi_init_cmd_from_req(struct scsi_cmnd *cmd,
 		struct scsi_request *sreq);
@@ -141,7 +139,6 @@
 #endif /* CONFIG_SYSCTL */
 
 /* scsi_sysfs.c */
-extern void scsi_device_dev_release(struct device *);
 extern int scsi_sysfs_add_sdev(struct scsi_device *);
 extern int scsi_sysfs_add_host(struct Scsi_Host *);
 extern int scsi_sysfs_register(void);
@@ -150,7 +147,6 @@
 extern int scsi_sysfs_target_initialize(struct scsi_device *);
 extern struct scsi_transport_template blank_transport_template;
 
-extern struct class sdev_class;
 extern struct bus_type scsi_bus_type;
 
 /* 
--- linux-2.6.11-rc4-mm1-full/drivers/scsi/scsi.c.old	2005-02-28 19:59:56.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/scsi/scsi.c	2005-03-01 00:58:19.000000000 +0100
@@ -68,6 +68,8 @@
 #include "scsi_priv.h"
 #include "scsi_logging.h"
 
+static void scsi_done(struct scsi_cmnd *cmd);
+static int scsi_retry_command(struct scsi_cmnd *cmd);
 
 /*
  * Definitions and constants.
@@ -733,7 +735,7 @@
  *
  * This function is interrupt context safe.
  */
-void scsi_done(struct scsi_cmnd *cmd)
+static void scsi_done(struct scsi_cmnd *cmd)
 {
 	/*
 	 * We don't have to worry about this one timing out any more.
@@ -829,7 +831,7 @@
  *              level drivers should not become re-entrant as a result of
  *              this.
  */
-int scsi_retry_command(struct scsi_cmnd *cmd)
+static int scsi_retry_command(struct scsi_cmnd *cmd)
 {
 	/*
 	 * Restore the SCSI command state.
@@ -1215,7 +1217,6 @@
 
 	return 0;
 }
-EXPORT_SYMBOL(scsi_device_cancel);
 
 #ifdef CONFIG_HOTPLUG_CPU
 static int scsi_cpu_notify(struct notifier_block *self,
--- linux-2.6.11-rc4-mm1-full/drivers/scsi/scsi_debug.c.old	2005-02-28 20:22:08.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/scsi/scsi_debug.c	2005-03-01 00:58:19.000000000 +0100
@@ -1783,7 +1783,7 @@
 device_initcall(scsi_debug_init);
 module_exit(scsi_debug_exit);
 
-void pseudo_0_release(struct device * dev)
+static void pseudo_0_release(struct device * dev)
 {
 	if (SCSI_DEBUG_OPT_NOISE & scsi_debug_opts)
 		printk(KERN_INFO "scsi_debug: pseudo_0_release() called\n");
--- linux-2.6.11-rc4-mm1-full/include/scsi/scsi_device.h.old	2005-02-28 20:14:08.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/include/scsi/scsi_device.h	2005-03-01 00:58:19.000000000 +0100
@@ -223,7 +223,6 @@
 extern int scsi_device_set_state(struct scsi_device *sdev,
 				 enum scsi_device_state state);
 extern int scsi_device_quiesce(struct scsi_device *sdev);
-extern void scsi_device_resume(struct scsi_device *sdev);
 extern void scsi_target_quiesce(struct scsi_target *);
 extern void scsi_target_resume(struct scsi_target *);
 extern const char *scsi_device_state_name(enum scsi_device_state);
--- linux-2.6.11-rc4-mm1-full/drivers/scsi/scsi_lib.c.old	2005-02-28 20:14:23.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/scsi/scsi_lib.c	2005-03-01 00:58:19.000000000 +0100
@@ -44,7 +44,7 @@
 #endif
 
 #define SP(x) { x, "sgpool-" #x } 
-struct scsi_host_sg_pool scsi_sg_pools[] = { 
+static struct scsi_host_sg_pool scsi_sg_pools[] = { 
 	SP(8),
 	SP(16),
 	SP(32),
@@ -1817,14 +1817,13 @@
  *
  *	Must be called with user context, may sleep.
  **/
-void
+static void
 scsi_device_resume(struct scsi_device *sdev)
 {
 	if(scsi_device_set_state(sdev, SDEV_RUNNING))
 		return;
 	scsi_run_queue(sdev->request_queue);
 }
-EXPORT_SYMBOL(scsi_device_resume);
 
 static void
 device_quiesce_fn(struct scsi_device *sdev, void *data)
--- linux-2.6.11-rc4-mm1-full/drivers/scsi/scsi_sysfs.c.old	2005-02-28 20:19:41.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/scsi/scsi_sysfs.c	2005-03-01 00:58:19.000000000 +0100
@@ -150,7 +150,7 @@
 	put_device(&sdev->sdev_gendev);
 }
 
-void scsi_device_dev_release(struct device *dev)
+static void scsi_device_dev_release(struct device *dev)
 {
 	struct scsi_device *sdev;
 	struct device *parent;
@@ -188,7 +188,7 @@
 		put_device(parent);
 }
 
-struct class sdev_class = {
+static struct class sdev_class = {
 	.name		= "scsi_device",
 	.release	= scsi_device_cls_release,
 };

