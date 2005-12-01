Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751297AbVK3X73@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751297AbVK3X73 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 18:59:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751328AbVK3X7B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 18:59:01 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:14243
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1751324AbVK3X6d
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 18:58:33 -0500
Subject: [patch 33/43] rename add_ktimeout_on() to ktimeout_add_on()
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, mingo@elte.hu, zippel@linux-m68k.org, george@mvista.com,
       johnstul@us.ibm.com
References: <20051130231140.164337000@tglx.tec.linutronix.de>
Content-Type: text/plain
Organization: linutronix
Date: Thu, 01 Dec 2005 01:04:07 +0100
Message-Id: <1133395447.32542.476.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

plain text document attachment (ktimeout-rename-ktimeout_add_on.patch)
- rename add_ktimeout_on() to ktimeout_add_on()

Signed-off-by: Ingo Molnar <mingo@elte.hu>

 include/linux/ktimeout.h |    2 +-
 include/linux/timer.h    |    2 +-
 kernel/ktimeout.c        |    6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

Index: linux/include/linux/ktimeout.h
===================================================================
--- linux.orig/include/linux/ktimeout.h
+++ linux/include/linux/ktimeout.h
@@ -60,7 +60,7 @@ static inline int ktimeout_pending(const
 	return ktimeout->entry.next != NULL;
 }
 
-extern void add_ktimeout_on(struct ktimeout *ktimeout, int cpu);
+extern void ktimeout_add_on(struct ktimeout *ktimeout, int cpu);
 extern int del_ktimeout(struct ktimeout * ktimeout);
 extern int __mod_ktimeout(struct ktimeout *ktimeout, unsigned long expires);
 extern int mod_ktimeout(struct ktimeout *ktimeout, unsigned long expires);
Index: linux/include/linux/timer.h
===================================================================
--- linux.orig/include/linux/timer.h
+++ linux/include/linux/timer.h
@@ -19,7 +19,7 @@
 #define init_timer			ktimeout_init
 #define setup_timer			ktimeout_setup
 #define timer_pending			ktimeout_pending
-#define add_timer_on			add_ktimeout_on
+#define add_timer_on			ktimeout_add_on
 #define del_timer			del_ktimeout
 #define __mod_timer			__mod_ktimeout
 #define mod_timer			mod_ktimeout
Index: linux/kernel/ktimeout.c
===================================================================
--- linux.orig/kernel/ktimeout.c
+++ linux/kernel/ktimeout.c
@@ -237,13 +237,13 @@ int __mod_ktimeout(struct ktimeout *ktim
 EXPORT_SYMBOL(__mod_ktimeout);
 
 /***
- * add_ktimeout_on - start a timeout on a particular CPU
+ * ktimeout_add_on - start a timeout on a particular CPU
  * @ktimeout: the timeout to be added
  * @cpu: the CPU to start it on
  *
  * This is not very scalable on SMP. Double adds are not possible.
  */
-void add_ktimeout_on(struct ktimeout *ktimeout, int cpu)
+void ktimeout_add_on(struct ktimeout *ktimeout, int cpu)
 {
 	tvec_base_t *base = &per_cpu(tvec_bases, cpu);
   	unsigned long flags;
@@ -364,7 +364,7 @@ out:
  * otherwise this function is meaningless. It must not be called from
  * interrupt contexts. The caller must not hold locks which would prevent
  * completion of the timeout's handler. The timeout's handler must not call
- * add_ktimeout_on(). Upon exit the timeout is not queued and the handler is
+ * ktimeout_add_on(). Upon exit the timeout is not queued and the handler is
  * not running on any CPU.
  *
  * The function returns whether it has deactivated a pending timeout or not.

--

