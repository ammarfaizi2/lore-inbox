Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262367AbVAZGzp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262367AbVAZGzp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 01:55:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262368AbVAZGzp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 01:55:45 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:28904 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262367AbVAZGzh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 01:55:37 -0500
Subject: [PATCH] unexport register_cpu and unregister_cpu
From: Nathan Lynch <nathanl@austin.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, anil.s.keshavamurthy@intel.com
Content-Type: text/plain
Date: Wed, 26 Jan 2005 00:55:47 -0600
Message-Id: <1106722547.9855.36.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://linus.bkbits.net:8080/linux-2.5/cset@4180a2b7mi2fzuNQDBOQY7eMAkns8g?nav=index.html|src/|src/drivers|src/drivers/base|related/drivers/base/cpu.c

This changeset introduced exports for register_cpu and unregister_cpu
right after 2.6.10.  As far as I can tell these are not called from any
code which can be built as a module, and I can't think of a good reason
why any out of tree code would use them.  Unless I've missed something,
can we remove them before 2.6.11?

Build-tested for ia64 and i386.

Signed-off-by: Nathan Lynch <nathanl@austin.ibm.com>

Index: linux-2.6.11-rc2-mm1/drivers/base/cpu.c
===================================================================
--- linux-2.6.11-rc2-mm1.orig/drivers/base/cpu.c	2005-01-25 23:50:02.677255800 -0600
+++ linux-2.6.11-rc2-mm1/drivers/base/cpu.c	2005-01-25 23:56:28.436611464 -0600
@@ -64,7 +64,6 @@
 
 	return;
 }
-EXPORT_SYMBOL(unregister_cpu);
 #else /* ... !CONFIG_HOTPLUG_CPU */
 static inline void register_cpu_control(struct cpu *cpu)
 {
@@ -96,9 +95,6 @@
 		register_cpu_control(cpu);
 	return error;
 }
-#ifdef CONFIG_HOTPLUG_CPU
-EXPORT_SYMBOL(register_cpu);
-#endif
 
 
 


