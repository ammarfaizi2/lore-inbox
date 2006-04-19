Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751012AbWDSRxj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751012AbWDSRxj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 13:53:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751037AbWDSRxi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 13:53:38 -0400
Received: from ns2.suse.de ([195.135.220.15]:53149 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751010AbWDSRxi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 13:53:38 -0400
From: Tony Jones <tonyj@suse.de>
To: linux-kernel@vger.kernel.org
Cc: chrisw@sous-sol.org, Tony Jones <tonyj@suse.de>,
       linux-security-module@vger.kernel.org
Date: Wed, 19 Apr 2006 10:49:13 -0700
Message-Id: <20060419174913.29149.55209.sendpatchset@ermintrude.int.wirex.com>
In-Reply-To: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com>
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com>
Subject: [RFC][PATCH 1/11] security: AppArmor - Integrate into kbuild
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch glues AppArmor into the security configuration and Makefile.
It also creates the AppArmor configuration and Makefile.


Signed-off-by: Tony Jones <tonyj@suse.de>

---
 MAINTAINERS                |    7 +++++++
 security/Kconfig           |    1 +
 security/Makefile          |    1 +
 security/apparmor/Kconfig  |    9 +++++++++
 security/apparmor/Makefile |    6 ++++++
 5 files changed, 24 insertions(+)

--- linux-2.6.17-rc1.orig/MAINTAINERS
+++ linux-2.6.17-rc1/MAINTAINERS
@@ -284,6 +284,13 @@
 W:	http://www.canb.auug.org.au/~sfr/
 S:	Supported
 
+APPARMOR SECURITY MODULE
+P:	Tony Jones
+M:	tonyj@suse.de
+L:	apparmor-dev@forge.novell.com
+W:	http://forge.novell.com/modules/xfmod/project/?apparmor
+S:	Supported
+
 APPLETALK NETWORK LAYER
 P:	Arnaldo Carvalho de Melo
 M:	acme@conectiva.com.br
--- linux-2.6.17-rc1.orig/security/Kconfig
+++ linux-2.6.17-rc1/security/Kconfig
@@ -100,6 +100,7 @@
 	  If you are unsure how to answer this question, answer N.
 
 source security/selinux/Kconfig
+source security/apparmor/Kconfig
 
 endmenu
 
--- linux-2.6.17-rc1.orig/security/Makefile
+++ linux-2.6.17-rc1/security/Makefile
@@ -4,6 +4,7 @@
 
 obj-$(CONFIG_KEYS)			+= keys/
 subdir-$(CONFIG_SECURITY_SELINUX)	+= selinux
+subdir-$(CONFIG_SECURITY_APPARMOR)	+= apparmor
 
 # if we don't select a security model, use the default capabilities
 ifneq ($(CONFIG_SECURITY),y)
--- /dev/null
+++ linux-2.6.17-rc1/security/apparmor/Kconfig
@@ -0,0 +1,9 @@
+config SECURITY_APPARMOR
+	tristate "AppArmor support"
+	depends on SECURITY!=n
+	help
+	  This enables the AppArmor security module.
+	  Required userspace tools (if they are not included in your
+	  distribution) and further information may be found at
+	  <http://forge.novell.com/modules/xfmod/project/?apparmor>
+	  If you are unsure how to answer this question, answer N.
--- /dev/null
+++ linux-2.6.17-rc1/security/apparmor/Makefile
@@ -0,0 +1,6 @@
+# Makefile for AppArmor Linux Security Module
+#
+subdir-$(CONFIG_SECURITY_APPARMOR) += match
+obj-$(CONFIG_SECURITY_APPARMOR) += apparmor.o
+
+apparmor-y := main.o list.o procattr.o lsm.o apparmorfs.o capabilities.o module_interface.o
