Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264484AbUEMTRW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264484AbUEMTRW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 15:17:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264444AbUEMTP6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 15:15:58 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:61611 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264465AbUEMTPI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 15:15:08 -0400
Date: Thu, 13 May 2004 12:14:57 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.6-mm2
Message-ID: <39780000.1084475697@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.6-mm2 won't compile without CONFIG_MODULE_UNLOAD ... looks very much
like the first definition of add_attribute needs moving inside the ifdef.

kernel/module.c:730: redefinition of `add_attribute'
kernel/module.c:382: `add_attribute' previously defined here
{standard input}: Assembler messages:
{standard input}:1121: Error: symbol `add_attribute' is already defined

# grep MODULE .config
CONFIG_MODULES=y
# CONFIG_MODULE_UNLOAD is not set

--- 2.6.6-mm2/kernel/module.c.old	2004-05-13 11:08:39.000000000 -0700
+++ 2.6.6-mm2/kernel/module.c	2004-05-13 11:13:50.000000000 -0700
@@ -378,6 +378,7 @@
 }
 #endif /* CONFIG_SMP */
 
+#ifdef CONFIG_MODULE_UNLOAD
 static int add_attribute(struct module *mod, struct kernel_param *kp)
 {
 	struct module_attribute *a;
@@ -394,7 +395,6 @@
 	return retval;
 }
 
-#ifdef CONFIG_MODULE_UNLOAD
 /* Init the unload section of the module. */
 static void module_unload_init(struct module *mod)
 {

