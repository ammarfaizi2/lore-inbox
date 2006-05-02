Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932396AbWEBGTp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932396AbWEBGTp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 02:19:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932395AbWEBGTp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 02:19:45 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:27010 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932396AbWEBGTo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 02:19:44 -0400
Date: Tue, 2 May 2006 11:46:49 +0530
From: Balbir Singh <balbir@in.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: lse-tech@lists.sourceforge.net, jlan@engr.sgi.com, Jamal <hadi@cyberus.ca>,
       Thomas Graf <tgraf@suug.ch>, netdev <netdev@vger.kernel.org>
Subject: [Patch 4/8] Utilities for genetlink usage
Message-ID: <20060502061649.GA22607@in.ibm.com>
Reply-To: balbir@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


genetlink-utils.patch

Two utilities for simplifying usage of NETLINK_GENERIC
interface.

Signed-off-by: Balbir Singh <balbir@in.ibm.com>
Signed-off-by: Shailabh Nagar <nagar@watson.ibm.com>
---

 include/net/genetlink.h |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+)

diff -puN include/net/genetlink.h~genetlink-utils include/net/genetlink.h
--- linux-2.6.17-rc3/include/net/genetlink.h~genetlink-utils	2006-05-02 07:35:15.000000000 +0530
+++ linux-2.6.17-rc3-balbir/include/net/genetlink.h	2006-05-02 07:35:52.000000000 +0530
@@ -150,4 +150,24 @@ static inline int genlmsg_unicast(struct
 	return nlmsg_unicast(genl_sock, skb, pid);
 }
 
+/**
+ * gennlmsg_data - head of message payload
+ * @gnlh: genetlink messsage header
+ */
+static inline void *genlmsg_data(const struct genlmsghdr *gnlh)
+{
+	return ((unsigned char *) gnlh + GENL_HDRLEN);
+}
+
+/**
+ * genlmsg_len - length of message payload
+ * @gnlh: genetlink message header
+ */
+static inline int genlmsg_len(const struct genlmsghdr *gnlh)
+{
+	struct nlmsghdr *nlh = (struct nlmsghdr *)((unsigned char *)gnlh -
+							NLMSG_HDRLEN);
+	return (nlh->nlmsg_len - GENL_HDRLEN - NLMSG_HDRLEN);
+}
+
 #endif	/* __NET_GENERIC_NETLINK_H */
_
