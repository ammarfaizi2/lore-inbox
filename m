Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268679AbUHLTt7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268679AbUHLTt7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 15:49:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268683AbUHLTt7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 15:49:59 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:24058 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S268679AbUHLTtt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 15:49:49 -0400
Date: Thu, 12 Aug 2004 12:49:44 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Paul Mackerras <paulus@samba.org>
Subject: [PATCH] ppc32: Fix warning on CONFIG_PPC32 && CONFIG_6xx
Message-ID: <20040812194944.GA5583@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the *ppos cleanups, proc_dol2crvec was updated, but the prototype
found at the top of kernel/sysctl.h was not, generating warning.  This
corrects the prototype to match the code.

(I'm gonna take a stab at moving these into arch/ppc shortly)

Signed-off-by: Tom Rini <trini@kernel.crashing.org>

===== kernel/sysctl.c 1.82 vs edited =====
--- 1.82/kernel/sysctl.c	2004-08-07 23:43:41 -07:00
+++ edited/kernel/sysctl.c	2004-08-12 12:45:43 -07:00
@@ -113,7 +113,7 @@
 #if defined(CONFIG_PPC32) && defined(CONFIG_6xx)
 extern unsigned long powersave_nap;
 int proc_dol2crvec(ctl_table *table, int write, struct file *filp,
-		  void __user *buffer, size_t *lenp);
+		  void __user *buffer, size_t *lenp, loff_t *ppos);
 #endif
 
 #ifdef CONFIG_BSD_PROCESS_ACCT

-- 
Tom Rini
http://gate.crashing.org/~trini/
