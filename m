Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267734AbUJPE6t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267734AbUJPE6t (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 00:58:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267748AbUJPE6t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 00:58:49 -0400
Received: from gate.crashing.org ([63.228.1.57]:47592 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S267734AbUJPE6s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 00:58:48 -0400
Subject: [PATCH] ppc64: Fix a typo in the code that reserves memory at boot
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Content-Type: text/plain
Message-Id: <1097902544.8963.5.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 16 Oct 2004 14:55:45 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

The code that marks memory regions as "reserved" early during boot
has a typo (doing incorrect rounding of the top address) which can
cause some areas to not be properly reserved. That may explain some
cases of initrd corruption reported recently.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

===== arch/ppc64/kernel/prom_init.c 1.2 vs edited =====
--- 1.2/arch/ppc64/kernel/prom_init.c	2004-09-27 19:12:49 +10:00
+++ edited/arch/ppc64/kernel/prom_init.c	2004-10-16 14:53:28 +10:00
@@ -595,7 +595,7 @@
 	 * dumb and just copy this entire array to the boot params
 	 */
 	base = _ALIGN_DOWN(base, PAGE_SIZE);
-	top = _ALIGN_DOWN(top, PAGE_SIZE);
+	top = _ALIGN_UP(top, PAGE_SIZE);
 	size = top - base;
 
 	if (cnt >= (MEM_RESERVE_MAP_SIZE - 1))


