Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272498AbTHAKqw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 06:46:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272519AbTHAKqa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 06:46:30 -0400
Received: from lindsey.linux-systeme.com ([80.190.48.67]:57105 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S273000AbTHAKo0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 06:44:26 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [PATCH 2.4.22-pre10] Cleanup DRM menu and give it a submenu
Date: Fri, 1 Aug 2003 12:40:17 +0200
User-Agent: KMail/1.5.2
Organization: Working Overloaded Linux Kernel
MIME-Version: 1.0
Message-Id: <200307312250.40474.m.c.p@wolk-project.de>
Cc: lkml <linux-kernel@vger.kernel.org>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_ROkK/e/TZgHxMmh"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_ROkK/e/TZgHxMmh
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Marcelo,

I've been getting complaints about the menu structure from the linux kernel 
config subsystem for a _long time_. Now let's clean up the DRM menu and give 
it a submenu. We are getting close that the menu will look more cleaner :)

More cleanups for different menu's are following.

Please apply for 2.4.22-pre10. Thank you :)

ciao, Marc

--Boundary-00=_ROkK/e/TZgHxMmh
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="2.4-DRM-extramenu.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="2.4-DRM-extramenu.patch"

--- a/drivers/char/Config.in	2002-12-18 13:52:04.000000000 +0100
+++ b/drivers/char/Config.in	2002-12-18 13:52:23.000000000 +0100
@@ -317,18 +317,7 @@ if [ "$CONFIG_AGP" != "n" ]; then
    fi
 fi
 
-bool 'Direct Rendering Manager (XFree86 DRI support)' CONFIG_DRM
-if [ "$CONFIG_DRM" = "y" ]; then
-   bool '  Build drivers for old (XFree 4.0) DRM' CONFIG_DRM_OLD
-   if [ "$CONFIG_DRM_OLD" = "y" ]; then
-      comment 'DRM 4.0 drivers'
-      source drivers/char/drm-4.0/Config.in
-   else
-      comment 'DRM 4.1 drivers'
-      define_bool CONFIG_DRM_NEW y
-      source drivers/char/drm/Config.in
-   fi
-fi
+source drivers/char/DRM-Config.in
 
 if [ "$CONFIG_HOTPLUG" = "y" -a "$CONFIG_PCMCIA" != "n" ]; then
    source drivers/char/pcmcia/Config.in
--- a/drivers/char/DRM-Config.in	2002-12-13 01:55:47.000000000 +0100
+++ b/drivers/char/DRM-Config.in	2002-12-18 13:50:54.000000000 +0100
@@ -0,0 +1,16 @@
+mainmenu_option next_comment
+comment 'Direct Rendering Manager (XFree86 DRI support)'
+bool 'Direct Rendering Manager (XFree86 DRI support)' CONFIG_DRM
+if [ "$CONFIG_DRM" = "y" ]; then
+   bool '  Build drivers for old (XFree 4.0) DRM' CONFIG_DRM_OLD
+   if [ "$CONFIG_DRM_OLD" = "y" ]; then
+      comment 'DRM 4.0 drivers'
+      source drivers/char/drm-4.0/Config.in
+   else
+      comment 'DRM 4.1 drivers'   
+      define_bool CONFIG_DRM_NEW y
+      source drivers/char/drm/Config.in
+   fi
+fi
+endmenu
+

--Boundary-00=_ROkK/e/TZgHxMmh--


