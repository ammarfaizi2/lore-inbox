Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264571AbUD1BbD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264571AbUD1BbD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 21:31:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264573AbUD1BbC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 21:31:02 -0400
Received: from fw.osdl.org ([65.172.181.6]:2242 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264571AbUD1Ba7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 21:30:59 -0400
Date: Tue, 27 Apr 2004 18:33:06 -0700
From: Dave Olien <dmo@osdl.org>
To: thornber@redhat.com
Cc: dm-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: [CORRECTED PATCH], trivial patch for dm-target.c with correction
Message-ID: <20040428013305.GA18833@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sorry, I made an error on that last patch to dm-target.c.  I overlooked
that it needed the init.h header file included also, and I had not compiled
the change because it was "so trivial".

Please use this patch instead.


diff -ur linux-2.6.6-rc2-udm1-original/drivers/md/dm-target.c linux-2.6.6-rc2-udm1-patched/drivers/md/dm-target.c
--- linux-2.6.6-rc2-udm1-original/drivers/md/dm-target.c	2004-04-27 17:59:53.000000000 -0700
+++ linux-2.6.6-rc2-udm1-patched/drivers/md/dm-target.c	2004-04-27 18:29:58.000000000 -0700
@@ -7,6 +7,7 @@
 #include "dm.h"
 
 #include <linux/module.h>
+#include <linux/init.h>
 #include <linux/kmod.h>
 #include <linux/bio.h>
 #include <linux/slab.h>
@@ -181,12 +182,12 @@
 	.map  = io_err_map,
 };
 
-int dm_target_init(void)
+int __init dm_target_init(void)
 {
 	return dm_register_target(&error_target);
 }
 
-void dm_target_exit(void)
+void __exit dm_target_exit(void)
 {
 	if (dm_unregister_target(&error_target))
 		DMWARN("error target unregistration failed");
