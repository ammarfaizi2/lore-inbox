Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263031AbTCLEi1>; Tue, 11 Mar 2003 23:38:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263032AbTCLEi1>; Tue, 11 Mar 2003 23:38:27 -0500
Received: from 209-198-142-194-host.prismnet.net ([209.198.142.194]:46852 "EHLO
	feeding.frenzy.com") by vger.kernel.org with ESMTP
	id <S263031AbTCLEi0>; Tue, 11 Mar 2003 23:38:26 -0500
Date: Tue, 11 Mar 2003 22:49:09 -0600 (CST)
From: Jay Patrick Howard <jhoward@feeding.frenzy.com>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] ~/kernel/sys.c (2.5.64) (trivial)
In-Reply-To: <20030312040309.GA7510@work.bitmover.com>
Message-ID: <20030311221535.W22624-100000@feeding.frenzy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <20030311224347.Y23539@feeding.frenzy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Apologies in advance if this is so trivial as to be non-patch-worthy.

Was poking around and noticed a possible improvement to kernekl/sys.c.
This change results in marginally better output using gcc 3.2 on x86.

As a test I constructed look-alike functions and a small driver.  There
appeared to be a ~40% speedup on the "true" branch and ~5% slowdown on the
"false" branch.  No effort was made to account for overhead when figuring
the percentages.

Unfortunately I don't know enough to say which side of the branch is more
commonly taken.



--- linux-2.5.64.orig/kernel/sys.c	Tue Mar  4 21:28:58 2003
+++ linux-2.5.64/kernel/sys.c	Tue Mar 11 22:06:12 2003
@@ -1096,18 +1096,12 @@
  */
 int in_group_p(gid_t grp)
 {
-	int retval = 1;
-	if (grp != current->fsgid)
-		retval = supplemental_group_member(grp);
-	return retval;
+	return (grp != current->fsgid) ? supplemental_group_member(grp) : 1;
 }

 int in_egroup_p(gid_t grp)
 {
-	int retval = 1;
-	if (grp != current->egid)
-		retval = supplemental_group_member(grp);
-	return retval;
+	return (grp != current->egid) ? supplemental_group_member(grp) : 1;
 }

 DECLARE_RWSEM(uts_sem);

