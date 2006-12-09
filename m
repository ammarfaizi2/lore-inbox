Return-Path: <linux-kernel-owner+w=401wt.eu-S1947626AbWLIBd7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947626AbWLIBd7 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 20:33:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947632AbWLIBd6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 20:33:58 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:43017 "EHLO
	sous-sol.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1947626AbWLIBd6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 20:33:58 -0500
Date: Fri, 8 Dec 2006 17:36:09 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: akpm@osdl.org, "Theodore Ts'o" <tytso@mit.edu>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Justin Forbes <jmforbes@linuxtx.org>, torvalds@osdl.org,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Randy Dunlap <rdunlap@xenotime.net>,
       Michael Krufky <mkrufky@linuxtv.org>, Dave Jones <davej@redhat.com>,
       Chuck Wolber <chuckw@quantumlinux.com>, alan@lxorguk.ukuu.org.uk,
       davem@davemloft.net
Subject: [patch 33/32] NETLINK: Put {IFA,IFLA}_{RTA,PAYLOAD} macros back for userspace.
Message-ID: <20061209013609.GR1397@sequoia.sous-sol.org>
References: <20061208235751.890503000@sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061208235751.890503000@sous-sol.org>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: David Miller <davem@davemloft.net>

NETLINK: Put {IFA,IFLA}_{RTA,PAYLOAD} macros back for userspace.

GLIBC uses them etc.

They are guarded by ifndef __KERNEL__ so nobody will start
accidently using them in the kernel again, it's just for
userspace.

Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
commit c0279128f20aa3580b0b43aaa49f351f6bad5f30
Author: David S. Miller <davem@sunset.davemloft.net>
Date:   Fri Dec 8 17:05:13 2006 -0800

 include/linux/if_addr.h |    6 ++++++
 include/linux/if_link.h |    6 ++++++
 2 files changed, 12 insertions(+)

--- linux-2.6.19.orig/include/linux/if_addr.h
+++ linux-2.6.19/include/linux/if_addr.h
@@ -52,4 +52,10 @@ struct ifa_cacheinfo
 	__u32	tstamp; /* updated timestamp, hundredths of seconds */
 };
 
+/* backwards compatibility for userspace */
+#ifndef __KERNEL__
+#define IFA_RTA(r)  ((struct rtattr*)(((char*)(r)) + NLMSG_ALIGN(sizeof(struct ifaddrmsg))))
+#define IFA_PAYLOAD(n) NLMSG_PAYLOAD(n,sizeof(struct ifaddrmsg))
+#endif
+
 #endif
--- linux-2.6.19.orig/include/linux/if_link.h
+++ linux-2.6.19/include/linux/if_link.h
@@ -82,6 +82,12 @@ enum
 
 #define IFLA_MAX (__IFLA_MAX - 1)
 
+/* backwards compatibility for userspace */
+#ifndef __KERNEL__
+#define IFLA_RTA(r)  ((struct rtattr*)(((char*)(r)) + NLMSG_ALIGN(sizeof(struct ifinfomsg))))
+#define IFLA_PAYLOAD(n) NLMSG_PAYLOAD(n,sizeof(struct ifinfomsg))
+#endif
+
 /* ifi_flags.
 
    IFF_* flags.
