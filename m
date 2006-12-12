Return-Path: <linux-kernel-owner+w=401wt.eu-S1751211AbWLLKhY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211AbWLLKhY (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 05:37:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751213AbWLLKhY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 05:37:24 -0500
Received: from nigel.suspend2.net ([203.171.70.205]:47387 "EHLO
	nigel.suspend2.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751211AbWLLKhX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 05:37:23 -0500
Subject: [PATCH] Fix swapped parameters in mm/vmscan.c.
From: Nigel Cunningham <nigel@suspend2.net>
Reply-To: nigel@suspend2.net
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Tue, 12 Dec 2006 21:37:18 +1100
Message-Id: <1165919838.31777.49.camel@nigel.suspend2.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The version of mm/vmscan.c in Linus' current tree has swapped parameters
in the shrink_all_zones declaration and call, used by the various
suspend-to-disk implementations. This doesn't seem to have any great
adverse effect, but it's clearly wrong.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

diff -ruNp 930-vmscan.patch-old/mm/vmscan.c 930-vmscan.patch-new/mm/vmscan.c
--- 930-vmscan.patch-old/mm/vmscan.c	2006-12-12 12:24:05.000000000 +1100
+++ 930-vmscan.patch-new/mm/vmscan.c	2006-12-12 12:23:52.000000000 +1100
@@ -1443,8 +1443,8 @@ void wakeup_kswapd(struct zone *zone, in
  *
  * For pass > 3 we also try to shrink the LRU lists that contain a few pages
  */
-static unsigned long shrink_all_zones(unsigned long nr_pages, int pass,
-				      int prio, struct scan_control *sc)
+static unsigned long shrink_all_zones(unsigned long nr_pages, int prio,
+				      int pass, struct scan_control *sc)
 {
 	struct zone *zone;
 	unsigned long nr_to_scan, ret = 0;


