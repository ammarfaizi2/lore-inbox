Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262066AbVBXHkb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262066AbVBXHkb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 02:40:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262061AbVBXHjB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 02:39:01 -0500
Received: from smtp104.mail.sc5.yahoo.com ([66.163.169.223]:57190 "HELO
	smtp104.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261900AbVBXHam (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 02:30:42 -0500
Subject: [PATCH 13/13] basic tuning
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1109230125.5177.91.camel@npiggin-nld.site>
References: <1109229293.5177.64.camel@npiggin-nld.site>
	 <1109229362.5177.67.camel@npiggin-nld.site>
	 <1109229415.5177.68.camel@npiggin-nld.site>
	 <1109229491.5177.71.camel@npiggin-nld.site>
	 <1109229542.5177.73.camel@npiggin-nld.site>
	 <1109229650.5177.78.camel@npiggin-nld.site>
	 <1109229700.5177.79.camel@npiggin-nld.site>
	 <1109229760.5177.81.camel@npiggin-nld.site>
	 <1109229867.5177.84.camel@npiggin-nld.site>
	 <1109229935.5177.85.camel@npiggin-nld.site>
	 <1109230031.5177.87.camel@npiggin-nld.site>
	 <1109230087.5177.89.camel@npiggin-nld.site>
	 <1109230125.5177.91.camel@npiggin-nld.site>
Content-Type: multipart/mixed; boundary="=-+yybaCAps4o+FKMDeai8"
Date: Thu, 24 Feb 2005 18:30:32 +1100
Message-Id: <1109230233.5177.94.camel@npiggin-nld.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-+yybaCAps4o+FKMDeai8
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

13/13


--=-+yybaCAps4o+FKMDeai8
Content-Disposition: attachment; filename=sched-tune.patch
Content-Type: text/x-patch; name=sched-tune.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Do some basic initial tuning.

Signed-off-by: Nick Piggin <nickpiggin@yahoo.com.au>

Index: linux-2.6/include/asm-x86_64/topology.h
===================================================================
--- linux-2.6.orig/include/asm-x86_64/topology.h	2005-02-24 17:39:07.615911131 +1100
+++ linux-2.6/include/asm-x86_64/topology.h	2005-02-24 17:39:07.990864853 +1100
@@ -52,12 +52,11 @@
 	.cache_nice_tries	= 2,			\
 	.busy_idx		= 3,			\
 	.idle_idx		= 2,			\
-	.newidle_idx		= 1, 			\
+	.newidle_idx		= 0, 			\
 	.wake_idx		= 1,			\
 	.forkexec_idx		= 1,			\
 	.per_cpu_gain		= 100,			\
 	.flags			= SD_LOAD_BALANCE	\
-				| SD_BALANCE_NEWIDLE	\
 				| SD_BALANCE_FORK	\
 				| SD_BALANCE_EXEC	\
 				| SD_WAKE_BALANCE,	\
Index: linux-2.6/include/linux/topology.h
===================================================================
--- linux-2.6.orig/include/linux/topology.h	2005-02-24 17:39:07.616911007 +1100
+++ linux-2.6/include/linux/topology.h	2005-02-24 17:39:07.991864730 +1100
@@ -118,15 +118,14 @@
 	.cache_nice_tries	= 1,			\
 	.per_cpu_gain		= 100,			\
 	.busy_idx		= 2,			\
-	.idle_idx		= 0,			\
-	.newidle_idx		= 1,			\
+	.idle_idx		= 1,			\
+	.newidle_idx		= 2,			\
 	.wake_idx		= 1,			\
-	.forkexec_idx		= 0,			\
+	.forkexec_idx		= 1,			\
 	.flags			= SD_LOAD_BALANCE	\
 				| SD_BALANCE_NEWIDLE	\
 				| SD_BALANCE_EXEC	\
-				| SD_WAKE_AFFINE	\
-				| SD_WAKE_BALANCE,	\
+				| SD_WAKE_AFFINE,	\
 	.last_balance		= jiffies,		\
 	.balance_interval	= 1,			\
 	.nr_balance_failed	= 0,			\

--=-+yybaCAps4o+FKMDeai8--


