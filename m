Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932070AbWIIL1p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932070AbWIIL1p (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 07:27:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932071AbWIIL1p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 07:27:45 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:18837 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932070AbWIIL1o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 07:27:44 -0400
Subject: [PATCH] [3/6] Move inclusion of <linux/linkage.h> in
	<asm-i386/signal.h>
From: David Woodhouse <dwmw2@infradead.org>
To: torvalds@osdl.org
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <1157800733.2977.40.camel@pmac.infradead.org>
References: <1157800733.2977.40.camel@pmac.infradead.org>
Content-Type: text/plain
Date: Sat, 09 Sep 2006 12:27:22 +0100
Message-Id: <1157801242.2977.53.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Because <linux/linkage.h> doesn't exist in userspace, it should be only
included from within #ifdef __KERNEL__. Move the corresponding #include

Signed-off-by: David Woodhouse <dwmw2@infradead.org>

diff --git a/include/asm-i386/signal.h b/include/asm-i386/signal.h
index 3824a50..c3e8ade 100644
--- a/include/asm-i386/signal.h
+++ b/include/asm-i386/signal.h
@@ -2,7 +2,6 @@ #ifndef _ASMi386_SIGNAL_H
 #define _ASMi386_SIGNAL_H
 
 #include <linux/types.h>
-#include <linux/linkage.h>
 #include <linux/time.h>
 #include <linux/compiler.h>
 
@@ -10,6 +9,9 @@ #include <linux/compiler.h>
 struct siginfo;
 
 #ifdef __KERNEL__
+
+#include <linux/linkage.h>
+
 /* Most things should be clean enough to redefine this at will, if care
    is taken to make libc match.  */
 



-- 
dwmw2

