Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030695AbWF0ErZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030695AbWF0ErZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 00:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030700AbWF0Em2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 00:42:28 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:52699 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S1030694AbWF0EmZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 00:42:25 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 21/21] [Suspend2] kernel/power/ui.h
Date: Tue, 27 Jun 2006 14:42:24 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060627044222.14883.76347.stgit@nigel.suspend2.net>
In-Reply-To: <20060627044112.14883.55823.stgit@nigel.suspend2.net>
References: <20060627044112.14883.55823.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Userspace user interface header file.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/ui.h |   71 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 71 insertions(+), 0 deletions(-)

diff --git a/kernel/power/ui.h b/kernel/power/ui.h
new file mode 100644
index 0000000..8b295e2
--- /dev/null
+++ b/kernel/power/ui.h
@@ -0,0 +1,71 @@
+/*
+ * kernel/power/ui.h
+ *
+ * Copyright 2004-2006 Nigel Cunningham <nigel@suspend2.net>
+ */
+
+extern int suspend_default_console_level;
+
+enum {
+	DONT_CLEAR_BAR,
+	CLEAR_BAR
+};
+
+enum {
+	/* Userspace -> Kernel */
+	USERUI_MSG_ABORT = 0x11,
+	USERUI_MSG_SET_STATE = 0x12,
+	USERUI_MSG_GET_STATE = 0x13,
+	USERUI_MSG_GET_DEBUG_STATE = 0x14,
+	USERUI_MSG_SET_DEBUG_STATE = 0x15,
+	USERUI_MSG_SET_PROGRESS_GRANULARITY = 0x17,
+	USERUI_MSG_SPACE = 0x18,
+
+	/* Kernel -> Userspace */
+	USERUI_MSG_MESSAGE = 0x21,
+	USERUI_MSG_PROGRESS = 0x22,
+	USERUI_MSG_REDRAW = 0x25,
+	USERUI_MSG_KEYPRESS = 0x26,
+	USERUI_MSG_DEBUG_STATE = 0x29,
+
+	USERUI_MSG_MAX,
+};
+
+struct userui_msg_params {
+	unsigned long a, b, c, d;
+	char text[255];
+};
+
+#if defined(CONFIG_NET)
+
+extern unsigned long suspend_update_status(unsigned long value, unsigned long maximum,
+		const char *fmt, ...);
+extern void suspend_prepare_status (int clearbar, const char *fmt, ...);
+extern void suspend_cond_pause(int pause, char *message);
+extern void abort_suspend(const char *fmt, ...);
+extern void suspend_prepare_console(void);
+extern void suspend_cleanup_console(void);
+extern void userui_redraw(void);
+
+#else
+static inline char suspend_wait_for_keypress(int timeout)
+{
+	return 0;
+} 
+
+static inline unsigned long suspend_update_status(unsigned long value, unsigned long maximum,
+		const char *fmt, ...)
+{
+	return maximum;
+} 
+
+static inline void __suspend_message(unsigned long section, unsigned long level,
+		int normally_logged,
+		const char *fmt, ...)  { }
+static inline void suspend_prepare_status(int clearbar, const char *fmt, ...) { }
+static inline void suspend_cond_pause(int pause, char *message) { }
+static inline void abort_suspend(const char *fmt, ...) { }
+static inline void suspend_prepare_console(void) { }
+static inline void suspend_cleanup_console(void) { }
+static inline void userui_redraw(void) { }
+#endif

--
Nigel Cunningham		nigel at suspend2 dot net
