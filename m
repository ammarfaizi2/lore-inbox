Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751633AbWHAOcY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751633AbWHAOcY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 10:32:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751636AbWHAOcY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 10:32:24 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:15802 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S1751633AbWHAOcX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 10:32:23 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH][Doc] Fix kerneldoc comments in kernel/timer.c
Date: Tue, 1 Aug 2006 16:31:39 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608011631.40189.eike-kernel@sf-tec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the kerneldoc comments in this file are ignored since the lead-in is
malformed, using either "/*" or "/***" instead of "/**".

Signed-off-by: Rolf Eike Beer <eike-kernel@sf-tec.de>

---
commit 4f52325acb61992f368a341938f8838caeacbec2
tree 8269f608e1bc704a146c1de4419bc59e5e4e312c
parent 55728fac5ce213ab144b6837054e03476ab6b6b7
author Rolf Eike Beer <eike-kernel@sf-tec.de> Tue, 01 Aug 2006 16:23:22 +0200
committer Rolf Eike Beer <beer@siso-eb-i34d.silicon-software.de> Tue, 01 Aug 2006 16:23:22 +0200

 kernel/timer.c |   25 +++++++++++++++----------
 1 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/kernel/timer.c b/kernel/timer.c
index b650f04..f96c4fa 100644
--- a/kernel/timer.c
+++ b/kernel/timer.c
@@ -136,7 +136,7 @@ static void internal_add_timer(tvec_base
 	list_add_tail(&timer->entry, vec);
 }
 
-/***
+/**
  * init_timer - initialize a timer.
  * @timer: the timer to be initialized
  *
@@ -235,7 +235,7 @@ int __mod_timer(struct timer_list *timer
 
 EXPORT_SYMBOL(__mod_timer);
 
-/***
+/**
  * add_timer_on - start a timer on a particular CPU
  * @timer: the timer to be added
  * @cpu: the CPU to start it on
@@ -255,9 +255,10 @@ void add_timer_on(struct timer_list *tim
 }
 
 
-/***
+/**
  * mod_timer - modify a timer's timeout
  * @timer: the timer to be modified
+ * @expires: new timeout in jiffies
  *
  * mod_timer is a more efficient way to update the expire field of an
  * active timer (if the timer is inactive it will be activated)
@@ -291,7 +292,7 @@ int mod_timer(struct timer_list *timer, 
 
 EXPORT_SYMBOL(mod_timer);
 
-/***
+/**
  * del_timer - deactive a timer.
  * @timer: the timer to be deactivated
  *
@@ -323,7 +324,10 @@ int del_timer(struct timer_list *timer)
 EXPORT_SYMBOL(del_timer);
 
 #ifdef CONFIG_SMP
-/*
+/**
+ * try_to_del_timer_sync - Try to deactivate a timer
+ * @timer: timer do del
+ *
  * This function tries to deactivate a timer. Upon successful (ret >= 0)
  * exit the timer is not queued and the handler is not running on any CPU.
  *
@@ -351,7 +355,7 @@ out:
 	return ret;
 }
 
-/***
+/**
  * del_timer_sync - deactivate a timer and wait for the handler to finish.
  * @timer: the timer to be deactivated
  *
@@ -401,7 +405,7 @@ static int cascade(tvec_base_t *base, tv
 	return index;
 }
 
-/***
+/**
  * __run_timers - run all expired timers (if any) on this CPU.
  * @base: the timer vector to be processed.
  *
@@ -970,7 +974,7 @@ void __init timekeeping_init(void)
 
 
 static int timekeeping_suspended;
-/*
+/**
  * timekeeping_resume - Resumes the generic timekeeping subsystem.
  * @dev:	unused
  *
@@ -1106,7 +1110,7 @@ static void clocksource_adjust(struct cl
 	clock->error -= (interval - offset) << (TICK_LENGTH_SHIFT - clock->shift);
 }
 
-/*
+/**
  * update_wall_time - Uses the current clocksource to increment the wall time
  *
  * Called from the timer interrupt, must hold a write on xtime_lock.
@@ -1497,8 +1501,9 @@ asmlinkage long sys_gettid(void)
 	return current->pid;
 }
 
-/*
+/**
  * sys_sysinfo - fill in sysinfo struct
+ * @info: pointer to buffer to fill
  */ 
 asmlinkage long sys_sysinfo(struct sysinfo __user *info)
 {
