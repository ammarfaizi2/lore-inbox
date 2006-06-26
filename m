Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933255AbWFZXNF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933255AbWFZXNF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 19:13:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933246AbWFZXMi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 19:12:38 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:64927 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933219AbWFZWi1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:38:27 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 22/32] [Suspend2] Move forward extra blocks in a page.
Date: Tue, 27 Jun 2006 08:38:25 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223824.4376.64646.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223706.4376.96042.stgit@nigel.suspend2.net>
References: <20060626223706.4376.96042.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shift the pointer to the current block forward (n-1) blocks, where n is the
blocks per page used for this device.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/suspend_block_io.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend_block_io.c b/kernel/power/suspend_block_io.c
index 3902758..fbce186 100644
--- a/kernel/power/suspend_block_io.c
+++ b/kernel/power/suspend_block_io.c
@@ -780,3 +780,19 @@ static void suspend_set_devinfo(struct s
 	suspend_devinfo = info;
 }
 
+static int forward_extra_blocks(void)
+{
+	int i;
+
+	for (i = 1; i < suspend_devinfo[suspend_writer_posn.current_chain].
+							blocks_per_page; i++)
+		suspend_extent_state_next(&suspend_writer_posn);
+
+	if (suspend_extent_state_eof(&suspend_writer_posn)) {
+		printk("Extent state eof.\n");
+		return -ENODATA;
+	}
+
+	return 0;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
