Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751334AbVLAABf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751334AbVLAABf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 19:01:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751332AbVK3X6v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 18:58:51 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:23203
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1751331AbVK3X6k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 18:58:40 -0500
Subject: [patch 39/43] rename try_to_del_ktimeout_sync() to
	ktimeout_try_to_del_sync()
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, mingo@elte.hu, zippel@linux-m68k.org, george@mvista.com,
       johnstul@us.ibm.com
References: <20051130231140.164337000@tglx.tec.linutronix.de>
Content-Type: text/plain
Organization: linutronix
Date: Thu, 01 Dec 2005 01:04:22 +0100
Message-Id: <1133395462.32542.483.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

plain text document attachment
(ktimeout-rename-ktimeout_try_to_del_sync.patch)
- rename try_to_del_ktimeout_sync() to ktimeout_try_to_del_sync()

Signed-off-by: Ingo Molnar <mingo@elte.hu>

 include/linux/ktimeout.h |    4 ++--
 include/linux/timer.h    |    2 +-
 kernel/ktimeout.c        |    4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

Index: linux/include/linux/ktimeout.h
===================================================================
--- linux.orig/include/linux/ktimeout.h
+++ linux/include/linux/ktimeout.h
@@ -88,10 +88,10 @@ static inline void ktimeout_add(struct k
 }
 
 #ifdef CONFIG_SMP
-  extern int try_to_del_ktimeout_sync(struct ktimeout *ktimeout);
+  extern int ktimeout_try_to_del_sync(struct ktimeout *ktimeout);
   extern int del_ktimeout_sync(struct ktimeout *ktimeout);
 #else
-# define try_to_del_ktimeout_sync(t)	ktimeout_del(t)
+# define ktimeout_try_to_del_sync(t)	ktimeout_del(t)
 # define del_ktimeout_sync(t)		ktimeout_del(t)
 #endif
 
Index: linux/include/linux/timer.h
===================================================================
--- linux.orig/include/linux/timer.h
+++ linux/include/linux/timer.h
@@ -25,7 +25,7 @@
 #define mod_timer			ktimeout_mod
 #define next_timer_interrupt		ktimeout_next_interrupt
 #define add_timer			ktimeout_add
-#define try_to_del_timer_sync		try_to_del_ktimeout_sync
+#define try_to_del_timer_sync		ktimeout_try_to_del_sync
 #define del_timer_sync			del_ktimeout_sync
 #define del_singleshot_timer_sync	del_singleshot_ktimeout_sync
 #define init_timers			init_ktimeouts
Index: linux/kernel/ktimeout.c
===================================================================
--- linux.orig/kernel/ktimeout.c
+++ linux/kernel/ktimeout.c
@@ -330,7 +330,7 @@ EXPORT_SYMBOL(ktimeout_del);
  *
  * It must not be called from interrupt contexts.
  */
-int try_to_del_ktimeout_sync(struct ktimeout *ktimeout)
+int ktimeout_try_to_del_sync(struct ktimeout *ktimeout)
 {
 	ktimeout_base_t *base;
 	unsigned long flags;
@@ -372,7 +372,7 @@ out:
 int del_ktimeout_sync(struct ktimeout *ktimeout)
 {
 	for (;;) {
-		int ret = try_to_del_ktimeout_sync(ktimeout);
+		int ret = ktimeout_try_to_del_sync(ktimeout);
 		if (ret >= 0)
 			return ret;
 	}

--

