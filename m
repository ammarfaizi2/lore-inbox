Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932727AbWBUKUI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932727AbWBUKUI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 05:20:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932728AbWBUKUI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 05:20:08 -0500
Received: from liaag1ad.mx.compuserve.com ([149.174.40.30]:29883 "EHLO
	liaag1ad.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S932727AbWBUKUH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 05:20:07 -0500
Date: Tue, 21 Feb 2006 05:16:08 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch] i386: Don't let ptrace set the nested task bit
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200602210519_MC3-1-B8DF-2A97@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There's no good reason for allowing ptrace to set the NT
bit in EFLAGS, so mask it off.

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

--- 2.6.16-rc4-nb.orig/arch/i386/kernel/ptrace.c
+++ 2.6.16-rc4-nb/arch/i386/kernel/ptrace.c
@@ -34,10 +34,10 @@
 
 /*
  * Determines which flags the user has access to [1 = access, 0 = no access].
- * Prohibits changing ID(21), VIP(20), VIF(19), VM(17), IOPL(12-13), IF(9).
+ * Prohibits changing ID(21), VIP(20), VIF(19), VM(17), NT(14), IOPL(12-13), IF(9).
  * Also masks reserved bits (31-22, 15, 5, 3, 1).
  */
-#define FLAG_MASK 0x00054dd5
+#define FLAG_MASK 0x00050dd5
 
 /* set's the trap flag. */
 #define TRAP_FLAG 0x100
-- 
Chuck
"Equations are the Devil's sentences."  --Stephen Colbert
