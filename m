Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267552AbUJHEmv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267552AbUJHEmv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 00:42:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267620AbUJHEmv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 00:42:51 -0400
Received: from gate.crashing.org ([63.228.1.57]:59557 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S267552AbUJHEmu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 00:42:50 -0400
Subject: [PATCH] ppc64: Fix module exports for G5
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1097210132.32157.108.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 08 Oct 2004 14:35:32 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

Some stuffs in ppc_ksyms.c where still #ifdef CONFIG_PPC_PSERIES, which
is no longer set for PowerMac-only configs. Change them to depend on
CONFIG_PPC_MULTIPLATFORM for now. Later on, a bunch of these will be
just gone since those are mostly deprecated functions and I'll move the
exports close to the actual functions.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

===== arch/ppc64/kernel/ppc_ksyms.c 1.44 vs edited =====
--- 1.44/arch/ppc64/kernel/ppc_ksyms.c	2004-09-15 21:53:26 +10:00
+++ edited/arch/ppc64/kernel/ppc_ksyms.c	2004-10-08 14:32:49 +10:00
@@ -136,7 +136,7 @@
 
 EXPORT_SYMBOL(ppc_md);
 
-#ifdef CONFIG_PPC_PSERIES
+#ifdef CONFIG_PPC_MULTIPLATFORM
 EXPORT_SYMBOL(find_devices);
 EXPORT_SYMBOL(find_type_devices);
 EXPORT_SYMBOL(find_compatible_devices);


