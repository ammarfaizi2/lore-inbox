Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286218AbRL0GF7>; Thu, 27 Dec 2001 01:05:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286220AbRL0GFt>; Thu, 27 Dec 2001 01:05:49 -0500
Received: from fe070.worldonline.dk ([212.54.64.208]:2057 "HELO
	fe070.worldonline.dk") by vger.kernel.org with SMTP
	id <S286218AbRL0GFf>; Thu, 27 Dec 2001 01:05:35 -0500
Date: Thu, 27 Dec 2001 07:05:06 +0100 (CET)
From: Niels Kristian Bech Jensen <nkbj@image.dk>
X-X-Sender: <nkbj@helium.nkbj.dk>
To: Keith Owens <kaos@ocs.com.au>
cc: "Linux kernel developer's mailing list" 
	<linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.18-pre1
In-Reply-To: <11193.1009422220@ocs3.intra.ocs.com.au>
Message-ID: <Pine.LNX.4.33.0112270704240.14041-100000@helium.nkbj.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Dec 2001, Keith Owens wrote:

> On Wed, 26 Dec 2001 11:55:27 -0800, 
> J Sloan <jjs@pobox.com> wrote:
> >Just a reminder, sis woes persist -
> >all else seems fine at this point.
> >
> >if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.4.18pre1; fi
> >depmod: *** Unresolved symbols in 
> >/lib/modules/2.4.18pre1/kernel/drivers/char/drm/sis.o
> >depmod:         sis_malloc_Ra3329ed5
> >depmod:         sis_free_Rced25333
> 
> You have to select CONFIG_FB_SIS as well.  This is a deficency in CML1
> that is difficult to fix, there are cross directory dependencies.
> 
This workaround seems to work (I know it's ugly):

--- linux-2.4.18-pre1/drivers/char/drm/Config.in	Sat Dec 22 07:20:44 2001
+++ linux/drivers/char/drm/Config.in	Thu Dec 27 06:51:19 2001
@@ -14,4 +14,7 @@
     dep_tristate '  Intel I810' CONFIG_DRM_I810 $CONFIG_AGP
     dep_tristate '  Matrox g200/g400' CONFIG_DRM_MGA $CONFIG_AGP
     dep_tristate '  SiS' CONFIG_DRM_SIS $CONFIG_AGP
+    if [ "$CONFIG_DRM_SIS" != "n" ]; then
+        define_bool CONFIG_FB_SIS y
+    fi
 fi
--- linux-2.4.18-pre1/drivers/video/Config.in	Fri Nov 23 07:41:27 2001
+++ linux/drivers/video/Config.in	Thu Dec 27 06:30:32 2001
@@ -139,6 +139,9 @@
  	 tristate '  ATI Radeon display support (EXPERIMENTAL)' CONFIG_FB_RADEON
 	 tristate '  ATI Rage128 display support (EXPERIMENTAL)' CONFIG_FB_ATY128
 	 tristate '  SIS acceleration (EXPERIMENTAL)' CONFIG_FB_SIS
+	 if [ "$CONFIG_DRM_SIS" != "n" -a "$CONFIG_FB_SIS" != "y" ]; then
+	    define_bool CONFIG_FB_SIS y
+	 fi
 	 if [ "$CONFIG_FB_SIS" != "n" ]; then
 	    bool '    SIS 630/540/730 support' CONFIG_FB_SIS_300
 	    bool '    SIS 315H/315 support' CONFIG_FB_SIS_315

-- 
Niels Kristian Bech Jensen -- nkbj@image.dk -- http://www.image.dk/~nkbj/

----------->>  Stop software piracy --- use free software!  <<-----------

