Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965295AbWGJWid@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965295AbWGJWid (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 18:38:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965296AbWGJWid
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 18:38:33 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:38118 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S965295AbWGJWic (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 18:38:32 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <fastboot@osdl.org>
Subject: [PATCH] i386 kexec:  Allow the kexec on panic support to compile on voyager.
Date: Mon, 10 Jul 2006 16:37:49 -0600
Message-ID: <m1y7v1krwi.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch removes the foolish assumption that SMP implied local
apics.  That assumption is not-true on the Voyager subarch.  This
makes that dependency explicit, and allows the code to build.

What gets disabled is just an optimization to get better crash
dumps so the support should work if there is a kernel that will
initialization on the voyager subarch under those harsh conditions.

Hopefully we can figure out how to initialize apics in init_IRQ
and remove the need to disable io_apics and this dependency.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 arch/i386/kernel/crash.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/i386/kernel/crash.c b/arch/i386/kernel/crash.c
index f10da80..67d297d 100644
--- a/arch/i386/kernel/crash.c
+++ b/arch/i386/kernel/crash.c
@@ -92,7 +92,7 @@ static void crash_save_self(struct pt_re
 	crash_save_this_cpu(regs, cpu);
 }
 
-#ifdef CONFIG_SMP
+#if defined(CONFIG_SMP) && defined(CONFIG_X86_LOCAL_APIC)
 static atomic_t waiting_for_crash_ipi;
 
 static int crash_nmi_callback(struct notifier_block *self,
-- 
1.4.1.gac83a

