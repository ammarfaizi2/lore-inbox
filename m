Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262740AbUKRLgQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262740AbUKRLgQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 06:36:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262738AbUKRLfE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 06:35:04 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:30443 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262733AbUKRLeX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 06:34:23 -0500
Date: Thu, 18 Nov 2004 12:34:23 +0100
From: Jan Kara <jack@suse.cz>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH] Add missing DQUOT_OFF
Message-ID: <20041118113423.GB2767@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="H+4ONPRPur6+Ovig"
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--H+4ONPRPur6+Ovig
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

  Hello!

  Attached patch adds missing DQUOT_OFF to the umount path of the root
filesystem (it is only remounted read-only and so the usual path with
DQUOT_OFF is not taken). Please apply.

								Honza

-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs

--H+4ONPRPur6+Ovig
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="quota-new-2.6.10-rc2-mm1-2-offadd.diff"

Add quotaoff when unmounting root (actually remounting RO).

Signed-off-by: Jan Kara <jack@suse.cz>

diff -rupNX /home/jack/.kerndiffexclude linux-2.6.10-rc2-mm1-1-eqfix/fs/namespace.c linux-2.6.10-rc2-mm1-2-offadd/fs/namespace.c
--- linux-2.6.10-rc2-mm1-1-eqfix/fs/namespace.c	2004-11-16 16:39:08.000000000 +0100
+++ linux-2.6.10-rc2-mm1-2-offadd/fs/namespace.c	2004-11-16 16:49:35.000000000 +0100
@@ -423,6 +423,7 @@ static int do_umount(struct vfsmount *mn
 		down_write(&sb->s_umount);
 		if (!(sb->s_flags & MS_RDONLY)) {
 			lock_kernel();
+			DQUOT_OFF(sb);
 			retval = do_remount_sb(sb, MS_RDONLY, NULL, 0);
 			unlock_kernel();
 		}

--H+4ONPRPur6+Ovig--
