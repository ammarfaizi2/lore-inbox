Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750784AbWEEMxK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750784AbWEEMxK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 08:53:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750795AbWEEMxJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 08:53:09 -0400
Received: from mummy.ncsc.mil ([144.51.88.129]:33221 "EHLO jazzhorn.ncsc.mil")
	by vger.kernel.org with ESMTP id S1750784AbWEEMxI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 08:53:08 -0400
Subject: [patch 1/1] selinux: add security class for appletalk sockets
From: Stephen Smalley <sds@tycho.nsa.gov>
To: lkml <linux-kernel@vger.kernel.org>, James Morris <jmorris@namei.org>,
       Andrew Morton <akpm@osdl.org>
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>
Content-Type: text/plain
Organization: National Security Agency
Date: Fri, 05 May 2006 08:57:25 -0400
Message-Id: <1146833845.23863.21.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christopher J. PeBenito <cpebenito@tresys.com> 

Add a security class for appletalk sockets so that they can be
distinguished in SELinux policy.  Please apply.

Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>
Acked-by:  James Morris <jmorris@namei.org>

---

 security/selinux/hooks.c                   |    2 ++
 security/selinux/include/av_inherit.h      |    1 +
 security/selinux/include/av_permissions.h  |   23 +++++++++++++++++++++++
 security/selinux/include/class_to_string.h |    1 +
 security/selinux/include/flask.h           |    1 +
 5 files changed, 28 insertions(+)

diff -X /home/sds/dontdiff -rup linux-2.6.17-rc3-mm1/security/selinux/hooks.c linux-2.6.17-rc3-mm1-x3/security/selinux/hooks.c
--- linux-2.6.17-rc3-mm1/security/selinux/hooks.c	2006-05-04 14:08:36.000000000 -0400
+++ linux-2.6.17-rc3-mm1-x3/security/selinux/hooks.c	2006-05-05 08:32:32.000000000 -0400
@@ -694,6 +694,8 @@ static inline u16 socket_type_to_securit
 		return SECCLASS_PACKET_SOCKET;
 	case PF_KEY:
 		return SECCLASS_KEY_SOCKET;
+	case PF_APPLETALK:
+		return SECCLASS_APPLETALK_SOCKET;
 	}
 
 	return SECCLASS_SOCKET;
diff -X /home/sds/dontdiff -rup linux-2.6.17-rc3-mm1/security/selinux/include/av_inherit.h linux-2.6.17-rc3-mm1-x3/security/selinux/include/av_inherit.h
--- linux-2.6.17-rc3-mm1/security/selinux/include/av_inherit.h	2006-05-04 14:08:36.000000000 -0400
+++ linux-2.6.17-rc3-mm1-x3/security/selinux/include/av_inherit.h	2006-05-05 08:32:32.000000000 -0400
@@ -29,3 +29,4 @@
    S_(SECCLASS_NETLINK_IP6FW_SOCKET, socket, 0x00400000UL)
    S_(SECCLASS_NETLINK_DNRT_SOCKET, socket, 0x00400000UL)
    S_(SECCLASS_NETLINK_KOBJECT_UEVENT_SOCKET, socket, 0x00400000UL)
+   S_(SECCLASS_APPLETALK_SOCKET, socket, 0x00400000UL)
diff -X /home/sds/dontdiff -rup linux-2.6.17-rc3-mm1/security/selinux/include/av_permissions.h linux-2.6.17-rc3-mm1-x3/security/selinux/include/av_permissions.h
--- linux-2.6.17-rc3-mm1/security/selinux/include/av_permissions.h	2006-05-04 14:08:36.000000000 -0400
+++ linux-2.6.17-rc3-mm1-x3/security/selinux/include/av_permissions.h	2006-05-05 08:32:32.000000000 -0400
@@ -933,3 +933,26 @@
 #define NETLINK_KOBJECT_UEVENT_SOCKET__SEND_MSG   0x00100000UL
 #define NETLINK_KOBJECT_UEVENT_SOCKET__NAME_BIND  0x00200000UL
 
+#define APPLETALK_SOCKET__IOCTL                   0x00000001UL
+#define APPLETALK_SOCKET__READ                    0x00000002UL
+#define APPLETALK_SOCKET__WRITE                   0x00000004UL
+#define APPLETALK_SOCKET__CREATE                  0x00000008UL
+#define APPLETALK_SOCKET__GETATTR                 0x00000010UL
+#define APPLETALK_SOCKET__SETATTR                 0x00000020UL
+#define APPLETALK_SOCKET__LOCK                    0x00000040UL
+#define APPLETALK_SOCKET__RELABELFROM             0x00000080UL
+#define APPLETALK_SOCKET__RELABELTO               0x00000100UL
+#define APPLETALK_SOCKET__APPEND                  0x00000200UL
+#define APPLETALK_SOCKET__BIND                    0x00000400UL
+#define APPLETALK_SOCKET__CONNECT                 0x00000800UL
+#define APPLETALK_SOCKET__LISTEN                  0x00001000UL
+#define APPLETALK_SOCKET__ACCEPT                  0x00002000UL
+#define APPLETALK_SOCKET__GETOPT                  0x00004000UL
+#define APPLETALK_SOCKET__SETOPT                  0x00008000UL
+#define APPLETALK_SOCKET__SHUTDOWN                0x00010000UL
+#define APPLETALK_SOCKET__RECVFROM                0x00020000UL
+#define APPLETALK_SOCKET__SENDTO                  0x00040000UL
+#define APPLETALK_SOCKET__RECV_MSG                0x00080000UL
+#define APPLETALK_SOCKET__SEND_MSG                0x00100000UL
+#define APPLETALK_SOCKET__NAME_BIND               0x00200000UL
+
diff -X /home/sds/dontdiff -rup linux-2.6.17-rc3-mm1/security/selinux/include/class_to_string.h linux-2.6.17-rc3-mm1-x3/security/selinux/include/class_to_string.h
--- linux-2.6.17-rc3-mm1/security/selinux/include/class_to_string.h	2006-05-04 14:08:36.000000000 -0400
+++ linux-2.6.17-rc3-mm1-x3/security/selinux/include/class_to_string.h	2006-05-05 08:32:32.000000000 -0400
@@ -58,3 +58,4 @@
     S_("nscd")
     S_("association")
     S_("netlink_kobject_uevent_socket")
+    S_("appletalk_socket")
diff -X /home/sds/dontdiff -rup linux-2.6.17-rc3-mm1/security/selinux/include/flask.h linux-2.6.17-rc3-mm1-x3/security/selinux/include/flask.h
--- linux-2.6.17-rc3-mm1/security/selinux/include/flask.h	2006-05-04 14:08:36.000000000 -0400
+++ linux-2.6.17-rc3-mm1-x3/security/selinux/include/flask.h	2006-05-05 08:32:32.000000000 -0400
@@ -60,6 +60,7 @@
 #define SECCLASS_NSCD                                    53
 #define SECCLASS_ASSOCIATION                             54
 #define SECCLASS_NETLINK_KOBJECT_UEVENT_SOCKET           55
+#define SECCLASS_APPLETALK_SOCKET                        56
 
 /*
  * Security identifier indices for initial entities

-- 
Stephen Smalley
National Security Agency

