Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261744AbVB1VEV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261744AbVB1VEV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 16:04:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261761AbVB1VDi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 16:03:38 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:58887 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261744AbVB1VA0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 16:00:26 -0500
Date: Mon, 28 Feb 2005 22:00:24 +0100
From: Adrian Bunk <bunk@stusta.de>
To: andrew.vasquez@qlogic.com
Cc: James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/scsi/qla2xxx/: cleanups
Message-ID: <20050228210024.GM4021@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following cleanups:
- make needlessly global code static
- kill the unused global *_version and *_version_str variables
  in the firmware files

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/scsi/qla2xxx/ql2100.c     |    2 
 drivers/scsi/qla2xxx/ql2100_fw.c  |   12 -----
 drivers/scsi/qla2xxx/ql2200.c     |    2 
 drivers/scsi/qla2xxx/ql2200_fw.c  |   12 -----
 drivers/scsi/qla2xxx/ql2300.c     |    2 
 drivers/scsi/qla2xxx/ql2300_fw.c  |   12 -----
 drivers/scsi/qla2xxx/ql2322.c     |    2 
 drivers/scsi/qla2xxx/ql2322_fw.c  |   12 -----
 drivers/scsi/qla2xxx/ql6312.c     |    2 
 drivers/scsi/qla2xxx/ql6312_fw.c  |   12 -----
 drivers/scsi/qla2xxx/qla_gbl.h    |    8 ---
 drivers/scsi/qla2xxx/qla_inline.h |   49 ---------------------
 drivers/scsi/qla2xxx/qla_os.c     |   68 ++++++++++++++++++++++++------
 13 files changed, 56 insertions(+), 139 deletions(-)

--- linux-2.6.11-rc4-mm1-full/drivers/scsi/qla2xxx/ql2100_fw.c.old	2005-02-28 19:41:38.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/scsi/qla2xxx/ql2100_fw.c	2005-02-28 19:41:50.000000000 +0100
@@ -22,18 +22,6 @@
  */
 
 #ifdef UNIQUE_FW_NAME
-unsigned short fw2100tp_version = 1*1024+19;
-#else
-unsigned short risc_code_version = 1*1024+19;
-#endif
-
-#ifdef UNIQUE_FW_NAME
-unsigned char fw2100tp_version_str[] = {1,19,24};
-#else
-unsigned char firmware_version[] = {1,19,24};
-#endif
-
-#ifdef UNIQUE_FW_NAME
 #define fw2100tp_VERSION_STRING "1.19.24"
 #else
 #define FW_VERSION_STRING "1.19.24"
--- linux-2.6.11-rc4-mm1-full/drivers/scsi/qla2xxx/ql2100.c.old	2005-02-28 19:42:04.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/scsi/qla2xxx/ql2100.c	2005-02-28 19:42:18.000000000 +0100
@@ -14,8 +14,6 @@
 
 static char qla_driver_name[] = "qla2100";
 
-extern unsigned char  fw2100tp_version[];
-extern unsigned char  fw2100tp_version_str[];
 extern unsigned short fw2100tp_addr01;
 extern unsigned short fw2100tp_code01[];
 extern unsigned short fw2100tp_length01;
--- linux-2.6.11-rc4-mm1-full/drivers/scsi/qla2xxx/ql2200_fw.c.old	2005-02-28 19:42:26.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/scsi/qla2xxx/ql2200_fw.c	2005-02-28 19:42:35.000000000 +0100
@@ -22,18 +22,6 @@
  */
 
 #ifdef UNIQUE_FW_NAME
-unsigned short fw2200tp_version = 2*1024+2;
-#else
-unsigned short risc_code_version = 2*1024+2;
-#endif
-
-#ifdef UNIQUE_FW_NAME
-unsigned char fw2200tp_version_str[] = {2,2,6};
-#else
-unsigned char firmware_version[] = {2,2,6};
-#endif
-
-#ifdef UNIQUE_FW_NAME
 #define fw2200tp_VERSION_STRING "2.02.06"
 #else
 #define FW_VERSION_STRING "2.02.06"
--- linux-2.6.11-rc4-mm1-full/drivers/scsi/qla2xxx/ql2200.c.old	2005-02-28 19:42:44.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/scsi/qla2xxx/ql2200.c	2005-02-28 19:42:47.000000000 +0100
@@ -14,8 +14,6 @@
 
 static char qla_driver_name[] = "qla2200";
 
-extern unsigned char  fw2200tp_version[];
-extern unsigned char  fw2200tp_version_str[];
 extern unsigned short fw2200tp_addr01;
 extern unsigned short fw2200tp_code01[];
 extern unsigned short fw2200tp_length01;
--- linux-2.6.11-rc4-mm1-full/drivers/scsi/qla2xxx/ql2300.c.old	2005-02-28 19:43:16.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/scsi/qla2xxx/ql2300.c	2005-02-28 19:43:47.000000000 +0100
@@ -14,8 +14,6 @@
 
 static char qla_driver_name[] = "qla2300";
 
-extern unsigned char  fw2300ipx_version[];
-extern unsigned char  fw2300ipx_version_str[];
 extern unsigned short fw2300ipx_addr01;
 extern unsigned short fw2300ipx_code01[];
 extern unsigned short fw2300ipx_length01;
--- linux-2.6.11-rc4-mm1-full/drivers/scsi/qla2xxx/ql2300_fw.c.old	2005-02-28 19:43:33.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/scsi/qla2xxx/ql2300_fw.c	2005-02-28 19:43:43.000000000 +0100
@@ -22,18 +22,6 @@
  */
 
 #ifdef UNIQUE_FW_NAME
-unsigned short fw2300ipx_version = 3*1024+3;
-#else
-unsigned short risc_code_version = 3*1024+3;
-#endif
-
-#ifdef UNIQUE_FW_NAME
-unsigned char fw2300ipx_version_str[] = {3, 3, 8};
-#else
-unsigned char firmware_version[] = {3, 3, 8};
-#endif
-
-#ifdef UNIQUE_FW_NAME
 #define fw2300ipx_VERSION_STRING "3.03.08"
 #else
 #define FW_VERSION_STRING "3.03.08"
--- linux-2.6.11-rc4-mm1-full/drivers/scsi/qla2xxx/ql2322_fw.c.old	2005-02-28 19:43:58.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/scsi/qla2xxx/ql2322_fw.c	2005-02-28 19:44:06.000000000 +0100
@@ -22,18 +22,6 @@
  */
 
 #ifdef UNIQUE_FW_NAME
-unsigned short fw2322ipx_version = 3*1024+3;
-#else
-unsigned short risc_code_version = 3*1024+3;
-#endif
-
-#ifdef UNIQUE_FW_NAME
-unsigned char fw2322ipx_version_str[] = {3, 3, 8};
-#else
-unsigned char firmware_version[] = {3, 3, 8};
-#endif
-
-#ifdef UNIQUE_FW_NAME
 #define fw2322ipx_VERSION_STRING "3.03.08"
 #else
 #define FW_VERSION_STRING "3.03.08"
--- linux-2.6.11-rc4-mm1-full/drivers/scsi/qla2xxx/ql2322.c.old	2005-02-28 19:44:16.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/scsi/qla2xxx/ql2322.c	2005-02-28 19:44:21.000000000 +0100
@@ -13,8 +13,6 @@
 
 static char qla_driver_name[] = "qla2322";
 
-extern unsigned char  fw2322ipx_version[];
-extern unsigned char  fw2322ipx_version_str[];
 extern unsigned short fw2322ipx_addr01;
 extern unsigned short fw2322ipx_code01[];
 extern unsigned short fw2322ipx_length01;
--- linux-2.6.11-rc4-mm1-full/drivers/scsi/qla2xxx/ql6312_fw.c.old	2005-02-28 19:44:37.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/scsi/qla2xxx/ql6312_fw.c	2005-02-28 19:44:45.000000000 +0100
@@ -22,18 +22,6 @@
  */
 
 #ifdef UNIQUE_FW_NAME
-unsigned short fw2300flx_version = 3*1024+3;
-#else
-unsigned short risc_code_version = 3*1024+3;
-#endif
-
-#ifdef UNIQUE_FW_NAME
-unsigned char fw2300flx_version_str[] = {3, 3, 8};
-#else
-unsigned char firmware_version[] = {3, 3, 8};
-#endif
-
-#ifdef UNIQUE_FW_NAME
 #define fw2300flx_VERSION_STRING "3.03.08"
 #else
 #define FW_VERSION_STRING "3.03.08"
--- linux-2.6.11-rc4-mm1-full/drivers/scsi/qla2xxx/ql6312.c.old	2005-02-28 19:45:01.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/scsi/qla2xxx/ql6312.c	2005-02-28 19:45:05.000000000 +0100
@@ -13,8 +13,6 @@
 
 static char qla_driver_name[] = "qla6312";
 
-extern unsigned char  fw2300flx_version[];
-extern unsigned char  fw2300flx_version_str[];
 extern unsigned short fw2300flx_addr01;
 extern unsigned short fw2300flx_code01[];
 extern unsigned short fw2300flx_length01;
--- linux-2.6.11-rc4-mm1-full/drivers/scsi/qla2xxx/qla_gbl.h.old	2005-02-28 19:46:22.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/scsi/qla2xxx/qla_gbl.h	2005-02-28 20:40:28.000000000 +0100
@@ -53,15 +53,9 @@
  */
 extern char qla2x00_version_str[];
 
-extern int num_hosts;
-extern int apiHBAInstance;
-
 extern struct _qla2x00stats qla2x00_stats;
-extern int ql2xretrycount;
 extern int ql2xlogintimeout;
 extern int qlport_down_retry;
-extern int ql2xmaxqdepth;
-extern int displayConfig;
 extern int ql2xplogiabsentdevice;
 extern int ql2xenablezio;
 extern int ql2xintrdelaytimer;
@@ -77,8 +71,6 @@
 
 extern char *qla2x00_get_fw_version_str(struct scsi_qla_host *, char *);
 
-extern void qla2x00_cmd_timeout(srb_t *);
-
 extern int __qla2x00_suspend_lun(scsi_qla_host_t *, os_lun_t *, int, int, int);
 
 extern void qla2x00_done(scsi_qla_host_t *);
--- linux-2.6.11-rc4-mm1-full/drivers/scsi/qla2xxx/qla_inline.h.old	2005-02-28 19:49:09.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/scsi/qla2xxx/qla_inline.h	2005-02-28 20:45:00.000000000 +0100
@@ -241,52 +241,3 @@
 	}
 	return (QLA_SUCCESS);
 }
-
-static __inline__ void qla2x00_add_timer_to_cmd(srb_t *, int);
-static __inline__ void qla2x00_delete_timer_from_cmd(srb_t *);
-
-/**************************************************************************
-*   qla2x00_add_timer_to_cmd
-*
-* Description:
-*       Creates a timer for the specified command. The timeout is usually
-*       the command time from kernel minus 2 secs.
-*
-* Input:
-*     sp - pointer to validate
-*
-* Returns:
-*     None.
-**************************************************************************/
-static inline void
-qla2x00_add_timer_to_cmd(srb_t *sp, int timeout)
-{
-	init_timer(&sp->timer);
-	sp->timer.expires = jiffies + timeout * HZ;
-	sp->timer.data = (unsigned long) sp;
-	sp->timer.function = (void (*) (unsigned long))qla2x00_cmd_timeout;
-	add_timer(&sp->timer);
-}
-
-/**************************************************************************
-*   qla2x00_delete_timer_from_cmd
-*
-* Description:
-*       Delete the timer for the specified command.
-*
-* Input:
-*     sp - pointer to validate
-*
-* Returns:
-*     None.
-**************************************************************************/
-static inline void 
-qla2x00_delete_timer_from_cmd(srb_t *sp)
-{
-	if (sp->timer.function != NULL) {
-		del_timer(&sp->timer);
-		sp->timer.function =  NULL;
-		sp->timer.data = (unsigned long) NULL;
-	}
-}
-
--- linux-2.6.11-rc4-mm1-full/drivers/scsi/qla2xxx/qla_os.c.old	2005-02-28 19:46:36.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/scsi/qla2xxx/qla_os.c	2005-02-28 20:52:11.000000000 +0100
@@ -36,8 +36,8 @@
 /*
  * SRB allocation cache
  */
-char srb_cachep_name[16];
-kmem_cache_t *srb_cachep;
+static char srb_cachep_name[16];
+static kmem_cache_t *srb_cachep;
 
 /*
  * Stats for all adpaters.
@@ -47,13 +47,12 @@
 /*
  * Ioctl related information.
  */
-int num_hosts;
-int apiHBAInstance;
+static int num_hosts;
 
 /*
  * Module parameter information and variables
  */
-int ql2xmaxqdepth;
+static int ql2xmaxqdepth;
 module_param(ql2xmaxqdepth, int, S_IRUGO|S_IWUSR);
 MODULE_PARM_DESC(ql2xmaxqdepth,
 		"Maximum queue depth to report for target devices.");
@@ -69,13 +68,13 @@
 		"Maximum number of command retries to a port that returns"
 		"a PORT-DOWN status.");
 
-int ql2xretrycount = 20;
+static int ql2xretrycount = 20;
 module_param(ql2xretrycount, int, S_IRUGO|S_IWUSR);
 MODULE_PARM_DESC(ql2xretrycount,
 		"Maximum number of mid-layer retries allowed for a command.  "
 		"Default value is 20, ");
 
-int displayConfig;
+static int displayConfig;
 module_param(displayConfig, int, S_IRUGO|S_IWUSR);
 MODULE_PARM_DESC(displayConfig,
 		"If 1 then display the configuration used in /etc/modprobe.conf.");
@@ -100,7 +99,7 @@
 		"ZIO: Waiting time for Firmware before it generates an "
 		"interrupt to the host to notify completion of request.");
 
-int ConfigRequired;
+static int ConfigRequired;
 module_param(ConfigRequired, int, S_IRUGO|S_IRUSR);
 MODULE_PARM_DESC(ConfigRequired,
 		"If 1, then only configured devices passed in through the"
@@ -119,7 +118,7 @@
 		"target returns a <NOT READY> status.  Default is 10 "
 		"iterations.");
 
-int ql2xdoinitscan = 1;
+static int ql2xdoinitscan = 1;
 module_param(ql2xdoinitscan, int, S_IRUGO|S_IWUSR);
 MODULE_PARM_DESC(ql2xdoinitscan,
 		"Signal mid-layer to perform scan after driver load: 0 -- no "
@@ -163,6 +162,8 @@
 static int qla2x00_proc_info(struct Scsi_Host *, char *, char **,
     off_t, int, int);
 
+static void qla2x00_cmd_timeout(srb_t *sp);
+
 static struct scsi_host_template qla2x00_driver_template = {
 	.module			= THIS_MODULE,
 	.name			= "qla2xxx",
@@ -193,6 +194,51 @@
 
 static void qla2x00_display_fc_names(scsi_qla_host_t *);
 
+/**************************************************************************
+*   qla2x00_add_timer_to_cmd
+*
+* Description:
+*       Creates a timer for the specified command. The timeout is usually
+*       the command time from kernel minus 2 secs.
+*
+* Input:
+*     sp - pointer to validate
+*
+* Returns:
+*     None.
+**************************************************************************/
+static inline void
+qla2x00_add_timer_to_cmd(srb_t *sp, int timeout)
+{
+	init_timer(&sp->timer);
+	sp->timer.expires = jiffies + timeout * HZ;
+	sp->timer.data = (unsigned long) sp;
+	sp->timer.function = (void (*) (unsigned long))qla2x00_cmd_timeout;
+	add_timer(&sp->timer);
+}
+
+/**************************************************************************
+*   qla2x00_delete_timer_from_cmd
+*
+* Description:
+*       Delete the timer for the specified command.
+*
+* Input:
+*     sp - pointer to validate
+*
+* Returns:
+*     None.
+**************************************************************************/
+static inline void 
+qla2x00_delete_timer_from_cmd(srb_t *sp)
+{
+	if (sp->timer.function != NULL) {
+		del_timer(&sp->timer);
+		sp->timer.function =  NULL;
+		sp->timer.data = (unsigned long) NULL;
+	}
+}
+
 /* TODO Convert to inlines
  *
  * Timer routines
@@ -230,8 +276,6 @@
 	ha->timer_active = 0;
 }
 
-void qla2x00_cmd_timeout(srb_t *);
-
 static __inline__ void qla2x00_callback(scsi_qla_host_t *, struct scsi_cmnd *);
 static __inline__ void sp_put(struct scsi_qla_host * ha, srb_t *sp);
 static __inline__ void sp_get(struct scsi_qla_host * ha, srb_t *sp);
@@ -3876,7 +3920,7 @@
 * None.
 * Note:Need to add the support for if( sp->state == SRB_FAILOVER_STATE).
 **************************************************************************/
-void
+static void
 qla2x00_cmd_timeout(srb_t *sp)
 {
 	int t, l;

