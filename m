Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750910AbWH3Mnh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750910AbWH3Mnh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 08:43:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750909AbWH3Mnh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 08:43:37 -0400
Received: from mtagate5.de.ibm.com ([195.212.29.154]:47110 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750908AbWH3Mng (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 08:43:36 -0400
Date: Wed, 30 Aug 2006 14:43:33 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [S390] EX_TABLE macro.
Message-ID: <20060830124333.GE22276@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

[S390] EX_TABLE macro.

Add EX_TABLE helper macro to simplify creation of inline assembly
exception table entries.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 include/asm-s390/processor.h |   17 +++++++++++++++++
 1 files changed, 17 insertions(+)

diff -urpN linux-2.6/include/asm-s390/processor.h linux-2.6-patched/include/asm-s390/processor.h
--- linux-2.6/include/asm-s390/processor.h	2006-08-30 14:24:22.000000000 +0200
+++ linux-2.6-patched/include/asm-s390/processor.h	2006-08-30 14:24:36.000000000 +0200
@@ -339,4 +339,21 @@ int unregister_idle_notifier(struct noti
 
 #endif
 
+/*
+ * Helper macro for exception table entries
+ */
+#ifndef __s390x__
+#define EX_TABLE(_fault,_target)			\
+	".section __ex_table,\"a\"\n"			\
+	"	.align 4\n"				\
+	"	.long  " #_fault "," #_target "\n"	\
+	".previous\n"
+#else
+#define EX_TABLE(_fault,_target)			\
+	".section __ex_table,\"a\"\n"			\
+	"	.align 8\n"				\
+	"	.quad  " #_fault "," #_target "\n"	\
+	".previous\n"
+#endif
+
 #endif                                 /* __ASM_S390_PROCESSOR_H           */
