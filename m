Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315760AbSFCXiV>; Mon, 3 Jun 2002 19:38:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315862AbSFCXiU>; Mon, 3 Jun 2002 19:38:20 -0400
Received: from pD9E23450.dip.t-dialin.net ([217.226.52.80]:58507 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S315760AbSFCXiS>; Mon, 3 Jun 2002 19:38:18 -0400
Date: Mon, 3 Jun 2002 17:38:05 -0600 (MDT)
From: Lightweight patch manager <patch@luckynet.dynu.com>
X-X-Sender: patch@hawkeye.luckynet.adm
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "H. Peter Avin" <hpa@zytor.com>
Subject: [PATCH][2.5] isofs: no unhide support any more
Message-ID: <Pine.LNX.4.44.0206031735450.11309-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch drops the unhide checks from dir.c and namei.c in isofs.

I don't know if this is the right approach, but that's at least what was 
requested.

--- linux-2.5.20/fs/isofs/namei.c	Sun Jun  2 19:44:52 2002
+++ thunder-2.5.20/fs/isofs/namei.c	Mon Jun  3 17:27:38 2002
@@ -139,20 +139,8 @@
 			dpnt = tmpname;
 		}
 
-		/*
-		 * Skip hidden or associated files unless unhide is set 
-		 */
-		match = 0;
-		if (dlen > 0 &&
-		    (!(de->flags[-sbi->s_high_sierra] & 5)
-		     || sbi->s_unhide == 'y'))
-		{
-			match = (isofs_cmp(dentry,dpnt,dlen) == 0);
-		}
-		if (match) {
-			if (bh) brelse(bh);
-			return inode_number;
-		}
+		if (bh) brelse(bh);
+		return inode_number;
 	}
 	if (bh) brelse(bh);
 	return 0;
--- linux-2.5.20/fs/isofs/dir.c	Sun Jun  2 19:44:45 2002
+++ thunder-2.5.20/fs/isofs/dir.c	Mon Jun  3 17:32:30 2002
@@ -192,16 +192,6 @@
 			continue;
 		}
 
-		/* Handle everything else.  Do name translation if there
-		   is no Rock Ridge NM field. */
-		if (sbi->s_unhide == 'n') {
-			/* Do not report hidden or associated files */
-			if (de->flags[-sbi->s_high_sierra] & 5) {
-				filp->f_pos += de_len;
-				continue;
-			}
-		}
-
 		map = 1;
 		if (sbi->s_rock) {
 			len = get_rock_ridge_filename(de, tmpname, inode);
-- 
Lightweight patch manager using pine. If you have any objections, tell me.

