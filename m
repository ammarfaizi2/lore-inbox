Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262016AbSI3LEj>; Mon, 30 Sep 2002 07:04:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262017AbSI3LEj>; Mon, 30 Sep 2002 07:04:39 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:32666 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S262016AbSI3LEi>; Mon, 30 Sep 2002 07:04:38 -0400
Date: Mon, 30 Sep 2002 16:45:47 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.39-mm1 fixes 2/3
Message-ID: <20020930164547.B27121@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20020930164314.A27121@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020930164314.A27121@in.ibm.com>; from dipankar@in.ibm.com on Mon, Sep 30, 2002 at 04:43:14PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The read_barrier_depends patch didn't have compilable list_for_each_rcu()
macros. These macros allow a simpler interface to use RCU by taking
care of memory barriers. Fix against 2.5.39-mm1.

Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.


--- include/linux/list.h.orig	Mon Sep 30 13:59:10 2002
+++ include/linux/list.h	Mon Sep 30 13:59:23 2002
@@ -307,7 +307,7 @@
  */
 #define list_for_each_rcu(pos, head) \
 	for (pos = (head)->next, prefetch(pos->next); pos != (head); \
-        	pos = pos->next, ({ read_barrier_depends(); 0}), prefetch(pos->next))
+        	pos = pos->next, ({ read_barrier_depends(); 0;}), prefetch(pos->next))
         	
 /**
  * list_for_each_safe_rcu	-	iterate over an rcu-protected list safe
@@ -318,7 +318,7 @@
  */
 #define list_for_each_safe_rcu(pos, n, head) \
 	for (pos = (head)->next, n = pos->next; pos != (head); \
-		pos = n, ({ read_barrier_depends(); 0}), n = pos->next)
+		pos = n, ({ read_barrier_depends(); 0;}), n = pos->next)
 
 #endif /* __KERNEL__ || _LVM_H_INCLUDE */
 
