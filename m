Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751081AbWF0FIo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751081AbWF0FIo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 01:08:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030667AbWF0Ei6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 00:38:58 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:33238 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S1030658AbWF0Eim
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 00:38:42 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 11/12] [Suspend2] Encryption module accessors structure.
Date: Tue, 27 Jun 2006 14:38:41 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060627043839.14437.12900.stgit@nigel.suspend2.net>
In-Reply-To: <20060627043803.14437.68085.stgit@nigel.suspend2.net>
References: <20060627043803.14437.68085.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add the struct that lets the encryption functions be used by the core.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/encryption.c |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/kernel/power/encryption.c b/kernel/power/encryption.c
index 4e309e3..8f544ff 100644
--- a/kernel/power/encryption.c
+++ b/kernel/power/encryption.c
@@ -482,3 +482,24 @@ static struct suspend_proc_data proc_par
 	
 };
 
+/*
+ * Ops structure.
+ */
+
+static struct suspend_module_ops suspend_encryption_ops = {
+	.type			= FILTER_MODULE,
+	.name			= "Encryptor",
+	.module			= THIS_MODULE,
+	.memory_needed 		= suspend_encrypt_memory_needed,
+	.print_debug_info	= suspend_encrypt_print_debug_stats,
+	.save_config_info	= suspend_encrypt_save_config_info,
+	.load_config_info	= suspend_encrypt_load_config_info,
+	.storage_needed		= suspend_encrypt_storage_needed,
+	
+	.rw_init		= suspend_encrypt_rw_init,
+	.rw_cleanup		= suspend_encrypt_rw_cleanup,
+
+	.write_chunk		= suspend_encrypt_write_chunk,
+	.read_chunk		= suspend_encrypt_read_chunk,
+};
+

--
Nigel Cunningham		nigel at suspend2 dot net
