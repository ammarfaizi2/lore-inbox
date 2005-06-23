Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262274AbVFWHp3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262274AbVFWHp3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 03:45:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262350AbVFWHpY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 03:45:24 -0400
Received: from [24.22.56.4] ([24.22.56.4]:14822 "EHLO
	w-gerrit.beaverton.ibm.com") by vger.kernel.org with ESMTP
	id S262274AbVFWGSn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 02:18:43 -0400
Message-Id: <20050623061800.928796000@w-gerrit.beaverton.ibm.com>
References: <20050623061552.833852000@w-gerrit.beaverton.ibm.com>
Date: Wed, 22 Jun 2005 23:16:25 -0700
From: Gerrit Huizenga <gh@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: ckrm-tech@lists.sourceforge.net, Matt Helsley <matthltc@us.ibm.com>,
       Gerrit Huizenga <gh@us.ibm.com>
Subject: [patch 33/38] CKRM e18: Send timestamps to userspace in msecs instead of jiffies
Content-Disposition: inline; filename=ckrm-jiffies_to_msec-modified
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Send timestamps to userspace in msecs instead of jiffies.

Signed-Off-By: Matt Helsley <matthltc@us.ibm.com>
Signed-Off-By: Gerrit Huizenga <gh@us.ibm.com>

---------------------------------------------------------------------

Index: linux-2.6.12-ckrm1/include/linux/crbce.h
===================================================================
--- linux-2.6.12-ckrm1.orig/include/linux/crbce.h	2005-06-20 15:37:54.000000000 -0700
+++ linux-2.6.12-ckrm1/include/linux/crbce.h	2005-06-20 15:37:59.000000000 -0700
@@ -90,7 +90,7 @@ struct crbce_hdr {
 struct crbce_hdr_ts {
 	int type;
 	pid_t pid;
-	uint32_t jiffies;
+	uint32_t timestamp;  /* in msecs */
 	uint64_t cls;
 };
 
Index: linux-2.6.12-ckrm1/kernel/ckrm/rbce/crbce_ext.c
===================================================================
--- linux-2.6.12-ckrm1.orig/kernel/ckrm/rbce/crbce_ext.c	2005-06-20 13:08:48.000000000 -0700
+++ linux-2.6.12-ckrm1/kernel/ckrm/rbce/crbce_ext.c	2005-06-20 15:37:59.000000000 -0700
@@ -25,6 +25,7 @@
 
 #include <net/sock.h>
 #include <linux/netlink.h>
+#include <linux/jiffies.h>
 #include "rbce_internal.h"
 
 #define PSAMPLE(pdata)    (&((pdata)->ext_data.sample))
@@ -123,7 +124,8 @@ static inline void close_ukcc_channel(vo
 
 #define rec_set_hdr(r,t,p)      ((r)->hdr.type = (t), (r)->hdr.pid = (p))
 #define rec_set_timehdr(r,t,p,c)  (rec_set_hdr(r,t,p), \
-	(r)->hdr.jiffies = jiffies, (r)->hdr.cls=(unsigned long)(c) )
+	(r)->hdr.timestamp = jiffies_to_msecs(jiffies), \
+	(r)->hdr.cls=(unsigned long)(c) )
 
 #if CHANNEL_AUTO_CONT
 

--
