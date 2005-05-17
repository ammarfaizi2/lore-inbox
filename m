Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261249AbVEQGyS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261249AbVEQGyS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 02:54:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261251AbVEQGyS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 02:54:18 -0400
Received: from ozlabs.org ([203.10.76.45]:6590 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261267AbVEQGyN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 02:54:13 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17033.37831.789240.709268@cargo.ozlabs.ibm.com>
Date: Tue, 17 May 2005 16:48:39 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org, torvalds@osdl.org
CC: Kumar Gala <galak@freescale.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] ppc32: enable use of early_param
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We need to call parse_early_param() early on to allow usage of
early_param() for command line parsing.

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>
Signed-off-by: Paul Mackerras <paulus@samba.org>

---
commit d9aa16f3736be7e3ff97ead1a710b8061e9990f8
tree ad05fc7300bdd058ecfb5cbbf022c4c19f4e13c5
parent 704da4a5c793087584fa5d0ed73440dd4ac44294
author Kumar K. Gala <kumar.gala@freescale.com> Mon, 16 May 2005 20:29:56 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Mon, 16 May 2005 20:29:56 -0500

 ppc/kernel/setup.c |    2 ++
 1 files changed, 2 insertions(+)

Index: arch/ppc/kernel/setup.c
===================================================================
--- 1702b9dd418707a930969079b460df0ace2f1c1a/arch/ppc/kernel/setup.c  (mode:100644)
+++ ad05fc7300bdd058ecfb5cbbf022c4c19f4e13c5/arch/ppc/kernel/setup.c  (mode:100644)
@@ -753,6 +753,8 @@
 	strlcpy(saved_command_line, cmd_line, COMMAND_LINE_SIZE);
 	*cmdline_p = cmd_line;
 
+	parse_early_param();
+
 	/* set up the bootmem stuff with available memory */
 	do_init_bootmem();
 	if ( ppc_md.progress ) ppc_md.progress("setup_arch: bootmem", 0x3eab);
