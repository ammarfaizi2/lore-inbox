Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266458AbUHIKQt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266458AbUHIKQt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 06:16:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266457AbUHIKPu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 06:15:50 -0400
Received: from aun.it.uu.se ([130.238.12.36]:17611 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S266454AbUHIKO7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 06:14:59 -0400
Date: Mon, 9 Aug 2004 12:14:45 +0200 (MEST)
Message-Id: <200408091014.i79AEjA8012592@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: [PATCH][2.6.8-rc3-mm2] ppc32 sysctl warning fix
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One declaration of ppc32's proc_dol2crvec() wasn't converted
to the new calling convention (ppos parameter added), causing
compile-time warnings in kernel/sysctl.c. Trivial fix below.

/Mikael

--- linux-2.6.8-rc3-mm2/kernel/sysctl.c.~1~	2004-08-09 01:16:41.000000000 +0200
+++ linux-2.6.8-rc3-mm2/kernel/sysctl.c	2004-08-09 02:07:30.000000000 +0200
@@ -120,7 +120,7 @@
 #if defined(CONFIG_PPC32) && defined(CONFIG_6xx)
 extern unsigned long powersave_nap;
 int proc_dol2crvec(ctl_table *table, int write, struct file *filp,
-		  void __user *buffer, size_t *lenp);
+		  void __user *buffer, size_t *lenp, loff_t *ppos);
 #endif
 
 #ifdef CONFIG_BSD_PROCESS_ACCT
