Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263176AbTKETvn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 14:51:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263229AbTKETvD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 14:51:03 -0500
Received: from web40908.mail.yahoo.com ([66.218.78.205]:36871 "HELO
	web40908.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263176AbTKETtn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 14:49:43 -0500
Message-ID: <20031105194942.51568.qmail@web40908.mail.yahoo.com>
Date: Wed, 5 Nov 2003 11:49:42 -0800 (PST)
From: Bradley Chapman <kakadu_croc@yahoo.com>
Subject: Re: 2.6.0-test9-mm2
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mr. Morton,

This patch: +drm-agp-module-dependency-fix.patch

has broken the radeon DRM driver under 2.6.0-test9-mm2. Enclosed is an e-mail I
sent to the dri-devel sourceforge list:

<snip>

I'm having problems using te DRI radeon driver in the 2.6.0-test9-mm2
kernel tree. When X is started, the kernel outputs these messages:

[drm:radeon_cp_init] *ERROR* radeon_cp_init called without lock held
[drm:radeon_unlock] *ERROR* Process 1083 using kernel context 0

The driver did not do this under 2.6.0-test9-mm1.

Interesting parts of dmesg (under 2.6.0-test9-mm2):

Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel i845 Chipset.
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: AGP aperture is 64M @ 0xec000000
[drm] Initialized radeon 1.9.0 20020828 on minor 0

I am using XFree86-4.3.0-42 from Fedora Core.

</snip>

Diffing the drivers/char/drm trees produces this, which I assume is the patch
you applied:

diff -urN linux-2.6.0-test9-mm1/drivers/char/drm/drm_agpsupport.h
linux-2.6.0-test9-mm2/drivers/char/drm/drm_agpsupport.h
--- linux-2.6.0-test9-mm1/drivers/char/drm/drm_agpsupport.h     2003-10-17
22:42:52.000000000 +0100
+++ linux-2.6.0-test9-mm2/drivers/char/drm/drm_agpsupport.h     2003-11-05
08:45:46.000000000 +0000
@@ -37,8 +37,8 @@
 #if __REALLY_HAVE_AGP


-#define DRM_AGP_GET (drm_agp_t *)inter_module_get("drm_agp")
-#define DRM_AGP_PUT inter_module_put("drm_agp")
+#define DRM_AGP_GET symbol_get(agp_drm)
+#define DRM_AGP_PUT symbol_put(agp_drm)

 /**
  * Pointer to the drm_agp_t structure made available by the agpgart module.

I've had some responses from dri-devel so far, but right now I'm running
2.6.0-test9-mm1, which works perfectly fine.

What now?

TIA

Brad

=====
Brad Chapman

Permanent e-mail: kakadu_croc@yahoo.com

__________________________________
Do you Yahoo!?
Protect your identity with Yahoo! Mail AddressGuard
http://antispam.yahoo.com/whatsnewfree
