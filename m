Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269388AbUJLASt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269388AbUJLASt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 20:18:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269384AbUJLARm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 20:17:42 -0400
Received: from host157-148.pool8289.interbusiness.it ([82.89.148.157]:14979
	"EHLO zion.localdomain") by vger.kernel.org with ESMTP
	id S269388AbUJLAQ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 20:16:58 -0400
Subject: [patch 5/6] uml: fix an "unused" warnings
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it
From: blaisorblade_spam@yahoo.it
Date: Tue, 12 Oct 2004 02:16:33 +0200
Message-Id: <20041012001633.B94388691@zion.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes some random warnings. To avoid "defined but not used" for
not_configged_ops, make it be defined only if at least one channel is not defined.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.9-current-paolo/arch/um/Kconfig_char        |    4 ++++
 linux-2.6.9-current-paolo/arch/um/drivers/chan_kern.c |    2 ++
 2 files changed, 6 insertions(+)

diff -puN arch/um/drivers/chan_kern.c~uml-fix-some-warnings arch/um/drivers/chan_kern.c
--- linux-2.6.9-current/arch/um/drivers/chan_kern.c~uml-fix-some-warnings	2004-09-19 18:27:33.885887560 +0200
+++ linux-2.6.9-current-paolo/arch/um/drivers/chan_kern.c	2004-09-19 18:27:33.888887104 +0200
@@ -19,6 +19,7 @@
 #include "line.h"
 #include "os.h"
 
+#ifdef CONFIG_NOCONFIG_CHAN
 static void *not_configged_init(char *str, int device, struct chan_opts *opts)
 {
 	printk(KERN_ERR "Using a channel type which is configured out of "
@@ -87,6 +88,7 @@ static struct chan_ops not_configged_ops
 	.free		= not_configged_free,
 	.winch		= 0,
 };
+#endif /* CONFIG_NOCONFIG_CHAN */
 
 void generic_close(int fd, void *unused)
 {
diff -puN arch/um/Kconfig_char~uml-fix-some-warnings arch/um/Kconfig_char
--- linux-2.6.9-current/arch/um/Kconfig_char~uml-fix-some-warnings	2004-09-19 18:27:33.886887408 +0200
+++ linux-2.6.9-current-paolo/arch/um/Kconfig_char	2004-09-19 18:27:33.888887104 +0200
@@ -72,6 +72,10 @@ config XTERM_CHAN
         well, since UML's gdb currently requires an xterm.
         It is safe to say 'Y' here.
 
+config NOCONFIG_CHAN
+	bool
+	default !(XTERM_CHAN && TTY_CHAN && PTY_CHAN && PORT_CHAN && FD_CHAN && NULL_CHAN)
+
 config CON_ZERO_CHAN
 	string "Default main console channel initialization"
 	default "fd:0,fd:1"
_
