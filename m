Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751157AbWF0FCq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157AbWF0FCq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 01:02:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750795AbWF0FCQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 01:02:16 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:31707 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933398AbWF0EkI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 00:40:08 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 13/13] [Suspend2] Netlink header.
Date: Tue, 27 Jun 2006 14:40:07 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060627044006.14630.94937.stgit@nigel.suspend2.net>
In-Reply-To: <20060627043923.14630.565.stgit@nigel.suspend2.net>
References: <20060627043923.14630.565.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Header file describing userspace helper data, generic message numbers and
exported functions.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/netlink.h |   59 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 59 insertions(+), 0 deletions(-)

diff --git a/kernel/power/netlink.h b/kernel/power/netlink.h
new file mode 100644
index 0000000..e55533a
--- /dev/null
+++ b/kernel/power/netlink.h
@@ -0,0 +1,59 @@
+/*
+ * kernel/power/netlink.h
+ *
+ * Copyright (C) 2004-2006 Nigel Cunningham <nigel@suspend2.net>
+ *
+ * This file is released under the GPLv2.
+ *
+ * Declarations for functions for communicating with a userspace helper
+ * via netlink.
+ */
+
+#include <linux/netlink.h>
+#include <net/sock.h>
+
+#define NETLINK_MSG_BASE 0x10
+
+#define NETLINK_MSG_READY 0x10
+#define	NETLINK_MSG_NOFREEZE_ME 0x16
+#define NETLINK_MSG_GET_DEBUGGING 0x19
+#define NETLINK_MSG_CLEANUP 0x24
+#define NETLINK_MSG_NOFREEZE_ACK 0x27
+#define NETLINK_MSG_IS_DEBUGGING 0x28
+
+struct user_helper_data {
+	int (*rcv_msg) (struct sk_buff *skb, struct nlmsghdr *nlh);
+	void (* not_ready) (void);
+	struct sock *nl;
+	u32 sock_seq;
+	pid_t pid;
+	char *comm;
+	char program[256];
+	int pool_level;
+	int pool_limit;
+	struct sk_buff *emerg_skbs;
+	int skb_size;
+	int netlink_id;	
+	char *name;
+	struct user_helper_data *next;
+	struct completion wait_for_process;
+	int interface_version;
+	int must_init;
+};
+
+
+#ifdef CONFIG_NET
+int suspend_netlink_setup(struct user_helper_data *uhd);
+void suspend_netlink_close(struct user_helper_data *uhd);
+void suspend_send_netlink_message(struct user_helper_data *uhd,
+		int type, void* params, size_t len);
+#else
+static inline int suspend_netlink_setup(struct user_helper_data *uhd)
+{
+	return 0;
+}
+
+static inline void suspend_netlink_close(struct user_helper_data *uhd) { };
+static inline void suspend_send_netlink_message(struct user_helper_data *uhd,
+		int type, void* params, size_t len) { };
+#endif

--
Nigel Cunningham		nigel at suspend2 dot net
