Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262033AbVBAOxG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262033AbVBAOxG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 09:53:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262032AbVBAOwp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 09:52:45 -0500
Received: from mummy.ncsc.mil ([144.51.88.129]:1247 "EHLO jazzhorn.ncsc.mil")
	by vger.kernel.org with ESMTP id S262031AbVBAOwR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 09:52:17 -0500
Subject: [PATCH][SELINUX] Define execmod permission for character devices
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Andrew Morton <akpm@osdl.org>, James Morris <jmorris@redhat.com>,
       lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1107269127.26936.129.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 01 Feb 2005 09:45:28 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch against 2.6.11-rc2-mm2 regenerates the SELinux module headers
to define the execmod permission for character device files in order to
provide proper auditing of such checks on /dev/zero.  Please apply.

Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>
Signed-off-by:  James Morris <jmorris@redhat.com>

 security/selinux/include/av_perm_to_string.h |    3 +++
 security/selinux/include/av_permissions.h    |    4 ++++
 2 files changed, 7 insertions(+)

Index: linux-2.6/security/selinux/include/av_perm_to_string.h
===================================================================
RCS file: /nfshome/pal/CVS/linux-2.6/security/selinux/include/av_perm_to_string.h,v
retrieving revision 1.19
diff -u -p -r1.19 av_perm_to_string.h
--- linux-2.6/security/selinux/include/av_perm_to_string.h	1 Dec 2004 16:47:00 -0000	1.19
+++ linux-2.6/security/selinux/include/av_perm_to_string.h	31 Jan 2005 19:40:08 -0000
@@ -17,6 +17,9 @@
    S_(SECCLASS_FILE, FILE__EXECUTE_NO_TRANS, "execute_no_trans")
    S_(SECCLASS_FILE, FILE__ENTRYPOINT, "entrypoint")
    S_(SECCLASS_FILE, FILE__EXECMOD, "execmod")
+   S_(SECCLASS_CHR_FILE, CHR_FILE__EXECUTE_NO_TRANS, "execute_no_trans")
+   S_(SECCLASS_CHR_FILE, CHR_FILE__ENTRYPOINT, "entrypoint")
+   S_(SECCLASS_CHR_FILE, CHR_FILE__EXECMOD, "execmod")
    S_(SECCLASS_FD, FD__USE, "use")
    S_(SECCLASS_TCP_SOCKET, TCP_SOCKET__CONNECTTO, "connectto")
    S_(SECCLASS_TCP_SOCKET, TCP_SOCKET__NEWCONN, "newconn")
Index: linux-2.6/security/selinux/include/av_permissions.h
===================================================================
RCS file: /nfshome/pal/CVS/linux-2.6/security/selinux/include/av_permissions.h,v
retrieving revision 1.18
diff -u -p -r1.18 av_permissions.h
--- linux-2.6/security/selinux/include/av_permissions.h	1 Dec 2004 16:47:00 -0000	1.18
+++ linux-2.6/security/selinux/include/av_permissions.h	31 Jan 2005 19:40:08 -0000
@@ -143,6 +143,10 @@
 #define CHR_FILE__QUOTAON                         0x00008000UL
 #define CHR_FILE__MOUNTON                         0x00010000UL
 
+#define CHR_FILE__EXECUTE_NO_TRANS                0x00020000UL
+#define CHR_FILE__ENTRYPOINT                      0x00040000UL
+#define CHR_FILE__EXECMOD                         0x00080000UL
+
 #define BLK_FILE__IOCTL                           0x00000001UL
 #define BLK_FILE__READ                            0x00000002UL
 #define BLK_FILE__WRITE                           0x00000004UL

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency

