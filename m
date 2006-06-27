Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932579AbWF0FEL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932579AbWF0FEL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 01:04:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932261AbWF0FDW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 01:03:22 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:28123 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S1030686AbWF0Ejp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 00:39:45 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 06/13] [Suspend2] Tell userui whether debugging is enabled.
Date: Tue, 27 Jun 2006 14:39:44 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060627043942.14630.16220.stgit@nigel.suspend2.net>
In-Reply-To: <20060627043923.14630.565.stgit@nigel.suspend2.net>
References: <20060627043923.14630.565.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Send a netlink message to the userspace ui component (if any), notifying it
as to whether debugging support is enabled.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/netlink.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/kernel/power/netlink.c b/kernel/power/netlink.c
index 696009d..0aaf90e 100644
--- a/kernel/power/netlink.c
+++ b/kernel/power/netlink.c
@@ -115,3 +115,15 @@ nlmsg_failure:
 		put_skb(uhd, skb);
 }
 
+#ifdef CONFIG_PM_DEBUG
+static int is_debugging = 1;
+#else
+static int is_debugging = 0;
+#endif
+
+static void send_whether_debugging(struct user_helper_data *uhd)
+{
+	suspend_send_netlink_message(uhd, NETLINK_MSG_IS_DEBUGGING,
+			&is_debugging, sizeof(int));
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
