Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266818AbRGOS03>; Sun, 15 Jul 2001 14:26:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266822AbRGOS0K>; Sun, 15 Jul 2001 14:26:10 -0400
Received: from [210.52.24.10] ([210.52.24.10]:45317 "HELO mx.linux.net.cn")
	by vger.kernel.org with SMTP id <S266818AbRGOSZ5>;
	Sun, 15 Jul 2001 14:25:57 -0400
Date: Sun, 15 Jul 2001 11:25:45 +0800
From: Fang Han <dfbb@linux.net.cn>
To: linux-kernel@vger.kernel.org
Subject: [PATCH]Fix 2.4.7 Compile Error (From AC's patch)
Message-ID: <20010715112545.A1455@dfbbb.us.mvd>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If choose PVR2_FB, It will have an error, Because that driver is for 
Dreamcast. an SUPER_H arch.

So I just get the right part from AC's patch.

--- linux/drivers/video/Config.in.orig	Sun Jul 15 11:18:23 2001
+++ linux/drivers/video/Config.in	Sun Jul 15 11:19:26 2001
@@ -98,8 +98,10 @@
          bool '    CGsix (GX,TurboGX) support' CONFIG_FB_CGSIX
       fi
    fi
-   tristate '  NEC PowerVR 2 display support' CONFIG_FB_PVR2
-   dep_bool '    Debug pvr2fb' CONFIG_FB_PVR2_DEBUG $CONFIG_FB_PVR2
+   if [ "$CONFIG_SH_DREAMCAST" = "y" ]; then
+      tristate '  NEC PowerVR 2 display support' CONFIG_FB_PVR2
+      dep_bool '    Debug pvr2fb' CONFIG_FB_PVR2_DEBUG $CONFIG_FB_PVR2
+   fi
    bool '  Epson 1355 framebuffer support' CONFIG_FB_E1355
    if [ "$CONFIG_FB_E1355" = "y" ]; then
       hex '    Register Base Address' CONFIG_E1355_REG_BASE a8000000
