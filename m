Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262606AbUFBM7q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262606AbUFBM7q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 08:59:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262585AbUFBM7p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 08:59:45 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:60326 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262488AbUFBM7b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 08:59:31 -0400
Date: Wed, 2 Jun 2004 14:59:28 +0200
From: Jan Kara <jack@ucw.cz>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix for old quota format
Message-ID: <20040602125928.GB2028@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="GID0FwUMdk1T2AWN"
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--GID0FwUMdk1T2AWN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

  Hello!

  Attached two-liner fixes a problem in the old quota format when we tried
to read quota information after the end of quota file (that is correct as
it might a user with sufficiently large UID which has no limits or usage).
Please apply.

								Honza

--GID0FwUMdk1T2AWN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="quota-2.6.7-rc2-6-v1emptyfix"

diff -ruX /home/jack/.kerndiffexclude linux-2.6.7-rc2-5-credfix/fs/quota_v1.c linux-2.6.7-rc2-6-v1emptyfix/fs/quota_v1.c
--- linux-2.6.7-rc2-5-credfix/fs/quota_v1.c	2004-05-13 21:00:27.000000000 +0200
+++ linux-2.6.7-rc2-6-v1emptyfix/fs/quota_v1.c	2004-05-31 19:15:34.000000000 +0200
@@ -52,6 +52,8 @@
 
 	/* Now we are sure filp is valid */
 	offset = v1_dqoff(dquot->dq_id);
+	/* Set structure to 0s in case read fails/is after end of file */
+	memset(&dqblk, 0, sizeof(struct v1_disk_dqblk));
 	fs = get_fs();
 	set_fs(KERNEL_DS);
 	filp->f_op->read(filp, (char *)&dqblk, sizeof(struct v1_disk_dqblk), &offset);

--GID0FwUMdk1T2AWN--
