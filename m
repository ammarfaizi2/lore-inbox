Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030632AbWF0EiM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030632AbWF0EiM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 00:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030647AbWF0EiL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 00:38:11 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:28118 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S1030637AbWF0EiI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 00:38:08 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 01/12] [Suspend2] Encryption support header
Date: Tue, 27 Jun 2006 14:38:07 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060627043805.14437.49018.stgit@nigel.suspend2.net>
In-Reply-To: <20060627043803.14437.68085.stgit@nigel.suspend2.net>
References: <20060627043803.14437.68085.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add the header for the encryption support file.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/encryption.c |   47 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 47 insertions(+), 0 deletions(-)

diff --git a/kernel/power/encryption.c b/kernel/power/encryption.c
new file mode 100644
index 0000000..a90d3ca
--- /dev/null
+++ b/kernel/power/encryption.c
@@ -0,0 +1,47 @@
+/*
+ * kernel/power/suspend_core/encryption.c
+ *
+ * Copyright (C) 2003-2006 Nigel Cunningham <nigel@suspend2.net>
+ *
+ * This file is released under the GPLv2.
+ *
+ * This file contains data encryption routines for suspend,
+ * using cryptoapi transforms.
+ *
+ * ToDo:
+ * - Apply min/max_keysize the cipher changes.
+ * - Test.
+ */
+
+#include <linux/suspend.h>
+#include <linux/module.h>
+#include <linux/highmem.h>
+#include <linux/vmalloc.h>
+#include <linux/crypto.h>
+#include <asm/scatterlist.h>
+
+#include "suspend2.h"
+#include "modules.h"
+#include "proc.h"
+#include "suspend2_common.h"
+#include "io.h"
+
+#define S2C_WRITE 0
+#define S2C_READ 1
+
+static struct suspend_module_ops suspend_encryption_ops;
+static struct suspend_module_ops *next_driver;
+
+static char suspend_encryptor_name[32];
+static struct crypto_tfm *suspend_encryptor_transform;
+static char suspend_encryptor_key[256];
+static int suspend_key_len;
+static char suspend_encryptor_iv[256];
+static int suspend_encryptor_mode;
+static int suspend_encryptor_save_key_and_iv;
+
+static u8 *page_buffer = NULL;
+static unsigned int bufofs;
+
+static struct scatterlist suspend_crypt_sg[PAGE_SIZE/8];
+       

--
Nigel Cunningham		nigel at suspend2 dot net
