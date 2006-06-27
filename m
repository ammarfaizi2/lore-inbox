Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030592AbWF0EhW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030592AbWF0EhW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 00:37:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933389AbWF0EhW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 00:37:22 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:20694 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933312AbWF0EhW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 00:37:22 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 01/13] [Suspend2] Compression File Header
Date: Tue, 27 Jun 2006 14:37:20 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060627043718.14320.97503.stgit@nigel.suspend2.net>
In-Reply-To: <20060627043716.14320.30977.stgit@nigel.suspend2.net>
References: <20060627043716.14320.30977.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the header of the suspend2 modules that implements compression
support, using cryptoapi.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/compression.c |   41 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 41 insertions(+), 0 deletions(-)

diff --git a/kernel/power/compression.c b/kernel/power/compression.c
new file mode 100644
index 0000000..72075d7
--- /dev/null
+++ b/kernel/power/compression.c
@@ -0,0 +1,41 @@
+/*
+ * kernel/power/compression.c
+ *
+ * Copyright (C) 2003-2006 Nigel Cunningham <nigel@suspend2.net>
+ *
+ * This file is released under the GPLv2.
+ *
+ * This file contains data compression routines for suspend,
+ * using cryptoapi.
+ *
+ */
+
+#include <linux/suspend.h>
+#include <linux/module.h>
+#include <linux/highmem.h>
+#include <linux/vmalloc.h>
+#include <linux/crypto.h>
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
+static int suspend_expected_compression = 0;
+
+static struct suspend_module_ops suspend_compression_ops;
+static struct suspend_module_ops *next_driver;
+
+static char suspend_compressor_name[32];
+static struct crypto_tfm *suspend_compressor_transform;
+
+static u8 *local_buffer = NULL;
+static u8 *page_buffer = NULL;
+static unsigned int bufofs;
+
+static int position = 0;
+       

--
Nigel Cunningham		nigel at suspend2 dot net
