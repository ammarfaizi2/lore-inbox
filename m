Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932079AbWIILcQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932079AbWIILcQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 07:32:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932081AbWIILcQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 07:32:16 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:423 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932079AbWIILcP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 07:32:15 -0400
Subject: [PATCH] [5/6] Don't expose PFN stuff to userspace in
	<asm-i386/setup.h>
From: David Woodhouse <dwmw2@infradead.org>
To: torvalds@osdl.org
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <1157800733.2977.40.camel@pmac.infradead.org>
References: <1157800733.2977.40.camel@pmac.infradead.org>
Content-Type: text/plain
Date: Sat, 09 Sep 2006 12:31:33 +0100
Message-Id: <1157801493.2977.61.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The header file <linux/pfn.h> doesn't exist in userspace and probably
shouldn't -- but it's used unconditionally in <asm-i386/setup.h>.
Protect it with #ifdef __KERNEL__ and move setup.h from $(header-y) to
$(unifdef-y) in Kbuild accordingly.

Signed-off-by: David Woodhouse <dwmw2@infradead.org>

diff --git a/include/asm-i386/Kbuild b/include/asm-i386/Kbuild
index 335b2fa..2308190 100644
--- a/include/asm-i386/Kbuild
+++ b/include/asm-i386/Kbuild
@@ -1,5 +1,5 @@
 include include/asm-generic/Kbuild.asm
 
-header-y += boot.h debugreg.h ldt.h setup.h ucontext.h
+header-y += boot.h debugreg.h ldt.h ucontext.h
 
-unifdef-y += mtrr.h vm86.h
+unifdef-y += mtrr.h setup.h vm86.h
diff --git a/include/asm-i386/setup.h b/include/asm-i386/setup.h
index f737e42..2734909 100644
--- a/include/asm-i386/setup.h
+++ b/include/asm-i386/setup.h
@@ -6,6 +6,7 @@
 #ifndef _i386_SETUP_H
 #define _i386_SETUP_H
 
+#ifdef __KERNEL__
 #include <linux/pfn.h>
 
 /*
@@ -13,6 +14,7 @@ #include <linux/pfn.h>
  */
 #define MAXMEM_PFN	PFN_DOWN(MAXMEM)
 #define MAX_NONPAE_PFN	(1 << 20)
+#endif
 
 #define PARAM_SIZE 4096
 #define COMMAND_LINE_SIZE 256

-- 
dwmw2

