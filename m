Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422933AbWBBKCR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422933AbWBBKCR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 05:02:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423435AbWBBKCR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 05:02:17 -0500
Received: from vanessarodrigues.com ([192.139.46.150]:52926 "EHLO
	jaguar.mkp.net") by vger.kernel.org with ESMTP id S1422933AbWBBKCR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 05:02:17 -0500
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org, Dave Jones <davej@redhat.com>,
       tony.luck@intel.com
Subject: [patch] Build drivers/sn/ for all sn2 builds
From: Jes Sorensen <jes@sgi.com>
Date: 02 Feb 2006 05:02:15 -0500
Message-ID: <yq01wymoz88.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Reposting this patch which solves the problem where drivers/sn isn't
being evaluated by the build system for some config cases.

Solves a problem earlier reported by Dave Jones.

Cheers,
Jes

Include drivers/sn when CONFIG_IA64_SGI_SN2 or CONFIG_IA64_GENERIC
is enabled.

Signed-off-by: Jes Sorensen <jes@sgi.com>
----

 arch/ia64/Kconfig |    3 +++
 drivers/Makefile  |    2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

Index: linux-2.6/arch/ia64/Kconfig
===================================================================
--- linux-2.6.orig/arch/ia64/Kconfig
+++ linux-2.6/arch/ia64/Kconfig
@@ -374,6 +374,9 @@
 	  To use this option, you have to ensure that the "/proc file system
 	  support" (CONFIG_PROC_FS) is enabled, too.
 
+config SGI_SN
+	def_bool y if (IA64_SGI_SN2 || IA64_GENERIC)
+
 source "drivers/firmware/Kconfig"
 
 source "fs/Kconfig.binfmt"
Index: linux-2.6/drivers/Makefile
===================================================================
--- linux-2.6.orig/drivers/Makefile
+++ linux-2.6/drivers/Makefile
@@ -69,7 +69,7 @@
 obj-$(CONFIG_CPU_FREQ)		+= cpufreq/
 obj-$(CONFIG_MMC)		+= mmc/
 obj-$(CONFIG_INFINIBAND)	+= infiniband/
-obj-$(CONFIG_SGI_IOC4)		+= sn/
+obj-$(CONFIG_SGI_SN)		+= sn/
 obj-y				+= firmware/
 obj-$(CONFIG_CRYPTO)		+= crypto/
 obj-$(CONFIG_SUPERH)		+= sh/
