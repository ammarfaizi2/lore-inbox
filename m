Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266627AbUI0Kmg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266627AbUI0Kmg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 06:42:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266631AbUI0Kmg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 06:42:36 -0400
Received: from cantor.suse.de ([195.135.220.2]:10925 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266627AbUI0Kme (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 06:42:34 -0400
Date: Mon, 27 Sep 2004 12:41:47 +0200
From: Andi Kleen <ak@suse.de>
To: "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>, tom.l.nguyen@intel.com,
       linux-kernel@vger.kernel.org
Subject: [PATCH] Fix x86-64 properly with MSI & Suresh's change
Message-ID: <20040927104147.GE3532@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Together with Suresh's recent LH workaround: this patch makes x86-64 
compile again with MSI on.  i386 uses an CPU number, x86-64
an CPU mask for MSI_TARGET_CPUS and that didn't work very well.

I must admit I don't fully understand how MSI irq affinity
is supposed to work (why do you always redirect to the current CPU?),
but this matches i386 which is presumably the best tested MSI
platform.

Signed-off-by: Andi Kleen <ak@suse.de>

diff -u linux/include/asm-x86_64/msi.h-o linux/include/asm-x86_64/msi.h
--- linux/include/asm-x86_64/msi.h-o	2004-09-24 13:04:06.000000000 +0200
+++ linux/include/asm-x86_64/msi.h	2004-09-27 12:19:56.000000000 +0200
@@ -7,10 +7,11 @@
 #define ASM_MSI_H
 
 #include <asm/desc.h>
+#include <asm/smp.h>
 
 #define LAST_DEVICE_VECTOR		232
 #define MSI_DEST_MODE			MSI_LOGICAL_MODE
 #define MSI_TARGET_CPU_SHIFT		12
-#define MSI_TARGET_CPU			TARGET_CPUS
+#define MSI_TARGET_CPU			hard_smp_processor_id()
 
 #endif /* ASM_MSI_H */


