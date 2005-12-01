Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751344AbVLAACq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344AbVLAACq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 19:02:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751339AbVLAACQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 19:02:16 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:10915
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1751319AbVK3X6c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 18:58:32 -0500
Subject: [patch 31/43] rename init_ktimeout() to ktimeout_init()
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, mingo@elte.hu, zippel@linux-m68k.org, george@mvista.com,
       johnstul@us.ibm.com
References: <20051130231140.164337000@tglx.tec.linutronix.de>
Content-Type: text/plain
Organization: linutronix
Date: Thu, 01 Dec 2005 01:04:03 +0100
Message-Id: <1133395443.32542.474.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

plain text document attachment (ktimeout-rename-ktimeout_init.patch)
- rename init_ktimeout() to ktimeout_init()

Signed-off-by: Ingo Molnar <mingo@elte.hu>

 include/linux/ktimeout.h |    4 ++--
 include/linux/timer.h    |    2 +-
 kernel/ktimeout.c        |    8 ++++----
 3 files changed, 7 insertions(+), 7 deletions(-)

Index: linux/include/linux/ktimeout.h
===================================================================
--- linux.orig/include/linux/ktimeout.h
+++ linux/include/linux/ktimeout.h
@@ -34,7 +34,7 @@ extern struct ktimeout_base_s __init_kti
 	struct ktimeout _name =					\
 		KTIMEOUT_INITIALIZER(_function, _expires, _data)
 
-void fastcall init_ktimeout(struct ktimeout * ktimeout);
+void fastcall ktimeout_init(struct ktimeout * ktimeout);
 
 static inline void setup_ktimeout(struct ktimeout * ktimeout,
 				void (*function)(unsigned long),
@@ -42,7 +42,7 @@ static inline void setup_ktimeout(struct
 {
 	ktimeout->function = function;
 	ktimeout->data = data;
-	init_ktimeout(ktimeout);
+	ktimeout_init(ktimeout);
 }
 
 /***
Index: linux/include/linux/timer.h
===================================================================
--- linux.orig/include/linux/timer.h
+++ linux/include/linux/timer.h
@@ -16,7 +16,7 @@
  */
 #define TIMER_INITIALIZER		KTIMEOUT_INITIALIZER 
 #define DEFINE_TIMER			DEFINE_KTIMEOUT
-#define init_timer			init_ktimeout
+#define init_timer			ktimeout_init
 #define setup_timer			setup_ktimeout
 #define timer_pending			ktimeout_pending
 #define add_timer_on			add_ktimeout_on
Index: linux/kernel/ktimeout.c
===================================================================
--- linux.orig/kernel/ktimeout.c
+++ linux/kernel/ktimeout.c
@@ -135,18 +135,18 @@ ktimeout_base_t __init_ktimeout_base
 EXPORT_SYMBOL(__init_ktimeout_base);
 
 /***
- * init_ktimeout - initialize a timeout.
+ * ktimeout_init - initialize a timeout.
  * @ktimeout: the timeout to be initialized
  *
- * init_ktimeout() must be done to a timeout prior calling *any* of the
+ * ktimeout_init() must be done to a timeout prior calling *any* of the
  * other timeout functions.
  */
-void fastcall init_ktimeout(struct ktimeout *ktimeout)
+void fastcall ktimeout_init(struct ktimeout *ktimeout)
 {
 	ktimeout->entry.next = NULL;
 	ktimeout->base = &per_cpu(tvec_bases, raw_smp_processor_id()).t_base;
 }
-EXPORT_SYMBOL(init_ktimeout);
+EXPORT_SYMBOL(ktimeout_init);
 
 static inline void detach_ktimeout(struct ktimeout *ktimeout,
 					int clear_pending)

--

