Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933260AbWFZXJ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933260AbWFZXJ0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 19:09:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933244AbWFZXJH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 19:09:07 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:17079 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933260AbWFZWjC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:39:02 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 32/32] [Suspend2] Module ops for the block i/o functions.
Date: Tue, 27 Jun 2006 08:39:00 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223859.4376.33360.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223706.4376.96042.stgit@nigel.suspend2.net>
References: <20060626223706.4376.96042.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Structure defining ops for the block io code, and the routines to register
and deregister them.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/suspend_block_io.c |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend_block_io.c b/kernel/power/suspend_block_io.c
index 9339826..2d9a2f0 100644
--- a/kernel/power/suspend_block_io.c
+++ b/kernel/power/suspend_block_io.c
@@ -1055,3 +1055,30 @@ struct suspend_bio_ops suspend_bio_ops =
 	.write_header_chunk_finish = write_header_chunk_finish,
 };
 
+static struct suspend_module_ops suspend_blockwriter_ops = 
+{
+	.name					= "Block I/O",
+	.type					= MISC_MODULE,
+	.module					= THIS_MODULE,
+	.memory_needed				= suspend_bio_memory_needed,
+};
+
+static __init int suspend_block_io_load(void)
+{
+	return suspend_register_module(&suspend_blockwriter_ops);
+}
+
+#ifdef MODULE
+static __exit void suspend_block_io_unload(void)
+{
+	suspend_unregister_module(&suspend_blockwriter_ops);
+}
+
+module_init(suspend_block_io_load);
+module_exit(suspend_block_io_unload);
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Nigel Cunningham");
+MODULE_DESCRIPTION("Suspend2 block io functions");
+#else
+late_initcall(suspend_block_io_load);
+#endif

--
Nigel Cunningham		nigel at suspend2 dot net
