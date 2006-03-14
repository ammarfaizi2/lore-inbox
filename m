Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932526AbWCNAzM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932526AbWCNAzM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 19:55:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932527AbWCNAzL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 19:55:11 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:62430 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932521AbWCNAzJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 19:55:09 -0500
Subject: [Patch 8/9] generic netlink utility functions
From: Shailabh Nagar <nagar@watson.ibm.com>
Reply-To: nagar@watson.ibm.com
To: linux-kernel <linux-kernel@vger.kernel.org>,
       netdev <netdev@vger.kernel.org>
Cc: Jamal <hadi@cyberus.ca>
In-Reply-To: <1142296834.5858.3.camel@elinux04.optonline.net>
References: <1142296834.5858.3.camel@elinux04.optonline.net>
Content-Type: text/plain
Organization: IBM
Message-Id: <1142297705.5858.28.camel@elinux04.optonline.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 13 Mar 2006 19:55:05 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

genetlink-utils.patch

Two utilities for simplifying usage of NETLINK_GENERIC
interface.

Signed-off-by: Balbir Singh <balbir@in.ibm.com>
Signed-off-by: Shailabh Nagar <nagar@watson.ibm.com>

 include/net/genetlink.h |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+)

Index: linux-2.6.16-rc5/include/net/genetlink.h
===================================================================
--- linux-2.6.16-rc5.orig/include/net/genetlink.h	2006-03-11 07:41:32.000000000 -0500
+++ linux-2.6.16-rc5/include/net/genetlink.h	2006-03-11 07:41:41.000000000 -0500
@@ -150,4 +150,24 @@ static inline int genlmsg_unicast(struct
 	return nlmsg_unicast(genl_sock, skb, pid);
 }
 
+/**
+ * gennlmsg_data - head of message payload
+ * @gnlh: genetlink messsage header
+ */
+static inline void *genlmsg_data(const struct genlmsghdr *gnlh)
+{
+       return ((unsigned char *) gnlh + GENL_HDRLEN);
+}
+
+/**
+ * genlmsg_len - length of message payload
+ * @gnlh: genetlink message header
+ */
+static inline int genlmsg_len(const struct genlmsghdr *gnlh)
+{
+       struct nlmsghdr *nlh = (struct nlmsghdr *)((unsigned char *)gnlh -
+                                                   NLMSG_HDRLEN);
+       return (nlh->nlmsg_len - GENL_HDRLEN - NLMSG_HDRLEN);
+}
+
 #endif	/* __NET_GENERIC_NETLINK_H */


