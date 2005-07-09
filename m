Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261173AbVGIK61@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261173AbVGIK61 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 06:58:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261214AbVGIK60
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 06:58:26 -0400
Received: from [151.97.230.9] ([151.97.230.9]:24748 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S261173AbVGIK5m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 06:57:42 -0400
Subject: [patch 1/1] uml: fix lvalue for gcc4
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Sat, 09 Jul 2005 13:01:33 +0200
Message-Id: <20050709110143.D59181E9EA4@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This construct is refused by GCC 4, so here's the fix.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/arch/um/sys-x86_64/signal.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN arch/um/sys-x86_64/signal.c~uml-fix-for-gcc4-lvalue arch/um/sys-x86_64/signal.c
--- linux-2.6.git/arch/um/sys-x86_64/signal.c~uml-fix-for-gcc4-lvalue	2005-07-09 13:01:03.000000000 +0200
+++ linux-2.6.git-paolo/arch/um/sys-x86_64/signal.c	2005-07-09 13:01:03.000000000 +0200
@@ -168,7 +168,7 @@ int setup_signal_stack_si(unsigned long 
 
 	frame = (struct rt_sigframe __user *)
 		round_down(stack_top - sizeof(struct rt_sigframe), 16) - 8;
-	((unsigned char *) frame) -= 128;
+	frame -= 128 / sizeof(frame);
 
 	if (!access_ok(VERIFY_WRITE, fp, sizeof(struct _fpstate)))
 		goto out;
_
