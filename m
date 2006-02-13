Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964875AbWBMXUJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964875AbWBMXUJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 18:20:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030233AbWBMXUJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 18:20:09 -0500
Received: from stat9.steeleye.com ([209.192.50.41]:48084 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S964879AbWBMXUI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 18:20:08 -0500
Subject: [PATCH] fix x86 topology export in sysfs for subarchitectures.
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, yanmin.zhang@intel.com
Content-Type: text/plain
Date: Mon, 13 Feb 2006 17:20:03 -0600
Message-Id: <1139872803.5120.31.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The correct way to export hyperthreading based functions is to predicate
them on CONFIG_X86_HT.  Without this, the topology exporting patch
breaks the build on all non-PC x86 subarchitectures.

Signed-off-by: James Bottomley <James.Bottomley@SteelEye.com>

---

diff --git a/include/asm-i386/topology.h b/include/asm-i386/topology.h
index af503a1..aa958c6 100644
--- a/include/asm-i386/topology.h
+++ b/include/asm-i386/topology.h
@@ -27,7 +27,7 @@
 #ifndef _ASM_I386_TOPOLOGY_H
 #define _ASM_I386_TOPOLOGY_H
 
-#ifdef CONFIG_SMP
+#ifdef CONFIG_X86_HT
 #define topology_physical_package_id(cpu)				\
 	(phys_proc_id[cpu] == BAD_APICID ? -1 : phys_proc_id[cpu])
 #define topology_core_id(cpu)						\


