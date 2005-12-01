Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751330AbVLAAAq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751330AbVLAAAq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 19:00:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751318AbVK3X65
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 18:58:57 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:17059
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1751327AbVK3X6f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 18:58:35 -0500
Subject: [patch 35/43] rename __mod_ktimeout() to __mod_ktimeout()
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, mingo@elte.hu, zippel@linux-m68k.org, george@mvista.com,
       johnstul@us.ibm.com
References: <20051130231140.164337000@tglx.tec.linutronix.de>
Content-Type: text/plain
Organization: linutronix
Date: Thu, 01 Dec 2005 01:04:12 +0100
Message-Id: <1133395452.32542.478.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

plain text document attachment (ktimeout-rename-__ktimeout_mod.patch)
- rename __mod_ktimeout() to __mod_ktimeout()

Signed-off-by: Ingo Molnar <mingo@elte.hu>

 include/linux/ktimeout.h |    4 ++--
 include/linux/timer.h    |    2 +-
 kernel/ktimeout.c        |    8 ++++----
 3 files changed, 7 insertions(+), 7 deletions(-)

Index: linux/include/linux/ktimeout.h
===================================================================
--- linux.orig/include/linux/ktimeout.h
+++ linux/include/linux/ktimeout.h
@@ -62,7 +62,7 @@ static inline int ktimeout_pending(const
 
 extern void ktimeout_add_on(struct ktimeout *ktimeout, int cpu);
 extern int ktimeout_del(struct ktimeout * ktimeout);
-extern int __mod_ktimeout(struct ktimeout *ktimeout, unsigned long expires);
+extern int __ktimeout_mod(struct ktimeout *ktimeout, unsigned long expires);
 extern int mod_ktimeout(struct ktimeout *ktimeout, unsigned long expires);
 
 extern unsigned long next_ktimeout_interrupt(void);
@@ -84,7 +84,7 @@ extern unsigned long next_ktimeout_inter
 static inline void add_ktimeout(struct ktimeout *ktimeout)
 {
 	BUG_ON(ktimeout_pending(ktimeout));
-	__mod_ktimeout(ktimeout, ktimeout->expires);
+	__ktimeout_mod(ktimeout, ktimeout->expires);
 }
 
 #ifdef CONFIG_SMP
Index: linux/include/linux/timer.h
===================================================================
--- linux.orig/include/linux/timer.h
+++ linux/include/linux/timer.h
@@ -21,7 +21,7 @@
 #define timer_pending			ktimeout_pending
 #define add_timer_on			ktimeout_add_on
 #define del_timer			ktimeout_del
-#define __mod_timer			__mod_ktimeout
+#define __mod_timer			__ktimeout_mod
 #define mod_timer			mod_ktimeout
 #define next_timer_interrupt		next_ktimeout_interrupt
 #define add_timer			add_ktimeout
Index: linux/kernel/ktimeout.c
===================================================================
--- linux.orig/kernel/ktimeout.c
+++ linux/kernel/ktimeout.c
@@ -189,7 +189,7 @@ static ktimeout_base_t *lock_ktimeout_ba
 	}
 }
 
-int __mod_ktimeout(struct ktimeout *ktimeout, unsigned long expires)
+int __ktimeout_mod(struct ktimeout *ktimeout, unsigned long expires)
 {
 	ktimeout_base_t *base;
 	tvec_base_t *new_base;
@@ -234,7 +234,7 @@ int __mod_ktimeout(struct ktimeout *ktim
 	return ret;
 }
 
-EXPORT_SYMBOL(__mod_ktimeout);
+EXPORT_SYMBOL(__ktimeout_mod);
 
 /***
  * ktimeout_add_on - start a timeout on a particular CPU
@@ -287,7 +287,7 @@ int mod_ktimeout(struct ktimeout *ktimeo
 	if (ktimeout->expires == expires && ktimeout_pending(ktimeout))
 		return 1;
 
-	return __mod_ktimeout(ktimeout, expires);
+	return __ktimeout_mod(ktimeout, expires);
 }
 
 EXPORT_SYMBOL(mod_ktimeout);
@@ -622,7 +622,7 @@ fastcall signed long __sched schedule_ti
 	expire = timeout + jiffies;
 
 	ktimeout_setup(&ktimeout, process_timeout, (unsigned long)current);
-	__mod_ktimeout(&ktimeout, expire);
+	__ktimeout_mod(&ktimeout, expire);
 	schedule();
 	del_singleshot_ktimeout_sync(&ktimeout);
 

--

