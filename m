Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261944AbVEWRks@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261944AbVEWRks (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 13:40:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261934AbVEWRjX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 13:39:23 -0400
Received: from de01egw02.freescale.net ([192.88.165.103]:25991 "EHLO
	de01egw02.freescale.net") by vger.kernel.org with ESMTP
	id S261928AbVEWRai (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 13:30:38 -0400
Date: Mon, 23 May 2005 12:29:56 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
X-X-Sender: galak@nylon.am.freescale.net
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org,
       linuxppc-embedded <linuxppc-embedded@ozlabs.org>, rvinson@mvista.com
Subject: [PATCH] ppc32: Fix an off-by-one error in ipic_init
Message-ID: <Pine.LNX.4.61.0505231228070.5309@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(This fixes a bug and should go into 2.6.12 if possible.)

There is an off-by-one error in the IPIC code that configures the
external interrupts (Edge or Level Sensitive).

Signed-off-by: Randy Vinson <rvinson@mvista.com>
Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
commit e8366420067384e3443e5ed95c151198e5ca6d22
tree 6aeff44236e7890cce085e65661884e4622785a7
parent 57bf2ca5c599f50428bf3f8ff9707411b2dfbae8
author Kumar K. Gala <kumar.gala@freescale.com> Mon, 23 May 2005 12:27:15 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Mon, 23 May 2005 12:27:15 -0500

 ppc/syslib/ipic.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: arch/ppc/syslib/ipic.c
===================================================================
--- 55631465fc89fa1f96bdadaa7026113780db1c8a/arch/ppc/syslib/ipic.c  (mode:100644)
+++ 6aeff44236e7890cce085e65661884e4622785a7/arch/ppc/syslib/ipic.c  (mode:100644)
@@ -479,7 +479,7 @@
 	temp = 0;
 	for (i = 0 ; i < senses_count ; i++) {
 		if ((senses[i] & IRQ_SENSE_MASK) == IRQ_SENSE_EDGE) {
-			temp |= 1 << (16 - i);
+			temp |= 1 << (15 - i);
 			if (i != 0)
 				irq_desc[i + irq_offset + MPC83xx_IRQ_EXT1 - 1].status = 0;
 			else
