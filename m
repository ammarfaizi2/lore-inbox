Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932295AbWFXAVY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932295AbWFXAVY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 20:21:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932736AbWFXAVY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 20:21:24 -0400
Received: from mx1.suse.de ([195.135.220.2]:61839 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932490AbWFXAVP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 20:21:15 -0400
Date: Sat, 24 Jun 2006 02:21:14 +0200
From: "Andi Kleen" <ak@suse.de>
To: torvalds@osdl.org
Cc: discuss@x86-64.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       hpa@zytor.com
Subject: [PATCH] [55/82] i386/x86-64: Fix isoimage when syslinux is in 
 /usr/share
Message-ID: <449C857A.mailDLW18S19K@suse.de>
User-Agent: nail 10.6 11/15/03
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It's like this on SUSE systems.

Cc: hpa@zytor.com

Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/i386/boot/Makefile   |    9 +++++++--
 arch/x86_64/boot/Makefile |    9 +++++++--
 2 files changed, 14 insertions(+), 4 deletions(-)

Index: linux/arch/x86_64/boot/Makefile
===================================================================
--- linux.orig/arch/x86_64/boot/Makefile
+++ linux/arch/x86_64/boot/Makefile
@@ -107,8 +107,13 @@ fdimage288: $(BOOTIMAGE) $(obj)/mtools.c
 isoimage: $(BOOTIMAGE)
 	-rm -rf $(obj)/isoimage
 	mkdir $(obj)/isoimage
-	cp `echo /usr/lib*/syslinux/isolinux.bin | awk '{ print $1; }'` \
-		$(obj)/isoimage
+	for i in lib lib64 share end ; do \
+		if [ -f /usr/$$i/syslinux/isolinux.bin ] ; then \
+			cp /usr/$$i/syslinux/isolinux.bin $(obj)/isoimage ; \
+			break ; \
+		fi ; \
+		if [ $$i = end ] ; then exit 1 ; fi ; \
+	done
 	cp $(BOOTIMAGE) $(obj)/isoimage/linux
 	echo '$(image_cmdline)' > $(obj)/isoimage/isolinux.cfg
 	if [ -f '$(FDINITRD)' ] ; then \
Index: linux/arch/i386/boot/Makefile
===================================================================
--- linux.orig/arch/i386/boot/Makefile
+++ linux/arch/i386/boot/Makefile
@@ -109,8 +109,13 @@ fdimage288: $(BOOTIMAGE) $(obj)/mtools.c
 isoimage: $(BOOTIMAGE)
 	-rm -rf $(obj)/isoimage
 	mkdir $(obj)/isoimage
-	cp `echo /usr/lib*/syslinux/isolinux.bin | awk '{ print $1; }'` \
-		$(obj)/isoimage
+	for i in lib lib64 share end ; do \
+		if [ -f /usr/$$i/syslinux/isolinux.bin ] ; then \
+			cp /usr/$$i/syslinux/isolinux.bin $(obj)/isoimage ; \
+			break ; \
+		fi ; \
+		if [ $$i = end ] ; then exit 1 ; fi ; \
+	done
 	cp $(BOOTIMAGE) $(obj)/isoimage/linux
 	echo '$(image_cmdline)' > $(obj)/isoimage/isolinux.cfg
 	if [ -f '$(FDINITRD)' ] ; then \
