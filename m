Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261551AbSIXEsA>; Tue, 24 Sep 2002 00:48:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261556AbSIXEsA>; Tue, 24 Sep 2002 00:48:00 -0400
Received: from dp.samba.org ([66.70.73.150]:51349 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261551AbSIXEr7>;
	Tue, 24 Sep 2002 00:47:59 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] streq()
Date: Tue, 24 Sep 2002 14:49:41 +1000
Message-Id: <20020924045313.0FBE52C075@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Embarrassing, huh?  But I just found a bug in my code cause by
"if (strcmp(a,b))" instead of "if (!strcmp(a,b))".

This bites me about once a year, so Linus, please apply.

Preparing to have my "3l33t k3rN31 h@ck3r" card revoked,
Rusty.

Name: streq implementation
Author: Rusty Russell
Status: Trivial

D: I can't believe that after all these years I still make the "sense
D: of strcmp" mistake.  So it's time to reintroduce my favorite macro.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.38/include/linux/string.h working-2.5.38-streq/include/linux/string.h
--- linux-2.5.38/include/linux/string.h	2002-06-06 21:38:40.000000000 +1000
+++ working-2.5.38-streq/include/linux/string.h	2002-09-24 14:43:30.000000000 +1000
@@ -15,7 +15,7 @@ extern "C" {
 extern char * strpbrk(const char *,const char *);
 extern char * strsep(char **,const char *);
 extern __kernel_size_t strspn(const char *,const char *);
-
+#define streq(a,b) (strcmp((a),(b)) == 0)
 
 /*
  * Include machine specific inline routines

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
