Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263460AbUEMOjt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263460AbUEMOjt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 10:39:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263564AbUEMOjt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 10:39:49 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:38834 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S263460AbUEMOjs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 10:39:48 -0400
Date: Thu, 13 May 2004 16:39:47 +0200
From: Jan Kara <jack@ucw.cz>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, Lukasz Trabinski <lukasz@wsisiz.edu.pl>,
       Jerome Borsboom <j.borsboom@erasmusmc.nl>,
       Eugene Crosser <crosser@average.org>
Subject: [PATCH] Quota fix 1
Message-ID: <20040513143947.GP3629@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

  Hello,

  I'm sending you a patch which fixes the problem with release_dqblk()
being NULL for old quota format. The patch is against 2.6.6 (+the patch
you submitted to Linus). Please apply.

								Honza


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="quota-2.6.6-1-releasefix.diff"

diff -ru linux-2.6.6-quotactl/fs/dquot.c linux-2.6.6-1-releasefix/fs/dquot.c
--- linux-2.6.6-quotactl/fs/dquot.c	Thu May 13 16:31:35 2004
+++ linux-2.6.6-1-releasefix/fs/dquot.c	Thu May 13 16:32:09 2004
@@ -367,7 +367,8 @@
 	if (atomic_read(&dquot->dq_count) > 1)
 		goto out_dqlock;
 	down(&dqopt->dqio_sem);
-	ret = dqopt->ops[dquot->dq_type]->release_dqblk(dquot);
+	if (dqopt->ops[dquot->dq_type]->release_dqblk)
+		ret = dqopt->ops[dquot->dq_type]->release_dqblk(dquot);
 	clear_bit(DQ_ACTIVE_B, &dquot->dq_flags);
 	up(&dqopt->dqio_sem);
 out_dqlock:

--/04w6evG8XlLl3ft--
