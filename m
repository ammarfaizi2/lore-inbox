Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750830AbWD2Xnf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750830AbWD2Xnf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Apr 2006 19:43:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750835AbWD2XnO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Apr 2006 19:43:14 -0400
Received: from moutng.kundenserver.de ([212.227.126.188]:26057 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1750834AbWD2XnK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Apr 2006 19:43:10 -0400
Message-Id: <200604300142.23473.arnd@arndb.de>
References: <20060429232812.825714000@localhost.localdomain>
Date: Sun, 30 Apr 2006 01:42:22 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: paulus@samba.org
Cc: cbe-oss-dev@ozlabs.org, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, Christian Krafft <krafft@de.ibm.com>,
       Arnd Bergmann <arnd.bergmann@de.ibm.com>
Subject: [PATCH 10/13] cell: correctly detect systemsim host
Content-Disposition: inline
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:bf0b512fe2ff06b96d9695102898be39
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Krafft <krafft@de.ibm.com>
Systemsim uses a different compatible property in the device tree.

Signed-off-by: Christian Krafft <krafft@de.ibm.com>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
---
Index: linus-2.6/arch/powerpc/platforms/cell/setup.c
===================================================================
--- linus-2.6.orig/arch/powerpc/platforms/cell/setup.c	2006-04-29 
22:53:51.000000000 +0200
+++ linus-2.6/arch/powerpc/platforms/cell/setup.c	2006-04-29 
22:54:32.000000000 +0200
@@ -201,10 +201,13 @@
 	 * more appropriate detection logic
 	 */
 	unsigned long root = of_get_flat_dt_root();
-	if (!of_flat_dt_is_compatible(root, "IBM,CPBW-1.0"))
-		return 0;
+	if (of_flat_dt_is_compatible(root, "IBM,CPBW-1.0"))
+		return 1;
 
-	return 1;
+	if (of_flat_dt_is_compatible(root, "IBM,CPBW-SystemSim"))
+		return 1;
+
+	return 0;
 }
 
 /*

--

