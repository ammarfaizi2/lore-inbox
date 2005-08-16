Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965083AbVHPDIA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965083AbVHPDIA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 23:08:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965085AbVHPDIA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 23:08:00 -0400
Received: from mail21.sea5.speakeasy.net ([69.17.117.23]:4824 "EHLO
	mail21.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S965080AbVHPDH7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 23:07:59 -0400
Date: Mon, 15 Aug 2005 23:07:32 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@excalibur.intercode
To: linux-kernel@vger.kernel.org
Subject: Re: git-net-selinux-build-fix.patch added to -mm tree (fwd)
Message-ID: <Pine.LNX.4.63.0508152307240.11405@excalibur.intercode>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Forgot to cc lkml.


---------- Forwarded message ----------
Date: Mon, 15 Aug 2005 23:00:10 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: akpm@osdl.org
Cc: David S. Miller <davem@davemloft.net>, Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: git-net-selinux-build-fix.patch added to -mm tree

Please use this patch instead so that we catch the new DCCP message type.

Signed-off-by: James Morris <jmorris@namei.org>

---

 security/selinux/hooks.c    |    2 +-
 security/selinux/nlmsgtab.c |    3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff -purN -X dontdiff net-2.6.14.o/security/selinux/hooks.c net-2.6.14.w/security/selinux/hooks.c
--- net-2.6.14.o/security/selinux/hooks.c	2005-08-15 15:47:44.000000000 -0400
+++ net-2.6.14.w/security/selinux/hooks.c	2005-08-15 16:01:29.000000000 -0400
@@ -659,7 +659,7 @@ static inline u16 socket_type_to_securit
 			return SECCLASS_NETLINK_ROUTE_SOCKET;
 		case NETLINK_FIREWALL:
 			return SECCLASS_NETLINK_FIREWALL_SOCKET;
-		case NETLINK_TCPDIAG:
+		case NETLINK_INET_DIAG:
 			return SECCLASS_NETLINK_TCPDIAG_SOCKET;
 		case NETLINK_NFLOG:
 			return SECCLASS_NETLINK_NFLOG_SOCKET;
diff -purN -X dontdiff net-2.6.14.o/security/selinux/nlmsgtab.c net-2.6.14.w/security/selinux/nlmsgtab.c
--- net-2.6.14.o/security/selinux/nlmsgtab.c	2005-08-15 15:47:44.000000000 -0400
+++ net-2.6.14.w/security/selinux/nlmsgtab.c	2005-08-15 16:06:44.000000000 -0400
@@ -16,7 +16,7 @@
 #include <linux/rtnetlink.h>
 #include <linux/if.h>
 #include <linux/netfilter_ipv4/ip_queue.h>
-#include <linux/tcp_diag.h>
+#include <linux/inet_diag.h>
 #include <linux/xfrm.h>
 #include <linux/audit.h>
 
@@ -76,6 +76,7 @@ static struct nlmsg_perm nlmsg_firewall_
 static struct nlmsg_perm nlmsg_tcpdiag_perms[] =
 {
 	{ TCPDIAG_GETSOCK,	NETLINK_TCPDIAG_SOCKET__NLMSG_READ },
+	{ DCCPDIAG_GETSOCK,	NETLINK_TCPDIAG_SOCKET__NLMSG_READ },
 };
 
 static struct nlmsg_perm nlmsg_xfrm_perms[] =
