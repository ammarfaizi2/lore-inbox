Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267542AbTBXVid>; Mon, 24 Feb 2003 16:38:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267545AbTBXVic>; Mon, 24 Feb 2003 16:38:32 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:64995 "EHLO
	mtvmime01.veritas.com") by vger.kernel.org with ESMTP
	id <S267542AbTBXVic>; Mon, 24 Feb 2003 16:38:32 -0500
Date: Mon, 24 Feb 2003 21:50:29 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: Nick Piggin <piggin@cyberone.com.au>, <linux-kernel@vger.kernel.org>
Subject: anticipation is killing me
Message-ID: <Pine.LNX.4.44.0302242142570.1343-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With 2.5.62-mm3 (not -mm2) I need small patch to can_start_anticipation.
I've not studied the code, this patch may be the worst nonsense; and if
it's at all mysterious to you, sorry, I probably won't be able to give
more info until tomorrow...

Hugh

--- 2.5.62-mm3/drivers/block/as-iosched.c	Mon Feb 24 12:29:49 2003
+++ linux/drivers/block/as-iosched.c	Mon Feb 24 21:38:39 2003
@@ -856,7 +856,8 @@
 		 */
 		del_timer(&ad->antic_timer);
 		ad->antic_status = ANTIC_FINISHED;
-		blk_remove_plug(arq->request->q);
+		if (arq)
+			blk_remove_plug(arq->request->q);
 		schedule_work(&ad->antic_work);
 		return 0;
 	}

