Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263173AbTDMEad (for <rfc822;willy@w.ods.org>); Sun, 13 Apr 2003 00:30:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263239AbTDMEad (for <rfc822;linux-kernel-outgoing>);
	Sun, 13 Apr 2003 00:30:33 -0400
Received: from [12.47.58.73] ([12.47.58.73]:3985 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S263173AbTDMEac (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Apr 2003 00:30:32 -0400
Date: Sat, 12 Apr 2003 21:42:14 -0700
From: Andrew Morton <akpm@digeo.com>
To: Jeremy Hall <jhall@maoz.com>
Cc: wli@holomorphy.com, jhall@maoz.com, felipe_alfaro@linuxmail.org,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Joshua Kwan <joshk@triplehelix.org>,
       Shane Shrybman <shrybman@sympatico.ca>
Subject: Re: 2.5.67-mm2
Message-Id: <20030412214214.57a87776.akpm@digeo.com>
In-Reply-To: <200304130350.h3D3o8pn031108@sith.maoz.com>
References: <20030413031440.GA14357@holomorphy.com>
	<200304130350.h3D3o8pn031108@sith.maoz.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Apr 2003 04:42:13.0625 (UTC) FILETIME=[0D87DE90:01C30177]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This should fix it up.

 include/linux/spinlock.h |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff -puN include/linux/spinlock.h~lockmeter-fixes include/linux/spinlock.h
--- 25/include/linux/spinlock.h~lockmeter-fixes	2003-04-12 21:35:49.000000000 -0700
+++ 25-akpm/include/linux/spinlock.h	2003-04-12 21:35:57.000000000 -0700
@@ -328,20 +328,20 @@ do { \
 
 #define spin_unlock_irqrestore(lock, flags) \
 do { \
-	spin_unlock(lock); \
+	_raw_spin_unlock(lock); \
 	local_irq_restore(flags); \
 	preempt_enable(); \
 } while (0)
 
 #define _raw_spin_unlock_irqrestore(lock, flags) \
 do { \
-	spin_unlock(lock); \
+	_raw_spin_unlock(lock); \
 	local_irq_restore(flags); \
 } while (0)
 
 #define spin_unlock_irq(lock) \
 do { \
-	spin_unlock(lock); \
+	_raw_spin_unlock(lock); \
 	local_irq_enable(); \
 	preempt_enable(); \
 } while (0)
@@ -355,14 +355,14 @@ do { \
 
 #define read_unlock_irqrestore(lock, flags) \
 do { \
-	read_unlock(lock); \
+	_raw_read_unlock(lock); \
 	local_irq_restore(flags); \
 	preempt_enable(); \
 } while (0)
 
 #define read_unlock_irq(lock) \
 do { \
-	read_unlock(lock); \
+	_raw_read_unlock(lock); \
 	local_irq_enable(); \
 	preempt_enable(); \
 } while (0)
@@ -376,14 +376,14 @@ do { \
 
 #define write_unlock_irqrestore(lock, flags) \
 do { \
-	write_unlock(lock); \
+	_raw_write_unlock(lock); \
 	local_irq_restore(flags); \
 	preempt_enable(); \
 } while (0)
 
 #define write_unlock_irq(lock) \
 do { \
-	write_unlock(lock); \
+	_raw_write_unlock(lock); \
 	local_irq_enable(); \
 	preempt_enable(); \
 } while (0)

_

