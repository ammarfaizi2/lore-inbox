Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261506AbUKSRS7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261506AbUKSRS7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 12:18:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261511AbUKSRRf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 12:17:35 -0500
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:60094 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S261503AbUKSROb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 12:14:31 -0500
Subject: [PATCH][SELINUX] Map Unix seqpacket sockets to appropriate
	security class
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Andrew Morton <akpm@osdl.org>, James Morris <jmorris@redhat.com>,
       lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1100884202.15944.173.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 19 Nov 2004 12:10:02 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch for SELinux (applies to 2.6.10-rc2 or 2.6.10-rc2-mm2) fixes a
bug in the mapping of socket types to security classes and ensures that
Unix seqpacket sockets are mapped to an appropriate security class.  The
Unix stream security class is re-used in this case as it has the same
permission checking applied as for seqpacket.  Please apply.

Signed-off-by:  Stephen Smalley <sds@epoch.ncsc.mil>
Signed-off-by:  James Morris <jmorris@redhat.com>


 security/selinux/hooks.c |    3 +++
 1 files changed, 3 insertions(+)

Index: linux-2.6/security/selinux/hooks.c
===================================================================
RCS file: /nfshome/pal/CVS/linux-2.6/security/selinux/hooks.c,v
retrieving revision 1.132
diff -u -p -r1.132 hooks.c
--- linux-2.6/security/selinux/hooks.c	25 Oct 2004 12:51:44 -0000	1.132
+++ linux-2.6/security/selinux/hooks.c	19 Nov 2004 14:12:40 -0000
@@ -630,10 +630,12 @@ static inline u16 socket_type_to_securit
 	case PF_UNIX:
 		switch (type) {
 		case SOCK_STREAM:
+		case SOCK_SEQPACKET:
 			return SECCLASS_UNIX_STREAM_SOCKET;
 		case SOCK_DGRAM:
 			return SECCLASS_UNIX_DGRAM_SOCKET;
 		}
+		break;
 	case PF_INET:
 	case PF_INET6:
 		switch (type) {
@@ -644,6 +646,7 @@ static inline u16 socket_type_to_securit
 		case SOCK_RAW:
 			return SECCLASS_RAWIP_SOCKET;
 		}
+		break;
 	case PF_NETLINK:
 		switch (protocol) {
 		case NETLINK_ROUTE:

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

