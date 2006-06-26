Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030208AbWFZXCO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030208AbWFZXCO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 19:02:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933267AbWFZWj5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:39:57 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:18615 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933253AbWFZWjL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:39:11 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 02/35] [Suspend2] Filewriter set_devinfo patch.
Date: Tue, 27 Jun 2006 08:39:10 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223908.4685.39200.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223902.4685.52543.stgit@nigel.suspend2.net>
References: <20060626223902.4685.52543.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tell the block io routines which device and blocks to use.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/suspend_file.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend_file.c b/kernel/power/suspend_file.c
index 525e482..36db6b8 100644
--- a/kernel/power/suspend_file.c
+++ b/kernel/power/suspend_file.c
@@ -94,3 +94,14 @@ enum {
 	MARK_RESUME_ATTEMPTED,
 };
 
+static void set_devinfo(struct block_device *bdev, int target_blkbits)
+{
+	devinfo.bdev = bdev;
+	if (!target_blkbits) {
+		devinfo.bmap_shift = devinfo.blocks_per_page = 0;
+	} else {
+		devinfo.bmap_shift = target_blkbits - 9;
+		devinfo.blocks_per_page = (1 << (PAGE_SHIFT - target_blkbits));
+	}
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
