Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289011AbSAIUJH>; Wed, 9 Jan 2002 15:09:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288995AbSAIUGa>; Wed, 9 Jan 2002 15:06:30 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:24307 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S288998AbSAIUDc>;
	Wed, 9 Jan 2002 15:03:32 -0500
Date: Wed, 9 Jan 2002 12:03:27 -0800
To: Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        linux-irda@pasta.cs.uit.no
Subject: [PATCH] : ir247_debug_warn.diff
Message-ID: <20020109120327.D12039@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ir247_debug_warn.diff :
---------------------
	<Patch from Kai Germaschewski>
	o [FEATURE] Remove compiler warning when not using DEBUG

diff -u -p linux/net/irda/irda_device.d8.c linux/net/irda/irda_device.c
--- linux/net/irda/irda_device.d8.c	Tue Jan  8 14:30:59 2002
+++ linux/net/irda/irda_device.c	Tue Jan  8 14:33:46 2002
@@ -81,6 +81,7 @@ const char *infrared_mode[] = {
 	"TV_REMOTE",
 };
 
+#ifdef CONFIG_IRDA_DEBUG
 static const char *task_state[] = {
 	"IRDA_TASK_INIT",
 	"IRDA_TASK_DONE", 
@@ -92,6 +93,7 @@ static const char *task_state[] = {
 	"IRDA_TASK_CHILD_WAIT",
 	"IRDA_TASK_CHILD_DONE",
 };
+#endif	/* CONFIG_IRDA_DEBUG */
 
 static void irda_task_timer_expired(void *data);
 
diff -u -p linux/net/irda/iriap.d8.c linux/net/irda/iriap.c
--- linux/net/irda/iriap.d8.c	Tue Jan  8 14:31:09 2002
+++ linux/net/irda/iriap.c	Tue Jan  8 14:35:11 2002
@@ -41,6 +41,7 @@
 #include <net/irda/iriap_event.h>
 #include <net/irda/iriap.h>
 
+#ifdef CONFIG_IRDA_DEBUG
 /* FIXME: This one should go in irlmp.c */
 static const char *ias_charset_types[] = {
 	"CS_ASCII",
@@ -55,6 +56,7 @@ static const char *ias_charset_types[] =
 	"CS_ISO_8859_9",
 	"CS_UNICODE"
 };
+#endif	/* CONFIG_IRDA_DEBUG */
 
 static hashbin_t *iriap = NULL;
 static __u32 service_handle; 
diff -u -p linux/net/irda/irlap.d8.c linux/net/irda/irlap.c
--- linux/net/irda/irlap.d8.c	Tue Jan  8 14:31:18 2002
+++ linux/net/irda/irlap.c	Tue Jan  8 14:35:57 2002
@@ -59,6 +59,7 @@ int sysctl_warn_noreply_time = 3;
 extern void irlap_queue_xmit(struct irlap_cb *self, struct sk_buff *skb);
 static void __irlap_close(struct irlap_cb *self);
 
+#ifdef CONFIG_IRDA_DEBUG
 static char *lap_reasons[] = {
 	"ERROR, NOT USED",
 	"LAP_DISC_INDICATION",
@@ -69,6 +70,7 @@ static char *lap_reasons[] = {
 	"LAP_PRIMARY_CONFLICT",
 	"ERROR, NOT USED",
 };
+#endif	/* CONFIG_IRDA_DEBUG */
 
 #ifdef CONFIG_PROC_FS
 int irlap_proc_read(char *, char **, off_t, int);
diff -u -p linux/net/irda/irlap_event.d8.c linux/net/irda/irlap_event.c
--- linux/net/irda/irlap_event.d8.c	Tue Jan  8 14:31:29 2002
+++ linux/net/irda/irlap_event.c	Tue Jan  8 14:36:55 2002
@@ -77,6 +77,7 @@ static int irlap_state_sclose (struct ir
 static int irlap_state_reset_check(struct irlap_cb *, IRLAP_EVENT event, 
 				   struct sk_buff *, struct irlap_info *);
 
+#ifdef CONFIG_IRDA_DEBUG
 static const char *irlap_event[] = {
 	"DISCOVERY_REQUEST",
 	"CONNECT_REQUEST",
@@ -117,6 +118,7 @@ static const char *irlap_event[] = {
 	"BACKOFF_TIMER_EXPIRED",
 	"MEDIA_BUSY_TIMER_EXPIRED",
 };
+#endif	/* CONFIG_IRDA_DEBUG */
 
 const char *irlap_state[] = {
 	"LAP_NDM",
@@ -312,7 +314,6 @@ static int irlap_state_ndm(struct irlap_
 {
 	discovery_t *discovery_rsp;
 	int ret = 0;
-	int i;
 
 	ASSERT(self != NULL, return -1;);
 	ASSERT(self->magic == LAP_MAGIC, return -1;);
@@ -478,6 +479,8 @@ static int irlap_state_ndm(struct irlap_
 		break;
 #ifdef CONFIG_IRDA_ULTRA
 	case SEND_UI_FRAME:
+	{   
+		int i;
 		/* Only allowed to repeat an operation twice */
 		for (i=0; ((i<2) && (self->media_busy == FALSE)); i++) {
 			skb = skb_dequeue(&self->txq_ultra);
@@ -492,6 +495,7 @@ static int irlap_state_ndm(struct irlap_
 			irda_device_set_media_busy(self->netdev, TRUE);
 		}
 		break;
+	}
 	case RECV_UI_FRAME:
 		/* Only accept broadcast frames in NDM mode */
 		if (info->caddr != CBROADCAST) {
diff -u -p linux/net/irda/irlmp_event.d8.c linux/net/irda/irlmp_event.c
--- linux/net/irda/irlmp_event.d8.c	Tue Jan  8 14:31:47 2002
+++ linux/net/irda/irlmp_event.c	Tue Jan  8 14:37:48 2002
@@ -49,6 +49,7 @@ const char *irlsap_state[] = {
 	"LSAP_SETUP_PEND",
 };
 
+#ifdef CONFIG_IRDA_DEBUG
 static const char *irlmp_event[] = {
 	"LM_CONNECT_REQUEST",
  	"LM_CONNECT_CONFIRM",
@@ -75,6 +76,7 @@ static const char *irlmp_event[] = {
  	"LM_LAP_DISCOVERY_CONFIRM",
 	"LM_LAP_IDLE_TIMEOUT",
 };
+#endif	/* CONFIG_IRDA_DEBUG */
 
 /* LAP Connection control proto declarations */
 static void irlmp_state_standby  (struct lap_cb *, IRLMP_EVENT, 
diff -u -p linux/net/irda/irsyms.d8.c linux/net/irda/irsyms.c
--- linux/net/irda/irsyms.d8.c	Tue Jan  8 14:31:56 2002
+++ linux/net/irda/irsyms.c	Tue Jan  8 14:32:55 2002
@@ -198,7 +198,7 @@ int __init irda_init(void)
 	return 0;
 }
 
-static void __exit irda_cleanup(void)
+void __exit irda_cleanup(void)
 {
 #ifdef CONFIG_SYSCTL
 	irda_sysctl_unregister();
