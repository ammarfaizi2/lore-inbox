Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751111AbWE2Xet@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751111AbWE2Xet (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 19:34:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbWE2Xet
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 19:34:49 -0400
Received: from terminus.zytor.com ([192.83.249.54]:17600 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751111AbWE2Xet
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 19:34:49 -0400
Date: Mon, 29 May 2006 16:34:42 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
Message-Id: <200605292334.k4TNYgKg029556@terminus.zytor.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Make sysctl obligatory except under CONFIG_EMBEDDED
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: H. Peter Anvin <hpa@zytor.com>

This patch makes sysctl non-optional unless EMBEDDED is set.  There
are a number of interfaces exposed via sysctl, enough that it has to
be considered core kernel functionality at this point.

Signed-off-by: H. Peter Anvin <hpa@zytor.com>

diff --git a/init/Kconfig b/init/Kconfig
index 3b36a1d..9087910 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -151,7 +151,8 @@ config BSD_PROCESS_ACCT_V3
 	  at <http://www.physik3.uni-rostock.de/tim/kernel/utils/acct/>.
 
 config SYSCTL
-	bool "Sysctl support"
+	bool "Sysctl support" if EMBEDDED
+	default y
 	---help---
 	  The sysctl interface provides a means of dynamically changing
 	  certain kernel parameters and variables on the fly without requiring
