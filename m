Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751081AbWAEA7F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751081AbWAEA7F (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 19:59:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750973AbWAEAuW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 19:50:22 -0500
Received: from mail.kroah.org ([69.55.234.183]:1466 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750974AbWAEAtz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 19:49:55 -0500
Cc: gregkh@suse.de
Subject: [PATCH] HOTPLUG: always enable the .config option, unless EMBEDDED
In-Reply-To: <1136422169909@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 4 Jan 2006 16:49:30 -0800
Message-Id: <11364221692430@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] HOTPLUG: always enable the .config option, unless EMBEDDED

With modules, dynamic /dev, and uevents, people really want
CONFIG_HOTPLUG to be enabled in their kernels.  If not, they can still
disable it, but it is discouraged.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 712f47cea7703a340406fde61e84eb86ce781988
tree cf8a4ae14b1503446000454151ef5c8cef507336
parent 312c004d36ce6c739512bac83b452f4c20ab1f62
author Greg Kroah-Hartman <gregkh@suse.de> Wed, 16 Nov 2005 11:27:07 -0800
committer Greg Kroah-Hartman <gregkh@suse.de> Wed, 04 Jan 2006 16:18:08 -0800

 init/Kconfig |   17 +++++++++--------
 1 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index 0de8b77..d2b4e33 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -197,14 +197,6 @@ config AUDITSYSCALL
 	  can be used independently or with another kernel subsystem,
 	  such as SELinux.
 
-config HOTPLUG
-	bool "Support for hot-pluggable devices" if !ARCH_S390
-	default ARCH_S390
-	help
-	  This option is provided for the case where no in-kernel-tree
-	  modules require HOTPLUG functionality, but a module built
-	  outside the kernel tree does. Such modules require Y here.
-
 config IKCONFIG
 	bool "Kernel .config support"
 	---help---
@@ -289,6 +281,15 @@ config KALLSYMS_EXTRA_PASS
 	   you wait for kallsyms to be fixed.
 
 
+config HOTPLUG
+	bool "Support for hot-pluggable devices" if EMBEDDED
+	default y
+	help
+	  This option is provided for the case where no hotplug or uevent
+	  capabilities is wanted by the kernel.  You should only consider
+	  disabling this option for embedded systems that do not use modules, a
+	  dynamic /dev tree, or dynamic device discovery.  Just say Y.
+
 config PRINTK
 	default y
 	bool "Enable support for printk" if EMBEDDED

