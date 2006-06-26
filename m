Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751277AbWFZXJF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751277AbWFZXJF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 19:09:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933226AbWFZWjH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:39:07 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:65439 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933249AbWFZWia
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:38:30 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 23/32] [Suspend2] Advance one page in the extent state.
Date: Tue, 27 Jun 2006 08:38:28 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223827.4376.14290.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223706.4376.96042.stgit@nigel.suspend2.net>
References: <20060626223706.4376.96042.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Advance one page in the list of devices and blocks (extent state).

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/suspend_block_io.c |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend_block_io.c b/kernel/power/suspend_block_io.c
index fbce186..fdbbe4b 100644
--- a/kernel/power/suspend_block_io.c
+++ b/kernel/power/suspend_block_io.c
@@ -796,3 +796,22 @@ static int forward_extra_blocks(void)
 	return 0;
 }
 
+static int forward_one_page(void)
+{
+	int at_start = (suspend_writer_posn.current_chain == -1);
+
+	/* Have to go forward one to ensure we're on the right chain,
+	 * before we can know how many more blocks to skip.*/
+	suspend_extent_state_next(&suspend_writer_posn);
+
+	if (!at_start)
+		if (forward_extra_blocks())
+			return -ENODATA;
+
+	if (extra_page_forward) {
+		extra_page_forward = 0;
+		return forward_one_page();
+	}
+
+	return 0;
+}

--
Nigel Cunningham		nigel at suspend2 dot net
