Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030687AbWF0Ejt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030687AbWF0Ejt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 00:39:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030654AbWF0EiQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 00:38:16 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:26582 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S1030630AbWF0Eh7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 00:37:59 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 12/13] [Suspend2] Compression operations structure.
Date: Tue, 27 Jun 2006 14:37:58 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060627043756.14320.81165.stgit@nigel.suspend2.net>
In-Reply-To: <20060627043716.14320.30977.stgit@nigel.suspend2.net>
References: <20060627043716.14320.30977.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add the compression ops structure, which provides the core (or previous
module in the pipeline) with access to the compression functions.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/compression.c |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/kernel/power/compression.c b/kernel/power/compression.c
index 54d54a9..4f0f82e 100644
--- a/kernel/power/compression.c
+++ b/kernel/power/compression.c
@@ -520,3 +520,23 @@ static struct suspend_proc_data proc_par
 }
 };
 
+/*
+ * Ops structure.
+ */
+static struct suspend_module_ops suspend_compression_ops = {
+	.type			= FILTER_MODULE,
+	.name			= "Suspend2 Compressor",
+	.module			= THIS_MODULE,
+	.memory_needed 		= suspend_compress_memory_needed,
+	.print_debug_info	= suspend_compress_print_debug_stats,
+	.save_config_info	= suspend_compress_save_config_info,
+	.load_config_info	= suspend_compress_load_config_info,
+	.storage_needed		= suspend_compress_storage_needed,
+	
+	.rw_init		= suspend_compress_rw_init,
+	.rw_cleanup		= suspend_compress_rw_cleanup,
+
+	.write_chunk		= suspend_compress_write_chunk,
+	.read_chunk		= suspend_compress_read_chunk,
+};
+

--
Nigel Cunningham		nigel at suspend2 dot net
