Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261600AbUK1XXC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261600AbUK1XXC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 18:23:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261597AbUK1XXB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 18:23:01 -0500
Received: from tron.kn.vutbr.cz ([147.229.191.152]:18436 "EHLO
	tron.kn.vutbr.cz") by vger.kernel.org with ESMTP id S261600AbUK1XWz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 18:22:55 -0500
Message-ID: <41AA5DC0.20403@stud.feec.vutbr.cz>
Date: Mon, 29 Nov 2004 00:22:40 +0100
From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
User-Agent: Mozilla Thunderbird 0.8 (X11/20041005)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Neil Brown <neilb@cse.unsw.edu.au>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] jiffies handling in md.c
Content-Type: multipart/mixed;
 boundary="------------040007000008040006070004"
X-Spam-Flag: NO
X-Spam-Report: Spam detection software, running on the system "tron.kn.vutbr.cz", has
  identified this incoming email as possible spam.  The original message
  has been attached to this so you can view it (if it isn't spam) or block
  similar future email.  If you have any questions, see
  the administrator of that system for details.
  ____
  Content analysis details:   (-3.9 points, 6.0 required)
  ____
   pts rule name              description
  ---- ---------------------- --------------------------------------------
   0.7 FROM_ENDS_IN_NUMS      From: ends in numbers
  -4.9 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
                              [score: 0.0010]
   0.3 MAILTO_TO_SPAM_ADDR    URI: Includes a link to a likely spammer email
  ____
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040007000008040006070004
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit

Hello,
md_do_sync in md.c doesn't handle jiffies overflow correctly.
The attached patch fixes this by changing the comparison to use the 
time_after_eq macro.
Only compile-tested.

Signed-off-by: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>

--------------040007000008040006070004
Content-Type: text/x-patch;
 name="md-jiffies.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="md-jiffies.patch"

--- linux-2.6.10-rc2-bk12/drivers/md/md.c.orig	2004-11-16 21:04:12.000000000 +0100
+++ linux-2.6.10-rc2-bk12/drivers/md/md.c	2004-11-29 00:02:29.854834272 +0100
@@ -3394,7 +3394,7 @@ static void md_do_sync(mddev_t *mddev)
 			break;
 
 	repeat:
-		if (jiffies >= mark[last_mark] + SYNC_MARK_STEP ) {
+		if (time_after_eq(jiffies, mark[last_mark] + SYNC_MARK_STEP )) {
 			/* step marks */
 			int next = (last_mark+1) % SYNC_MARKS;
 

--------------040007000008040006070004--
