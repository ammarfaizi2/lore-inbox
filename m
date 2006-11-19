Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756499AbWKSIVp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756499AbWKSIVp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 03:21:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756501AbWKSIVp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 03:21:45 -0500
Received: from liaag2ae.mx.compuserve.com ([149.174.40.156]:48575 "EHLO
	liaag2ae.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1756499AbWKSIVp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 03:21:45 -0500
Date: Sun, 19 Nov 2006 03:18:24 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch] PM: suspend/resume debugging should depend on
  SOFTWARE_SUSPEND
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       "Rafael J. Wysocki" <rjw@sisk.pl>
Message-ID: <200611190320_MC3-1-D21B-111C@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When doing 'make oldconfig' we should ask about suspend/resume
debug features when SOFTWARE_SUSPEND is not enabled.

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

--- 2.6.19-rc6-32.orig/kernel/power/Kconfig
+++ 2.6.19-rc6-32/kernel/power/Kconfig
@@ -38,7 +38,7 @@ config PM_DEBUG
 
 config DISABLE_CONSOLE_SUSPEND
 	bool "Keep console(s) enabled during suspend/resume (DANGEROUS)"
-	depends on PM && PM_DEBUG
+	depends on PM_DEBUG && SOFTWARE_SUSPEND
 	default n
 	---help---
 	This option turns off the console suspend mechanism that prevents
@@ -49,7 +49,7 @@ config DISABLE_CONSOLE_SUSPEND
 
 config PM_TRACE
 	bool "Suspend/resume event tracing"
-	depends on PM && PM_DEBUG && X86_32 && EXPERIMENTAL
+	depends on PM_DEBUG && SOFTWARE_SUSPEND && X86_32 && EXPERIMENTAL
 	default n
 	---help---
 	This enables some cheesy code to save the last PM event point in the
-- 
Chuck
