Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933321AbWFZWln@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933321AbWFZWln (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:41:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933319AbWFZWlU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:41:20 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:37047 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933321AbWFZWlO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:41:14 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 02/28] [Suspend2] Close a bdev used by the swapwriter.
Date: Tue, 27 Jun 2006 08:41:12 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626224111.4975.50748.stgit@nigel.suspend2.net>
In-Reply-To: <20060626224105.4975.90758.stgit@nigel.suspend2.net>
References: <20060626224105.4975.90758.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Release a bdev used by the swapwriter.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/suspend_swap.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend_swap.c b/kernel/power/suspend_swap.c
index 7732a75..8a58b12 100644
--- a/kernel/power/suspend_swap.c
+++ b/kernel/power/suspend_swap.c
@@ -87,3 +87,19 @@ struct bdev_opened
  */
 static struct bdev_opened *bdev_info_list[MAX_SWAPFILES + 2];
        
+static void close_bdev(int i)
+{
+	struct bdev_opened *this = bdev_info_list[i];
+
+	if (this->claimed)
+		bd_release(this->bdev);
+
+	/* Release our reference. */
+	blkdev_put(this->bdev);
+
+	/* Free our info. */
+	kfree(this);
+
+	bdev_info_list[i] = NULL;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
