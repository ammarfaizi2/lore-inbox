Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268034AbTCFKEU>; Thu, 6 Mar 2003 05:04:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268039AbTCFKEU>; Thu, 6 Mar 2003 05:04:20 -0500
Received: from CPE-144-132-203-93.nsw.bigpond.net.au ([144.132.203.93]:63360
	"EHLO anakin.wychk.org") by vger.kernel.org with ESMTP
	id <S268034AbTCFKET>; Thu, 6 Mar 2003 05:04:19 -0500
Date: Thu, 6 Mar 2003 18:10:17 +0800
From: Geoffrey Lee <glee@gnupilgrims.org>
To: linux-kernel@vger.kernel.org
Cc: trivial@rustcorp.com.au
Subject: [PATCH]  fix undefined reference for sis drm.
Message-ID: <20030306101017.GA6479@anakin.wychk.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="BOKacYhQ+x31HxR3"
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=big5
Content-Disposition: inline

Hi all,


This fixes a bug where where if sis fb is not set and sis drm is
selected then there will be undefined references to sis_malloc() and
sis_free().

What I've done is a sort of a bandaid because I don't have hardware
to fix and test. 


	-- G.
-- 
char p[] = "\xeb\x1f\x5e\x89\x76\x08\x31\xc0\x88\x46\x07\x89\x46\x0c\xb0\x0b"
  "\x89\xf3\x8d\x4e\x08\x8d\x56\x0c\xcd\x80\x31\xdb\x89\xd8\x40\xcd"
  "\x80\xe8\xdc\xff\xff\xff/bin/sh";



--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=big5
Content-Disposition: attachment; filename="Config.in.patch"

--- linux-2.4.21/drivers/char/drm/Config.in.orig	Thu Mar  6 21:06:47 2003
+++ linux-2.4.21/drivers/char/drm/Config.in	Thu Mar  6 21:09:26 2003
@@ -13,4 +13,6 @@
 dep_mbool    '    Enabled XFree 4.1 ioctl interface by default' CONFIG_DRM_I810_XFREE_41 $CONFIG_DRM_I810
 dep_tristate '  Intel 830M' CONFIG_DRM_I830 $CONFIG_AGP
 dep_tristate '  Matrox g200/g400' CONFIG_DRM_MGA $CONFIG_AGP
-dep_tristate '  SiS' CONFIG_DRM_SIS $CONFIG_AGP
+if [ "$CONFIG_FB_SIS" = "y" ]; then
+   dep_tristate '  SiS' CONFIG_DRM_SIS $CONFIG_AGP
+fi

--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=big5
Content-Disposition: attachment; filename="Configure.help.patch"

--- linux-2.4.21/Documentation/Configure.help.orig	Thu Mar  6 21:07:02 2003
+++ linux-2.4.21/Documentation/Configure.help	Thu Mar  6 21:08:26 2003
@@ -26277,6 +26277,9 @@
   Choose this option if you have a SIS graphics card. AGP support is
   required for this driver to work.
 
+  You will also be required to have support for SIS frame buffer as
+  it requires a few routines from it.
+
 Etrax Ethernet slave support (over lp0/1)
 CONFIG_ETRAX_ETHERNET_LPSLAVE
   This option enables a slave ETRAX 100 or ETRAX 100LX, connected to a

--BOKacYhQ+x31HxR3--
