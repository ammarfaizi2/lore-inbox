Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317410AbSFRNpl>; Tue, 18 Jun 2002 09:45:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317413AbSFRNpl>; Tue, 18 Jun 2002 09:45:41 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:50446 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317410AbSFRNpk>;
	Tue, 18 Jun 2002 09:45:40 -0400
Date: Tue, 18 Jun 2002 14:45:41 +0100
From: Matthew Wilcox <willy@debian.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Remove sync_timers
Message-ID: <20020618144541.G9435@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Nobody's using it any more, kill:

diff -urNX dontdiff linux-2.5.22/include/linux/timer.h linux-2.5.22-bh/include/linux/timer.h
--- linux-2.5.22/include/linux/timer.h	Thu Jun  6 06:57:51 2002
+++ linux-2.5.22-bh/include/linux/timer.h	Mon Jun 17 16:02:04 2002
@@ -25,10 +25,8 @@
 
 #ifdef CONFIG_SMP
 extern int del_timer_sync(struct timer_list * timer);
-extern void sync_timers(void);
 #else
 #define del_timer_sync(t)	del_timer(t)
-#define sync_timers()		do { } while (0)
 #endif
 
 /*
diff -urNX dontdiff linux-2.5.22/kernel/timer.c linux-2.5.22-bh/kernel/timer.c
--- linux-2.5.22/kernel/timer.c	Sun Jun  9 06:09:49 2002
+++ linux-2.5.22-bh/kernel/timer.c	Tue Jun 18 05:13:51 2002
@@ -231,11 +232,6 @@
 }
 
 #ifdef CONFIG_SMP
-void sync_timers(void)
-{
-	spin_unlock_wait(&global_bh_lock);
-}
-
 /*
  * SMP specific function to delete periodic timer.
  * Caller must disable by some means restarting the timer

-- 
Revolutions do not require corporate support.
