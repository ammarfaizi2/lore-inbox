Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264659AbTFAP7f (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 11:59:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264660AbTFAP7f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 11:59:35 -0400
Received: from main.gmane.org ([80.91.224.249]:11921 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264659AbTFAP7d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 11:59:33 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Pasi Savolainen <psavo@iki.fi>
Subject: [patch][2.5.70] DRM (mga) SMP link fix (flush_tlb_all)
Date: Sun, 1 Jun 2003 16:02:00 +0000 (UTC)
Message-ID: <bbd81o$tso$2@main.gmane.org>
X-Complaints-To: usenet@main.gmane.org
User-Agent: slrn/0.9.7.4 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


drivers/char/drm/drm_memory.h needs this to compile as module (at least)
on SMP, where flush_tlb_all() isn't a inline macro.

For some reason insmod/modprobe got a hard hang with this, even though
it did detect missing symbol (should've boil out at that stage?).
This hang prevents any further module loading/unloading activity, and is
very frustrating. Is it on must-fix list yet?


--- linux-2.5.70/arch/i386/kernel/i386_ksyms.c  2003-06-01 17:25:41.000000000 +0300
+++ linux-2.5.70-mo/arch/i386/kernel/i386_ksyms.c       2003-06-01 17:26:13.000000000 +0300
@@ -159,7 +159,7 @@
 
 /* TLB flushing */
 EXPORT_SYMBOL(flush_tlb_page);
-
+EXPORT_SYMBOL(flush_tlb_all);
 #endif
 
 #ifdef CONFIG_X86_IO_APIC


-- 
   Psi -- <http://www.iki.fi/pasi.savolainen>

