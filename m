Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264763AbUHBLeu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264763AbUHBLeu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 07:34:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266458AbUHBLeu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 07:34:50 -0400
Received: from zork.zork.net ([64.81.246.102]:226 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S264763AbUHBLes (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 07:34:48 -0400
To: bfennema@falcon.csc.calpoly.edu
Cc: linux_udf@hpesjro.fc.hp.com, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] kill UDF registration/unregistration messages
From: Sean Neakums <sneakums@zork.net>
Mail-Followup-To: bfennema@falcon.csc.calpoly.edu,
	linux_udf@hpesjro.fc.hp.com, akpm@osdl.org,
	linux-kernel@vger.kernel.org
Date: Mon, 02 Aug 2004 12:31:21 +0100
Message-ID: <6u1xipdbee.fsf@zork.zork.net>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: sneakums@zork.net
X-SA-Exim-Scanned: No (on zork.zork.net); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben,

This patch kills two printks from UDF that announce its registration
and unregistration.  Since one can determine which filesystems are
present by examining /proc/filesystems, these messages strike me as
noise.

Patch is against 2.6.8-rc2-mm2.


Signed-off-by: Sean Neakums <sneakums@zork.net>

--- S8-rc2-mm2/fs/udf/super.c~	2004-07-30 20:32:12.000000000 +0100
+++ S8-rc2-mm2/fs/udf/super.c	2004-08-02 12:23:36.000000000 +0100
@@ -194,7 +194,6 @@
 static int __init init_udf_fs(void)
 {
 	int err;
-	printk(KERN_NOTICE "udf: registering filesystem\n");
 	err = init_inodecache();
 	if (err)
 		goto out1;
@@ -210,7 +209,6 @@
 
 static void __exit exit_udf_fs(void)
 {
-	printk(KERN_NOTICE "udf: unregistering filesystem\n");
 	unregister_filesystem(&udf_fstype);
 	destroy_inodecache();
 }
