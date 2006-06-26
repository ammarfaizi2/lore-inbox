Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933316AbWFZWx0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933316AbWFZWx0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:53:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933331AbWFZWwi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:52:38 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:37559 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933316AbWFZWlR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:41:17 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 03/28] [Suspend2] Close bdevs opened by the swapwriter.
Date: Tue, 27 Jun 2006 08:41:16 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626224114.4975.48247.stgit@nigel.suspend2.net>
In-Reply-To: <20060626224105.4975.90758.stgit@nigel.suspend2.net>
References: <20060626224105.4975.90758.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Close bdevs opened by the swapwriter and clear the resume_block_device and
header_block_device.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/suspend_swap.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend_swap.c b/kernel/power/suspend_swap.c
index 8a58b12..6f87a4a 100644
--- a/kernel/power/suspend_swap.c
+++ b/kernel/power/suspend_swap.c
@@ -103,3 +103,14 @@ static void close_bdev(int i)
 	bdev_info_list[i] = NULL;
 }
 
+static void close_bdevs(void)
+{
+	int i;
+
+	for (i = 0; i < MAX_SWAPFILES; i++)
+		if (bdev_info_list[i])
+			close_bdev(i);
+
+	resume_block_device = header_block_device = NULL;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
