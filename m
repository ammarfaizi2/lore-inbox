Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278707AbRJ1WO3>; Sun, 28 Oct 2001 17:14:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278709AbRJ1WOS>; Sun, 28 Oct 2001 17:14:18 -0500
Received: from [63.231.122.81] ([63.231.122.81]:25146 "EHLO lynx.adilger.int")
	by vger.kernel.org with ESMTP id <S278703AbRJ1WNX>;
	Sun, 28 Oct 2001 17:13:23 -0500
Date: Sun, 28 Oct 2001 01:03:06 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] compile warning cleanups
Message-ID: <20011028010306.C4229@lynx.no>
Mail-Followup-To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,
a couple of compile warning cleanups that I've had in my tree for a long
time.  Please apply.

Cheers, Andreas
===========================================================================
diff -ru linux.orig/drivers/scsi/aha1542.c linux/drivers/scsi/aha1542.c
--- linux.orig/drivers/scsi/aha1542.c	Thu Oct 25 03:04:57 2001
+++ linux/drivers/scsi/aha1542.c	Thu Oct 25 02:55:33 2001
@@ -111,7 +111,6 @@
 static int setup_busoff[MAXBOARDS];
 static int setup_dmaspeed[MAXBOARDS] __initdata = { -1, -1, -1, -1 };
 
-static char *setup_str[MAXBOARDS] __initdata;
 
 /*
  * LILO/Module params:  aha1542=<PORTBASE>[,<BUSON>,<BUSOFF>[,<DMASPEED>]]
@@ -960,6 +959,7 @@
 
 #ifndef MODULE
 static int setup_idx = 0;
+static char *setup_str[MAXBOARDS] __initdata;
 
 void __init aha1542_setup(char *str, int *ints)
 {
diff -ru linux.orig/drivers/sound/cs4232.c linux/drivers/sound/cs4232.c
--- linux.orig/drivers/sound/cs4232.c	Thu Oct 25 02:02:31 2001
+++ linux/drivers/sound/cs4232.c	Thu Oct 25 02:09:10 2001
@@ -324,7 +324,6 @@
 static int __initdata mpuio	= -1;
 static int __initdata mpuirq	= -1;
 static int __initdata synthio	= -1;
-static int __initdata synthirq	= -1;
 static int __initdata isapnp	= 1;
 
 MODULE_DESCRIPTION("CS4232 based soundcard driver"); 
@@ -345,8 +344,11 @@
 MODULE_PARM_DESC(mpuirq,"MPU 401 IRQ");
 MODULE_PARM(synthio,"i");
 MODULE_PARM_DESC(synthio,"Maui WaveTable base I/O port");
+#ifdef CONFIG_SOUND_WAVEFRONT_MODULE
+static int __initdata synthirq	= -1;
 MODULE_PARM(synthirq,"i");
 MODULE_PARM_DESC(synthirq,"Maui WaveTable IRQ");
+#endif
 MODULE_PARM(isapnp,"i");
 MODULE_PARM_DESC(isapnp,"Enable ISAPnP probing (default 1)");
 
diff -ru linux.orig/net/irda/irda_device.c linux/net/irda/irda_device.c
--- linux.orig/net/irda/irda_device.c	Thu Oct 25 01:50:55 2001
+++ linux/net/irda/irda_device.c	Wed Oct 24 23:53:49 2001
@@ -78,6 +78,7 @@
 	"TV_REMOTE",
 };
 
+#ifdef CONFIG_IRDA_DEBUG
 static const char *task_state[] = {
 	"IRDA_TASK_INIT",
 	"IRDA_TASK_DONE", 
@@ -89,6 +90,7 @@
 	"IRDA_TASK_CHILD_WAIT",
 	"IRDA_TASK_CHILD_DONE",
 };
+#endif
 
 static void irda_task_timer_expired(void *data);
 
diff -ru linux.orig/net/irda/iriap.c linux/net/irda/iriap.c
--- linux.orig/net/irda/iriap.c	Thu Oct 25 01:50:55 2001
+++ linux/net/irda/iriap.c	Wed Oct 24 23:53:49 2001
@@ -41,6 +41,7 @@
 #include <net/irda/iriap.h>
 
 /* FIXME: This one should go in irlmp.c */
+#ifdef CONFIG_IRDA_DEBUG
 static const char *ias_charset_types[] = {
 	"CS_ASCII",
 	"CS_ISO_8859_1",
@@ -54,6 +55,7 @@
 	"CS_ISO_8859_9",
 	"CS_UNICODE"
 };
+#endif
 
 static hashbin_t *iriap = NULL;
 static __u32 service_handle; 
diff -ru linux.orig/net/irda/irlap.c linux/net/irda/irlap.c
--- linux.orig/net/irda/irlap.c	Thu Oct 25 01:50:55 2001
+++ linux/net/irda/irlap.c	Wed Oct 24 23:53:49 2001
@@ -53,6 +53,7 @@
 extern void irlap_queue_xmit(struct irlap_cb *self, struct sk_buff *skb);
 static void __irlap_close(struct irlap_cb *self);
 
+#ifdef CONFIG_IRDA_DEBUG
 static char *lap_reasons[] = {
 	"ERROR, NOT USED",
 	"LAP_DISC_INDICATION",
@@ -63,6 +64,7 @@
 	"LAP_PRIMARY_CONFLICT",
 	"ERROR, NOT USED",
 };
+#endif
 
 #ifdef CONFIG_PROC_FS
 int irlap_proc_read(char *, char **, off_t, int);
diff -ru linux.orig/net/irda/irlap_event.c linux/net/irda/irlap_event.c
--- linux.orig/net/irda/irlap_event.c	Thu Oct 25 02:03:04 2001
+++ linux/net/irda/irlap_event.c	Thu Oct 25 02:09:37 2001
@@ -76,6 +76,7 @@
 static int irlap_state_reset_check(struct irlap_cb *, IRLAP_EVENT event, 
 				   struct sk_buff *, struct irlap_info *);
 
+#ifdef CONFIG_IRDA_DEBUG
 static const char *irlap_event[] = {
 	"DISCOVERY_REQUEST",
 	"CONNECT_REQUEST",
@@ -115,6 +116,7 @@
 	"WD_TIMER_EXPIRED",
 	"BACKOFF_TIMER_EXPIRED",
 };
+#endif
 
 const char *irlap_state[] = {
 	"LAP_NDM",
diff -ru linux.orig/net/irda/irlmp_event.c linux/net/irda/irlmp_event.c
--- linux.orig/net/irda/irlmp_event.c	Thu Oct 25 01:50:55 2001
+++ linux/net/irda/irlmp_event.c	Wed Oct 24 23:53:49 2001
@@ -48,6 +48,7 @@
 	"LSAP_SETUP_PEND",
 };
 
+#ifdef CONFIG_IRDA_DEBUG
 static const char *irlmp_event[] = {
 	"LM_CONNECT_REQUEST",
  	"LM_CONNECT_CONFIRM",
@@ -74,6 +75,7 @@
  	"LM_LAP_DISCOVERY_CONFIRM",
 	"LM_LAP_IDLE_TIMEOUT",
 };
+#endif
 
 /* LAP Connection control proto declarations */
 static void irlmp_state_standby  (struct lap_cb *, IRLMP_EVENT, 
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

