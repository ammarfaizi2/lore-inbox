Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129387AbRAEHjP>; Fri, 5 Jan 2001 02:39:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129415AbRAEHjG>; Fri, 5 Jan 2001 02:39:06 -0500
Received: from dnscache.cbr.au.asiaonline.net ([210.215.8.100]:25243 "EHLO
	dnscache.cbr.au.asiaonline.net") by vger.kernel.org with ESMTP
	id <S129387AbRAEHit>; Fri, 5 Jan 2001 02:38:49 -0500
Message-ID: <3A5578E9.5A5FEEEE@valinux.com>
Date: Fri, 05 Jan 2001 18:34:01 +1100
From: Gareth Hughes <gareth@valinux.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.sourceforge.net>
Subject: Patch: Fix for r128 DRM compilation problem
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The 2.4.0 kernel will fail to compile if the r128 DRM module is enabled
but AGP support (agpgart) is not.  The following patch fixes this error:

--- linux/drivers/char/drm/Config.in	Wed Aug  9 02:27:33 2000
+++ linux.gth/drivers/char/drm/Config.in	Fri Jan  5 18:11:53 2001
@@ -9,7 +9,7 @@
 if [ "$CONFIG_DRM" != "n" ]; then
     tristate '  3dfx Banshee/Voodoo3+' CONFIG_DRM_TDFX
     tristate '  3dlabs GMX 2000' CONFIG_DRM_GAMMA
-    tristate '  ATI Rage 128' CONFIG_DRM_R128
+    dep_tristate '  ATI Rage 128' CONFIG_DRM_R128 $CONFIG_AGP
     dep_tristate '  Intel I810' CONFIG_DRM_I810 $CONFIG_AGP
     dep_tristate '  Matrox g200/g400' CONFIG_DRM_MGA $CONFIG_AGP
 fi

I will apply this to DRI CVS now.  Apologies for letting this slip
through.

-- Gareth
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
