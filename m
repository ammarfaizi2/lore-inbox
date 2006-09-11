Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751179AbWIKHoE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751179AbWIKHoE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 03:44:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751170AbWIKHoA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 03:44:00 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:1249 "EHLO e36.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751165AbWIKHn7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 03:43:59 -0400
From: Balbir Singh <balbir@in.ibm.com>
To: akpm@osdl.org
Cc: Jamal Hadi <hadi@cyberus.ca>, Shailabh Nagar <nagar@watson.ibm.com>,
       Thomas Graf <tgraf@suug.ch>, netdev@vger.kernel.org,
       Balbir Singh <balbir@in.ibm.com>, linux-kernel@vger.kernel.org
Date: Mon, 11 Sep 2006 13:10:21 +0530
Message-Id: <20060911074021.26844.70576.sendpatchset@localhost.localdomain>
Subject: [RFC][PATCH -mm] Add genetlink utilities for payload length calculation
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Add two utility helper functions genlmsg_msg_size() and genlmsg_total_size().
These functions are derived from their netlink counterparts.

Signed-off-by: Balbir Singh <balbir@in.ibm.com>
---

 include/net/genetlink.h |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+)

diff -puN include/net/genetlink.h~genetlink-payload-size-helpers include/net/genetlink.h
--- linux-2.6.18-rc6/include/net/genetlink.h~genetlink-payload-size-helpers	2006-09-11 10:34:56.000000000 +0530
+++ linux-2.6.18-rc6-balbir/include/net/genetlink.h	2006-09-11 11:42:37.000000000 +0530
@@ -171,4 +171,22 @@ static inline int genlmsg_len(const stru
 	return (nlh->nlmsg_len - GENL_HDRLEN - NLMSG_HDRLEN);
 }
 
+/**
+ * genlmsg_msg_size - length of genetlink message not including padding
+ * @payload: length of message payload
+ */
+static inline int genlmsg_msg_size(int payload)
+{
+	return GENL_HDRLEN + payload;
+}
+
+/**
+ * genlmsg_total_size - length of genetlink message including padding
+ * @payload: length of message payload
+ */
+static inline int genlmsg_total_size(int payload)
+{
+	return NLMSG_ALIGN(genlmsg_msg_size(payload));
+}
+
 #endif	/* __NET_GENERIC_NETLINK_H */
_

-- 

	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
