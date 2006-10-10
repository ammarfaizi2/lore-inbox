Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030639AbWJJXQi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030639AbWJJXQi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 19:16:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030640AbWJJXQi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 19:16:38 -0400
Received: from havoc.gtf.org ([69.61.125.42]:26795 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1030639AbWJJXQh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 19:16:37 -0400
Date: Tue, 10 Oct 2006 19:16:31 -0400
From: Jeff Garzik <jeff@garzik.org>
To: neilb@cse.unsw.edu.au, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] MD: conditionalize some code
Message-ID: <20061010231631.GA18222@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The autorun code is only used if this module is built into the static
kernel image.  Adjust #ifdefs accordingly.

Signed-off-by: Jeff Garzik <jeff@garzik.org>

---

 drivers/md/md.c               |    4 +++-

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 57fa64f..c75cdf9 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -3368,6 +3368,7 @@ out:
 	return err;
 }
 
+#ifndef MODULE
 static void autorun_array(mddev_t *mddev)
 {
 	mdk_rdev_t *rdev;
@@ -3482,6 +3483,7 @@ static void autorun_devices(int part)
 	}
 	printk(KERN_INFO "md: ... autorun DONE.\n");
 }
+#endif /* !MODULE */
 
 static int get_version(void __user * arg)
 {
@@ -5592,7 +5594,7 @@ static void autostart_arrays(int part)
 	autorun_devices(part);
 }
 
-#endif
+#endif /* !MODULE */
 
 static __exit void md_exit(void)
 {
