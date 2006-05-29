Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751391AbWE2Vkm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751391AbWE2Vkm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 17:40:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751365AbWE2Vjp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 17:39:45 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:59090 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751348AbWE2VZL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 17:25:11 -0400
Date: Mon, 29 May 2006 23:25:32 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>
Subject: [patch 29/61] lock validator: print all lock-types on SysRq-D
Message-ID: <20060529212532.GC3155@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060529212109.GA2058@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

print all lock-types on SysRq-D.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
---
 drivers/char/sysrq.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

Index: linux/drivers/char/sysrq.c
===================================================================
--- linux.orig/drivers/char/sysrq.c
+++ linux/drivers/char/sysrq.c
@@ -148,12 +148,14 @@ static struct sysrq_key_op sysrq_mountro
 	.enable_mask	= SYSRQ_ENABLE_REMOUNT,
 };
 
-#ifdef CONFIG_DEBUG_MUTEXES
+#ifdef CONFIG_LOCKDEP
 static void sysrq_handle_showlocks(int key, struct pt_regs *pt_regs,
 				struct tty_struct *tty)
 {
 	debug_show_all_locks();
+	print_lock_types();
 }
+
 static struct sysrq_key_op sysrq_showlocks_op = {
 	.handler	= sysrq_handle_showlocks,
 	.help_msg	= "show-all-locks(D)",
