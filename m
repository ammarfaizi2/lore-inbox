Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964983AbVLMO65@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964983AbVLMO65 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 09:58:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964984AbVLMO64
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 09:58:56 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:33036 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S964983AbVLMO64 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 09:58:56 -0500
Date: Tue, 13 Dec 2005 15:58:56 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] let MAGIC_SYSRQ no longer depend on DEBUG_KERNEL
Message-ID: <20051213145856.GJ23349@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I know several people using MAGIC_SYSRQ not for kernel debugging but for 
trying to do a halfway normal shutdown in case of problems.

Since there's no technical reason why MAGIC_SYSRQ would have to depend 
on DEBUG_KERNEL, I'm therefore suggesting to drop this dependency.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 22 Nov 2005

 lib/Kconfig.debug |   15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

--- linux-2.6.15-rc1-mm2-full/lib/Kconfig.debug.old	2005-11-20 20:26:51.000000000 +0100
+++ linux-2.6.15-rc1-mm2-full/lib/Kconfig.debug	2005-11-20 20:27:52.000000000 +0100
@@ -8,16 +8,9 @@
 	  operations.  This is useful for identifying long delays
 	  in kernel startup.
 
-
-config DEBUG_KERNEL
-	bool "Kernel debugging"
-	help
-	  Say Y here if you are developing drivers or trying to debug and
-	  identify kernel problems.
-
 config MAGIC_SYSRQ
 	bool "Magic SysRq key"
-	depends on DEBUG_KERNEL && !UML
+	depends on !UML
 	help
 	  If you say Y here, you will have some control over the system even
 	  if the system crashes for example during kernel debugging (e.g., you
@@ -29,6 +22,12 @@
 	  keys are documented in <file:Documentation/sysrq.txt>. Don't say Y
 	  unless you really know what this hack does.
 
+config DEBUG_KERNEL
+	bool "Kernel debugging"
+	help
+	  Say Y here if you are developing drivers or trying to debug and
+	  identify kernel problems.
+
 config LOG_BUF_SHIFT
 	int "Kernel log buffer size (16 => 64KB, 17 => 128KB)" if DEBUG_KERNEL
 	range 12 21

