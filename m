Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311025AbSFJLxN>; Mon, 10 Jun 2002 07:53:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311710AbSFJLxM>; Mon, 10 Jun 2002 07:53:12 -0400
Received: from p50887BDF.dip.t-dialin.net ([80.136.123.223]:51853 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S311025AbSFJLxM>; Mon, 10 Jun 2002 07:53:12 -0400
Date: Mon, 10 Jun 2002 05:52:53 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Francois Gouget <fgouget@free.fr>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeremy White <jwhite@codeweavers.com>
Subject: Re: isofs unhide option:  troubles with Wine
In-Reply-To: <Pine.LNX.4.43.0206091947390.6638-100000@amboise.dolphin>
Message-ID: <Pine.LNX.4.44.0206100549330.6159-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 9 Jun 2002, Francois Gouget wrote:
> 2. or should it completely ignore the 'hidden' bit?

I already _had_ a patch which did exactly this.

Regards,
Thunder

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
German attitude becoming        |	Thunder from the hill at ngforever
rightaway popular:		|
       "Get outa my way,  	|	free inhabitant not directly
    for I got a mobile phone!"	|	belonging anywhere

