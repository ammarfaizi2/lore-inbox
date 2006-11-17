Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424767AbWKQFlj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424767AbWKQFlj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 00:41:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162376AbWKQFlj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 00:41:39 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:55934 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1162363AbWKQFlh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 00:41:37 -0500
Date: Thu, 16 Nov 2006 21:30:38 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: pazke@donpac.ru, akpm <akpm@osdl.org>
Subject: [PATCH] visws: sgivwfb is module needs exports
Message-Id: <20061116213038.84cc25b5.randy.dunlap@oracle.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <randy.dunlap@oracle.com>

With CONFIG_FB_SGIVW=m:
WARNING: "sgivwfb_mem_size" [drivers/video/sgivwfb.ko] undefined!
WARNING: "sgivwfb_mem_phys" [drivers/video/sgivwfb.ko] undefined!

(or don't allow FB_SGIVW=m in Kconfig)

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 arch/i386/mach-visws/setup.c |    3 +++
 1 file changed, 3 insertions(+)

--- linux-2619-rc6.orig/arch/i386/mach-visws/setup.c
+++ linux-2619-rc6/arch/i386/mach-visws/setup.c
@@ -6,6 +6,7 @@
 #include <linux/smp.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
+#include <linux/module.h>
 
 #include <asm/fixmap.h>
 #include <asm/arch_hooks.h>
@@ -142,6 +143,8 @@ void __init time_init_hook(void)
 
 unsigned long sgivwfb_mem_phys;
 unsigned long sgivwfb_mem_size;
+EXPORT_SYMBOL(sgivwfb_mem_phys);
+EXPORT_SYMBOL(sgivwfb_mem_size);
 
 long long mem_size __initdata = 0;
 


---
