Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261380AbUDHANt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 20:13:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261400AbUDHANt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 20:13:49 -0400
Received: from gate.crashing.org ([63.228.1.57]:8889 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261380AbUDHANs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 20:13:48 -0400
Subject: [PATCH] ppc64: Fix G5 build with DART (iommu) support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1081383165.1401.77.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 08 Apr 2004 10:12:46 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

A recent patch that cleaned up some absolute/virt translation macros
forgot one occurence, thus breaking g5 build with iommu support.

Please apply,

Ben.

===== arch/ppc64/kernel/prom.c 1.66 vs edited =====
--- 1.66/arch/ppc64/kernel/prom.c	Wed Mar 31 01:45:59 2004
+++ edited/arch/ppc64/kernel/prom.c	Thu Apr  8 10:08:09 2004
@@ -798,7 +798,7 @@
 	 * will blow up an entire large page anyway in the kernel mapping
 	 */
 	RELOC(dart_tablebase) =
-		absolute_to_virt(lmb_alloc_base(1UL<<24, 1UL<<24, 0x80000000L));
+		abs_to_virt(lmb_alloc_base(1UL<<24, 1UL<<24, 0x80000000L));
 
 	prom_print(RELOC("Dart at: "));
 	prom_print_hex(RELOC(dart_tablebase));


