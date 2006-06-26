Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933284AbWFZXRb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933284AbWFZXRb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 19:17:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933257AbWFZXQr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 19:16:47 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:58783 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933215AbWFZWho
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:37:44 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 10/32] [Suspend2] Wait on readahead.
Date: Tue, 27 Jun 2006 08:37:42 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223741.4376.64838.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223706.4376.96042.stgit@nigel.suspend2.net>
References: <20060626223706.4376.96042.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wait for the next page of readahead to be complete.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/suspend_block_io.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend_block_io.c b/kernel/power/suspend_block_io.c
index f9c883a..ae45fc3 100644
--- a/kernel/power/suspend_block_io.c
+++ b/kernel/power/suspend_block_io.c
@@ -385,3 +385,18 @@ static void wait_on_one_page(struct io_i
 	do { do_bio_wait(3); } while (io_info->flags);
 }
 
+/*
+ * wait_on_readahead
+ *
+ * Wait until a particular readahead is ready.
+ */
+static void suspend_wait_on_readahead(int readahead_index)
+{
+	int index = readahead_index / BITS_PER_LONG;
+	int bit = readahead_index - index * BITS_PER_LONG;
+
+	/* read_ahead_index is the one we want to return */
+	while (!test_bit(bit, &suspend_readahead_flags[index]))
+		do_bio_wait(6);
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
