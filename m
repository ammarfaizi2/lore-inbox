Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267022AbSKLWFF>; Tue, 12 Nov 2002 17:05:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267023AbSKLWFF>; Tue, 12 Nov 2002 17:05:05 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:43515 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S267022AbSKLWFE>; Tue, 12 Nov 2002 17:05:04 -0500
Date: Tue, 12 Nov 2002 17:11:10 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: viro@math.psu.edu
Cc: linux-kernel@vger.kernel.org
Subject: path_release missing or not?
Message-ID: <20021112171110.A21229@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al, please tell me if the patch below is bogus. I checked paths
and it looks right, but I may be missing something.

-- Pete

--- linux-2.4.19/fs/namei.c	2002-08-02 17:39:45.000000000 -0700
+++ linux-2.4.19-p3/fs/namei.c	2002-11-12 14:01:55.000000000 -0800
@@ -1984,8 +1984,10 @@
 	 * bloody create() on broken symlinks. Furrfu...
 	 */
 	name = __getname();
-	if (!name)
+	if (!name) {
+		path_release(nd);
 		return -ENOMEM;
+	}
 	strcpy(name, nd->last.name);
 	nd->last.name = name;
 	return 0;
