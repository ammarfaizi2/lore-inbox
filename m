Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751317AbWC3AtL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751317AbWC3AtL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 19:49:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbWC3AtL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 19:49:11 -0500
Received: from mtagate4.uk.ibm.com ([195.212.29.137]:1807 "EHLO
	mtagate4.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1751317AbWC3AtJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 19:49:09 -0500
Message-ID: <442B2AF4.1020302@watson.ibm.com>
Date: Wed, 29 Mar 2006 19:48:52 -0500
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: netdev <netdev@vger.kernel.org>, Thomas Graf <tgraf@suug.ch>,
       Jamal <hadi@cyberus.ca>
Subject: [Patch 4/8] generic netlink utility functions
References: <442B271D.10208@watson.ibm.com>
In-Reply-To: <442B271D.10208@watson.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
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

Index: linux-2.6.16/include/net/genetlink.h
===================================================================
--- linux-2.6.16.orig/include/net/genetlink.h	2006-03-29 18:12:54.000000000 -0500
+++ linux-2.6.16/include/net/genetlink.h	2006-03-29 18:13:17.000000000 -0500
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

