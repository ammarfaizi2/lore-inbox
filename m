Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261779AbVDEPZg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261779AbVDEPZg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 11:25:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261781AbVDEPZf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 11:25:35 -0400
Received: from mx1.redhat.com ([66.187.233.31]:36750 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261779AbVDEPZT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 11:25:19 -0400
Date: Tue, 5 Apr 2005 11:25:08 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, Stephen Smalley <sds@epoch.ncsc.mil>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH] SELinux: fix bug in Netlink message type detection
Message-ID: <Xine.LNX.4.44.0504051122310.11575-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a bug in the SELinux Netlink message type detection code,
where the wrong constant was being used in a case statement.  The incorrect
value is not valid for this class of object so it would not have been reached,
and fallen through to a default handler for all Netlink messages.

Please apply.


Signed-off-by: James Morris <jmorris@redhat.com>
Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>

---

 security/selinux/nlmsgtab.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
  

diff -urN -X dontdiff linux-2.6.12-rc1-mm4.o/security/selinux/nlmsgtab.c linux-2.6.12-rc1-mm4.w/security/selinux/nlmsgtab.c
--- linux-2.6.12-rc1-mm4.o/security/selinux/nlmsgtab.c	2005-03-15 19:17:05.000000000 -0500
+++ linux-2.6.12-rc1-mm4.w/security/selinux/nlmsgtab.c	2005-04-04 18:57:55.000000000 -0400
@@ -126,7 +126,7 @@
 		break;
 
 	case SECCLASS_NETLINK_FIREWALL_SOCKET:
-	case NETLINK_IP6_FW:
+	case SECCLASS_NETLINK_IP6FW_SOCKET:
 		err = nlmsg_perm(nlmsg_type, perm, nlmsg_firewall_perms,
 				 sizeof(nlmsg_firewall_perms));
 		break;

