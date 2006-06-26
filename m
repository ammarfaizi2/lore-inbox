Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933250AbWFZXSF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933250AbWFZXSF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 19:18:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933216AbWFZWhZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:37:25 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:53151 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933214AbWFZWhF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:37:05 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 19/19] [Suspend2] I/O header file.
Date: Tue, 27 Jun 2006 08:37:03 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223701.4219.8154.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223557.4219.53030.stgit@nigel.suspend2.net>
References: <20060626223557.4219.53030.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Header file for core I/O functions.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/io.h |   46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 46 insertions(+), 0 deletions(-)

diff --git a/kernel/power/io.h b/kernel/power/io.h
new file mode 100644
index 0000000..55df2ed
--- /dev/null
+++ b/kernel/power/io.h
@@ -0,0 +1,46 @@
+/*
+ * kernel/power/io.h
+ *
+ * Copyright (C) 2005-2006 Nigel Cunningham <nigel@suspend2.net>
+ *
+ * This file is released under the GPLv2.
+ *
+ * It contains high level IO routines for suspending.
+ *
+ */
+
+#include "pagedir.h"
+
+/* Non-module data saved in our image header */
+struct suspend_header {
+	u32 version_code;
+	unsigned long num_physpages;
+	unsigned long orig_mem_free;
+	char machine[65];
+	char version[65];
+	int num_cpus;
+	int page_size;
+	int pageset_2_size;
+	int param0;
+	int param1;
+	int param2;
+	int param3;
+	int progress0;
+	int progress1;
+	int progress2;
+	int progress3;
+	int io_time[2][2];
+	struct pagedir pagedir;
+	dev_t root_fs;
+};
+
+extern int write_pageset(struct pagedir *pagedir, int whichtowrite);
+extern int write_image_header(void);
+extern int read_pageset1(void);
+extern int read_pageset2(int overwrittenpagesonly);
+
+extern int suspend_attempt_to_parse_resume_device(void);
+extern void attempt_to_parse_resume_device2(void);
+extern dev_t name_to_dev_t(char *line);
+extern __nosavedata unsigned long bytes_in, bytes_out;
+extern char *get_have_image_data(void);

--
Nigel Cunningham		nigel at suspend2 dot net
