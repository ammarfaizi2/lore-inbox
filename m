Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751132AbVJXQH6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751132AbVJXQH6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 12:07:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751134AbVJXQH6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 12:07:58 -0400
Received: from 253-121.adsl.pool.ew.hu ([193.226.253.121]:3603 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1751132AbVJXQH5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 12:07:57 -0400
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: [PATCH 2.6.14-rc5-mm1] fix inline spin_unlock for UP
Message-Id: <E1EU4rH-0005nR-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 24 Oct 2005 18:07:35 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The "inline spin_unlock..." patches don't compile on:

CONFIG_PREEMPT=n
CONFIG_DEBUG_SPINLOCK=n
CONFIG_SMP=n

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

Index: linux/include/linux/spinlock.h
===================================================================
--- linux.orig/include/linux/spinlock.h	2005-10-24 13:00:29.000000000 +0200
+++ linux/include/linux/spinlock.h	2005-10-24 13:12:08.000000000 +0200
@@ -174,7 +174,7 @@ extern int __lockfunc generic__raw_read_
 /*
  * We inline the unlock functions in the nondebug case:
  */
-#if defined(CONFIG_DEBUG_SPINLOCK) || defined(CONFIG_PREEMPT)
+#if defined(CONFIG_DEBUG_SPINLOCK) || defined(CONFIG_PREEMPT) || !defined(CONFIG_SMP)
 # define spin_unlock(lock)		_spin_unlock(lock)
 # define read_unlock(lock)		_read_unlock(lock)
 # define write_unlock(lock)		_write_unlock(lock)
@@ -184,7 +184,7 @@ extern int __lockfunc generic__raw_read_
 # define write_unlock(lock)		__raw_write_unlock(&(lock)->raw_lock)
 #endif
 
-#if defined(CONFIG_DEBUG_SPINLOCK) || defined(CONFIG_PREEMPT)
+#if defined(CONFIG_DEBUG_SPINLOCK) || defined(CONFIG_PREEMPT) || !defined(CONFIG_SMP)
 # define spin_unlock_irq(lock)		_spin_unlock_irq(lock)
 # define read_unlock_irq(lock)		_read_unlock_irq(lock)
 # define write_unlock_irq(lock)		_write_unlock_irq(lock)
