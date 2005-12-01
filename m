Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751325AbVK3X64@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751325AbVK3X64 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 18:58:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751318AbVK3X6z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 18:58:55 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:18595
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1751325AbVK3X6g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 18:58:36 -0500
Subject: [patch 36/43] rename mod_ktimeout() to ktimeout_mod()
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, mingo@elte.hu, zippel@linux-m68k.org, george@mvista.com,
       johnstul@us.ibm.com
References: <20051130231140.164337000@tglx.tec.linutronix.de>
Content-Type: text/plain
Organization: linutronix
Date: Thu, 01 Dec 2005 01:04:14 +0100
Message-Id: <1133395454.32542.479.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

plain text document attachment (ktimeout-rename-ktimeout_mod.patch)
- rename mod_ktimeout() to ktimeout_mod()

Signed-off-by: Ingo Molnar <mingo@elte.hu>

 include/linux/ktimeout.h |    2 +-
 include/linux/timer.h    |    2 +-
 kernel/ktimeout.c        |   14 +++++++-------
 3 files changed, 9 insertions(+), 9 deletions(-)

Index: linux/include/linux/ktimeout.h
===================================================================
--- linux.orig/include/linux/ktimeout.h
+++ linux/include/linux/ktimeout.h
@@ -63,7 +63,7 @@ static inline int ktimeout_pending(const
 extern void ktimeout_add_on(struct ktimeout *ktimeout, int cpu);
 extern int ktimeout_del(struct ktimeout * ktimeout);
 extern int __ktimeout_mod(struct ktimeout *ktimeout, unsigned long expires);
-extern int mod_ktimeout(struct ktimeout *ktimeout, unsigned long expires);
+extern int ktimeout_mod(struct ktimeout *ktimeout, unsigned long expires);
 
 extern unsigned long next_ktimeout_interrupt(void);
 
Index: linux/include/linux/timer.h
===================================================================
--- linux.orig/include/linux/timer.h
+++ linux/include/linux/timer.h
@@ -22,7 +22,7 @@
 #define add_timer_on			ktimeout_add_on
 #define del_timer			ktimeout_del
 #define __mod_timer			__ktimeout_mod
-#define mod_timer			mod_ktimeout
+#define mod_timer			ktimeout_mod
 #define next_timer_interrupt		next_ktimeout_interrupt
 #define add_timer			add_ktimeout
 #define try_to_del_timer_sync		try_to_del_ktimeout_sync
Index: linux/kernel/ktimeout.c
===================================================================
--- linux.orig/kernel/ktimeout.c
+++ linux/kernel/ktimeout.c
@@ -257,25 +257,25 @@ void ktimeout_add_on(struct ktimeout *kt
 

 /***
- * mod_ktimeout - modify a timeout's interval
+ * ktimeout_mod - modify a timeout's interval
  * @ktimeout: the timeout to be modified
  *
- * mod_ktimeout is a more efficient way to update the expire field of an
+ * ktimeout_mod is a more efficient way to update the expire field of an
  * active timeout (if the timeout is inactive it will be activated)
  *
- * mod_ktimeout(ktimeout, expires) is equivalent to:
+ * ktimeout_mod(ktimeout, expires) is equivalent to:
  *
  *  ktimeout_del(ktimeout); ktimeout->expires = expires; add_ktimeout(ktimeout);
  *
  * Note that if there are multiple unserialized concurrent users of the same
- * timeout, then mod_ktimeout() is the only safe way to modify the interval,
+ * timeout, then ktimeout_mod() is the only safe way to modify the interval,
  * since add_ktimeout() cannot modify an already running ktimeout.
  *
  * The function returns whether it has modified a pending timeout or not.
- * (ie. mod_ktimeout() of an inactive timeout returns 0, mod_ktimeout() of an
+ * (ie. ktimeout_mod() of an inactive timeout returns 0, ktimeout_mod() of an
  * active timeout returns 1.)
  */
-int mod_ktimeout(struct ktimeout *ktimeout, unsigned long expires)
+int ktimeout_mod(struct ktimeout *ktimeout, unsigned long expires)
 {
 	BUG_ON(!ktimeout->function);
 
@@ -290,7 +290,7 @@ int mod_ktimeout(struct ktimeout *ktimeo
 	return __ktimeout_mod(ktimeout, expires);
 }
 
-EXPORT_SYMBOL(mod_ktimeout);
+EXPORT_SYMBOL(ktimeout_mod);
 
 /***
  * ktimeout_del - deactive a timeout.

--

