Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267565AbUG2SMO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267565AbUG2SMO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 14:12:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267505AbUG2SJL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 14:09:11 -0400
Received: from omx1-ext.SGI.COM ([192.48.179.11]:6338 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S267474AbUG2SHl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 14:07:41 -0400
Date: Thu, 29 Jul 2004 13:07:32 -0500
From: Greg Edwards <edwardsg@sgi.com>
To: kai@germaschewski.name, sam@ravnborg.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] add ia64 support to rpm Makefile target
Message-ID: <20040729180732.GA15920@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On ia64, only the EFI (fat) partition is available to boot from.  The rpm
needs to install the kernel under /boot/efi to be useable on ia64.

Signed-off-by: Greg Edwards <edwardsg@sgi.com>


# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/07/29 13:00:54-05:00 edwardsg@attica.americas.sgi.com 
#   Add ia64 support to the rpm Makefile target.
# 
# scripts/package/mkspec
#   2004/07/29 13:00:41-05:00 edwardsg@attica.americas.sgi.com +13 -2
#   On ia64, only the EFI (fat) partition is available to boot from.  The
#   rpm needs to install the kernel under /boot/efi to be useable on ia64.
# 
diff -Nru a/scripts/package/mkspec b/scripts/package/mkspec
--- a/scripts/package/mkspec	2004-07-29 13:04:34 -05:00
+++ b/scripts/package/mkspec	2004-07-29 13:04:34 -05:00
@@ -43,10 +43,21 @@
 echo "make clean && make"
 echo ""
 echo "%install"
-echo 'mkdir -p $RPM_BUILD_ROOT/boot $RPM_BUILD_ROOT/lib $RPM_BUILD_ROOT/lib/modules'
+
+if [[ "$ARCH" != "ia64" ]]; then
+	echo 'mkdir -p $RPM_BUILD_ROOT/boot $RPM_BUILD_ROOT/lib $RPM_BUILD_ROOT/lib/modules'
+else
+	echo 'mkdir -p $RPM_BUILD_ROOT/boot/efi $RPM_BUILD_ROOT/lib $RPM_BUILD_ROOT/lib/modules'
+fi
 
 echo 'INSTALL_MOD_PATH=$RPM_BUILD_ROOT make modules_install'
-echo 'cp $KBUILD_IMAGE $RPM_BUILD_ROOT'"/boot/vmlinuz-$VERSION.$PATCHLEVEL.$SUBLEVEL$EXTRAVERSION"
+
+if [[ "$ARCH" != "ia64" ]]; then
+	echo 'cp $KBUILD_IMAGE $RPM_BUILD_ROOT'"/boot/vmlinuz-$VERSION.$PATCHLEVEL.$SUBLEVEL$EXTRAVERSION"
+else
+	echo 'cp $KBUILD_IMAGE $RPM_BUILD_ROOT'"/boot/efi/vmlinuz-$VERSION.$PATCHLEVEL.$SUBLEVEL$EXTRAVERSION"
+	echo 'ln -s '"efi/vmlinuz-$VERSION.$PATCHLEVEL.$SUBLEVEL$EXTRAVERSION" '$RPM_BUILD_ROOT'"/boot/"
+fi
 
 echo 'cp System.map $RPM_BUILD_ROOT'"/boot/System.map-$VERSION.$PATCHLEVEL.$SUBLEVEL$EXTRAVERSION"
 
