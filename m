Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262732AbUKRLbo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262732AbUKRLbo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 06:31:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262733AbUKRLbm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 06:31:42 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:54250 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262732AbUKRLbe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 06:31:34 -0500
Date: Thu, 18 Nov 2004 12:31:34 +0100
From: Jan Kara <jack@suse.cz>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH] Minor fix of inequalities in the quota code
Message-ID: <20041118113134.GA2767@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ReaqsoxgOBHFXBhH"
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

  Hello!

  Attached is a patch which changes inequalities checking whether user got
below the softlimit to match the ones deciding whether he exceeded them.
IMO it makes more sence if the inequalities match.. The patch is against
2.6.10-rc2-mm1 but should apply well against any recent kernel. Please
apply.

								Honza

-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs

--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="quota-new-2.6.10-rc2-mm1-1-eqfix.diff"

Change inequalities for deciding when a user has cleaned up enough space
to be below softlimit to match the ones for deciding when the softlimit
has been exceeded.

Signed-off-by: Jan Kara <jack@suse.cz>

diff -rupNX /home/jack/.kerndiffexclude linux-2.6.10-rc2-mm1/fs/dquot.c linux-2.6.10-rc2-mm1-1-eqfix/fs/dquot.c
--- linux-2.6.10-rc2-mm1/fs/dquot.c	2004-11-16 16:39:07.000000000 +0100
+++ linux-2.6.10-rc2-mm1-1-eqfix/fs/dquot.c	2004-11-16 16:46:54.000000000 +0100
@@ -758,7 +758,7 @@ static inline void dquot_decr_inodes(str
 		dquot->dq_dqb.dqb_curinodes -= number;
 	else
 		dquot->dq_dqb.dqb_curinodes = 0;
-	if (dquot->dq_dqb.dqb_curinodes < dquot->dq_dqb.dqb_isoftlimit)
+	if (dquot->dq_dqb.dqb_curinodes <= dquot->dq_dqb.dqb_isoftlimit)
 		dquot->dq_dqb.dqb_itime = (time_t) 0;
 	clear_bit(DQ_INODES_B, &dquot->dq_flags);
 }
@@ -769,7 +769,7 @@ static inline void dquot_decr_space(stru
 		dquot->dq_dqb.dqb_curspace -= number;
 	else
 		dquot->dq_dqb.dqb_curspace = 0;
-	if (toqb(dquot->dq_dqb.dqb_curspace) < dquot->dq_dqb.dqb_bsoftlimit)
+	if (toqb(dquot->dq_dqb.dqb_curspace) <= dquot->dq_dqb.dqb_bsoftlimit)
 		dquot->dq_dqb.dqb_btime = (time_t) 0;
 	clear_bit(DQ_BLKS_B, &dquot->dq_flags);
 }

--ReaqsoxgOBHFXBhH--
