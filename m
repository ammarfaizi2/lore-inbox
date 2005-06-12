Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262240AbVFLL2Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262240AbVFLL2Y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 07:28:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262229AbVFLL0q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 07:26:46 -0400
Received: from aun.it.uu.se ([130.238.12.36]:11238 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261945AbVFLLWw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 07:22:52 -0400
Date: Sun, 12 Jun 2005 13:22:45 +0200 (MEST)
Message-Id: <200506121122.j5CBMjtH019768@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: marcelo.tosatti@cyclades.com
Subject: [PATCH 2.4.31 9/9] gcc4: fix i386 struct_cpy() warnings
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On i386 gcc4 generates a few compile-time warnings like:

process.c:556: warning: statement with no effect
process.c:569: warning: statement with no effect

This is because the i386 struct_cpy() macro references an
undefined variable when its two operands differ in size,
in the hope of turning a runtime error into a link-time error.

However, a simple variable reference has no effect, which
is why gcc4 complains.

The fix is to change it to a call to an undefined function.

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

 include/asm-i386/string.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -rupN linux-2.4.31/include/asm-i386/string.h linux-2.4.31.gcc4-i386-struct_cpy-warnings/include/asm-i386/string.h
--- linux-2.4.31/include/asm-i386/string.h	2001-08-12 11:35:53.000000000 +0200
+++ linux-2.4.31.gcc4-i386-struct_cpy-warnings/include/asm-i386/string.h	2005-06-12 11:52:25.000000000 +0200
@@ -337,7 +337,7 @@ extern void __struct_cpy_bug (void);
 #define struct_cpy(x,y) 			\
 ({						\
 	if (sizeof(*(x)) != sizeof(*(y))) 	\
-		__struct_cpy_bug;		\
+		__struct_cpy_bug();		\
 	memcpy(x, y, sizeof(*(x)));		\
 })
 
