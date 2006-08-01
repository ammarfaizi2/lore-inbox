Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751645AbWHAS5m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751645AbWHAS5m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 14:57:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751793AbWHAS5m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 14:57:42 -0400
Received: from mx1.redhat.com ([66.187.233.31]:59333 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751645AbWHAS5l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 14:57:41 -0400
Date: Tue, 1 Aug 2006 14:57:38 -0400
From: Dave Jones <davej@redhat.com>
To: ak@suse.de
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: wire up missing syscalls on x86-64
Message-ID: <20060801185738.GT22240@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, ak@suse.de,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Dave Jones <davej@redhat.com>

diff --git a/arch/x86_64/ia32/ia32entry.S b/arch/x86_64/ia32/ia32entry.S
index 5a92fed..07399fe 100644
--- a/arch/x86_64/ia32/ia32entry.S
+++ b/arch/x86_64/ia32/ia32entry.S
@@ -687,8 +687,8 @@ #endif
 	.quad sys_readlinkat		/* 305 */
 	.quad sys_fchmodat
 	.quad sys_faccessat
-	.quad quiet_ni_syscall		/* pselect6 for now */
-	.quad quiet_ni_syscall		/* ppoll for now */
+	.quad compat_sys_pselect6
+	.quad compat_sys_ppoll
 	.quad sys_unshare		/* 310 */
 	.quad compat_sys_set_robust_list
 	.quad compat_sys_get_robust_list
diff --git a/include/asm-x86_64/unistd.h b/include/asm-x86_64/unistd.h
index feb77cb..0a08bbf 100644
--- a/include/asm-x86_64/unistd.h
+++ b/include/asm-x86_64/unistd.h
@@ -600,9 +600,9 @@ __SYSCALL(__NR_fchmodat, sys_fchmodat)
 #define __NR_faccessat		269
 __SYSCALL(__NR_faccessat, sys_faccessat)
 #define __NR_pselect6		270
-__SYSCALL(__NR_pselect6, sys_ni_syscall)	/* for now */
+__SYSCALL(__NR_pselect6, sys_pselect6)
 #define __NR_ppoll		271
-__SYSCALL(__NR_ppoll,	sys_ni_syscall)		/* for now */
+__SYSCALL(__NR_ppoll,	sys_ppoll)
 #define __NR_unshare		272
 __SYSCALL(__NR_unshare,	sys_unshare)
 #define __NR_set_robust_list	273
-- 
http://www.codemonkey.org.uk
