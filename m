Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262051AbUKDCC2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262051AbUKDCC2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 21:02:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262052AbUKDCB6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 21:01:58 -0500
Received: from host157-148.pool8289.interbusiness.it ([82.89.148.157]:63635
	"EHLO zion.localdomain") by vger.kernel.org with ESMTP
	id S262051AbUKDBzk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 20:55:40 -0500
Subject: [patch 18/20] uml: clear errno in CATCH_EINTR
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, cw@f00f.org,
       blaisorblade_spam@yahoo.it
From: blaisorblade_spam@yahoo.it
Date: Thu, 04 Nov 2004 00:17:57 +0100
Message-Id: <20041103231757.63EB155C8B@zion.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


To avoid silly messages coming out during debugging or when things break,
after that we've read in CATCH_EINTR that errno == EINTR, clear it, so that
it's 0 in next iteration.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 vanilla-linux-2.6.9-paolo/arch/um/include/user_util.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN arch/um/include/user_util.h~uml-clear-errno-in-CATCH_EINTR arch/um/include/user_util.h
--- vanilla-linux-2.6.9/arch/um/include/user_util.h~uml-clear-errno-in-CATCH_EINTR	2004-11-03 23:30:34.178063672 +0100
+++ vanilla-linux-2.6.9-paolo/arch/um/include/user_util.h	2004-11-03 23:30:34.181063216 +0100
@@ -8,7 +8,7 @@
 
 #include "sysdep/ptrace.h"
 
-#define CATCH_EINTR(expr) while (((expr) < 0) && (errno == EINTR))
+#define CATCH_EINTR(expr) while ((errno = 0, ((expr) < 0)) && (errno == EINTR))
 
 extern int mode_tt;
 
_
