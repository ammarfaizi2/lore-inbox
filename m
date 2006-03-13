Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750789AbWCMVI0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750789AbWCMVI0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 16:08:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750877AbWCMVI0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 16:08:26 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:23241
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1750789AbWCMVI0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 16:08:26 -0500
From: Rob Landley <rob@landley.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Ext2 flags shouldn't report "nogrpid".
Date: Mon, 13 Mar 2006 16:08:47 -0500
User-Agent: KMail/1.8.3
MIME-Version: 1.0
Message-Id: <200603131608.47271.rob@landley.net>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_f9dFERdRXHW1fiw"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_f9dFERdRXHW1fiw
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Signed-off-by: Rob Landley <rob@landley.net>

If I mount ext2 "rw", I want it to say "rw", not "rw,nogrpid".
--
I caught this writing an automated regression test script for the busybox 
mount command.  The symptom is
  /dev/loop0 on /images/ext2.dir type ext2 (rw,nogrpid)
instead of:
  /dev/loop0 on /images/ext2.dir type ext2 (rw)

The behavior was introduced by git commit 
8fc2751beb0941966d3a97b26544e8585e428c08.

Rob
-- 
Never bet against the cheap plastic solution.

--Boundary-00=_f9dFERdRXHW1fiw
Content-Type: text/x-diff;
  charset="us-ascii";
  name="ext2.diff"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="ext2.diff"

--- linux-2.6.16-rc5/fs/ext2/super.c	2006-02-27 00:09:35.000000000 -0500
+++ linux-2.6.16-rc5.new/fs/ext2/super.c	2006-03-13 15:55:15.000000000 -0500
@@ -210,8 +210,6 @@
 
 	if (sbi->s_mount_opt & EXT2_MOUNT_GRPID)
 		seq_puts(seq, ",grpid");
-	else
-		seq_puts(seq, ",nogrpid");
 
 #if defined(CONFIG_QUOTA)
 	if (sbi->s_mount_opt & EXT2_MOUNT_USRQUOTA)

--Boundary-00=_f9dFERdRXHW1fiw--
