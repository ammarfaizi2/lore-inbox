Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262665AbVAVFgS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262665AbVAVFgS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 00:36:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262668AbVAVFgS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 00:36:18 -0500
Received: from ozlabs.org ([203.10.76.45]:14062 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262665AbVAVFgG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 00:36:06 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16881.58940.944521.179766@cargo.ozlabs.ibm.com>
Date: Sat, 22 Jan 2005 16:35:56 +1100
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Cc: anton@samba.org, nacc@us.ibm.com
Subject: [PATCH] PPC64 replace schedule_timeout in die
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is from Nishanth Aravamudan <nacc@us.ibm.com>.

Replace schedule_timeout() with ssleep to simplify the code and to
express the delay in seconds instead of HZ.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Paul Mackerras <paulus@samba.org>

--- 2.6.11-rc1-kj-v/arch/ppc64/kernel/traps.c	2005-01-15 16:55:41.000000000 -0800
+++ 2.6.11-rc1-kj/arch/ppc64/kernel/traps.c	2005-01-15 17:30:39.000000000 -0800
@@ -29,6 +29,7 @@
 #include <linux/interrupt.h>
 #include <linux/init.h>
 #include <linux/module.h>
+#include <linux/delay.h>
 #include <asm/kdebug.h>
 
 #include <asm/pgtable.h>
@@ -137,8 +138,7 @@ int die(const char *str, struct pt_regs 
 
 	if (panic_on_oops) {
 		printk(KERN_EMERG "Fatal exception: panic in 5 seconds\n");
-		set_current_state(TASK_UNINTERRUPTIBLE);
-		schedule_timeout(5 * HZ);
+		ssleep(5);
 		panic("Fatal exception");
 	}
 	do_exit(SIGSEGV);
