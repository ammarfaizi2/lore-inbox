Return-Path: <linux-kernel-owner+w=401wt.eu-S1751200AbXAFH1I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751200AbXAFH1I (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 02:27:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbXAFH1I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 02:27:08 -0500
Received: from smtp.ustc.edu.cn ([202.38.64.16]:59149 "HELO ustc.edu.cn"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1751200AbXAFH1H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 02:27:07 -0500
Message-ID: <368068421.90598@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Message-Id: <20070106072729.877602418@mail.ustc.edu.cn>
References: <20070106072626.911640026@mail.ustc.edu.cn>
User-Agent: quilt/0.45-1
Date: Sat, 06 Jan 2007 15:26:30 +0800
From: Fengguang Wu <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] readahead: context based method: remove readahead_ratio
Content-Disposition: inline; filename=readahead-context-based-method-remove-readahead_ratio.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The context based readahead is pretty conservative by nature,
so do not apply readahead_ratio here.

Signed-off-by: Fengguang Wu <wfg@mail.ustc.edu.cn>

---
 mm/readahead.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

--- linux-2.6.20-rc3-mm1.orig/mm/readahead.c
+++ linux-2.6.20-rc3-mm1/mm/readahead.c
@@ -1236,9 +1236,7 @@ static unsigned long count_history_pages
 	 * Check the far pages coarsely.
 	 * The enlarged count will contribute to the look-ahead size.
 	 */
-	lookback = ra_max * (LOOKAHEAD_RATIO + 1) *
-						100 / (readahead_ratio | 1);
-
+	lookback = ra_max * LOOKAHEAD_RATIO;
 	for (count += ra_max; count < lookback; count += ra_max)
 		if (!__probe_page(mapping, offset - count))
 			break;
@@ -1384,7 +1382,8 @@ has_history_pages:
 		adjust_rala_aggressive(ra_max, &ra_size, &la_size);
 		ra_set_class(ra, RA_CLASS_CONTEXT_AGGRESSIVE);
 	} else {
-		ra_size = max(ra_min, ra_size * readahead_ratio / 100);
+		if (ra_size < ra_min)
+		    ra_size = ra_min;
 		if (!adjust_rala(ra_max, &ra_size, &la_size))
 			return -1;
 		ra_set_class(ra, RA_CLASS_CONTEXT);

--
