Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268998AbUJELez@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268998AbUJELez (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 07:34:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268995AbUJELez
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 07:34:55 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:26553 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S269001AbUJELej (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 07:34:39 -0400
Date: Tue, 5 Oct 2004 12:34:37 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [bk pull] DRM: Kconfig update
Message-ID: <Pine.LNX.4.58.0410051233090.27829@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

This is just a proper fix to stop the i830/i915 being built into the same
kernel I missed Romans post that contained it until now...

Please do a

	bk pull bk://drm.bkbits.net/drm-2.6

This will include the latest DRM changes and will update the following files:

 drivers/char/drm/Kconfig |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

through these ChangeSets:

<airlied@starflyer.(none)> (04/10/05 1.2051)
   drm: Stop i830 and i915 both being build at same time

   Roman Zippel submitted this to lk but I missed it, it does
   what I tried to do badly before.

   Signed-off-by: Dave Airlie <airlied@linux.ie>

diff -Nru a/drivers/char/drm/Kconfig b/drivers/char/drm/Kconfig
--- a/drivers/char/drm/Kconfig	2004-10-05 19:30:37 +10:00
+++ b/drivers/char/drm/Kconfig	2004-10-05 19:30:37 +10:00
@@ -55,9 +55,13 @@
 	  selected, the module will be called i810.  AGP support is required
 	  for this driver to work.

-config DRM_I830
-	tristate "Intel 830M, 845G, 852GM, 855GM, 865G"
+choice
+	prompt "Intel 830M, 845G, 852GM, 855GM, 865G"
 	depends on DRM && AGP && AGP_INTEL
+	optional
+
+config DRM_I830
+	tristate "i830 driver"
 	help
 	  Choose this option if you have a system that has Intel 830M, 845G,
 	  852GM, 855GM or 865G integrated graphics.  If M is selected, the
@@ -65,8 +69,7 @@
 	  to work. This driver will eventually be replaced by the i915 one.

 config DRM_I915
-	tristate "Intel 830M, 845G, 852GM, 855GM, 865G, 915G"
-	depends on DRM && AGP && AGP_INTEL
+	tristate "i915 driver"
 	help
 	  Choose this option if you have a system that has Intel 830M, 845G,
 	  852GM, 855GM 865G or 915G integrated graphics.  If M is selected, the
@@ -74,6 +77,7 @@
 	  to work. This driver will eventually replace the I830 driver, when
 	  later release of X start to use the new DDX and DRI.

+endchoice

 config DRM_MGA
 	tristate "Matrox g200/g400"
