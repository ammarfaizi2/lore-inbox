Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278701AbRJ1WTJ>; Sun, 28 Oct 2001 17:19:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278703AbRJ1WSz>; Sun, 28 Oct 2001 17:18:55 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:14608 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S278701AbRJ1WRm>; Sun, 28 Oct 2001 17:17:42 -0500
Date: Sun, 28 Oct 2001 23:18:13 +0100
From: Jan Kara <jack@ucw.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, mason@suse.com
Subject: Quota fix
Message-ID: <20011028231813.F22960@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="qMm9M+Fa2AknHoGS"
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

  Hello,

  I'm sending you a small fix (thanks to Chris Mason for the patch)
which fixes possible list corruption when dquots are invalidated.
Please apply.

								Honza

PS to Chris: I simplified an condition a bit. Your was right too but
  I like being more careful and tell we block even if we don't.

--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dquot_deadlock.diff"

Index: 0.43/fs/dquot.c
--- 0.43/fs/dquot.c Mon, 15 Oct 2001 03:51:05 -0400 root (linux/i/40_dquot.c 1.1.2.1.3.1.1.1 644)
+++ 0.43(w)/fs/dquot.c Mon, 15 Oct 2001 14:12:57 -0400 root (linux/i/40_dquot.c 1.1.2.1.3.1.1.1 644)
@@ -1246,6 +1246,8 @@
 {
 	if (dquot->dq_dup_ref && dquot->dq_count - dquot->dq_dup_ref <= 1)
 		return 1;
+	if (dquot->dq_count <= 1) 
+		return 1; 
 	return 0;
 }
 

--qMm9M+Fa2AknHoGS--
