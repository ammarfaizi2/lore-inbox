Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261435AbUCDEGw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 23:06:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261451AbUCDEGo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 23:06:44 -0500
Received: from fw.osdl.org ([65.172.181.6]:42674 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261435AbUCDEDO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 23:03:14 -0500
Date: Wed, 3 Mar 2004 20:03:13 -0800
From: Chris Wright <chrisw@osdl.org>
To: greg@kroah.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] class_simple cleanup in misc
Message-ID: <20040303200312.M21045@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Error path doesn't class_simple_destroy.

===== drivers/char/misc.c 1.27 vs edited =====
--- 1.27/drivers/char/misc.c	Fri Feb 13 03:15:29 2004
+++ edited/drivers/char/misc.c	Wed Mar  3 19:39:51 2004
@@ -342,6 +342,7 @@
 	if (register_chrdev(MISC_MAJOR,"misc",&misc_fops)) {
 		printk("unable to get major %d for misc devices\n",
 		       MISC_MAJOR);
+		class_simple_destroy(misc_class);
 		return -EIO;
 	}
 	return 0;
