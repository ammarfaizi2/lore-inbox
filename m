Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130407AbQKUMvq>; Tue, 21 Nov 2000 07:51:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130473AbQKUMvg>; Tue, 21 Nov 2000 07:51:36 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:10759 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S130407AbQKUMv0>; Tue, 21 Nov 2000 07:51:26 -0500
Date: Tue, 21 Nov 2000 13:21:37 +0100
From: Jan Kara <jack@suse.cz>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: Small fix in quota
Message-ID: <20001121132137.D2457@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="9jxsPFA5p3P2qPhR"
X-Mailer: Mutt 1.0i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii

  Hello.

  I'm sending you a small fix in quota. Currently on
systems with many different users there are problems that too
many dquots are bound in unused inodes. Following patch
fixes it - quota tries to get dquots from unused inodes
more than once.

						Honza

PS: I already sent this patch some time ago but it got lost...

--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dquot.c.diff"

--- linux/fs/dquot.c	Tue Nov 21 13:05:16 2000
+++ linux/fs/dquot.c	Tue Nov 21 13:05:44 2000
@@ -522,7 +522,7 @@
 struct dquot *get_empty_dquot(void)
 {
 	struct dquot *dquot;
-	int shrink = 1;	/* Number of times we should try to shrink dcache and icache */
+	int shrink = 8;	/* Number of times we should try to shrink dcache and icache */
 
 repeat:
 	dquot = find_best_free();

--9jxsPFA5p3P2qPhR--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
