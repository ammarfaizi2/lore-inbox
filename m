Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262267AbVC3Pti@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262267AbVC3Pti (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 10:49:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262275AbVC3Pth
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 10:49:37 -0500
Received: from webapps.arcom.com ([194.200.159.168]:59922 "EHLO
	webapps.arcom.com") by vger.kernel.org with ESMTP id S262267AbVC3Pt2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 10:49:28 -0500
Subject: use ${CROSS_COMPILE}installkernel in arch/*/boot/install.sh
From: Ian Campbell <icampbell@arcom.com>
To: Andrew Morton <akpm@osdl.org>
Cc: rmk@arm.linux.org.uk, spyro@f2s.com, paulus@samba.org,
       schwidefsky@de.ibm.com, ak@suse.de, linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Arcom Control Systems
Date: Wed, 30 Mar 2005 16:49:26 +0100
Message-Id: <1112197767.18208.34.camel@icampbell-debian>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Mar 2005 15:56:05.0562 (UTC) FILETIME=[FB0699A0:01C53540]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The attached patch causes the various arch specific install.sh scripts
to look for ${CROSS_COMPILE}installkernel rather than just installkernel
(in both /sbin/ and ~/bin/ where the script already did this). This
allows you to have e.g. arm-linux-installkernel as a handy way to
install on your cross target. It also prevents the script picking up on
the host /sbin/installkernel which causes the script to fall through and
do the install itself (which is what I actually use myself, with
$INSTALL_PATH set).

I don't believe it causes back-compatibility problems since calling the
host installkernel was never likely to work or be what you wanted when
cross compiling anyway. If $CROSS_COMPILE isn't set then nothing
changes.

I only use ARM and i386 myself but I figured it couldn't hurt to do the
whole lot. I've cc'd those who I hope are the arch maintainers for files
that I've touched.

Signed-off-by: Ian Campbell <icampbell@arcom.com>

Index: 2.6/arch/arm/boot/install.sh
===================================================================
--- 2.6.orig/arch/arm/boot/install.sh	2005-03-24 14:48:23.000000000 +0000
+++ 2.6/arch/arm/boot/install.sh	2005-03-24 15:07:12.000000000 +0000
@@ -21,8 +21,8 @@
 #
 
 # User may have a custom install script
-if [ -x ~/bin/installkernel ]; then exec ~/bin/installkernel "$@"; fi
-if [ -x /sbin/installkernel ]; then exec /sbin/installkernel "$@"; fi
+if [ -x ~/bin/${CROSS_COMPILE}installkernel ]; then exec ~/bin/${CROSS_COMPILE}installkernel "$@"; fi
+if [ -x /sbin/${CROSS_COMPILE}installkernel ]; then exec /sbin/${CROSS_COMPILE}installkernel "$@"; fi
 
 if [ "$(basename $2)" = "zImage" ]; then
 # Compressed install
Index: 2.6/arch/arm26/boot/install.sh
===================================================================
--- 2.6.orig/arch/arm26/boot/install.sh	2005-03-24 14:48:23.000000000 +0000
+++ 2.6/arch/arm26/boot/install.sh	2005-03-24 15:07:12.000000000 +0000
@@ -23,8 +23,8 @@
 
 # User may have a custom install script
 
-if [ -x /sbin/installkernel ]; then
-  exec /sbin/installkernel "$@"
+if [ -x /sbin/${CROSS_COMPILE}installkernel ]; then
+  exec /sbin/${CROSS_COMPILE}installkernel "$@"
 fi
 
 if [ "$2" = "zImage" ]; then
Index: 2.6/arch/i386/boot/install.sh
===================================================================
--- 2.6.orig/arch/i386/boot/install.sh	2005-03-24 14:48:23.000000000 +0000
+++ 2.6/arch/i386/boot/install.sh	2005-03-24 15:07:13.000000000 +0000
@@ -21,8 +21,8 @@
 
 # User may have a custom install script
 
-if [ -x ~/bin/installkernel ]; then exec ~/bin/installkernel "$@"; fi
-if [ -x /sbin/installkernel ]; then exec /sbin/installkernel "$@"; fi
+if [ -x ~/bin/${CROSS_COMPILE}installkernel ]; then exec ~/bin/${CROSS_COMPILE}installkernel "$@"; fi
+if [ -x /sbin/${CROSS_COMPILE}installkernel ]; then exec /sbin/${CROSS_COMPILE}installkernel "$@"; fi
 
 # Default install - same as make zlilo
 
Index: 2.6/arch/ppc64/boot/install.sh
===================================================================
--- 2.6.orig/arch/ppc64/boot/install.sh	2005-03-24 14:48:23.000000000 +0000
+++ 2.6/arch/ppc64/boot/install.sh	2005-03-24 15:07:13.000000000 +0000
@@ -21,8 +21,8 @@
 
 # User may have a custom install script
 
-if [ -x ~/bin/installkernel ]; then exec ~/bin/installkernel "$@"; fi
-if [ -x /sbin/installkernel ]; then exec /sbin/installkernel "$@"; fi
+if [ -x ~/bin/${CROSS_COMPILE}installkernel ]; then exec ~/bin/${CROSS_COMPILE}installkernel "$@"; fi
+if [ -x /sbin/${CROSS_COMPILE}installkernel ]; then exec /sbin/${CROSS_COMPILE}installkernel "$@"; fi
 
 # Default install
 
Index: 2.6/arch/s390/boot/install.sh
===================================================================
--- 2.6.orig/arch/s390/boot/install.sh	2005-03-24 14:48:24.000000000 +0000
+++ 2.6/arch/s390/boot/install.sh	2005-03-24 15:07:13.000000000 +0000
@@ -21,8 +21,8 @@
 
 # User may have a custom install script
 
-if [ -x ~/bin/installkernel ]; then exec ~/bin/installkernel "$@"; fi
-if [ -x /sbin/installkernel ]; then exec /sbin/installkernel "$@"; fi
+if [ -x ~/bin/${CROSS_COMPILE}installkernel ]; then exec ~/bin/${CROSS_COMPILE}installkernel "$@"; fi
+if [ -x /sbin/${CROSS_COMPILE}installkernel ]; then exec /sbin/${CROSS_COMPILE}installkernel "$@"; fi
 
 # Default install - same as make zlilo
 
Index: 2.6/arch/x86_64/boot/install.sh
===================================================================
--- 2.6.orig/arch/x86_64/boot/install.sh	2005-03-24 14:48:24.000000000 +0000
+++ 2.6/arch/x86_64/boot/install.sh	2005-03-24 15:07:13.000000000 +0000
@@ -21,8 +21,8 @@
 
 # User may have a custom install script
 
-if [ -x ~/bin/installkernel ]; then exec ~/bin/installkernel "$@"; fi
-if [ -x /sbin/installkernel ]; then exec /sbin/installkernel "$@"; fi
+if [ -x ~/bin/${CROSS_COMPILE}installkernel ]; then exec ~/bin/${CROSS_COMPILE}installkernel "$@"; fi
+if [ -x /sbin/${CROSS_COMPILE}installkernel ]; then exec /sbin/${CROSS_COMPILE}installkernel "$@"; fi
 
 # Default install - same as make zlilo
 


-- 
Ian Campbell, Senior Design Engineer
                                        Web: http://www.arcom.com
Arcom, Clifton Road,                    Direct: +44 (0)1223 403 465
Cambridge CB1 7EA, United Kingdom       Phone:  +44 (0)1223 411 200

