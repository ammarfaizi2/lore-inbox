Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932271AbWJEVoV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932271AbWJEVoV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 17:44:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932260AbWJEVmN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 17:42:13 -0400
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35]:3434 "HELO
	smtp004.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S932244AbWJEVmL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 17:42:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:Subject:Date:To:Cc:Bcc:Message-Id:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:User-Agent;
  b=KgVOdS3B7tDWbq1+j5KJ12mii7l9bCzS7uIlVxMAmAehfjulkYcC7mod3xWaF40+solUpw2ApRe9vZFhOARmg5V/C2QcTR7sYjzcJn3OjmsmXDgq57Cs1rdYBoyRvrcIH9vH1XK5gPkoqDim/Z22oEd/vcIPwuBmSlW52ozu4PU=  ;
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 11/14] uml: asm offsets duplication removal
Date: Thu, 05 Oct 2006 23:39:10 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20061005213910.17268.63692.stgit@memento.home.lan>
In-Reply-To: <20061005213212.17268.7409.stgit@memento.home.lan>
References: <20061005213212.17268.7409.stgit@memento.home.lan>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Unify macros common to x86 and x86_64 kernel-offsets.h files.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/include/common-offsets.h               |   10 ++++++++++
 arch/um/include/sysdep-i386/kernel-offsets.h   |    4 ----
 arch/um/include/sysdep-x86_64/kernel-offsets.h |    4 ----
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/um/include/common-offsets.h b/arch/um/include/common-offsets.h
index 39bb210..461175f 100644
--- a/arch/um/include/common-offsets.h
+++ b/arch/um/include/common-offsets.h
@@ -1,9 +1,16 @@
 /* for use by sys-$SUBARCH/kernel-offsets.c */
 
+DEFINE(KERNEL_MADV_REMOVE, MADV_REMOVE);
+#ifdef CONFIG_MODE_TT
+OFFSET(HOST_TASK_EXTERN_PID, task_struct, thread.mode.tt.extern_pid);
+#endif
+
 OFFSET(HOST_TASK_REGS, task_struct, thread.regs);
 OFFSET(HOST_TASK_PID, task_struct, pid);
+
 DEFINE(UM_KERN_PAGE_SIZE, PAGE_SIZE);
 DEFINE(UM_NSEC_PER_SEC, NSEC_PER_SEC);
+
 DEFINE_STR(UM_KERN_EMERG, KERN_EMERG);
 DEFINE_STR(UM_KERN_ALERT, KERN_ALERT);
 DEFINE_STR(UM_KERN_CRIT, KERN_CRIT);
@@ -12,7 +19,10 @@ DEFINE_STR(UM_KERN_WARNING, KERN_WARNING
 DEFINE_STR(UM_KERN_NOTICE, KERN_NOTICE);
 DEFINE_STR(UM_KERN_INFO, KERN_INFO);
 DEFINE_STR(UM_KERN_DEBUG, KERN_DEBUG);
+
 DEFINE(UM_ELF_CLASS, ELF_CLASS);
 DEFINE(UM_ELFCLASS32, ELFCLASS32);
 DEFINE(UM_ELFCLASS64, ELFCLASS64);
+
+/* For crypto assembler code. */
 DEFINE(crypto_tfm_ctx_offset, offsetof(struct crypto_tfm, __crt_ctx));
diff --git a/arch/um/include/sysdep-i386/kernel-offsets.h b/arch/um/include/sysdep-i386/kernel-offsets.h
index 2e58c4c..97ec9d8 100644
--- a/arch/um/include/sysdep-i386/kernel-offsets.h
+++ b/arch/um/include/sysdep-i386/kernel-offsets.h
@@ -18,9 +18,5 @@ #define OFFSET(sym, str, mem) \
 void foo(void)
 {
 	OFFSET(HOST_TASK_DEBUGREGS, task_struct, thread.arch.debugregs);
-	DEFINE(KERNEL_MADV_REMOVE, MADV_REMOVE);
-#ifdef CONFIG_MODE_TT
-	OFFSET(HOST_TASK_EXTERN_PID, task_struct, thread.mode.tt.extern_pid);
-#endif
 #include <common-offsets.h>
 }
diff --git a/arch/um/include/sysdep-x86_64/kernel-offsets.h b/arch/um/include/sysdep-x86_64/kernel-offsets.h
index 4cbfbb9..a307237 100644
--- a/arch/um/include/sysdep-x86_64/kernel-offsets.h
+++ b/arch/um/include/sysdep-x86_64/kernel-offsets.h
@@ -19,9 +19,5 @@ #define OFFSET(sym, str, mem) \
 
 void foo(void)
 {
-	DEFINE(KERNEL_MADV_REMOVE, MADV_REMOVE);
-#ifdef CONFIG_MODE_TT
-	OFFSET(HOST_TASK_EXTERN_PID, task_struct, thread.mode.tt.extern_pid);
-#endif
 #include <common-offsets.h>
 }
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 
