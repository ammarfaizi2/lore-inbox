Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261509AbVF2IWG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261509AbVF2IWG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 04:22:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261594AbVF2IWG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 04:22:06 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:45225 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S261509AbVF2IWC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 04:22:02 -0400
Date: Wed, 29 Jun 2005 10:21:36 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH] s390: fix finish_arch_switch
Message-ID: <20050629082136.GA32488@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 4866cde064afbb6c2a488c265e696879de616daa requires finish_arch_switch
to have only one parameter instead of two.
Also fix another compile error (double declaration of account_system_vtime) if
CONFIG_VIRT_CPU_ACCOUNTING is not defined.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>

diffstat:
 include/asm-s390/system.h |    4 +---
 1 files changed, 1 insertion(+), 3 deletions(-)

diff -urN a/include/asm-s390/system.h b/include/asm-s390/system.h
--- a/include/asm-s390/system.h	2005-06-29 09:39:40.000000000 +0200
+++ b/include/asm-s390/system.h	2005-06-29 09:40:20.000000000 +0200
@@ -107,11 +107,9 @@
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING
 extern void account_user_vtime(struct task_struct *);
 extern void account_system_vtime(struct task_struct *);
-#else
-#define account_system_vtime(prev) do { } while (0)
 #endif
 
-#define finish_arch_switch(rq, prev) do {				     \
+#define finish_arch_switch(prev) do {					     \
 	set_fs(current->thread.mm_segment);				     \
 	account_system_vtime(prev);					     \
 } while (0)
