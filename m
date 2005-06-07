Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261869AbVFGNeg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261869AbVFGNeg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 09:34:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261866AbVFGNeU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 09:34:20 -0400
Received: from [151.97.230.9] ([151.97.230.9]:28873 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S261865AbVFGNdd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 09:33:33 -0400
Subject: [patch 1/2] uml: complete "[RFC] uml: add and use generic hw_controller_type->release"
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, cw@f00f.org,
       mingo@redhat.com, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Tue, 07 Jun 2005 02:42:16 +0200
Message-Id: <20050607004216.72956EB2A@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This occurrence of free_irq_by_irq_and_dev() was missed when converting UML to
the use of hw_controller_type->release.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/arch/um/drivers/line.c |    1 -
 1 files changed, 1 deletion(-)

diff -puN arch/um/drivers/line.c~uml-gen-irq-release-missed arch/um/drivers/line.c
--- linux-2.6.git/arch/um/drivers/line.c~uml-gen-irq-release-missed	2005-06-07 02:25:22.000000000 +0200
+++ linux-2.6.git-paolo/arch/um/drivers/line.c	2005-06-07 02:25:22.000000000 +0200
@@ -756,7 +756,6 @@ static void unregister_winch(struct tty_
         if(winch->pid != -1)
                 os_kill_process(winch->pid, 1);
 
-        free_irq_by_irq_and_dev(WINCH_IRQ, winch);
         free_irq(WINCH_IRQ, winch);
         list_del(&winch->list);
         kfree(winch);
_
