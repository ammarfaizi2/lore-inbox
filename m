Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751323AbVLAAEg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751323AbVLAAEg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 19:04:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbVLAAD6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 19:03:58 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:4515
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1751287AbVK3X6X
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 18:58:23 -0500
Subject: [patch 27/43] Convert timer_list users to ktimeout
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, mingo@elte.hu, zippel@linux-m68k.org, george@mvista.com,
       johnstul@us.ibm.com
References: <20051130231140.164337000@tglx.tec.linutronix.de>
Content-Type: text/plain
Organization: linutronix
Date: Thu, 01 Dec 2005 01:03:54 +0100
Message-Id: <1133395434.32542.470.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

plain text document attachment (ktimeout-struct-more.patch)
- convert all uses of struct timer_list in ktimeout.h over to struct ktimeout

Signed-off-by: Ingo Molnar <mingo@elte.hu>

 include/linux/ktimeout.h |   22 +++++++++++-----------
 1 files changed, 11 insertions(+), 11 deletions(-)

Index: linux/include/linux/ktimeout.h
===================================================================
--- linux.orig/include/linux/ktimeout.h
+++ linux/include/linux/ktimeout.h
@@ -28,12 +28,12 @@ extern struct timer_base_s __init_timer_
 	}
 
 #define DEFINE_TIMER(_name, _function, _expires, _data)		\
-	struct timer_list _name =				\
+	struct ktimeout _name =				\
 		TIMER_INITIALIZER(_function, _expires, _data)
 
-void fastcall init_timer(struct timer_list * timer);
+void fastcall init_timer(struct ktimeout * timer);
 
-static inline void setup_timer(struct timer_list * timer,
+static inline void setup_timer(struct ktimeout * timer,
 				void (*function)(unsigned long),
 				unsigned long data)
 {
@@ -52,15 +52,15 @@ static inline void setup_timer(struct ti
  *
  * return value: 1 if the timer is pending, 0 if not.
  */
-static inline int timer_pending(const struct timer_list * timer)
+static inline int timer_pending(const struct ktimeout * timer)
 {
 	return timer->entry.next != NULL;
 }
 
-extern void add_timer_on(struct timer_list *timer, int cpu);
-extern int del_timer(struct timer_list * timer);
-extern int __mod_timer(struct timer_list *timer, unsigned long expires);
-extern int mod_timer(struct timer_list *timer, unsigned long expires);
+extern void add_timer_on(struct ktimeout *timer, int cpu);
+extern int del_timer(struct ktimeout * timer);
+extern int __mod_timer(struct ktimeout *timer, unsigned long expires);
+extern int mod_timer(struct ktimeout *timer, unsigned long expires);
 
 extern unsigned long next_timer_interrupt(void);
 
@@ -78,15 +78,15 @@ extern unsigned long next_timer_interrup
  * Timers with an ->expired field in the past will be executed in the next
  * timer tick.
  */
-static inline void add_timer(struct timer_list *timer)
+static inline void add_timer(struct ktimeout *timer)
 {
 	BUG_ON(timer_pending(timer));
 	__mod_timer(timer, timer->expires);
 }
 
 #ifdef CONFIG_SMP
-  extern int try_to_del_timer_sync(struct timer_list *timer);
-  extern int del_timer_sync(struct timer_list *timer);
+  extern int try_to_del_timer_sync(struct ktimeout *timer);
+  extern int del_timer_sync(struct ktimeout *timer);
 #else
 # define try_to_del_timer_sync(t)	del_timer(t)
 # define del_timer_sync(t)		del_timer(t)

--

