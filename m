Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266252AbUHNWx0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266252AbUHNWx0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 18:53:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266249AbUHNWx0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 18:53:26 -0400
Received: from fw.osdl.org ([65.172.181.6]:13242 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266252AbUHNWxU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 18:53:20 -0400
Date: Sat, 14 Aug 2004 15:53:11 -0700
From: Chris Wright <chrisw@osdl.org>
To: akpm@osdl.org, torvalds@osdl.org
Cc: Kurt Garloff <garloff@suse.de>,
       Linux kernel list <linux-kernel@vger.kernel.org>,
       Stephen Smalley <sds@epoch.ncsc.mil>, James Morris <jmorris@redhat.com>
Subject: [PATCH] configurable SELinux bootparam value
Message-ID: <20040814155311.Z1924@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add configure option for setting default SELinux bootparam value.
Ack'd by James Morris.

Signed-off-by: Chris Wright <chrisw@osdl.org>

===== security/selinux/Kconfig 1.6 vs edited =====
--- 1.6/security/selinux/Kconfig	2004-06-01 02:27:56 -07:00
+++ edited/security/selinux/Kconfig	2004-08-10 13:39:43 -07:00
@@ -24,6 +24,21 @@
 
 	  If you are unsure how to answer this question, answer N.
 
+config SECURITY_SELINUX_BOOTPARAM_VALUE
+	int "NSA SELinux boot parameter default value"
+	depends on SECURITY_SELINUX_BOOTPARAM
+	range 0 1
+	default 1
+	help
+	  This option sets the default value for the kernel parameter
+	  'selinux', which allows SELinux to be disabled at boot.  If this
+	  option is set to 0 (zero), the SELinux kernel parameter will
+	  default to 0, disabling SELinux at bootup.  If this option is
+	  set to 1 (one), the SELinux kernel paramater will default to 1,
+	  enabling SELinux at bootup.
+
+	  If you are unsure how to answer this question, answer 1.
+
 config SECURITY_SELINUX_DISABLE
 	bool "NSA SELinux runtime disable"
 	depends on SECURITY_SELINUX
===== security/selinux/hooks.c 1.53 vs edited =====
--- 1.53/security/selinux/hooks.c	2004-07-28 21:58:32 -07:00
+++ edited/security/selinux/hooks.c	2004-08-10 13:44:00 -07:00
@@ -87,7 +87,7 @@
 #endif
 
 #ifdef CONFIG_SECURITY_SELINUX_BOOTPARAM
-int selinux_enabled = 1;
+int selinux_enabled = CONFIG_SECURITY_SELINUX_BOOTPARAM_VALUE;
 
 static int __init selinux_enabled_setup(char *str)
 {
