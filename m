Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933234AbWFZXMi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933234AbWFZXMi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 19:12:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933214AbWFZWiZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:38:25 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:59295 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933219AbWFZWhr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:37:47 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 11/32] [Suspend2] Test whether readahead is ready.
Date: Tue, 27 Jun 2006 08:37:45 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223744.4376.24603.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223706.4376.96042.stgit@nigel.suspend2.net>
References: <20060626223706.4376.96042.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Determine whether a particular page's readahead has completed.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/suspend_block_io.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend_block_io.c b/kernel/power/suspend_block_io.c
index ae45fc3..f14939e 100644
--- a/kernel/power/suspend_block_io.c
+++ b/kernel/power/suspend_block_io.c
@@ -400,3 +400,17 @@ static void suspend_wait_on_readahead(in
 		do_bio_wait(6);
 }
 
+/*
+ * readahead_done
+ *
+ * Returns whether the readahead requested is ready.
+ */
+
+static int suspend_readahead_ready(int readahead_index)
+{
+	int index = readahead_index / BITS_PER_LONG;
+	int bit = readahead_index - (index * BITS_PER_LONG);
+
+	return test_bit(bit, &suspend_readahead_flags[index]);
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
