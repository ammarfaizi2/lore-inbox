Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751333AbVK3X6q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751333AbVK3X6q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 18:58:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751335AbVK3X6q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 18:58:46 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:26275
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1751333AbVK3X6o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 18:58:44 -0500
Subject: [patch 41/43] rename del_singleshot_ktimeout_sync() to
	ktimeout_del_singleshot_sync()
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, mingo@elte.hu, zippel@linux-m68k.org, george@mvista.com,
       johnstul@us.ibm.com
References: <20051130231140.164337000@tglx.tec.linutronix.de>
Content-Type: text/plain
Organization: linutronix
Date: Thu, 01 Dec 2005 01:04:26 +0100
Message-Id: <1133395466.32542.485.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

plain text document attachment
(ktimeout-rename-ktimeout_del_singleshot_sync.patch)
- rename del_singleshot_ktimeout_sync() to ktimeout_del_singleshot_sync()

Signed-off-by: Ingo Molnar <mingo@elte.hu>

 include/linux/ktimeout.h |    2 +-
 include/linux/timer.h    |    2 +-
 kernel/ktimeout.c        |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

Index: linux/include/linux/ktimeout.h
===================================================================
--- linux.orig/include/linux/ktimeout.h
+++ linux/include/linux/ktimeout.h
@@ -95,7 +95,7 @@ static inline void ktimeout_add(struct k
 # define ktimeout_del_sync(t)		ktimeout_del(t)
 #endif
 
-#define del_singleshot_ktimeout_sync(t) ktimeout_del_sync(t)
+#define ktimeout_del_singleshot_sync(t) ktimeout_del_sync(t)
 
 extern void init_ktimeouts(void);
 extern void run_local_ktimeouts(void);
Index: linux/include/linux/timer.h
===================================================================
--- linux.orig/include/linux/timer.h
+++ linux/include/linux/timer.h
@@ -27,7 +27,7 @@
 #define add_timer			ktimeout_add
 #define try_to_del_timer_sync		ktimeout_try_to_del_sync
 #define del_timer_sync			ktimeout_del_sync
-#define del_singleshot_timer_sync	del_singleshot_ktimeout_sync
+#define del_singleshot_timer_sync	ktimeout_del_singleshot_sync
 #define init_timers			init_ktimeouts
 #define run_local_timers		run_local_ktimeouts
 
Index: linux/kernel/ktimeout.c
===================================================================
--- linux.orig/kernel/ktimeout.c
+++ linux/kernel/ktimeout.c
@@ -624,7 +624,7 @@ fastcall signed long __sched schedule_ti
 	ktimeout_setup(&ktimeout, process_timeout, (unsigned long)current);
 	__ktimeout_mod(&ktimeout, expire);
 	schedule();
-	del_singleshot_ktimeout_sync(&ktimeout);
+	ktimeout_del_singleshot_sync(&ktimeout);
 
 	timeout = expire - jiffies;
 

--

