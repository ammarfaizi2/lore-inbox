Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932316AbWJEWBg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932316AbWJEWBg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 18:01:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932320AbWJEWBg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 18:01:36 -0400
Received: from pat.qlogic.com ([198.70.193.2]:52555 "EHLO avexch1.qlogic.com")
	by vger.kernel.org with ESMTP id S932316AbWJEWBe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 18:01:34 -0400
Date: Thu, 5 Oct 2006 15:01:31 -0700
From: Andrew Vasquez <andrew.vasquez@qlogic.com>
To: Frederik Deweerdt <deweerdt@free.fr>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux-SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] fix qla{2,4} build error
Message-ID: <20061005220131.GB9033@andrew-vasquezs-computer.local>
References: <Pine.LNX.4.64.0610042017340.3952@g5.osdl.org> <20061005204918.GI352@slug>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061005204918.GI352@slug>
Organization: QLogic Corporation
User-Agent: Mutt/1.5.12-2006-07-14
X-OriginalArrivalTime: 05 Oct 2006 22:01:33.0834 (UTC) FILETIME=[D224DEA0:01C6E8C9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Oct 2006, Frederik Deweerdt wrote:

> On Wed, Oct 04, 2006 at 08:29:16PM -0700, Linus Torvalds wrote:
> >  4998 total commits
> >  6535 files changed, 414890 insertions(+), 233881 deletions(-)
> commit 0181944fe647cae18d545ac1167df3d15d393701 adds a
> 'extended_error_logging' global variable to qla2xxx which is defined by
> qla4xxx too.
> Trying to build both drivers results in the following error:
> 
>   LD      drivers/scsi/built-in.o
>   drivers/scsi/qla4xxx/built-in.o: In function
>   `qla4xxx_slave_configure':
>   drivers/scsi/qla4xxx/ql4_os.c:1433: multiple definition of
>   `extended_error_logging'
>   drivers/scsi/qla2xxx/built-in.o:drivers/scsi/qla2xxx/qla_os.c:2166:
>   first defined here
>   make[2]: *** [drivers/scsi/built-in.o] Error 1
>   make[1]: *** [drivers/scsi] Error 2
>   make: *** [drivers] Error 2
> 
> The following patch simply adds a qla2_ (qla4_ respectively) prefix to
> the variable name.

Thanks for doing this, but could I suggest the following instead which
will at least maintain some consistency (yes, I know it's lacking)
with other qla2xxx module-parameter prefixes (ql2x and ql4x).

---

Signed-off-by: Andrew Vasquez <andrew.vasquez@qlogic.com>

diff --git a/drivers/scsi/qla2xxx/qla_dbg.h b/drivers/scsi/qla2xxx/qla_dbg.h
index 5334253..3a91709 100644
--- a/drivers/scsi/qla2xxx/qla_dbg.h
+++ b/drivers/scsi/qla2xxx/qla_dbg.h
@@ -38,7 +38,7 @@ #endif
 * Macros use for debugging the driver.
 */
 
-#define DEBUG(x)	do { if (extended_error_logging) { x; } } while (0)
+#define DEBUG(x)	do { if (ql2xextened_error_logging) { x; } } while (0)
 
 #if defined(QL_DEBUG_LEVEL_1)
 #define DEBUG1(x)	do {x;} while (0)
@@ -46,12 +46,12 @@ #else
 #define DEBUG1(x)	do {} while (0)
 #endif
 
-#define DEBUG2(x)	do { if (extended_error_logging) { x; } } while (0)
-#define DEBUG2_3(x)	do { if (extended_error_logging) { x; } } while (0)
-#define DEBUG2_3_11(x)	do { if (extended_error_logging) { x; } } while (0)
-#define DEBUG2_9_10(x)	do { if (extended_error_logging) { x; } } while (0)
-#define DEBUG2_11(x)	do { if (extended_error_logging) { x; } } while (0)
-#define DEBUG2_13(x)	do { if (extended_error_logging) { x; } } while (0)
+#define DEBUG2(x)	do { if (ql2xextened_error_logging) { x; } } while (0)
+#define DEBUG2_3(x)	do { if (ql2xextened_error_logging) { x; } } while (0)
+#define DEBUG2_3_11(x)	do { if (ql2xextened_error_logging) { x; } } while (0)
+#define DEBUG2_9_10(x)	do { if (ql2xextened_error_logging) { x; } } while (0)
+#define DEBUG2_11(x)	do { if (ql2xextened_error_logging) { x; } } while (0)
+#define DEBUG2_13(x)	do { if (ql2xextened_error_logging) { x; } } while (0)
 
 #if defined(QL_DEBUG_LEVEL_3)
 #define DEBUG3(x)	do {x;} while (0)
diff --git a/drivers/scsi/qla2xxx/qla_gbl.h b/drivers/scsi/qla2xxx/qla_gbl.h
index bef7011..e9aa2c0 100644
--- a/drivers/scsi/qla2xxx/qla_gbl.h
+++ b/drivers/scsi/qla2xxx/qla_gbl.h
@@ -60,7 +60,7 @@ extern int ql2xplogiabsentdevice;
 extern int ql2xloginretrycount;
 extern int ql2xfdmienable;
 extern int ql2xallocfwdump;
-extern int extended_error_logging;
+extern int ql2xextened_error_logging;
 
 extern void qla2x00_sp_compl(scsi_qla_host_t *, srb_t *);
 
diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index d5d2627..06e0f54 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -1644,7 +1644,7 @@ #endif
 	 * Set host adapter parameters.
 	 */
 	if (nv->host_p[0] & BIT_7)
-		extended_error_logging = 1;
+		ql2xextened_error_logging = 1;
 	ha->flags.disable_risc_code_load = ((nv->host_p[0] & BIT_4) ? 1 : 0);
 	/* Always load RISC code on non ISP2[12]00 chips. */
 	if (!IS_QLA2100(ha) && !IS_QLA2200(ha))
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 3ba8c23..a08f64c 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -61,9 +61,9 @@ MODULE_PARM_DESC(ql2xallocfwdump,
 		"during HBA initialization.  Memory allocation requirements "
 		"vary by ISP type.  Default is 1 - allocate memory.");
 
-int extended_error_logging;
-module_param(extended_error_logging, int, S_IRUGO|S_IRUSR);
-MODULE_PARM_DESC(extended_error_logging,
+int ql2xextened_error_logging;
+module_param(ql2xextened_error_logging, int, S_IRUGO|S_IRUSR);
+MODULE_PARM_DESC(ql2xextened_error_logging,
 		"Option to enable extended error logging, "
 		"Default is 0 - no logging. 1 - log errors.");
 
@@ -2697,7 +2697,7 @@ qla2x00_module_init(void)
 
 	/* Derive version string. */
 	strcpy(qla2x00_version_str, QLA2XXX_VERSION);
-	if (extended_error_logging)
+	if (ql2xextened_error_logging)
 		strcat(qla2x00_version_str, "-debug");
 
 	qla2xxx_transport_template =
diff --git a/drivers/scsi/qla4xxx/ql4_dbg.h b/drivers/scsi/qla4xxx/ql4_dbg.h
index 56ddc22..d31a747 100644
--- a/drivers/scsi/qla4xxx/ql4_dbg.h
+++ b/drivers/scsi/qla4xxx/ql4_dbg.h
@@ -22,14 +22,14 @@ #define DEBUG(x)	do {} while (0);
 #endif
 
 #if defined(QL_DEBUG_LEVEL_2)
-#define DEBUG2(x)      do {if(extended_error_logging == 2) x;} while (0);
+#define DEBUG2(x)      do {if(ql4xextened_error_logging == 2) x;} while (0);
 #define DEBUG2_3(x)   do {x;} while (0);
 #else				/*  */
 #define DEBUG2(x)	do {} while (0);
 #endif				/*  */
 
 #if defined(QL_DEBUG_LEVEL_3)
-#define DEBUG3(x)      do {if(extended_error_logging == 3) x;} while (0);
+#define DEBUG3(x)      do {if(ql4xextened_error_logging == 3) x;} while (0);
 #else				/*  */
 #define DEBUG3(x)	do {} while (0);
 #if !defined(QL_DEBUG_LEVEL_2)
diff --git a/drivers/scsi/qla4xxx/ql4_glbl.h b/drivers/scsi/qla4xxx/ql4_glbl.h
index 418fb7a..f20ce65 100644
--- a/drivers/scsi/qla4xxx/ql4_glbl.h
+++ b/drivers/scsi/qla4xxx/ql4_glbl.h
@@ -72,7 +72,7 @@ int qla4xxx_reinitialize_ddb_list(struct
 int qla4xxx_process_ddb_changed(struct scsi_qla_host * ha,
 				uint32_t fw_ddb_index, uint32_t state);
 
-extern int extended_error_logging;
+extern int ql4xextened_error_logging;
 extern int ql4xdiscoverywait;
 extern int ql4xdontresethba;
 #endif				/* _QLA4x_GBL_H */
diff --git a/drivers/scsi/qla4xxx/ql4_mbx.c b/drivers/scsi/qla4xxx/ql4_mbx.c
index ed977f7..dfaacbd 100644
--- a/drivers/scsi/qla4xxx/ql4_mbx.c
+++ b/drivers/scsi/qla4xxx/ql4_mbx.c
@@ -701,7 +701,7 @@ void qla4xxx_get_conn_event_log(struct s
 	DEBUG3(printk("scsi%ld: Connection Event Log Dump (%d entries):\n",
 		      ha->host_no, num_valid_entries));
 
-	if (extended_error_logging == 3) {
+	if (ql4xextened_error_logging == 3) {
 		if (oldest_entry == 0) {
 			/* Circular Buffer has not wrapped around */
 			for (i=0; i < num_valid_entries; i++) {
diff --git a/drivers/scsi/qla4xxx/ql4_os.c b/drivers/scsi/qla4xxx/ql4_os.c
index 5036ebf..cce7ea8 100644
--- a/drivers/scsi/qla4xxx/ql4_os.c
+++ b/drivers/scsi/qla4xxx/ql4_os.c
@@ -34,9 +34,9 @@ MODULE_PARM_DESC(ql4xdontresethba,
 		 " default it will reset hba :0"
 		 " set to 1 to avoid resetting HBA");
 
-int extended_error_logging = 0; /* 0 = off, 1 = log errors */
-module_param(extended_error_logging, int, S_IRUGO | S_IRUSR);
-MODULE_PARM_DESC(extended_error_logging,
+int ql4xextened_error_logging = 0; /* 0 = off, 1 = log errors */
+module_param(ql4xextened_error_logging, int, S_IRUGO | S_IRUSR);
+MODULE_PARM_DESC(ql4xextened_error_logging,
 		 "Option to enable extended error logging, "
 		 "Default is 0 - no logging, 1 - debug logging");
 
@@ -1714,7 +1714,7 @@ static int __init qla4xxx_module_init(vo
 
 	/* Derive version string. */
 	strcpy(qla4xxx_version_str, QLA4XXX_DRIVER_VERSION);
-	if (extended_error_logging)
+	if (ql4xextened_error_logging)
 		strcat(qla4xxx_version_str, "-debug");
 
 	qla4xxx_scsi_transport =
