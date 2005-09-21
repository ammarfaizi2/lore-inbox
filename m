Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751130AbVIUQtf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751130AbVIUQtf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 12:49:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751148AbVIUQra
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 12:47:30 -0400
Received: from [151.97.230.9] ([151.97.230.9]:39054 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S1751145AbVIUQrH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 12:47:07 -0400
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 10/10] uml: fix compile warning after consolidation patch
Date: Wed, 21 Sep 2005 18:40:49 +0200
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Message-Id: <20050921164048.30500.76109.stgit@zion.home.lan>
In-Reply-To: <200509211822.17590.blaisorblade@yahoo.it>
References: <200509211822.17590.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

The header declaring this function wasn't included, so the function declaration
was totally bogus wrt. the proto - even if this wasn't going to fail at all.

It was so bad that the compile warning I got was "control reaches end of
non-void function", i.e. missing return. Actually, this has been there for ages,
the consolidation patch just added the warning which was needed to clean it up.
Nice. Really.

Cc: Allan Graves <allan.graves@gmail.com>
Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/kernel/tt/process_kern.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/um/kernel/tt/process_kern.c b/arch/um/kernel/tt/process_kern.c
--- a/arch/um/kernel/tt/process_kern.c
+++ b/arch/um/kernel/tt/process_kern.c
@@ -23,10 +23,11 @@
 #include "mem_user.h"
 #include "tlb.h"
 #include "mode.h"
+#include "mode_kern.h"
 #include "init.h"
 #include "tt.h"
 
-int switch_to_tt(void *prev, void *next, void *last)
+void switch_to_tt(void *prev, void *next)
 {
 	struct task_struct *from, *to, *prev_sched;
 	unsigned long flags;

