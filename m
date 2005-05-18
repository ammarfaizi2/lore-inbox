Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262088AbVEREy2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262088AbVEREy2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 00:54:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262077AbVEREy2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 00:54:28 -0400
Received: from az33egw01.freescale.net ([192.88.158.102]:21739 "EHLO
	az33egw01.freescale.net") by vger.kernel.org with ESMTP
	id S262088AbVERExx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 00:53:53 -0400
Date: Tue, 17 May 2005 23:53:41 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
X-X-Sender: galak@nylon.am.freescale.net
To: Andrew Morton <akpm@osdl.org>
cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] ppc32: Fix platform device initialization of 8250 serial
 ports
Message-ID: <Pine.LNX.4.61.0505172352170.28134@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

(This fixes a bug and should go into 2.6.12 if possible.)

Initialization of 8250 serial ports that are platform devices require that
at empty entry exists in the array of plat_serial8250_port.  With out an
empty entry we can get some pretty random behavior.

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>


---
commit 775d12402657efa10a3c76da6c764237afeca462
tree ab87cb0c7a06314683657598ac6f011a7cc38884
parent 995cccaa4c17395172a88369a7eda90ab98f9971
author Kumar K. Gala <kumar.gala@freescale.com> Tue, 17 May 2005 23:51:13 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Tue, 17 May 2005 23:51:13 -0500

 ppc/syslib/mpc83xx_devices.c |    1 +
 ppc/syslib/mpc85xx_devices.c |    1 +
 2 files changed, 2 insertions(+)

Index: arch/ppc/syslib/mpc83xx_devices.c
===================================================================
--- afaee9b3b47f4d48902232740857f7b7d66e356f/arch/ppc/syslib/mpc83xx_devices.c  (mode:100644)
+++ ab87cb0c7a06314683657598ac6f011a7cc38884/arch/ppc/syslib/mpc83xx_devices.c  (mode:100644)
@@ -61,6 +61,7 @@
 		.iotype		= UPIO_MEM,
 		.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST,
 	},
+	{ },
 };
 
 struct platform_device ppc_sys_platform_devices[] = {
Index: arch/ppc/syslib/mpc85xx_devices.c
===================================================================
--- afaee9b3b47f4d48902232740857f7b7d66e356f/arch/ppc/syslib/mpc85xx_devices.c  (mode:100644)
+++ ab87cb0c7a06314683657598ac6f011a7cc38884/arch/ppc/syslib/mpc85xx_devices.c  (mode:100644)
@@ -61,6 +61,7 @@
 		.iotype		= UPIO_MEM,
 		.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST | UPF_SHARE_IRQ,
 	},
+	{ },
 };
 
 struct platform_device ppc_sys_platform_devices[] = {
