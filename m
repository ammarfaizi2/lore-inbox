Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267472AbSLLSQy>; Thu, 12 Dec 2002 13:16:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265081AbSLLSMM>; Thu, 12 Dec 2002 13:12:12 -0500
Received: from [195.212.29.5] ([195.212.29.5]:64713 "EHLO
	d06lmsgate-5.uk.ibm.com") by vger.kernel.org with ESMTP
	id <S265019AbSLLSHs> convert rfc822-to-8bit; Thu, 12 Dec 2002 13:07:48 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] s390 (6/8): staticification.
Date: Thu, 12 Dec 2002 19:09:11 +0100
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200212121909.11264.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make some functions and variables static.

diffstat:
 char/sclp.c     |    6 +++---
 char/sclp_con.c |    8 ++++----
 char/sclp_rw.c  |    2 +-
 char/sclp_tty.c |    4 ++--
 net/ctcmain.c   |   16 ++++++++--------
 net/lcs.c       |   20 ++++++++++----------
 6 files changed, 28 insertions(+), 28 deletions(-)

diff -urN linux-2.5.51/drivers/s390/char/sclp.c linux-2.5.51-s390/drivers/s390/char/sclp.c
--- linux-2.5.51/drivers/s390/char/sclp.c	Tue Dec 10 03:46:11 2002
+++ linux-2.5.51-s390/drivers/s390/char/sclp.c	Thu Dec 12 18:03:31 2002
@@ -47,7 +47,7 @@
 static struct list_head sclp_reg_list;
 
 /* sccb queue */
-struct list_head sclp_req_queue;
+static struct list_head sclp_req_queue;
 
 /* sccb for unconditional read */
 static struct sclp_req sclp_read_req;
@@ -448,7 +448,7 @@
 	spin_unlock_irqrestore(&sclp_lock, flags);
 }
 
-struct sclp_register sclp_state_change_event = {
+static struct sclp_register sclp_state_change_event = {
 	.receive_mask = EvTyp_StateChange_Mask,
 	.receiver_fn = sclp_state_change
 };
@@ -514,7 +514,7 @@
 	ctrl_alt_del();
 }
 
-struct sclp_register sclp_quiesce_event = {
+static struct sclp_register sclp_quiesce_event = {
 	.receive_mask = EvTyp_SigQuiesce_Mask,
 	.receiver_fn = sclp_quiesce
 };
diff -urN linux-2.5.51/drivers/s390/char/sclp_con.c linux-2.5.51-s390/drivers/s390/char/sclp_con.c
--- linux-2.5.51/drivers/s390/char/sclp_con.c	Tue Dec 10 03:45:59 2002
+++ linux-2.5.51-s390/drivers/s390/char/sclp_con.c	Thu Dec 12 18:03:31 2002
@@ -97,7 +97,7 @@
 /*
  * Writes the given message to S390 system console
  */
-void
+static void
 sclp_console_write(struct console *console, const char *message,
 		   unsigned int count)
 {
@@ -152,7 +152,7 @@
 }
 
 /* returns the device number of the SCLP console */
-kdev_t
+static kdev_t
 sclp_console_device(struct console *c)
 {
 	return	mk_kdev(sclp_console_major, sclp_console_minor);
@@ -163,7 +163,7 @@
  * is going to give up. We have to make sure that all buffers
  * will be flushed to the SCLP.
  */
-void
+static void
 sclp_console_unblank(void)
 {
 	unsigned long flags;
@@ -187,7 +187,7 @@
  * used to register the SCLP console to the kernel and to
  * give printk necessary information
  */
-struct console sclp_console =
+static struct console sclp_console =
 {
 	.name = sclp_console_name,
 	.write = sclp_console_write,
diff -urN linux-2.5.51/drivers/s390/char/sclp_rw.c linux-2.5.51-s390/drivers/s390/char/sclp_rw.c
--- linux-2.5.51/drivers/s390/char/sclp_rw.c	Tue Dec 10 03:45:55 2002
+++ linux-2.5.51-s390/drivers/s390/char/sclp_rw.c	Thu Dec 12 18:03:31 2002
@@ -31,7 +31,7 @@
 #define MAX_SCCB_ROOM (PAGE_SIZE - sizeof(struct sclp_buffer))
 
 /* Event type structure for write message and write priority message */
-struct sclp_register sclp_rw_event = {
+static struct sclp_register sclp_rw_event = {
 	.send_mask = EvTyp_Msg_Mask | EvTyp_PMsgCmd_Mask
 };
 
diff -urN linux-2.5.51/drivers/s390/char/sclp_tty.c linux-2.5.51-s390/drivers/s390/char/sclp_tty.c
--- linux-2.5.51/drivers/s390/char/sclp_tty.c	Tue Dec 10 03:45:44 2002
+++ linux-2.5.51-s390/drivers/s390/char/sclp_tty.c	Thu Dec 12 18:03:31 2002
@@ -466,7 +466,7 @@
 /*
  * push input to tty
  */
-void sclp_tty_input(unsigned char* buf, unsigned int count)
+static void sclp_tty_input(unsigned char* buf, unsigned int count)
 {
 	unsigned int cchar;
 
@@ -694,7 +694,7 @@
 {
 }
 
-struct sclp_register sclp_input_event =
+static struct sclp_register sclp_input_event =
 {
 	.receive_mask = EvTyp_OpCmd_Mask | EvTyp_PMsgCmd_Mask,
 	.state_change_fn = sclp_tty_state_change,
diff -urN linux-2.5.51/drivers/s390/net/ctcmain.c linux-2.5.51-s390/drivers/s390/net/ctcmain.c
--- linux-2.5.51/drivers/s390/net/ctcmain.c	Tue Dec 10 03:45:54 2002
+++ linux-2.5.51-s390/drivers/s390/net/ctcmain.c	Thu Dec 12 18:03:31 2002
@@ -1,5 +1,5 @@
 /*
- * $Id: ctcmain.c,v 1.29 2002/12/06 12:31:38 cohuck Exp $
+ * $Id: ctcmain.c,v 1.30 2002/12/09 13:56:20 aberg Exp $
  *
  * CTC / ESCON network driver
  *
@@ -36,7 +36,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- * RELEASE-TAG: CTC/ESCON network driver $Revision: 1.29 $
+ * RELEASE-TAG: CTC/ESCON network driver $Revision: 1.30 $
  *
  */
 
@@ -279,7 +279,7 @@
 print_banner(void)
 {
 	static int printed = 0;
-	char vbuf[] = "$Revision: 1.29 $";
+	char vbuf[] = "$Revision: 1.30 $";
 	char *version = vbuf;
 
 	if (printed)
@@ -2821,7 +2821,7 @@
  * @returns 0 on success, !0 on failure.
  */
 
-int
+static int
 ctc_probe_device(struct ccwgroup_device *cgdev)
 {
 	struct ctc_priv *priv;
@@ -2864,7 +2864,7 @@
  *
  * @returns 0 on success, !0 on failure.
  */
-int
+static int
 ctc_new_device(struct ccwgroup_device *cgdev)
 {
 	char read_id[CTC_ID_SIZE];
@@ -2941,7 +2941,7 @@
  *
  * @returns 0 on success, !0 on failure.
  */
-int
+static int
 ctc_shutdown_device(struct ccwgroup_device *cgdev)
 {
 	struct ctc_priv *priv;
@@ -2975,7 +2975,7 @@
 
 }
 
-int
+static int
 ctc_remove_device(struct ccwgroup_device *cgdev)
 {
 	struct ctc_priv *priv;
@@ -2991,7 +2991,7 @@
 	return 0;
 }
 
-struct ccwgroup_driver ctc_group_driver = {
+static struct ccwgroup_driver ctc_group_driver = {
 	.name        = "ctc",
 	.max_slaves  = 2,
 	.driver_id   = 0xC3E3C3,
diff -urN linux-2.5.51/drivers/s390/net/lcs.c linux-2.5.51-s390/drivers/s390/net/lcs.c
--- linux-2.5.51/drivers/s390/net/lcs.c	Tue Dec 10 03:45:44 2002
+++ linux-2.5.51-s390/drivers/s390/net/lcs.c	Thu Dec 12 18:03:31 2002
@@ -11,7 +11,7 @@
  *			  Frank Pavlic (pavlic@de.ibm.com) and
  *		 	  Martin Schwidefsky <schwidefsky@de.ibm.com>
  *
- *    $Revision: 1.41 $	 $Date: 2002/12/06 12:42:01 $
+ *    $Revision: 1.42 $	 $Date: 2002/12/09 13:55:28 $
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -59,7 +59,7 @@
 /**
  * initialization string for output
  */
-#define VERSION_LCS_C  "$Revision: 1.41 $"
+#define VERSION_LCS_C  "$Revision: 1.42 $"
 
 static const char *version="LCS driver ("VERSION_LCS_C "/" VERSION_LCS_H ")";
 
@@ -1576,7 +1576,7 @@
 /**
  * get network statistics for ifconfig and other user programs
  */
-struct net_device_stats *
+static struct net_device_stats *
 lcs_getstats(struct net_device *dev)
 {
 	struct lcs_card *card;
@@ -1590,7 +1590,7 @@
  * stop lcs device
  * This function will be called by user doing ifconfig xxx down
  */
-int
+static int
 lcs_stop_device(struct net_device *dev)
 {
 	struct lcs_card *card;
@@ -1612,7 +1612,7 @@
  * start lcs device and make it runnable
  * This function will be called by user doing ifconfig xxx up
  */
-int
+static int
 lcs_open_device(struct net_device *dev)
 {
 	struct lcs_card *card;
@@ -1678,7 +1678,7 @@
 /**
  * lcs_probe_device is called on establishing a new ccwgroup_device.
  */
-int
+static int
 lcs_probe_device(struct ccwgroup_device *ccwgdev)
 {
 	struct lcs_card *card;
@@ -1714,7 +1714,7 @@
 /**
  * lcs_new_device will be called by setting the group device online.
  */
-int
+static int
 lcs_new_device(struct ccwgroup_device *ccwgdev)
 {
 	struct  lcs_card *card;
@@ -1794,7 +1794,7 @@
 /**
  * lcs_shutdown_device, called when setting the group device offline.
  */
-int
+static int
 lcs_shutdown_device(struct ccwgroup_device *ccwgdev)
 {
 	struct lcs_card *card;
@@ -1810,7 +1810,7 @@
 /**
  * lcs_remove_device, free buffers and card
  */
-int
+static int
 lcs_remove_device(struct ccwgroup_device *ccwgdev)
 {
 	struct lcs_card *card;
@@ -1828,7 +1828,7 @@
 /**
  * LCS ccwgroup driver registration
  */
-struct ccwgroup_driver lcs_group_driver = {
+static struct ccwgroup_driver lcs_group_driver = {
 	.name        = "lcs",
 	.max_slaves  = 2,
 	.driver_id   = 0xD3C3E2,

