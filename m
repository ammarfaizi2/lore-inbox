Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751284AbWFZXM0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751284AbWFZXM0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 19:12:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933234AbWFZWi2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:38:28 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:63903 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933244AbWFZWiU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:38:20 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 20/32] [Suspend2] Return memory needed for block io.
Date: Tue, 27 Jun 2006 08:38:18 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223817.4376.90024.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223706.4376.96042.stgit@nigel.suspend2.net>
References: <20060626223706.4376.96042.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Return the maximum amount of memory needed for block io.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/suspend_block_io.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend_block_io.c b/kernel/power/suspend_block_io.c
index 555d4fa..6e0f22c 100644
--- a/kernel/power/suspend_block_io.c
+++ b/kernel/power/suspend_block_io.c
@@ -766,3 +766,12 @@ static int suspend_bdev_page_io(int rw, 
 	return suspend_do_io(rw, &submit_info, 1);
 }
 
+static unsigned long suspend_bio_memory_needed(void)
+{
+	/* We want to have at least enough memory so as to have
+	 * MAX_OUTSTANDING_IO transactions on the fly at once. If we 
+	 * can to more, fine. */
+	return (MAX_OUTSTANDING_IO * (PAGE_SIZE + sizeof(struct request) +
+				sizeof(struct bio) + sizeof(struct io_info)));
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
