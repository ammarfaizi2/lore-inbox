Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933266AbWFZXH0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933266AbWFZXH0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 19:07:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933256AbWFZWjK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:39:10 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:16055 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933253AbWFZWiy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:38:54 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 30/32] [Suspend2] Finish writing an image header.
Date: Tue, 27 Jun 2006 08:38:52 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223851.4376.27344.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223706.4376.96042.stgit@nigel.suspend2.net>
References: <20060626223706.4376.96042.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup after writing an image header.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/suspend_block_io.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend_block_io.c b/kernel/power/suspend_block_io.c
index e822b19..f93d985 100644
--- a/kernel/power/suspend_block_io.c
+++ b/kernel/power/suspend_block_io.c
@@ -1028,3 +1028,10 @@ static int suspend_rw_header_chunk(int r
 	return rw ? 0 : buffer_size;
 }
 
+static int write_header_chunk_finish(void)
+{
+	return suspend_rw_page(WRITE,
+		virt_to_page(suspend_writer_buffer),
+		-1, 0, test_debug_state(SUSPEND_HEADER)) ? -EIO : 0;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
