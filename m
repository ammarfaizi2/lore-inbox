Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751341AbVK3X6z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751341AbVK3X6z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 18:58:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbVK3X6y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 18:58:54 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:20131
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1751318AbVK3X6h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 18:58:37 -0500
Subject: [patch 37/43] rename next_ktimeout_interrupt() to
	ktimeout_next_interrupt()
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, mingo@elte.hu, zippel@linux-m68k.org, george@mvista.com,
       johnstul@us.ibm.com
References: <20051130231140.164337000@tglx.tec.linutronix.de>
Content-Type: text/plain
Organization: linutronix
Date: Thu, 01 Dec 2005 01:04:18 +0100
Message-Id: <1133395458.32542.480.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

plain text document attachment
(ktimeout-rename-ktimeout_next_interrupt.patch)
- rename next_ktimeout_interrupt() to ktimeout_next_interrupt()

Signed-off-by: Ingo Molnar <mingo@elte.hu>

 include/linux/ktimeout.h |    2 +-
 include/linux/timer.h    |    2 +-
 kernel/ktimeout.c        |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

Index: linux/include/linux/ktimeout.h
===================================================================
--- linux.orig/include/linux/ktimeout.h
+++ linux/include/linux/ktimeout.h
@@ -65,7 +65,7 @@ extern int ktimeout_del(struct ktimeout 
 extern int __ktimeout_mod(struct ktimeout *ktimeout, unsigned long expires);
 extern int ktimeout_mod(struct ktimeout *ktimeout, unsigned long expires);
 
-extern unsigned long next_ktimeout_interrupt(void);
+extern unsigned long ktimeout_next_interrupt(void);
 
 /***
  * add_ktimeout - start a ktimeout
Index: linux/include/linux/timer.h
===================================================================
--- linux.orig/include/linux/timer.h
+++ linux/include/linux/timer.h
@@ -23,7 +23,7 @@
 #define del_timer			ktimeout_del
 #define __mod_timer			__ktimeout_mod
 #define mod_timer			ktimeout_mod
-#define next_timer_interrupt		next_ktimeout_interrupt
+#define next_timer_interrupt		ktimeout_next_interrupt
 #define add_timer			add_ktimeout
 #define try_to_del_timer_sync		try_to_del_ktimeout_sync
 #define del_timer_sync			del_ktimeout_sync
Index: linux/kernel/ktimeout.c
===================================================================
--- linux.orig/kernel/ktimeout.c
+++ linux/kernel/ktimeout.c
@@ -470,7 +470,7 @@ static inline void __run_ktimeouts(tvec_
  * is used on S/390 to stop all activity when a cpus is idle.
  * This functions needs to be called disabled.
  */
-unsigned long next_ktimeout_interrupt(void)
+unsigned long ktimeout_next_interrupt(void)
 {
 	tvec_base_t *base;
 	struct list_head *list;

--

