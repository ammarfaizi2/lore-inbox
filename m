Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261924AbVGVEXf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261924AbVGVEXf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 00:23:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261926AbVGVEXf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 00:23:35 -0400
Received: from [216.208.38.107] ([216.208.38.107]:42391 "EHLO
	OTTLS.pngxnet.com") by vger.kernel.org with ESMTP id S261924AbVGVEXe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 00:23:34 -0400
Subject: [PATCH] Address BUG: using smp_processor_id() in preemptible
	[00000001] code
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@ucw.cz>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>
Content-Type: text/plain
Organization: Cycades
Message-Id: <1122004741.3033.49.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 22 Jul 2005 13:59:01 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a warning in the disable_nonboot_cpus call in
kernel/power/smp.c.

Please apply.

Signed-off by: Nigel Cunningham <nigel@suspend2.net>

 smp.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
diff -ruNp 830-smp_processor_id_warning.patch-old/kernel/power/smp.c 830-smp_processor_id_warning.patch-new/kernel/power/smp.c
--- 830-smp_processor_id_warning.patch-old/kernel/power/smp.c	2005-07-18 06:37:08.000000000 +1000
+++ 830-smp_processor_id_warning.patch-new/kernel/power/smp.c	2005-07-22 11:09:16.000000000 +1000
@@ -38,7 +38,7 @@ void disable_nonboot_cpus(void)
 		}
 		printk("Error taking cpu %d down: %d\n", cpu, error);
 	}
-	BUG_ON(smp_processor_id() != 0);
+	BUG_ON(raw_smp_processor_id() != 0);
 	if (error)
 		panic("cpus not sleeping");
 }

-- 
Evolution.
Enumerate the requirements.
Consider the interdependencies.
Calculate the probabilities.

