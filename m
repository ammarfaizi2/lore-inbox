Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269382AbUJLASu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269382AbUJLASu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 20:18:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269381AbUJLAR2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 20:17:28 -0400
Received: from host157-148.pool8289.interbusiness.it ([82.89.148.157]:10883
	"EHLO zion.localdomain") by vger.kernel.org with ESMTP
	id S269384AbUJLAQ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 20:16:56 -0400
Subject: [patch 2/6] uml: fix warning for unused var
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it
From: blaisorblade_spam@yahoo.it
Date: Tue, 12 Oct 2004 02:16:26 +0200
Message-Id: <20041012001626.A9065868B@zion.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


That var is used only when CONFIG_UML_REAL_TIME_CLOCK is on, so #ifdef its
definition.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.9-current-paolo/arch/um/kernel/time_kern.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)

diff -puN arch/um/kernel/time_kern.c~uml-fix-unused-warning arch/um/kernel/time_kern.c
--- linux-2.6.9-current/arch/um/kernel/time_kern.c~uml-fix-unused-warning	2004-10-12 01:05:59.458570536 +0200
+++ linux-2.6.9-current-paolo/arch/um/kernel/time_kern.c	2004-10-12 01:05:59.460570232 +0200
@@ -44,7 +44,9 @@ int timer_irq_inited = 0;
 
 static int first_tick;
 static unsigned long long prev_usecs;
+#ifdef CONFIG_UML_REAL_TIME_CLOCK
 static long long delta;   		/* Deviation per interval */
+#endif
 
 #define MILLION 1000000
 
@@ -60,7 +62,7 @@ void timer_irq(union uml_pt_regs *regs)
 	}
 
 	if(first_tick){
-#if defined(CONFIG_UML_REAL_TIME_CLOCK)
+#ifdef CONFIG_UML_REAL_TIME_CLOCK
 		/* We've had 1 tick */
 		unsigned long long usecs = os_usecs();
 
_
