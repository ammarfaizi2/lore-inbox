Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264560AbUD1BCg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264560AbUD1BCg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 21:02:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264563AbUD1BCf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 21:02:35 -0400
Received: from fw.osdl.org ([65.172.181.6]:53167 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264560AbUD1BCc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 21:02:32 -0400
Date: Tue, 27 Apr 2004 18:04:38 -0700
From: Dave Olien <dmo@osdl.org>
To: thornber@redhat.com
Cc: dm-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH] trivial patch to dm-target.c
Message-ID: <20040428010438.GA17809@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch just adds __init and __exit qualifiers on dm_target_init()
and dm_target_exit(), since these are called only by dm_init() and
dm_exit(), which are also have these qualifiers respectively.


diff -ur linux-2.6.6-rc2-udm1-original/drivers/md/dm-target.c linux-2.6.6-rc2-udm1-patched/drivers/md/dm-target.c
--- linux-2.6.6-rc2-udm1-original/drivers/md/dm-target.c	2004-04-27 17:59:53.000000000 -0700
+++ linux-2.6.6-rc2-udm1-patched/drivers/md/dm-target.c	2004-04-27 17:59:25.000000000 -0700
@@ -181,12 +181,12 @@
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
