Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261688AbVAXWCe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261688AbVAXWCe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 17:02:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261606AbVAXWAO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 17:00:14 -0500
Received: from az33egw01.freescale.net ([192.88.158.102]:44686 "EHLO
	az33egw01.freescale.net") by vger.kernel.org with ESMTP
	id S261686AbVAXVvw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 16:51:52 -0500
Date: Mon, 24 Jan 2005 15:51:42 -0600 (CST)
From: Kumar Gala <galak@freescale.com>
X-X-Sender: galak@blarg.somerset.sps.mot.com
To: akpm@osdl.org
cc: waite@skycomputers.com, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org
Subject: [PATCH] ppc32: fix powersave with interrupts disabled
Message-ID: <Pine.LNX.4.61.0501241548380.23263@blarg.somerset.sps.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It looks like the problem has to do with entering the powersave routine 
with irqs disabled. Here is a patch that will only enter powersave if irqs 
are enabled.

Entering powersave on PPC while irqs are disabled causes a hang. Only 
enter powersave if irqs are disabled.

Signed-off-by: Brian Waite <waite@skycomputers.com> 
Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
diff -Nru a/arch/ppc/kernel/idle.c b/arch/ppc/kernel/idle.c
--- a/arch/ppc/kernel/idle.c	2005-01-24 15:48:24 -06:00
+++ b/arch/ppc/kernel/idle.c	2005-01-24 15:48:24 -06:00
@@ -39,7 +39,7 @@
 	powersave = ppc_md.power_save;
 
 	if (!need_resched()) {
-		if (powersave != NULL)
+		if (powersave != NULL && !irqs_disabled())
 			powersave();
 		else {
 #ifdef CONFIG_SMP

