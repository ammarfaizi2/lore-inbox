Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265302AbSJXDs1>; Wed, 23 Oct 2002 23:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265303AbSJXDs1>; Wed, 23 Oct 2002 23:48:27 -0400
Received: from out002pub.verizon.net ([206.46.170.141]:29120 "EHLO
	out002.verizon.net") by vger.kernel.org with ESMTP
	id <S265302AbSJXDs1>; Wed, 23 Oct 2002 23:48:27 -0400
Message-ID: <3DB76EC0.F9EB4A36@verizon.net>
Date: Wed, 23 Oct 2002 20:53:36 -0700
From: "Randy.Dunlap" <randy.dunlap@verizon.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.44 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [trivial] module.c double init?
Content-Type: multipart/mixed;
 boundary="------------343A2A36B592C87E961DF027"
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at out002.verizon.net from [4.64.197.173] at Wed, 23 Oct 2002 22:54:33 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------343A2A36B592C87E961DF027
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

in 2.5.44: kernel/module.c, function s_start(), there is:
	loff_t n = *pos;

and then same "n = *pos" is done in the for-loop initializer.
It's just a thinko, right?  or am I missing something?

Patch attached (to 2.5.44).

~Randy
--------------343A2A36B592C87E961DF027
Content-Type: text/plain; charset=us-ascii;
 name="module-dblinit-2544.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="module-dblinit-2544.patch"

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

