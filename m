Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268539AbTANCqS>; Mon, 13 Jan 2003 21:46:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268537AbTANCqE>; Mon, 13 Jan 2003 21:46:04 -0500
Received: from dp.samba.org ([66.70.73.150]:25740 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S268524AbTANCqA>;
	Mon, 13 Jan 2003 21:46:00 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Module state and address in /proc/modules.
Date: Tue, 14 Jan 2003 13:24:55 +1100
Message-Id: <20030114025452.563462C374@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The address allows oprofile and ksymoops to work again.  The state is
simply informative.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: Put more information in /proc/modules
Author: Stanley Wang, Rusty Russell
Status: Tested on 2.5.56

D: Puts the state of the module and the address in /proc/modules.

diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5-bk/kernel/module.c working-2.5-bk-procmodules-extra/kernel/module.c
--- linux-2.5-bk/kernel/module.c	Fri Jan 10 10:55:43 2003
+++ working-2.5-bk-procmodules-extra/kernel/module.c	Sat Jan 11 19:59:58 2003
@@ -1422,6 +1422,15 @@ static int m_show(struct seq_file *m, vo
 	seq_printf(m, "%s %lu",
 		   mod->name, mod->init_size + mod->core_size);
 	print_unload_info(m, mod);
+
+	/* Informative for users. */
+	seq_printf(m, " %s",
+		   mod->state == MODULE_STATE_GOING ? "Unloading":
+		   mod->state == MODULE_STATE_COMING ? "Loading":
+		   "Live");
+	/* Used by oprofile and other similar tools. */
+	seq_printf(m, " 0x%p", mod->module_core);
+
 	seq_printf(m, "\n");
 	return 0;
 }
