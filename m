Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261582AbSJ2EFn>; Mon, 28 Oct 2002 23:05:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261583AbSJ2EFn>; Mon, 28 Oct 2002 23:05:43 -0500
Received: from air-2.osdl.org ([65.172.181.6]:55259 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261582AbSJ2EFm>;
	Mon, 28 Oct 2002 23:05:42 -0500
Date: Mon, 28 Oct 2002 20:08:36 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: <linux-kernel@vger.kernel.org>
cc: <torvalds@transmeta.com>
Subject: [PATCH] remove /proc/ksyms double-init
Message-ID: <Pine.LNX.4.33L2.0210282006210.13379-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.33L2.0210282006212.13379@dragon.pdx.osdl.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Little patch for dumping /proc/ksyms.
Variable <n> was being initialized 2 times.

Patch is to 2.5.44, please apply.

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

