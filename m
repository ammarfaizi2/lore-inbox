Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262956AbVG3Nd5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262956AbVG3Nd5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 09:33:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262954AbVG3Nd5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 09:33:57 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:16041 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262956AbVG3Nd4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 09:33:56 -0400
Date: Sat, 30 Jul 2005 15:33:48 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>, xschmi00@stud.feec.vutbr.cz
Subject: [PATCH] swsusp: simpler calculation of number of pages in PBE list
Message-ID: <20050730133348.GA28974@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>

The function calc_nr uses an iterative algorithm to calculate the
number of pages needed for the image and the pagedir. Exactly the same
result can be obtained with a one-line expression.

Note that this was even proved correct ;-).

Signed-off-by: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Signed-off-by: Pavel Machek <pavel@suse.cz>

---
commit 06695555bdbe1a5ac3b7926867abfdc9e560121f
tree 3be140250bf556a51261ea75b908906e64182ec3
parent 42b960c2ed61b623d5e84b67f95c7f0ddad0565f
author <pavel@amd.(none)> Sat, 30 Jul 2005 15:19:56 +0200
committer <pavel@amd.(none)> Sat, 30 Jul 2005 15:19:56 +0200

 kernel/power/swsusp.c |   13 +------------
 1 files changed, 1 insertions(+), 12 deletions(-)

diff --git a/kernel/power/swsusp.c b/kernel/power/swsusp.c
--- a/kernel/power/swsusp.c
+++ b/kernel/power/swsusp.c
@@ -591,18 +591,7 @@ static void copy_data_pages(void)
 
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

-- 
teflon -- maybe it is a trademark, but it should not be.
