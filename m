Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262119AbVDLSfM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262119AbVDLSfM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 14:35:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262532AbVDLSer
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 14:34:47 -0400
Received: from fire.osdl.org ([65.172.181.4]:9419 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262307AbVDLKeO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:34:14 -0400
Message-Id: <200504121030.j3CAUpdI005163@shell0.pdx.osdl.net>
Subject: [patch 013/198] SELinux: fix bug in Netlink message type detection
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, jmorris@redhat.com,
       sds@tycho.nsa.gov
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:30:44 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: James Morris <jmorris@redhat.com>

This patch fixes a bug in the SELinux Netlink message type detection code,
where the wrong constant was being used in a case statement.  The incorrect
value is not valid for this class of object so it would not have been
reached, and fallen through to a default handler for all Netlink messages.

Signed-off-by: James Morris <jmorris@redhat.com>
Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/security/selinux/nlmsgtab.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN security/selinux/nlmsgtab.c~selinux-fix-bug-in-netlink-message-type-detection security/selinux/nlmsgtab.c
--- 25/security/selinux/nlmsgtab.c~selinux-fix-bug-in-netlink-message-type-detection	2005-04-12 03:21:06.586135656 -0700
+++ 25-akpm/security/selinux/nlmsgtab.c	2005-04-12 03:21:06.589135200 -0700
@@ -126,7 +126,7 @@ int selinux_nlmsg_lookup(u16 sclass, u16
 		break;
 
 	case SECCLASS_NETLINK_FIREWALL_SOCKET:
-	case NETLINK_IP6_FW:
+	case SECCLASS_NETLINK_IP6FW_SOCKET:
 		err = nlmsg_perm(nlmsg_type, perm, nlmsg_firewall_perms,
 				 sizeof(nlmsg_firewall_perms));
 		break;
_
