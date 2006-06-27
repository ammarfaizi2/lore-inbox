Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030705AbWF0EnH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030705AbWF0EnH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 00:43:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030706AbWF0EnF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 00:43:05 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:57819 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S1030702AbWF0Em6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 00:42:58 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 09/13] [Suspend2] Reset kswapd_max_order after resume.
Date: Tue, 27 Jun 2006 14:42:57 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060627044255.15066.58201.stgit@nigel.suspend2.net>
In-Reply-To: <20060627044226.15066.7403.stgit@nigel.suspend2.net>
References: <20060627044226.15066.7403.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reset the kswapd_max_order value to zero after resume so that we don't get
a swap storm.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 mm/vmscan.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 440a733..b6a5a0d 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1244,7 +1244,8 @@ static int kswapd(void *p)
 	for ( ; ; ) {
 		unsigned long new_order;
 
-		try_to_freeze();
+		if (try_to_freeze())
+			pgdat->kswapd_max_order = 0;
 
 		prepare_to_wait(&pgdat->kswapd_wait, &wait, TASK_INTERRUPTIBLE);
 		new_order = pgdat->kswapd_max_order;

--
Nigel Cunningham		nigel at suspend2 dot net
