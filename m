Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932178AbWJEUtp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932178AbWJEUtp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 16:49:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932185AbWJEUtp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 16:49:45 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:3482 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932178AbWJEUto (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 16:49:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=EmuiLKbhaz8qiUezuhT0xyv6/jTvFiDDCVloTQR/FAGvDcD66RUJCF0aBtVWxX7XznPOh+KQWha9auWEflFkPfqN8SJvFWmUyCpdh3PWj15pKkQTDRsIgK/EY7i6E2qhOCU+P1/l1RW45RFzZrJsgSiKDhy+TjbMBtI0NUQvoZk=
Date: Thu, 5 Oct 2006 20:49:18 +0000
From: Frederik Deweerdt <deweerdt@free.fr>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       andrew.vasquez@qlogic.com
Subject: [patch] fix qla{2,4} build error
Message-ID: <20061005204918.GI352@slug>
References: <Pine.LNX.4.64.0610042017340.3952@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610042017340.3952@g5.osdl.org>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2006 at 08:29:16PM -0700, Linus Torvalds wrote:
>  4998 total commits
>  6535 files changed, 414890 insertions(+), 233881 deletions(-)
commit 0181944fe647cae18d545ac1167df3d15d393701 adds a
'extended_error_logging' global variable to qla2xxx which is defined by
qla4xxx too.
Trying to build both drivers results in the following error:

  LD      drivers/scsi/built-in.o
  drivers/scsi/qla4xxx/built-in.o: In function
  `qla4xxx_slave_configure':
  drivers/scsi/qla4xxx/ql4_os.c:1433: multiple definition of
  `extended_error_logging'
  drivers/scsi/qla2xxx/built-in.o:drivers/scsi/qla2xxx/qla_os.c:2166:
  first defined here
  make[2]: *** [drivers/scsi/built-in.o] Error 1
  make[1]: *** [drivers/scsi] Error 2
  make: *** [drivers] Error 2

The following patch simply adds a qla2_ (qla4_ respectively) prefix to
the variable name.

Regards,
Frederik
 
Signed-off-by: Frederik Deweerdt <frederik.deweerdt@gmail.com>

diff --git a/drivers/scsi/qla2xxx/qla_dbg.h b/drivers/scsi/qla2xxx/qla_dbg.h
index 5334253..90dad7e 100644
--- a/drivers/scsi/qla2xxx/qla_dbg.h
+++ b/drivers/scsi/qla2xxx/qla_dbg.h
@@ -38,7 +38,7 @@ #endif
 * Macros use for debugging the driver.
 */
 
-#define DEBUG(x)	do { if (extended_error_logging) { x; } } while (0)
+#define DEBUG(x)	do { if (qla2_extended_error_logging) { x; } } while (0)
 
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
+#define DEBUG2(x)	do { if (qla2_extended_error_logging) { x; } } while (0)
+#define DEBUG2_3(x)	do { if (qla2_extended_error_logging) { x; } } while (0)
+#define DEBUG2_3_11(x)	do { if (qla2_extended_error_logging) { x; } } while (0)
+#define DEBUG2_9_10(x)	do { if (qla2_extended_error_logging) { x; } } while (0)
+#define DEBUG2_11(x)	do { if (qla2_extended_error_logging) { x; } } while (0)
+#define DEBUG2_13(x)	do { if (qla2_extended_error_logging) { x; } } while (0)
 
 #if defined(QL_DEBUG_LEVEL_3)
 #define DEBUG3(x)	do {x;} while (0)
diff --git a/drivers/scsi/qla2xxx/qla_gbl.h b/drivers/scsi/qla2xxx/qla_gbl.h
index bef7011..990b897 100644
--- a/drivers/scsi/qla2xxx/qla_gbl.h
+++ b/drivers/scsi/qla2xxx/qla_gbl.h
@@ -60,7 +60,7 @@ extern int ql2xplogiabsentdevice;
 extern int ql2xloginretrycount;
 extern int ql2xfdmienable;
 extern int ql2xallocfwdump;
-extern int extended_error_logging;
+extern int qla2_extended_error_logging;
 
 extern void qla2x00_sp_compl(scsi_qla_host_t *, srb_t *);
 
diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index d5d2627..833b930 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -1644,7 +1644,7 @@ #endif
 	 * Set host adapter parameters.
 	 */
 	if (nv->host_p[0] & BIT_7)
-		extended_error_logging = 1;
+		qla2_extended_error_logging = 1;
 	ha->flags.disable_risc_code_load = ((nv->host_p[0] & BIT_4) ? 1 : 0);
 	/* Always load RISC code on non ISP2[12]00 chips. */
 	if (!IS_QLA2100(ha) && !IS_QLA2200(ha))
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 3ba8c23..3f20d76 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -61,9 +61,9 @@ MODULE_PARM_DESC(ql2xallocfwdump,
 		"during HBA initialization.  Memory allocation requirements "
 		"vary by ISP type.  Default is 1 - allocate memory.");
 
-int extended_error_logging;
-module_param(extended_error_logging, int, S_IRUGO|S_IRUSR);
-MODULE_PARM_DESC(extended_error_logging,
+int qla2_extended_error_logging;
+module_param(qla2_extended_error_logging, int, S_IRUGO|S_IRUSR);
+MODULE_PARM_DESC(qla2_extended_error_logging,
 		"Option to enable extended error logging, "
 		"Default is 0 - no logging. 1 - log errors.");
 
@@ -2697,7 +2697,7 @@ qla2x00_module_init(void)
 
 	/* Derive version string. */
 	strcpy(qla2x00_version_str, QLA2XXX_VERSION);
-	if (extended_error_logging)
+	if (qla2_extended_error_logging)
 		strcat(qla2x00_version_str, "-debug");
 
 	qla2xxx_transport_template =
diff --git a/drivers/scsi/qla4xxx/ql4_dbg.h b/drivers/scsi/qla4xxx/ql4_dbg.h
index 56ddc22..3e99dcf 100644
--- a/drivers/scsi/qla4xxx/ql4_dbg.h
+++ b/drivers/scsi/qla4xxx/ql4_dbg.h
@@ -22,14 +22,14 @@ #define DEBUG(x)	do {} while (0);
 #endif
 
 #if defined(QL_DEBUG_LEVEL_2)
-#define DEBUG2(x)      do {if(extended_error_logging == 2) x;} while (0);
+#define DEBUG2(x)      do {if(qla4_extended_error_logging == 2) x;} while (0);
 #define DEBUG2_3(x)   do {x;} while (0);
 #else				/*  */
 #define DEBUG2(x)	do {} while (0);
 #endif				/*  */
 
 #if defined(QL_DEBUG_LEVEL_3)
-#define DEBUG3(x)      do {if(extended_error_logging == 3) x;} while (0);
+#define DEBUG3(x)      do {if(qla4_extended_error_logging == 3) x;} while (0);
 #else				/*  */
 #define DEBUG3(x)	do {} while (0);
 #if !defined(QL_DEBUG_LEVEL_2)
diff --git a/drivers/scsi/qla4xxx/ql4_glbl.h b/drivers/scsi/qla4xxx/ql4_glbl.h
index 418fb7a..77a997a 100644
--- a/drivers/scsi/qla4xxx/ql4_glbl.h
+++ b/drivers/scsi/qla4xxx/ql4_glbl.h
@@ -72,7 +72,7 @@ int qla4xxx_reinitialize_ddb_list(struct
 int qla4xxx_process_ddb_changed(struct scsi_qla_host * ha,
 				uint32_t fw_ddb_index, uint32_t state);
 
-extern int extended_error_logging;
+extern int qla4_extended_error_logging;
 extern int ql4xdiscoverywait;
 extern int ql4xdontresethba;
 #endif				/* _QLA4x_GBL_H */
diff --git a/drivers/scsi/qla4xxx/ql4_mbx.c b/drivers/scsi/qla4xxx/ql4_mbx.c
index ed977f7..ef82399 100644
--- a/drivers/scsi/qla4xxx/ql4_mbx.c
+++ b/drivers/scsi/qla4xxx/ql4_mbx.c
@@ -701,7 +701,7 @@ void qla4xxx_get_conn_event_log(struct s
 	DEBUG3(printk("scsi%ld: Connection Event Log Dump (%d entries):\n",
 		      ha->host_no, num_valid_entries));
 
-	if (extended_error_logging == 3) {
+	if (qla4_extended_error_logging == 3) {
 		if (oldest_entry == 0) {
 			/* Circular Buffer has not wrapped around */
 			for (i=0; i < num_valid_entries; i++) {
diff --git a/drivers/scsi/qla4xxx/ql4_os.c b/drivers/scsi/qla4xxx/ql4_os.c
index 5036ebf..178fcdd 100644
--- a/drivers/scsi/qla4xxx/ql4_os.c
+++ b/drivers/scsi/qla4xxx/ql4_os.c
@@ -34,9 +34,9 @@ MODULE_PARM_DESC(ql4xdontresethba,
 		 " default it will reset hba :0"
 		 " set to 1 to avoid resetting HBA");
 
-int extended_error_logging = 0; /* 0 = off, 1 = log errors */
-module_param(extended_error_logging, int, S_IRUGO | S_IRUSR);
-MODULE_PARM_DESC(extended_error_logging,
+int qla4_extended_error_logging = 0; /* 0 = off, 1 = log errors */
+module_param(qla4_extended_error_logging, int, S_IRUGO | S_IRUSR);
+MODULE_PARM_DESC(qla4_extended_error_logging,
 		 "Option to enable extended error logging, "
 		 "Default is 0 - no logging, 1 - debug logging");
 
@@ -1714,7 +1714,7 @@ static int __init qla4xxx_module_init(vo
 
 	/* Derive version string. */
 	strcpy(qla4xxx_version_str, QLA4XXX_DRIVER_VERSION);
-	if (extended_error_logging)
+	if (qla4_extended_error_logging)
 		strcat(qla4xxx_version_str, "-debug");
 
 	qla4xxx_scsi_transport =
