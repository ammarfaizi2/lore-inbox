Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265151AbTFULla (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 07:41:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265163AbTFULkQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 07:40:16 -0400
Received: from natsmtp01.webmailer.de ([192.67.198.81]:20416 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP id S265166AbTFULkH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 07:40:07 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] [SPARSE] increase MAXNEST constant
Date: Sat, 21 Jun 2003 13:53:43 +0200
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306211353.43512.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The MAXNEST constant in sparse is currently too small for
checking most of the kernel files. The deepest nesting
I found in the kernel is 25, so MAXNEST=32 should probably
be sufficient. It would be nice to check overruns here,
but I did not know where to best do it.

The problem is hidden when sparse is compiled with gcc-3.2 
or earlier, but causes segmentation faults with gcc-3.3.

	Arnd <><

===== pre-process.c 1.65 vs edited =====
--- 1.65/pre-process.c	Wed Jun 11 01:03:25 2003
+++ edited/pre-process.c	Sat Jun 21 13:26:03 2003
@@ -28,7 +28,7 @@
 int verbose = 0;
 int preprocessing = 0;
 
-#define MAXNEST (16)
+#define MAXNEST (32)
 static int true_nesting = 0;
 static int false_nesting = 0;
 static struct token *unmatched_if = NULL;
