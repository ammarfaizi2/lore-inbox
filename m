Return-Path: <linux-kernel-owner+willy=40w.ods.org-S771618AbUKBFO6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S771618AbUKBFO6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 00:14:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S324078AbUKAWdn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 17:33:43 -0500
Received: from peabody.ximian.com ([130.57.169.10]:10398 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S278093AbUKAUMg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 15:12:36 -0500
Subject: [patch] inotify: fix dnotify compile
From: Robert Love <rml@novell.com>
To: John McCutchan <ttb@tentacle.dhs.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1099330316.12182.2.camel@vertex>
References: <1099330316.12182.2.camel@vertex>
Content-Type: text/plain
Date: Mon, 01 Nov 2004 15:10:10 -0500
Message-Id: <1099339810.31022.39.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, John.

Looks like the dnotify patch was only half removed.  The declaration of
dir_notify_enable in include/linux/fs.h is still removed by the patch.
So e.g. sysctl.c does not compile.

You can remove that hunk from the patch or commit the following.

Thanks,

	Robert Love


fix CONFIG_DNOTIFY compile

Signed-Off-By: Robert Love <rml@novell.com>

 include/linux/fs.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -u linux-poop/include/linux/fs.h linux/include/linux/fs.h
--- linux-poop/include/linux/fs.h	2004-10-26 22:13:06.000000000 -0400
+++ linux/include/linux/fs.h	2004-11-01 14:52:58.630121656 -0500
@@ -62,7 +62,7 @@
 };
 extern struct inodes_stat_t inodes_stat;
 
-extern int leases_enable, lease_break_time;
+extern int leases_enable, dir_notify_enable, lease_break_time;
 
 #define NR_FILE  8192	/* this can well be larger on a larger system */
 #define NR_RESERVED_FILES 10 /* reserved for root */


