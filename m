Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263977AbSJ3FLX>; Wed, 30 Oct 2002 00:11:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263979AbSJ3FLX>; Wed, 30 Oct 2002 00:11:23 -0500
Received: from air-2.osdl.org ([65.172.181.6]:41641 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S263977AbSJ3FLV>;
	Wed, 30 Oct 2002 00:11:21 -0500
Date: Tue, 29 Oct 2002 21:14:07 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: <torvalds@transmeta.com>
cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] (trivial) remove double-init in /proc/ksyms
Message-ID: <Pine.LNX.4.33L2.0210292108540.16850-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This removes a small thinko (2 of: n = *pos) in
kernel/module.c's s_start() function.

Patch is to 2.5.44.  Please apply.

-- 
~Randy



--- ./kernel/module.c.fixit	Fri Oct 18 21:01:17 2002
+++ ./kernel/module.c	Wed Oct 23 19:54:10 2002
@@ -1165,7 +1165,7 @@
 	if (!p)
 		return ERR_PTR(-ENOMEM);
 	lock_kernel();
-	for (v = module_list, n = *pos; v; n -= v->nsyms, v = v->next) {
+	for (v = module_list; v; n -= v->nsyms, v = v->next) {
 		if (n < v->nsyms) {
 			p->mod = v;
 			p->index = n;

