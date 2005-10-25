Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932156AbVJYOQj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932156AbVJYOQj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 10:16:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932158AbVJYOQj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 10:16:39 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:5791 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932156AbVJYOQi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 10:16:38 -0400
Date: Tue, 25 Oct 2005 07:16:29 -0700 (PDT)
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Paul Jackson <pj@sgi.com>, linux-kernel@vger.kernel.org,
       Jesper Juhl <jesper.juhl@gmail.com>
Message-Id: <20051025141629.21880.42486.sendpatchset@jackhammer.engr.sgi.com>
Subject: [PATCH] lib stringc cleanup restore useful memmove const
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A couple of (char *) casts removed in a previous cleanup patch
in lib/string.c:memmove() were actually useful, as they
suppressed a couple of warnings:

	assignment discards qualifiers from pointer target type        

Fix by declaring the local variable const in the first place,
so casts aren't needed to strip the const qualifier.

Signed-off-by: Paul Jackson <pj@sgi.com>

---

 lib/string.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

--- 2.6.14-rc4-mm1-cpuset-patches.orig/lib/string.c	2005-10-17 23:01:05.974858400 -0700
+++ 2.6.14-rc4-mm1-cpuset-patches/lib/string.c	2005-10-25 06:49:42.921723168 -0700
@@ -488,7 +488,8 @@ EXPORT_SYMBOL(memcpy);
  */
 void *memmove(void *dest, const void *src, size_t count)
 {
-	char *tmp, *s;
+	char *tmp;
+	const char *s;
 
 	if (dest <= src) {
 		tmp = dest;

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
