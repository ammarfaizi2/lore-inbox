Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261324AbVCUPTS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261324AbVCUPTS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 10:19:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261373AbVCUPTS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 10:19:18 -0500
Received: from aun.it.uu.se ([130.238.12.36]:7605 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261324AbVCUPTN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 10:19:13 -0500
Date: Mon, 21 Mar 2005 16:19:01 +0100 (MET)
Message-Id: <200503211519.j2LFJ1os021884@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org, paulus@samba.org
Subject: [PATCH][2.6.12-rc1-mm1] fix compile error in ppc64 prom.c
Cc: linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Compiling 2.6.12-rc1-mm1 for ppc64 fails with:

arch/ppc64/kernel/prom.c:1691: error: syntax error before 'prom_reconfig_notifier'
arch/ppc64/kernel/prom.c:1692: error: field name not in record or union initializer
arch/ppc64/kernel/prom.c:1692: error: (near initialization for 'prom_reconfig_nb')
arch/ppc64/kernel/prom.c:1692: warning: initialization makes pointer from integer without a cast
make[1]: *** [arch/ppc64/kernel/prom.o] Error 1
make: *** [arch/ppc64/kernel] Error 2

Fix: repair the obvious syntax error (missing "=").

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

--- linux-2.6.12-rc1-mm1/arch/ppc64/kernel/prom.c.~1~	2005-03-21 14:48:51.000000000 +0100
+++ linux-2.6.12-rc1-mm1/arch/ppc64/kernel/prom.c	2005-03-21 15:14:19.000000000 +0100
@@ -1688,7 +1688,7 @@ static int prom_reconfig_notifier(struct
 }
 
 static struct notifier_block prom_reconfig_nb = {
-	.notifier_call prom_reconfig_notifier,
+	.notifier_call = prom_reconfig_notifier,
 	.priority = 10, /* This one needs to run first */
 };
 
