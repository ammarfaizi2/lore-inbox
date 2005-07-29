Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262790AbVG2TuS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262790AbVG2TuS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 15:50:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262775AbVG2Tsx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 15:48:53 -0400
Received: from tron.kn.vutbr.cz ([147.229.191.152]:54543 "EHLO
	tron.kn.vutbr.cz") by vger.kernel.org with ESMTP id S262763AbVG2Tq7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 15:46:59 -0400
Message-ID: <42EA87A0.908@stud.feec.vutbr.cz>
Date: Fri, 29 Jul 2005 21:46:40 +0200
From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050603)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: linux-kernel@vger.kernel.org, linux-pm@lists.osdl.org
Subject: [PATCH] swsusp: simpler calculation of number of pages in PBE list
Content-Type: multipart/mixed;
 boundary="------------090005060603090605030006"
X-Spam-Flag: NO
X-Spam-Report: Spam detection software, running on the system "tron.kn.vutbr.cz", has
  tested this incoming email. See other headers to know if the email
  has beed identified as possible spam.  The original message
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
                              [score: 0.0000]
   0.3 MAILTO_TO_SPAM_ADDR    URI: Includes a link to a likely spammer email
  ____
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090005060603090605030006
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit

The function calc_nr uses an iterative algorithm to calculate the number 
of pages needed for the image and the pagedir. Exactly the same result 
can be obtained with a one-line expression.

Signed-off-by: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>

--------------090005060603090605030006
Content-Type: text/x-patch;
 name="swsusp-simpler-calc_nr.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="swsusp-simpler-calc_nr.diff"

diff -Nurp -X dontdiff.new linux-mm/kernel/power/swsusp.c linux-mm.mich/kernel/power/swsusp.c
--- linux-mm/kernel/power/swsusp.c	2005-07-28 13:57:53.000000000 +0200
+++ linux-mm.mich/kernel/power/swsusp.c	2005-07-29 21:01:46.000000000 +0200
@@ -737,18 +737,7 @@ static void copy_data_pages(void)
 
 static int calc_nr(int nr_copy)
 {
-	int extra = 0;
-	int mod = !!(nr_copy % PBES_PER_PAGE);
-	int diff = (nr_copy / PBES_PER_PAGE) + mod;
-
-	do {
-		extra += diff;
-		nr_copy += diff;
-		mod = !!(nr_copy % PBES_PER_PAGE);
-		diff = (nr_copy / PBES_PER_PAGE) + mod - extra;
-	} while (diff > 0);
-
-	return nr_copy;
+	return nr_copy + (nr_copy+PBES_PER_PAGE-2)/(PBES_PER_PAGE-1);
 }
 
 /**

--------------090005060603090605030006--
