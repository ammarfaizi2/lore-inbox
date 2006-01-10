Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932557AbWAJUX7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932557AbWAJUX7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 15:23:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932586AbWAJUX6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 15:23:58 -0500
Received: from canuck.infradead.org ([205.233.218.70]:21732 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S932583AbWAJUX5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 15:23:57 -0500
Subject: [PATCH] [6/6] Add pselect/ppoll system calls on i386
From: David Woodhouse <dwmw2@infradead.org>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, drepper@redhat.com
In-Reply-To: <1136923488.3435.78.camel@localhost.localdomain>
References: <1136923488.3435.78.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 10 Jan 2006 20:23:56 +0000
Message-Id: <1136924637.3435.108.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the sys_pselect6() and sys_poll() calls to the i386 syscall
table.

Signed-off-by: David Woodhouse <dwmw2@infradead.org>

 arch/i386/kernel/syscall_table.S |    2 ++
 include/asm-i386/unistd.h        |    4 +++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/i386/kernel/syscall_table.S b/arch/i386/kernel/syscall_table.S
index 6ff3e52..14fb84e 100644
--- a/arch/i386/kernel/syscall_table.S
+++ b/arch/i386/kernel/syscall_table.S
@@ -294,3 +294,5 @@ ENTRY(sys_call_table)
 	.long sys_inotify_add_watch
 	.long sys_inotify_rm_watch
 	.long sys_migrate_pages
+	.long sys_pselect6		/* 295 */
+	.long sys_ppoll
diff --git a/include/asm-i386/unistd.h b/include/asm-i386/unistd.h
index 4a8d5ae..f2eace9 100644
--- a/include/asm-i386/unistd.h
+++ b/include/asm-i386/unistd.h
@@ -300,8 +300,10 @@
 #define __NR_inotify_add_watch	292
 #define __NR_inotify_rm_watch	293
 #define __NR_migrate_pages	294
+#define __NR_pselect6		295
+#define __NR_ppoll		296
 
-#define NR_syscalls 295
+#define NR_syscalls 297
 
 /*
  * user-visible error numbers are in the range -1 - -128: see

-- 
dwmw2

