Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131710AbQKCVTr>; Fri, 3 Nov 2000 16:19:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129099AbQKCVTg>; Fri, 3 Nov 2000 16:19:36 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:37388 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S131710AbQKCVT1>; Fri, 3 Nov 2000 16:19:27 -0500
Date: Fri, 3 Nov 2000 22:19:19 +0100
From: Jan Kara <jack@suse.cz>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: Small fix
Message-ID: <20001103221919.B29661@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="+g7M9IMkV8truYOl"
X-Mailer: Mutt 1.0i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+g7M9IMkV8truYOl
Content-Type: text/plain; charset=us-ascii

  Hello.

  I've got a report that some people using quotas for lots of
users are experiencing being out of dquots. The problem is
that we have quota structs bound in unused inodes and we are not
aggressive enough to get it back. The following patch should
fix it (OK, more proper would be to make quota cache dynamic
as inode cache is but that wouldn't definitely pass over you :)).

						Honza

--+g7M9IMkV8truYOl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dquot.c.diff"

--- linux/fs/dquot.c	Fri Oct  6 00:18:14 2000
+++ linux/fs/dquot.c	Fri Nov  3 21:10:51 2000
@@ -522,7 +522,7 @@
 struct dquot *get_empty_dquot(void)
 {
 	struct dquot *dquot;
-	int shrink = 1;	/* Number of times we should try to shrink dcache and icache */
+	int shrink = 16;	/* Number of times we should try to shrink dcache and icache */
 
 repeat:
 	dquot = find_best_free();

--+g7M9IMkV8truYOl--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
