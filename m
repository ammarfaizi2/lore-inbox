Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262465AbTGFQHs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 12:07:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262489AbTGFQHs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 12:07:48 -0400
Received: from snipe.mail.pas.earthlink.net ([207.217.120.62]:46547 "EHLO
	snipe.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S262465AbTGFQHr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 12:07:47 -0400
Date: Sun, 6 Jul 2003 12:24:00 -0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH] fix return of compat_sys_sched_getaffinity
Message-ID: <20030706162400.GA15526@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-EFAULT return got buggered when compat_sys_sched_getaffinity
was added in 2.5.68.

--- linux-2.5.74/kernel/compat.c.orig	2003-06-22 15:54:17.000000000 -0400
+++ linux-2.5.74/kernel/compat.c	2003-07-06 11:29:33.000000000 -0400
@@ -425,11 +425,9 @@
 				    &kernel_mask);
 	set_fs(old_fs);
 
-	if (ret > 0) {
+	if (ret > 0)
 		if (put_user(kernel_mask, user_mask_ptr))
-			ret = -EFAULT;
-		ret = sizeof(compat_ulong_t);
-	}
+			return -EFAULT;
 
 	return ret;
 }

-- 
Randy Hron
http://home.earthlink.net/~rwhron/kernel/bigbox.html

