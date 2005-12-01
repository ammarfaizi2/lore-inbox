Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751305AbVK3X72@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751305AbVK3X72 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 18:59:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751297AbVK3X7E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 18:59:04 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:12451
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1751320AbVK3X6d
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 18:58:33 -0500
Subject: [patch 32/43] rename setup_ktimeout() to ktimeout_setup()
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, mingo@elte.hu, zippel@linux-m68k.org, george@mvista.com,
       johnstul@us.ibm.com
References: <20051130231140.164337000@tglx.tec.linutronix.de>
Content-Type: text/plain
Organization: linutronix
Date: Thu, 01 Dec 2005 01:04:05 +0100
Message-Id: <1133395445.32542.475.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

plain text document attachment (ktimeout-rename-ktimeout_setup.patch)
- rename setup_ktimeout() to ktimeout_setup()

Signed-off-by: Ingo Molnar <mingo@elte.hu>

 include/linux/ktimeout.h |    2 +-
 include/linux/timer.h    |    2 +-
 kernel/ktimeout.c        |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

Index: linux/include/linux/ktimeout.h
===================================================================
--- linux.orig/include/linux/ktimeout.h
+++ linux/include/linux/ktimeout.h
@@ -36,7 +36,7 @@ extern struct ktimeout_base_s __init_kti
 
 void fastcall ktimeout_init(struct ktimeout * ktimeout);
 
-static inline void setup_ktimeout(struct ktimeout * ktimeout,
+static inline void ktimeout_setup(struct ktimeout * ktimeout,
 				void (*function)(unsigned long),
 				unsigned long data)
 {
Index: linux/include/linux/timer.h
===================================================================
--- linux.orig/include/linux/timer.h
+++ linux/include/linux/timer.h
@@ -17,7 +17,7 @@
 #define TIMER_INITIALIZER		KTIMEOUT_INITIALIZER 
 #define DEFINE_TIMER			DEFINE_KTIMEOUT
 #define init_timer			ktimeout_init
-#define setup_timer			setup_ktimeout
+#define setup_timer			ktimeout_setup
 #define timer_pending			ktimeout_pending
 #define add_timer_on			add_ktimeout_on
 #define del_timer			del_ktimeout
Index: linux/kernel/ktimeout.c
===================================================================
--- linux.orig/kernel/ktimeout.c
+++ linux/kernel/ktimeout.c
@@ -621,7 +621,7 @@ fastcall signed long __sched schedule_ti
 
 	expire = timeout + jiffies;
 
-	setup_ktimeout(&ktimeout, process_timeout, (unsigned long)current);
+	ktimeout_setup(&ktimeout, process_timeout, (unsigned long)current);
 	__mod_ktimeout(&ktimeout, expire);
 	schedule();
 	del_singleshot_ktimeout_sync(&ktimeout);

--

