Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292860AbSBVN3S>; Fri, 22 Feb 2002 08:29:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292863AbSBVN3K>; Fri, 22 Feb 2002 08:29:10 -0500
Received: from johanna5.ux.his.no ([152.94.1.25]:50376 "EHLO
	johanna5.ux.his.no") by vger.kernel.org with ESMTP
	id <S292860AbSBVN3C>; Fri, 22 Feb 2002 08:29:02 -0500
Date: Fri, 22 Feb 2002 14:29:00 +0100 (MET)
From: Erlend Aasland <erlend-a@ux.his.no>
Message-Id: <200202221329.g1MDT0Z28623@johanna5.ux.his.no>
To: linux-kernel@vger.kernel.org
Subject: [PATCH], Reposted: Problems with Documentation/DocBook in 2.5.5
Content-Type: text
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Apology:
Some of you have received this patch twice. I'm very sorry about this, but I had to resend this patch because I forgot to set the To: header in the first mail. Thanks to Bert Hubert for pointing it out and suggesting that I repost it.

The patch:
Patch 2.5.5 moved linux/drivers/sound to linux/sound, which has caused problems with the Documentation/DocBook section. F.x: "make htmldocs" wouldn't work. This tiny patch fixes the problems.

Patch is made against a clean 2.5.5 tree.



Erlend Aasland.

diff -urN linux-2.5.5/Documentation/DocBook/Makefile linux-2.5.5.new/Documentation/DocBook/Makefile
--- linux-2.5.5/Documentation/DocBook/Makefile	Wed Feb 13 01:23:05 2002
+++ linux-2.5.5.new/Documentation/DocBook/Makefile	Thu Feb 21 03:59:58 2002
@@ -59,8 +59,8 @@
 	$(TOPDIR)/scripts/docgen $(TOPDIR)/drivers/net/wan/z85230.c \
 		<z8530book.tmpl >z8530book.sgml
 
-via-audio.sgml: via-audio.tmpl $(TOPDIR)/drivers/sound/via82cxxx_audio.c
-	$(TOPDIR)/scripts/docgen $(TOPDIR)/drivers/sound/via82cxxx_audio.c \
+via-audio.sgml: via-audio.tmpl $(TOPDIR)/sound/oss/via82cxxx_audio.c
+	$(TOPDIR)/scripts/docgen $(TOPDIR)/sound/oss/via82cxxx_audio.c \
 		<via-audio.tmpl >via-audio.sgml
 
 tulip-user.sgml: tulip-user.tmpl
@@ -100,8 +100,8 @@
 		$(TOPDIR)/drivers/hotplug/pci_hotplug_core.c \
 		$(TOPDIR)/drivers/hotplug/pci_hotplug_util.c \
 		$(TOPDIR)/drivers/block/ll_rw_blk.c \
-		$(TOPDIR)/drivers/sound/sound_core.c \
-		$(TOPDIR)/drivers/sound/sound_firmware.c \
+		$(TOPDIR)/sound/sound_core.c \
+		$(TOPDIR)/sound/sound_firmware.c \
 		$(TOPDIR)/drivers/net/wan/syncppp.c \
 		$(TOPDIR)/drivers/net/wan/z85230.c \
 		$(TOPDIR)/drivers/usb/hcd.c \
diff -urN linux-2.5.5/Documentation/DocBook/kernel-api.tmpl linux-2.5.5.new/Documentation/DocBook/kernel-api.tmpl
--- linux-2.5.5/Documentation/DocBook/kernel-api.tmpl	Wed Feb 13 01:23:05 2002
+++ linux-2.5.5.new/Documentation/DocBook/kernel-api.tmpl	Thu Feb 21 11:17:34 2002
@@ -203,8 +203,8 @@
 
   <chapter id="snddev">
      <title>Sound Devices</title>
-!Edrivers/sound/sound_core.c
-!Idrivers/sound/sound_firmware.c
+!Esound/sound_core.c
+!Isound/sound_firmware.c
   </chapter>
 
   <chapter id="usb">
diff -urN linux-2.5.5/Documentation/DocBook/via-audio.tmpl linux-2.5.5.new/Documentation/DocBook/via-audio.tmpl
--- linux-2.5.5/Documentation/DocBook/via-audio.tmpl	Wed Feb 13 01:22:43 2002
+++ linux-2.5.5.new/Documentation/DocBook/via-audio.tmpl	Thu Feb 21 11:19:27 2002
@@ -537,7 +537,7 @@
    </listitem>
    <listitem>
     <para>
- Optimize included headers to eliminate headers found in linux/drivers/sound
+ Optimize included headers to eliminate headers found in linux/sound
 	</para>
    </listitem>
   </itemizedlist>
@@ -587,7 +587,7 @@
   
   <chapter id="intfunctions">
      <title>Internal Functions</title>
-!Idrivers/sound/via82cxxx_audio.c
+!Isound/oss/via82cxxx_audio.c
   </chapter>
 
 </book>

