Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267294AbUHENQJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267294AbUHENQJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 09:16:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267674AbUHENQI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 09:16:08 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:63379 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S267294AbUHENNo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 09:13:44 -0400
Date: Thu, 5 Aug 2004 15:13:59 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390: ctc driver changes.
Message-ID: <20040805131359.GD8251@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] s390: ctc driver changes.

From: Peter Tiedemann <ptiedem@de.ibm.com>

Prefix debug feature variables with ctc to avoid name space problems.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 drivers/s390/net/ctcdbug.c |   52 ++++++++++++++++++++++-----------------------
 drivers/s390/net/ctcdbug.h |   32 +++++++++++++--------------
 drivers/s390/net/ctcmain.c |   14 ++++++------
 3 files changed, 49 insertions(+), 49 deletions(-)

diff -urN linux-2.6/drivers/s390/net/ctcdbug.c linux-2.6-s390/drivers/s390/net/ctcdbug.c
--- linux-2.6/drivers/s390/net/ctcdbug.c	Thu Aug  5 14:20:39 2004
+++ linux-2.6-s390/drivers/s390/net/ctcdbug.c	Thu Aug  5 14:21:00 2004
@@ -1,6 +1,6 @@
 /*
  *
- * linux/drivers/s390/net/ctcdbug.c ($Revision: 1.2 $)
+ * linux/drivers/s390/net/ctcdbug.c ($Revision: 1.4 $)
  *
  * CTC / ESCON network driver - s390 dbf exploit.
  *
@@ -9,7 +9,7 @@
  *    Author(s): Original Code written by
  *			  Peter Tiedemann (ptiedem@de.ibm.com)
  *
- *    $Revision: 1.2 $	 $Date: 2004/07/15 16:03:08 $
+ *    $Revision: 1.4 $	 $Date: 2004/08/04 10:11:59 $
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -31,51 +31,51 @@
 /**
  * Debug Facility Stuff
  */
-debug_info_t *dbf_setup = NULL;
-debug_info_t *dbf_data = NULL;
-debug_info_t *dbf_trace = NULL;
+debug_info_t *ctc_dbf_setup = NULL;
+debug_info_t *ctc_dbf_data = NULL;
+debug_info_t *ctc_dbf_trace = NULL;
 
-DEFINE_PER_CPU(char[256], dbf_txt_buf);
+DEFINE_PER_CPU(char[256], ctc_dbf_txt_buf);
 
 void
-unregister_dbf_views(void)
+ctc_unregister_dbf_views(void)
 {
-	if (dbf_setup)
-		debug_unregister(dbf_setup);
-	if (dbf_data)
-		debug_unregister(dbf_data);
-	if (dbf_trace)
-		debug_unregister(dbf_trace);
+	if (ctc_dbf_setup)
+		debug_unregister(ctc_dbf_setup);
+	if (ctc_dbf_data)
+		debug_unregister(ctc_dbf_data);
+	if (ctc_dbf_trace)
+		debug_unregister(ctc_dbf_trace);
 }
 int
-register_dbf_views(void)
+ctc_register_dbf_views(void)
 {
-	dbf_setup = debug_register(CTC_DBF_SETUP_NAME,
+	ctc_dbf_setup = debug_register(CTC_DBF_SETUP_NAME,
 					CTC_DBF_SETUP_INDEX,
 					CTC_DBF_SETUP_NR_AREAS,
 					CTC_DBF_SETUP_LEN);
-	dbf_data = debug_register(CTC_DBF_DATA_NAME,
+	ctc_dbf_data = debug_register(CTC_DBF_DATA_NAME,
 				       CTC_DBF_DATA_INDEX,
 				       CTC_DBF_DATA_NR_AREAS,
 				       CTC_DBF_DATA_LEN);
-	dbf_trace = debug_register(CTC_DBF_TRACE_NAME,
+	ctc_dbf_trace = debug_register(CTC_DBF_TRACE_NAME,
 					CTC_DBF_TRACE_INDEX,
 					CTC_DBF_TRACE_NR_AREAS,
 					CTC_DBF_TRACE_LEN);
 
-	if ((dbf_setup == NULL) || (dbf_data == NULL) ||
-	    (dbf_trace == NULL)) {
-		unregister_dbf_views();
+	if ((ctc_dbf_setup == NULL) || (ctc_dbf_data == NULL) ||
+	    (ctc_dbf_trace == NULL)) {
+		ctc_unregister_dbf_views();
 		return -ENOMEM;
 	}
-	debug_register_view(dbf_setup, &debug_hex_ascii_view);
-	debug_set_level(dbf_setup, CTC_DBF_SETUP_LEVEL);
+	debug_register_view(ctc_dbf_setup, &debug_hex_ascii_view);
+	debug_set_level(ctc_dbf_setup, CTC_DBF_SETUP_LEVEL);
 
-	debug_register_view(dbf_data, &debug_hex_ascii_view);
-	debug_set_level(dbf_data, CTC_DBF_DATA_LEVEL);
+	debug_register_view(ctc_dbf_data, &debug_hex_ascii_view);
+	debug_set_level(ctc_dbf_data, CTC_DBF_DATA_LEVEL);
 
-	debug_register_view(dbf_trace, &debug_hex_ascii_view);
-	debug_set_level(dbf_trace, CTC_DBF_TRACE_LEVEL);
+	debug_register_view(ctc_dbf_trace, &debug_hex_ascii_view);
+	debug_set_level(ctc_dbf_trace, CTC_DBF_TRACE_LEVEL);
 
 	return 0;
 }
diff -urN linux-2.6/drivers/s390/net/ctcdbug.h linux-2.6-s390/drivers/s390/net/ctcdbug.h
--- linux-2.6/drivers/s390/net/ctcdbug.h	Thu Aug  5 14:20:39 2004
+++ linux-2.6-s390/drivers/s390/net/ctcdbug.h	Thu Aug  5 14:21:00 2004
@@ -1,6 +1,6 @@
 /*
  *
- * linux/drivers/s390/net/ctcdbug.h ($Revision: 1.2 $)
+ * linux/drivers/s390/net/ctcdbug.h ($Revision: 1.3 $)
  *
  * CTC / ESCON network driver - s390 dbf exploit.
  *
@@ -9,7 +9,7 @@
  *    Author(s): Original Code written by
  *			  Peter Tiedemann (ptiedem@de.ibm.com)
  *
- *    $Revision: 1.2 $	 $Date: 2004/07/15 16:03:08 $
+ *    $Revision: 1.3 $	 $Date: 2004/07/28 12:27:54 $
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -51,38 +51,38 @@
 
 #define DBF_TEXT(name,level,text) \
 	do { \
-		debug_text_event(dbf_##name,level,text); \
+		debug_text_event(ctc_dbf_##name,level,text); \
 	} while (0)
 
 #define DBF_HEX(name,level,addr,len) \
 	do { \
-		debug_event(dbf_##name,level,(void*)(addr),len); \
+		debug_event(ctc_dbf_##name,level,(void*)(addr),len); \
 	} while (0)
 
-extern DEFINE_PER_CPU(char[256], dbf_txt_buf);
-extern debug_info_t *dbf_setup;
-extern debug_info_t *dbf_data;
-extern debug_info_t *dbf_trace;
+extern DEFINE_PER_CPU(char[256], ctc_dbf_txt_buf);
+extern debug_info_t *ctc_dbf_setup;
+extern debug_info_t *ctc_dbf_data;
+extern debug_info_t *ctc_dbf_trace;
 
 
 #define DBF_TEXT_(name,level,text...)				\
 	do {								\
-		char* dbf_txt_buf = get_cpu_var(dbf_txt_buf);	\
-		sprintf(dbf_txt_buf, text);			  	\
-		debug_text_event(dbf_##name,level,dbf_txt_buf);	\
-		put_cpu_var(dbf_txt_buf);				\
+		char* ctc_dbf_txt_buf = get_cpu_var(ctc_dbf_txt_buf);	\
+		sprintf(ctc_dbf_txt_buf, text);			  	\
+		debug_text_event(ctc_dbf_##name,level,ctc_dbf_txt_buf);	\
+		put_cpu_var(ctc_dbf_txt_buf);				\
 	} while (0)
 
 #define DBF_SPRINTF(name,level,text...) \
 	do { \
-		debug_sprintf_event(dbf_trace, level, ##text ); \
-		debug_sprintf_event(dbf_trace, level, text ); \
+		debug_sprintf_event(ctc_dbf_trace, level, ##text ); \
+		debug_sprintf_event(ctc_dbf_trace, level, text ); \
 	} while (0)
 
 
-int register_dbf_views(void);
+int ctc_register_dbf_views(void);
 
-void unregister_dbf_views(void);
+void ctc_unregister_dbf_views(void);
 
 /**
  * some more debug stuff
diff -urN linux-2.6/drivers/s390/net/ctcmain.c linux-2.6-s390/drivers/s390/net/ctcmain.c
--- linux-2.6/drivers/s390/net/ctcmain.c	Thu Aug  5 14:20:39 2004
+++ linux-2.6-s390/drivers/s390/net/ctcmain.c	Thu Aug  5 14:21:00 2004
@@ -1,5 +1,5 @@
 /*
- * $Id: ctcmain.c,v 1.62 2004/07/15 16:03:08 ptiedem Exp $
+ * $Id: ctcmain.c,v 1.63 2004/07/28 12:27:54 ptiedem Exp $
  *
  * CTC / ESCON network driver
  *
@@ -36,7 +36,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- * RELEASE-TAG: CTC/ESCON network driver $Revision: 1.62 $
+ * RELEASE-TAG: CTC/ESCON network driver $Revision: 1.63 $
  *
  */
 
@@ -320,7 +320,7 @@
 print_banner(void)
 {
 	static int printed = 0;
-	char vbuf[] = "$Revision: 1.62 $";
+	char vbuf[] = "$Revision: 1.63 $";
 	char *version = vbuf;
 
 	if (printed)
@@ -3250,7 +3250,7 @@
 {
 	unregister_cu3088_discipline(&ctc_group_driver);
 	ctc_tty_cleanup();
-	unregister_dbf_views();
+	ctc_unregister_dbf_views();
 	ctc_pr_info("CTC driver unloaded\n");
 }
 
@@ -3267,16 +3267,16 @@
 
 	print_banner();
 
-	ret = register_dbf_views();
+	ret = ctc_register_dbf_views();
 	if (ret){
-		ctc_pr_crit("ctc_init failed with register_dbf_views rc = %d\n", ret);
+		ctc_pr_crit("ctc_init failed with ctc_register_dbf_views rc = %d\n", ret);
 		return ret;
 	}
 	ctc_tty_init();
 	ret = register_cu3088_discipline(&ctc_group_driver);
 	if (ret) {
 		ctc_tty_cleanup();
-		unregister_dbf_views();
+		ctc_unregister_dbf_views();
 	}
 	return ret;
 }
