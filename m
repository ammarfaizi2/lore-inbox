Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262111AbVGFCvB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262111AbVGFCvB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 22:51:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262098AbVGFCsr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 22:48:47 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:9369 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S262071AbVGFCTZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 22:19:25 -0400
Subject: [PATCH] [26/48] Suspend2 2.1.9.8 for 2.6.12: 603-suspend2_common-headers.patch
In-Reply-To: <11206164393426@foobar.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 6 Jul 2005 12:20:42 +1000
Message-Id: <11206164424053@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Nigel Cunningham <nigel@suspend2.net>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Nigel Cunningham <nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -ruNp 604-utility-header.patch-old/kernel/power/suspend2_core/utility.c 604-utility-header.patch-new/kernel/power/suspend2_core/utility.c
--- 604-utility-header.patch-old/kernel/power/suspend2_core/utility.c	1970-01-01 10:00:00.000000000 +1000
+++ 604-utility-header.patch-new/kernel/power/suspend2_core/utility.c	2005-07-05 23:48:59.000000000 +1000
@@ -0,0 +1,46 @@
+/*
+ * kernel/power/utility.c
+ *
+ * Copyright (C) 2004-2005 Nigel Cunningham <nigel@suspend2.net>
+ * 
+ * This file is released under the GPLv2.
+ *
+ * Routines that only suspend uses at the moment, but which might move
+ * when we merge because they're generic.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mm.h>
+#include <linux/proc_fs.h>
+#include <asm/string.h>
+
+#include "pageflags.h"
+
+/*
+ * suspend_snprintf
+ *
+ * Functionality    : Print a string with parameters to a buffer of a 
+ *                    limited size. Unlike vsnprintf, we return the number
+ *                    of bytes actually put in the buffer, not the number
+ *                    that would have been put in if it was big enough.
+ */
+int suspend_snprintf(char * buffer, int buffer_size, const char *fmt, ...)
+{
+	int result;
+	va_list args;
+
+	if (!buffer_size) {
+		return 0;
+	}
+
+	va_start(args, fmt);
+	result = vsnprintf(buffer, buffer_size, fmt, args);
+	va_end(args);
+
+	if (result > buffer_size) {
+		return buffer_size;
+	}
+
+	return result;
+}
diff -ruNp 604-utility-header.patch-old/kernel/power/suspend2_core/utility.h 604-utility-header.patch-new/kernel/power/suspend2_core/utility.h
--- 604-utility-header.patch-old/kernel/power/suspend2_core/utility.h	1970-01-01 10:00:00.000000000 +1000
+++ 604-utility-header.patch-new/kernel/power/suspend2_core/utility.h	2005-07-05 23:48:59.000000000 +1000
@@ -0,0 +1,12 @@
+/*
+ * kernel/power/suspend2_core/utility.h
+ *
+ * Copyright (C) 2004-2005 Nigel Cunningham <nigel@suspend2.net>
+ * 
+ * This file is released under the GPLv2.
+ *
+ * Routines that only suspend uses at the moment, but which might move
+ * when we merge because they're generic.
+ */
+
+extern int suspend_snprintf(char * buffer, int buffer_size, const char *fmt, ...);

