Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751421AbWIZFqv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751421AbWIZFqv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 01:46:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751415AbWIZFqQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 01:46:16 -0400
Received: from ns1.suse.de ([195.135.220.2]:64225 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751425AbWIZFkF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 01:40:05 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 38/47] add CONFIG_ENABLE_MUST_CHECK
Date: Mon, 25 Sep 2006 22:37:58 -0700
Message-Id: <11592492061208-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.2.1
In-Reply-To: <11592492023883-git-send-email-greg@kroah.com>
References: <20060926053728.GA8970@kroah.com> <1159249087369-git-send-email-greg@kroah.com> <11592490903867-git-send-email-greg@kroah.com> <11592490933346-git-send-email-greg@kroah.com> <1159249096460-git-send-email-greg@kroah.com> <11592490993970-git-send-email-greg@kroah.com> <11592491023995-git-send-email-greg@kroah.com> <1159249104512-git-send-email-greg@kroah.com> <11592491082990-git-send-email-greg@kroah.com> <1159249111668-git-send-email-greg@kroah.com> <11592491152668-git-send-email-greg@kroah.com> <115924911859-git-send-email-greg@kroah.com> <11592491211162-git-send-email-greg@kroah.com> <1159249124371-git-send-email-greg@kroah.com> <11592491274168-git-send-email-greg@kroah.com> <11592491303012-git-send-email-greg@kroah.com> <11592491342421-git-send-email-greg@kroah.com> <11592491371254-git-send-email-greg@kroah.com> <1159249140339-git-send-email-greg@kroah.com> <11592491451786-git-send-email-greg@kroah.com> <11592491482560-git-send-email-greg@kroah.com> <11592491512
 235-git-send-email-greg@kroah.com> <11592491551919-git-send-email-greg@kroah.com> <11592491581007-git-send-email-greg@kroah.com> <11592491611339-git-send-email-greg@kroah.com> <11592491643725-git-send-email-greg@kroah.com> <11592491672052-git-send-email-greg@kroah.com> <11592491704137-git-send-email-greg@kroah.com> <11592491744040-git-send-email-greg@kroah.com> <1159249177618-git-send-email-greg@kroah.com> <11592491803904-git-send-email-greg@kroah.com> <11592491833450-git-send-email-greg@kroah.com> <11592491862904-git-send-email-greg@kroah.com> <11592491901464-git-send-email-greg@kroah.com> <11592491924093-git-send-email-greg@kroah.com> <1159249196427-git-send-email-greg@kroah.com> <1159249200793-git-send-email-greg@kroah.com> <11592492023883-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>

Those 1500 warnings can be a bit of a pain.  Add a config option to shut them
up.

Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 include/linux/compiler.h |    5 +++++
 lib/Kconfig.debug        |    7 +++++++
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 9b4f110..060b961 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -99,6 +99,11 @@ #ifndef __must_check
 #define __must_check
 #endif
 
+#ifndef CONFIG_ENABLE_MUST_CHECK
+#undef __must_check
+#define __must_check
+#endif
+
 /*
  * Allow us to avoid 'defined but not used' warnings on functions and data,
  * as well as force them to be emitted to the assembly file.
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 554ee68..5c114c3 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -8,6 +8,13 @@ config PRINTK_TIME
 	  operations.  This is useful for identifying long delays
 	  in kernel startup.
 
+config ENABLE_MUST_CHECK
+	bool "Enable __must_check logic"
+	default y
+	help
+	  Enable the __must_check logic in the kernel build.  Disable this to
+	  suppress the "warning: ignoring return value of 'foo', declared with
+	  attribute warn_unused_result" messages.
 
 config MAGIC_SYSRQ
 	bool "Magic SysRq key"
-- 
1.4.2.1

