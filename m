Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267721AbUH2LWf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267721AbUH2LWf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 07:22:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265410AbUH2LWe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 07:22:34 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:3053 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S267721AbUH2LWY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 07:22:24 -0400
Date: Sun, 29 Aug 2004 12:22:23 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [bk pull] DRM tree - stop i830/i915 in kernel
Message-ID: <Pine.LNX.4.58.0408291220330.11976@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please do a

	bk pull bk://drm.bkbits.net/drm-2.6

This will include the latest DRM changes and will update the following files:

 drivers/char/drm/Kconfig |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

through these ChangeSets:

<airlied@starflyer.(none)> (04/08/29 1.1917)
   Stop i830 and i915 being built at the same time into the kernel
   Provide better info on which one is needed where...

   Signed-off-by: Dave Airlie <airlied@linux.ie>

diff -Nru a/drivers/char/drm/Kconfig b/drivers/char/drm/Kconfig
--- a/drivers/char/drm/Kconfig	Sun Aug 29 21:19:17 2004
+++ b/drivers/char/drm/Kconfig	Sun Aug 29 21:19:17 2004
@@ -57,22 +57,24 @@

 config DRM_I830
 	tristate "Intel 830M, 845G, 852GM, 855GM, 865G"
-	depends on DRM && AGP && AGP_INTEL
+	depends on DRM && AGP && AGP_INTEL && !(DRM_I915=y)
 	help
 	  Choose this option if you have a system that has Intel 830M, 845G,
 	  852GM, 855GM or 865G integrated graphics.  If M is selected, the
 	  module will be called i830.  AGP support is required for this driver
 	  to work. This driver will eventually be replaced by the i915 one.
+	  This driver should be used for systems running Xorg 6.7 and XFree86 4.4
+	  or previous releases.

 config DRM_I915
 	tristate "Intel 830M, 845G, 852GM, 855GM, 865G, 915G"
-	depends on DRM && AGP && AGP_INTEL
+	depends on DRM && AGP && AGP_INTEL && !(DRM_I830=y)
 	help
 	  Choose this option if you have a system that has Intel 830M, 845G,
 	  852GM, 855GM 865G or 915G integrated graphics.  If M is selected, the
 	  module will be called i915.  AGP support is required for this driver
-	  to work. This driver will eventually replace the I830 driver, when
-	  later release of X start to use the new DDX and DRI.
+	  to work. This driver should be used for systems running Xorg 6.8 and
+	  XFree86 releases after (but not including 4.4).


 config DRM_MGA
