Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264062AbUDQWag (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 18:30:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264064AbUDQWag
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 18:30:36 -0400
Received: from smtp.netcabo.pt ([212.113.174.9]:44717 "EHLO smtp.netcabo.pt")
	by vger.kernel.org with ESMTP id S264062AbUDQWaf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 18:30:35 -0400
From: "Pedro Emanuel M. D. Pinto" <pepinto@student.dei.uc.pt>
To: linux kernel <linux-kernel@vger.kernel.org>
Subject: hlist_add_after broken?
Date: Sat, 17 Apr 2004 23:30:34 +0100
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200404172330.34993.pepinto@student.dei.uc.pt>
X-OriginalArrivalTime: 17 Apr 2004 22:30:34.0155 (UTC) FILETIME=[994407B0:01C424CB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is an inline function (hlist_add_after) in include/linux/list.h which I 
believe is broken. The algorithm used doesn't make sence to me so if it 
actually ok I would appreciate if someone could explain it to me. Below is a 
patch I made against version 2.6.1 of what I believe is a working function.

regards,

Pedro Pinto


--- include/linux/list.h.orig	2004-04-17 23:13:42.901457376 +0100
+++ include/linux/list.h	2004-04-17 23:17:28.943093824 +0100
@@ -525,9 +525,12 @@
 static __inline__ void hlist_add_after(struct hlist_node *n,
 				       struct hlist_node *next)
 {
-	next->next	= n->next;
-	*(next->pprev)	= n;
-	n->next		= next;
+	next->next = n->next;
+	n->next = next;
+	next->pprev = &n->next;
+
+	if(next->next)
+		next->next->pprev  = &next->next;
 }

 #define hlist_entry(ptr, type, member) container_of(ptr,type,member)

