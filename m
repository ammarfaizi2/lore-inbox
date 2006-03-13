Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750808AbWCMOSR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750808AbWCMOSR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 09:18:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750839AbWCMOSR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 09:18:17 -0500
Received: from liaag1ad.mx.compuserve.com ([149.174.40.30]:17360 "EHLO
	liaag1ad.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1750808AbWCMOSQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 09:18:16 -0500
Date: Mon, 13 Mar 2006 09:13:31 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch] Require VM86 with VESA framebuffer
To: Antonino Daplas <adaplas@pol.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Adrian Bunk <bunk@stusta.de>, Linus Torvalds <torvalds@osdl.org>
Message-ID: <200603130917_MC3-1-BA83-2167@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Force VM86 when VESA framebuffer is enabled and fix a typo
in the VM86 config entry. If VM86 is disabled there will
be problems when starting X using the VESA driver.

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

--- 2.6.16-rc6-d2.orig/drivers/video/Kconfig
+++ 2.6.16-rc6-d2/drivers/video/Kconfig
@@ -456,6 +456,7 @@ config FB_TGA
 config FB_VESA
 	bool "VESA VGA graphics support"
 	depends on (FB = y) && X86
+	select VM86
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
--- 2.6.16-rc6-d2.orig/init/Kconfig
+++ 2.6.16-rc6-d2/init/Kconfig
@@ -224,7 +224,7 @@ config UID16
 	  This enables the legacy 16-bit UID syscall wrappers.
 
 config VM86
-	depends X86
+	depends on X86
 	default y
 	bool "Enable VM86 support" if EMBEDDED
 	help
-- 
Chuck
"Penguins don't come from next door, they come from the Antarctic!"
