Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422719AbWJFQzL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422719AbWJFQzL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 12:55:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422720AbWJFQzK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 12:55:10 -0400
Received: from pat.qlogic.com ([198.70.193.2]:11439 "EHLO avexch1.qlogic.com")
	by vger.kernel.org with ESMTP id S1422717AbWJFQzC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 12:55:02 -0400
Date: Fri, 6 Oct 2006 09:54:59 -0700
From: Andrew Vasquez <andrew.vasquez@qlogic.com>
To: James Bottomley <james.bottomley@steeleye.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux-SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Frederik Deweerdt <deweerdt@free.fr>
Subject: [PATCH] Maintain module-parameter name consistency with qla2xxx/qla4xxx.
Message-ID: <20061006165459.GF2365@n6014avq19270.qlogic.org>
References: <Pine.LNX.4.64.0610042017340.3952@g5.osdl.org> <20061005204918.GI352@slug> <20061005220131.GB9033@andrew-vasquezs-computer.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061005220131.GB9033@andrew-vasquezs-computer.local>
Organization: QLogic Corporation
User-Agent: Mutt/1.5.12-2006-07-14
X-OriginalArrivalTime: 06 Oct 2006 16:55:01.0211 (UTC) FILETIME=[29B312B0:01C6E968]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Andrew Vasquez <andrew.vasquez@qlogic.com>
---

> On Thu, 05 Oct 2006, Frederik Deweerdt wrote:
> 
> > On Wed, Oct 04, 2006 at 08:29:16PM -0700, Linus Torvalds wrote:
> > >  4998 total commits
> > >  6535 files changed, 414890 insertions(+), 233881 deletions(-)
> > commit 0181944fe647cae18d545ac1167df3d15d393701 adds a
> > 'extended_error_logging' global variable to qla2xxx which is defined by
> > qla4xxx too.
> > Trying to build both drivers results in the following error:
> > 
> >   LD      drivers/scsi/built-in.o
> >   drivers/scsi/qla4xxx/built-in.o: In function
> >   `qla4xxx_slave_configure':
> >   drivers/scsi/qla4xxx/ql4_os.c:1433: multiple definition of
> >   `extended_error_logging'
> >   drivers/scsi/qla2xxx/built-in.o:drivers/scsi/qla2xxx/qla_os.c:2166:
> >   first defined here
> >   make[2]: *** [drivers/scsi/built-in.o] Error 1
> >   make[1]: *** [drivers/scsi] Error 2
> >   make: *** [drivers] Error 2
> > 
> > The following patch simply adds a qla2_ (qla4_ respectively) prefix to
> > the variable name.
> 
> Thanks for doing this, but could I suggest the following instead which
> will at least maintain some consistency (yes, I know it's lacking)
> with other qla2xxx module-parameter prefixes (ql2x and ql4x).

Frederik's original patch made it into Linus' tree, James please add
this for the next scsi-rc-fixes.


diff --git a/drivers/scsi/qla2xxx/qla_dbg.h b/drivers/scsi/qla2xxx/qla_dbg.h
index 90dad7e..5b12278 100644
--- a/drivers/scsi/qla2xxx/qla_dbg.h
+++ b/drivers/scsi/qla2xxx/qla_dbg.h
@@ -38,7 +38,7 @@ #endif
 * Macros use for debugging the driver.
 */
 
-#define DEBUG(x)	do { if (qla2_extended_error_logging) { x; } } while (0)
+#define DEBUG(x)	do { if (ql2xextended_error_logging) { x; } } while (0)
 
 #if defined(QL_DEBUG_LEVEL_1)
 #define DEBUG1(x)	do {x;} while (0)
@@ -46,12 +46,12 @@ #else
 #define DEBUG1(x)	do {} while (0)
 #endif
 
-#define DEBUG2(x)	do { if (qla2_extended_error_logging) { x; } } while (0)
-#define DEBUG2_3(x)	do { if (qla2_extended_error_logging) { x; } } while (0)
-#define DEBUG2_3_11(x)	do { if (qla2_extended_error_logging) { x; } } while (0)
-#define DEBUG2_9_10(x)	do { if (qla2_extended_error_logging) { x; } } while (0)
-#define DEBUG2_11(x)	do { if (qla2_extended_error_logging) { x; } } while (0)
-#define DEBUG2_13(x)	do { if (qla2_extended_error_logging) { x; } } while (0)
+#define DEBUG2(x)	do { if (ql2xextended_error_logging) { x; } } while (0)
+#define DEBUG2_3(x)	do { if (ql2xextended_error_logging) { x; } } while (0)
+#define DEBUG2_3_11(x)	do { if (ql2xextended_error_logging) { x; } } while (0)
+#define DEBUG2_9_10(x)	do { if (ql2xextended_error_logging) { x; } } while (0)
+#define DEBUG2_11(x)	do { if (ql2xextended_error_logging) { x; } } while (0)
+#define DEBUG2_13(x)	do { if (ql2xextended_error_logging) { x; } } while (0)
 
 #if defined(QL_DEBUG_LEVEL_3)
 #define DEBUG3(x)	do {x;} while (0)
diff --git a/drivers/scsi/qla2xxx/qla_gbl.h b/drivers/scsi/qla2xxx/qla_gbl.h
index 7da6983..b51ce8f 100644
--- a/drivers/scsi/qla2xxx/qla_gbl.h
+++ b/drivers/scsi/qla2xxx/qla_gbl.h
@@ -60,7 +60,7 @@ extern int ql2xplogiabsentdevice;
 extern int ql2xloginretrycount;
 extern int ql2xfdmienable;
 extern int ql2xallocfwdump;
-extern int qla2_extended_error_logging;
+extern int ql2xextended_error_logging;
 
 extern void qla2x00_sp_compl(scsi_qla_host_t *, srb_t *);
 
diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index 833b930..d5e0a12 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -1644,7 +1644,7 @@ #endif
 	 * Set host adapter parameters.
 	 */
 	if (nv->host_p[0] & BIT_7)
-		qla2_extended_error_logging = 1;
+		ql2xextended_error_logging = 1;
 	ha->flags.disable_risc_code_load = ((nv->host_p[0] & BIT_4) ? 1 : 0);
 	/* Always load RISC code on non ISP2[12]00 chips. */
 	if (!IS_QLA2100(ha) && !IS_QLA2200(ha))
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 3f20d76..34b6eb7 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -61,9 +61,9 @@ MODULE_PARM_DESC(ql2xallocfwdump,
 		"during HBA initialization.  Memory allocation requirements "
 		"vary by ISP type.  Default is 1 - allocate memory.");
 
-int qla2_extended_error_logging;
-module_param(qla2_extended_error_logging, int, S_IRUGO|S_IRUSR);
-MODULE_PARM_DESC(qla2_extended_error_logging,
+int ql2xextended_error_logging;
+module_param(ql2xextended_error_logging, int, S_IRUGO|S_IRUSR);
+MODULE_PARM_DESC(ql2xextended_error_logging,
 		"Option to enable extended error logging, "
 		"Default is 0 - no logging. 1 - log errors.");
 
@@ -2697,7 +2697,7 @@ qla2x00_module_init(void)
 
 	/* Derive version string. */
 	strcpy(qla2x00_version_str, QLA2XXX_VERSION);
-	if (qla2_extended_error_logging)
+	if (ql2xextended_error_logging)
 		strcat(qla2x00_version_str, "-debug");
 
 	qla2xxx_transport_template =
diff --git a/drivers/scsi/qla4xxx/ql4_dbg.h b/drivers/scsi/qla4xxx/ql4_dbg.h
index 3e99dcf..d861c3b 100644
--- a/drivers/scsi/qla4xxx/ql4_dbg.h
+++ b/drivers/scsi/qla4xxx/ql4_dbg.h
@@ -22,14 +22,14 @@ #define DEBUG(x)	do {} while (0);
 #endif
 
 #if defined(QL_DEBUG_LEVEL_2)
-#define DEBUG2(x)      do {if(qla4_extended_error_logging == 2) x;} while (0);
+#define DEBUG2(x)      do {if(ql4xextended_error_logging == 2) x;} while (0);
 #define DEBUG2_3(x)   do {x;} while (0);
 #else				/*  */
 #define DEBUG2(x)	do {} while (0);
 #endif				/*  */
 
 #if defined(QL_DEBUG_LEVEL_3)
-#define DEBUG3(x)      do {if(qla4_extended_error_logging == 3) x;} while (0);
+#define DEBUG3(x)      do {if(ql4xextended_error_logging == 3) x;} while (0);
 #else				/*  */
 #define DEBUG3(x)	do {} while (0);
 #if !defined(QL_DEBUG_LEVEL_2)
diff --git a/drivers/scsi/qla4xxx/ql4_glbl.h b/drivers/scsi/qla4xxx/ql4_glbl.h
index 2c803ed..1b221ff 100644
--- a/drivers/scsi/qla4xxx/ql4_glbl.h
+++ b/drivers/scsi/qla4xxx/ql4_glbl.h
@@ -72,7 +72,7 @@ int qla4xxx_reinitialize_ddb_list(struct
 int qla4xxx_process_ddb_changed(struct scsi_qla_host * ha,
 				uint32_t fw_ddb_index, uint32_t state);
 
-extern int qla4_extended_error_logging;
+extern int ql4xextended_error_logging;
 extern int ql4xdiscoverywait;
 extern int ql4xdontresethba;
 #endif				/* _QLA4x_GBL_H */
diff --git a/drivers/scsi/qla4xxx/ql4_mbx.c b/drivers/scsi/qla4xxx/ql4_mbx.c
index ef82399..b721dc5 100644
--- a/drivers/scsi/qla4xxx/ql4_mbx.c
+++ b/drivers/scsi/qla4xxx/ql4_mbx.c
@@ -701,7 +701,7 @@ void qla4xxx_get_conn_event_log(struct s
 	DEBUG3(printk("scsi%ld: Connection Event Log Dump (%d entries):\n",
 		      ha->host_no, num_valid_entries));
 
-	if (qla4_extended_error_logging == 3) {
+	if (ql4xextended_error_logging == 3) {
 		if (oldest_entry == 0) {
 			/* Circular Buffer has not wrapped around */
 			for (i=0; i < num_valid_entries; i++) {
diff --git a/drivers/scsi/qla4xxx/ql4_os.c b/drivers/scsi/qla4xxx/ql4_os.c
index 178fcdd..dc3615f 100644
--- a/drivers/scsi/qla4xxx/ql4_os.c
+++ b/drivers/scsi/qla4xxx/ql4_os.c
@@ -34,9 +34,9 @@ MODULE_PARM_DESC(ql4xdontresethba,
 		 " default it will reset hba :0"
 		 " set to 1 to avoid resetting HBA");
 
-int qla4_extended_error_logging = 0; /* 0 = off, 1 = log errors */
-module_param(qla4_extended_error_logging, int, S_IRUGO | S_IRUSR);
-MODULE_PARM_DESC(qla4_extended_error_logging,
+int ql4xextended_error_logging = 0; /* 0 = off, 1 = log errors */
+module_param(ql4xextended_error_logging, int, S_IRUGO | S_IRUSR);
+MODULE_PARM_DESC(ql4xextended_error_logging,
 		 "Option to enable extended error logging, "
 		 "Default is 0 - no logging, 1 - debug logging");
 
@@ -1714,7 +1714,7 @@ static int __init qla4xxx_module_init(vo
 
 	/* Derive version string. */
 	strcpy(qla4xxx_version_str, QLA4XXX_DRIVER_VERSION);
-	if (qla4_extended_error_logging)
+	if (ql4xextended_error_logging)
 		strcat(qla4xxx_version_str, "-debug");
 
 	qla4xxx_scsi_transport =
