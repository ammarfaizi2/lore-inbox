Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262250AbSJ0DSa>; Sat, 26 Oct 2002 23:18:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262255AbSJ0DSa>; Sat, 26 Oct 2002 23:18:30 -0400
Received: from air-2.osdl.org ([65.172.181.6]:59022 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S262250AbSJ0DS3>;
	Sat, 26 Oct 2002 23:18:29 -0400
Date: Sat, 26 Oct 2002 20:21:34 -0700 (PDT)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] <trivial> module.c double init
Message-ID: <Pine.LNX.4.33L2.0210262018290.30019-200000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: MULTIPART/Mixed; BOUNDARY=------------343A2A36B592C87E961DF027
Content-ID: <Pine.LNX.4.33L2.0210262018291.30019@dragon.pdx.osdl.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--------------343A2A36B592C87E961DF027
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.33L2.0210262018292.30019@dragon.pdx.osdl.net>


in 2.5.44: kernel/module.c, function s_start(), there is:
	loff_t n = *pos;

and then same "n = *pos" is done in the for-loop initializer.

Patch attached (to 2.5.44).  Please apply.  8:)

~Randy

--------------343A2A36B592C87E961DF027
Content-Type: TEXT/PLAIN; CHARSET=us-ascii; NAME="module-dblinit-2544.patch"
Content-ID: <Pine.LNX.4.33L2.0210262018293.30019@dragon.pdx.osdl.net>
Content-Description: 
Content-Disposition: INLINE; FILENAME="module-dblinit-2544.patch"

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

--------------343A2A36B592C87E961DF027--
