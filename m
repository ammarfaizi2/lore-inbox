Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422759AbWJFRO1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422759AbWJFRO1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 13:14:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422761AbWJFRO1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 13:14:27 -0400
Received: from mail.codesourcery.com ([65.74.133.4]:60396 "EHLO
	mail.codesourcery.com") by vger.kernel.org with ESMTP
	id S1422759AbWJFRO0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 13:14:26 -0400
Date: Fri, 6 Oct 2006 17:14:24 +0000 (UTC)
From: "Joseph S. Myers" <joseph@codesourcery.com>
X-X-Sender: jsm28@digraph.polyomino.org.uk
To: linux-kernel@vger.kernel.org
cc: David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH] Remove "#ifdef linux" from linux/a.out.h
Message-ID: <Pine.LNX.4.64.0610061712110.18057@digraph.polyomino.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The <linux/a.out.h> header contains "#ifdef linux".  GCC's fixincludes
then creates its own copy of the installed header with this changed to
"#ifdef __linux__".  There should be no need for "#ifdef linux" in
Linux kernel headers, so this patch removes the conditional.  With
this patch, fixincludes (from GCC 4.1) makes no changes to the headers
installed by "make headers_install" on MIPS (I haven't tested on other
architectures).

Signed-off-by: Joseph Myers <joseph@codesourcery.com>
---
Index: include/linux/a.out.h
===================================================================
--- include/linux/a.out.h
+++ include/linux/a.out.h
@@ -127,7 +127,6 @@
 #define SEGMENT_SIZE PAGE_SIZE
 #endif
 
-#ifdef linux
 #include <asm/page.h>
 #if defined(__i386__) || defined(__mc68000__)
 #define SEGMENT_SIZE	1024
@@ -136,7 +135,6 @@
 #define SEGMENT_SIZE	PAGE_SIZE
 #endif
 #endif
-#endif
 
 #define _N_SEGMENT_ROUND(x) ALIGN(x, SEGMENT_SIZE)
 



-- 
Joseph S. Myers
joseph@codesourcery.com
