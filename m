Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279785AbRKFTdS>; Tue, 6 Nov 2001 14:33:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279844AbRKFTdJ>; Tue, 6 Nov 2001 14:33:09 -0500
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:64271 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S279785AbRKFTdB>; Tue, 6 Nov 2001 14:33:01 -0500
Date: Tue, 6 Nov 2001 20:32:38 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: <paulus@samba.org>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>,
        Andreas Dilger <adilger@turbolabs.com>
Subject: [PATCH] ppp_async.c jiffies cleanup
Message-ID: <Pine.LNX.4.30.0111062015290.23598-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Paul, Linus, Alan,

one more jiffies cleanup to use the comparison macros along the lines
Andreas Dilger already pointed out on lkml. I intend to post several
patches like this one in the future as time permits.

Tim


--- ../linux-2.4.14-pre6/drivers/net/ppp_async.c	Sun Sep 30 21:26:07 2001
+++ drivers/net/ppp_async.c	Tue Nov  6 20:27:28 2001
@@ -497,7 +497,7 @@
 		 * character if necessary.
 		 */
 		if (islcp || flag_time == 0
-		    || jiffies - ap->last_xmit >= flag_time)
+		    || time_after_eq(jiffies, ap->last_xmit + flag_time))
 			*buf++ = PPP_FLAG;
 		ap->last_xmit = jiffies;
 		fcs = PPP_INITFCS;

