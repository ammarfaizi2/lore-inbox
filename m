Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751236AbWDVVUN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751236AbWDVVUN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 17:20:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751234AbWDVVTv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 17:19:51 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:17372 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751236AbWDVVTr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 17:19:47 -0400
Message-ID: <4449967E.2050604@watson.ibm.com>
Date: Fri, 21 Apr 2006 22:35:42 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: LSE <lse-tech@lists.sourceforge.net>, Jay Lan <jlan@engr.sgi.com>,
       Jamal <hadi@cyberus.ca>, Thomas Graf <tgraf@suug.ch>,
       netdev <netdev@vger.kernel.org>
Subject: [Patch 4/8] Utilities for genetlink usage
References: <444991EF.3080708@watson.ibm.com>
In-Reply-To: <444991EF.3080708@watson.ibm.com>
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

Index: linux-2.6.17-rc1/include/net/genetlink.h
===================================================================
--- linux-2.6.17-rc1.orig/include/net/genetlink.h	2006-04-21 19:39:29.000000000 -0400
+++ linux-2.6.17-rc1/include/net/genetlink.h	2006-04-21 20:29:19.000000000 -0400
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
