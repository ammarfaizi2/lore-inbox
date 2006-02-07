Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965132AbWBGPpH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965132AbWBGPpH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 10:45:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965133AbWBGPop
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 10:44:45 -0500
Received: from mummy.ncsc.mil ([144.51.88.129]:21959 "EHLO jazzhorn.ncsc.mil")
	by vger.kernel.org with ESMTP id S965132AbWBGPo2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 10:44:28 -0500
Subject: [patch 1/1] selinux: require AUDIT
From: Stephen Smalley <sds@tycho.nsa.gov>
To: lkml <linux-kernel@vger.kernel.org>, James Morris <jmorris@namei.org>,
       Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Organization: National Security Agency
Date: Tue, 07 Feb 2006 10:50:07 -0500
Message-Id: <1139327407.2872.73.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make SELinux depend on AUDIT as it requires the basic audit support to
log permission denials at all.  Note that AUDITSYSCALL remains optional
for SELinux, although it can be useful in providing further information
upon denials.  Please apply.

Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>
Acked-by:  James Morris <jmorris@namei.org>

---

 init/Kconfig             |    1 -
 security/selinux/Kconfig |    2 +-
 security/selinux/avc.c   |    2 --
 3 files changed, 1 insertion(+), 4 deletions(-)

diff -rup -X /home/sds/dontdiff linux-2.6.16-rc2-git2/init/Kconfig linux-2.6.16-rc2-git2-x/init/Kconfig
--- linux-2.6.16-rc2-git2/init/Kconfig	2006-02-07 09:31:03.000000000 -0500
+++ linux-2.6.16-rc2-git2-x/init/Kconfig	2006-02-07 09:48:49.000000000 -0500
@@ -169,7 +169,6 @@ config SYSCTL
 config AUDIT
 	bool "Auditing support"
 	depends on NET
-	default y if SECURITY_SELINUX
 	help
 	  Enable auditing infrastructure that can be used with another
 	  kernel subsystem, such as SELinux (which requires this for
diff -rup -X /home/sds/dontdiff linux-2.6.16-rc2-git2/security/selinux/avc.c linux-2.6.16-rc2-git2-x/security/selinux/avc.c
--- linux-2.6.16-rc2-git2/security/selinux/avc.c	2006-02-06 11:44:47.000000000 -0500
+++ linux-2.6.16-rc2-git2-x/security/selinux/avc.c	2006-02-07 09:48:49.000000000 -0500
@@ -43,13 +43,11 @@ static const struct av_perm_to_string
 #undef S_
 };
 
-#ifdef CONFIG_AUDIT
 static const char *class_to_string[] = {
 #define S_(s) s,
 #include "class_to_string.h"
 #undef S_
 };
-#endif
 
 #define TB_(s) static const char * s [] = {
 #define TE_(s) };
diff -rup -X /home/sds/dontdiff linux-2.6.16-rc2-git2/security/selinux/Kconfig linux-2.6.16-rc2-git2-x/security/selinux/Kconfig
--- linux-2.6.16-rc2-git2/security/selinux/Kconfig	2006-02-07 09:31:03.000000000 -0500
+++ linux-2.6.16-rc2-git2-x/security/selinux/Kconfig	2006-02-07 09:48:49.000000000 -0500
@@ -1,6 +1,6 @@
 config SECURITY_SELINUX
 	bool "NSA SELinux Support"
-	depends on SECURITY_NETWORK && NET && INET
+	depends on SECURITY_NETWORK && AUDIT && NET && INET
 	default n
 	help
 	  This selects NSA Security-Enhanced Linux (SELinux).

-- 
Stephen Smalley
National Security Agency

