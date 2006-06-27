Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030671AbWF0Eix@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030671AbWF0Eix (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 00:38:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030661AbWF0Eik
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 00:38:40 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:31702 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S1030658AbWF0Eib
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 00:38:31 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 08/12] [Suspend2] Encryption resources needed.
Date: Tue, 27 Jun 2006 14:38:30 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060627043828.14437.24057.stgit@nigel.suspend2.net>
In-Reply-To: <20060627043803.14437.68085.stgit@nigel.suspend2.net>
References: <20060627043803.14437.68085.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add routines to return the amount of memory and header storage needed for
the encryption module.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/encryption.c |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/kernel/power/encryption.c b/kernel/power/encryption.c
index 25db7ba..d12eb47 100644
--- a/kernel/power/encryption.c
+++ b/kernel/power/encryption.c
@@ -297,3 +297,23 @@ static int suspend_encrypt_print_debug_s
 	return len;
 }
 
+/* encryption_memory_needed
+ *
+ * Description:	Tell the caller how much memory we need to operate during
+ * 		suspend/resume.
+ * Returns:	Unsigned long. Maximum number of bytes of memory required for
+ * 		operation.
+ */
+static unsigned long suspend_encrypt_memory_needed(void)
+{
+	return PAGE_SIZE;
+}
+
+static unsigned long suspend_encrypt_storage_needed(void)
+{
+	return 4 + strlen(suspend_encryptor_name) +
+		(suspend_encryptor_save_key_and_iv ?
+		 (4 + strlen(suspend_encryptor_key) +
+		  strlen(suspend_encryptor_iv)) : 0);
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
