Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262622AbVE0WKS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262622AbVE0WKS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 18:10:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262611AbVE0WJZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 18:09:25 -0400
Received: from de01egw01.freescale.net ([192.88.165.102]:8114 "EHLO
	de01egw01.freescale.net") by vger.kernel.org with ESMTP
	id S262615AbVE0WJJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 18:09:09 -0400
Date: Fri, 27 May 2005 17:08:36 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
X-X-Sender: galak@nylon.am.freescale.net
To: Andrew Morton <akpm@osdl.org>
cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>,
       linux-kernel@vger.kernel.org, rvinson@mvista.com
Subject: [PATCH] ppc32: MPC834x BCSR_SIZE too small for use in a BAT.
Message-ID: <Pine.LNX.4.61.0505271707530.25368@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The call to io_block_mapping was creating an invalid BAT entry because
the value of BCSR_SIZE (32K) is too small to be used in a BAT (128K min).
This change removes the io_block_mapping call since these registers can
easily be mapped using ioremap at the point of use.

Signed-off-by: Randy Vinson <rvinson@mvista.com>
Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
commit 2c6dd281d28694239de9e453541ed3b937d11e25
tree 0d93680a000f9dafe78831ee00573c1bb544bcf6
parent 4ec5240ec367a592834385893200dd4fb369354c
author Kumar K. Gala <kumar.gala@freescale.com> Thu, 26 May 2005 19:14:39 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Thu, 26 May 2005 19:14:39 -0500

 ppc/platforms/83xx/mpc834x_sys.c |    1 -
 ppc/platforms/83xx/mpc834x_sys.h |    1 -
 2 files changed, 2 deletions(-)

Index: arch/ppc/platforms/83xx/mpc834x_sys.c
===================================================================
--- 3ac9a34948049bff79a2b2ce49c0a3c84e35a748/arch/ppc/platforms/83xx/mpc834x_sys.c  (mode:100644)
+++ 0d93680a000f9dafe78831ee00573c1bb544bcf6/arch/ppc/platforms/83xx/mpc834x_sys.c  (mode:100644)
@@ -127,7 +127,6 @@
 {
 	/* we steal the lowest ioremap addr for virt space */
 	io_block_mapping(VIRT_IMMRBAR, immrbar, 1024*1024, _PAGE_IO);
-	io_block_mapping(BCSR_VIRT_ADDR, BCSR_PHYS_ADDR, BCSR_SIZE, _PAGE_IO);
 }
 
 int
Index: arch/ppc/platforms/83xx/mpc834x_sys.h
===================================================================
--- 3ac9a34948049bff79a2b2ce49c0a3c84e35a748/arch/ppc/platforms/83xx/mpc834x_sys.h  (mode:100644)
+++ 0d93680a000f9dafe78831ee00573c1bb544bcf6/arch/ppc/platforms/83xx/mpc834x_sys.h  (mode:100644)
@@ -26,7 +26,6 @@
 #define VIRT_IMMRBAR		((uint)0xfe000000)
 
 #define BCSR_PHYS_ADDR		((uint)0xf8000000)
-#define BCSR_VIRT_ADDR		((uint)0xfe100000)
 #define BCSR_SIZE		((uint)(32 * 1024))
 
 #ifdef CONFIG_PCI
