Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267550AbUHJQm5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267550AbUHJQm5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 12:42:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267553AbUHJQli
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 12:41:38 -0400
Received: from dsl-64-30-195-78.lcinet.net ([64.30.195.78]:13497 "EHLO
	jg555.com") by vger.kernel.org with ESMTP id S267550AbUHJQYf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 12:24:35 -0400
Message-ID: <4118F6AC.7080903@jg555.com>
Date: Tue, 10 Aug 2004 09:24:12 -0700
From: Jim Gifford <maillist@jg555.com>
User-Agent: Mozilla Thunderbird 0.7.3 (Windows/20040803)
X-Accept-Language: en-us, en
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_server-5150-1092155051-0001-2"
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
CC: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: Linux Kernel bug report (includes fix)
References: <200408101234.i7ACYdwP013901@burner.fokus.fraunhofer.de>
In-Reply-To: <200408101234.i7ACYdwP013901@burner.fokus.fraunhofer.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_server-5150-1092155051-0001-2
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

There is a simple fix to your problem, I have sent this patch to you a 
few times, but never got an answer.

I bet eveyone here will agree, this is the proper way to fix the issue

diff -Naur cdrtools-2.01.orig/DEFAULTS/Defaults.gnu 
cdrtools-2.01/DEFAULTS/Defaults.gnu
--- cdrtools-2.01.orig/DEFAULTS/Defaults.gnu    2003-02-16 
00:01:47.000000000 +0000
+++ cdrtools-2.01/DEFAULTS/Defaults.gnu    2004-05-07 00:52:58.111410726 
+0000
@@ -18,7 +18,7 @@
 ###########################################################################
 CWARNOPTS=
 
-DEFINCDIRS=    $(SRCROOT)/include /usr/src/linux/include
+DEFINCDIRS=    $(SRCROOT)/include
 LDPATH=        -L/opt/schily/lib
 RUNPATH=    -R $(INS_BASE)/lib -R /opt/schily/lib -R $(OLIBSDIR)
 
diff -Naur cdrtools-2.01.orig/DEFAULTS/Defaults.linux 
cdrtools-2.01/DEFAULTS/Defaults.linux
--- cdrtools-2.01.orig/DEFAULTS/Defaults.linux    2003-02-16 
00:01:48.000000000 +0000
+++ cdrtools-2.01/DEFAULTS/Defaults.linux    2004-05-07 
00:53:05.850026970 +0000
@@ -18,7 +18,7 @@
 ###########################################################################
 CWARNOPTS=
 
-DEFINCDIRS=    $(SRCROOT)/include /usr/src/linux/include
+DEFINCDIRS=    $(SRCROOT)/include
 LDPATH=        -L/opt/schily/lib
 RUNPATH=    -R $(INS_BASE)/lib -R /opt/schily/lib -R $(OLIBSDIR)
 
diff -Naur cdrtools-2.01.orig/libscg/scsi-linux-sg.c 
cdrtools-2.01/libscg/scsi-linux-sg.c
--- cdrtools-2.01.orig/libscg/scsi-linux-sg.c    2004-04-18 
10:26:44.000000000 +0000
+++ cdrtools-2.01/libscg/scsi-linux-sg.c    2004-05-07 
00:52:47.953227014 +0000
@@ -65,6 +65,14 @@
 
 #if LINUX_VERSION_CODE >= 0x01031a /* <linux/scsi.h> introduced in 
1.3.26 */
 #if LINUX_VERSION_CODE >= 0x020000 /* <scsi/scsi.h> introduced 
somewhere. */
+
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 0)
+    #define __KERNEL__
+    #include <asm/types.h>
+    #include <asm/byteorder.h>
+    #undef __KERNEL__
+#endif
+
 /* Need to fine tune the ifdef so we get the transition point right. */
 #include <scsi/scsi.h>
 #else

-- 
----
Jim Gifford
maillist@jg555.com


--=_server-5150-1092155051-0001-2
Content-Type: text/x-patch; name="cdrtools-2.01-kernel_2.6-3[1].patch"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cdrtools-2.01-kernel_2.6-3[1].patch"

Submitted By: Jim Gifford (jim at linuxfromscratch dot org)
Date: 2004-05-06
Initial Package Version: 2.01
Origin: Jim Gifford and http://kerneltrap.org/node/view/879
Upstream Status: Sent
Description: Fixes CDRTools Compile with the 2.6 Kernel
 
 
diff -Naur cdrtools-2.01.orig/DEFAULTS/Defaults.gnu cdrtools-2.01/DEFAULTS/Defaults.gnu
--- cdrtools-2.01.orig/DEFAULTS/Defaults.gnu	2003-02-16 00:01:47.000000000 +0000
+++ cdrtools-2.01/DEFAULTS/Defaults.gnu	2004-05-07 00:52:58.111410726 +0000
@@ -18,7 +18,7 @@
 ###########################################################################
 CWARNOPTS=
 
-DEFINCDIRS=	$(SRCROOT)/include /usr/src/linux/include
+DEFINCDIRS=	$(SRCROOT)/include
 LDPATH=		-L/opt/schily/lib
 RUNPATH=	-R $(INS_BASE)/lib -R /opt/schily/lib -R $(OLIBSDIR)
 
diff -Naur cdrtools-2.01.orig/DEFAULTS/Defaults.linux cdrtools-2.01/DEFAULTS/Defaults.linux
--- cdrtools-2.01.orig/DEFAULTS/Defaults.linux	2003-02-16 00:01:48.000000000 +0000
+++ cdrtools-2.01/DEFAULTS/Defaults.linux	2004-05-07 00:53:05.850026970 +0000
@@ -18,7 +18,7 @@
 ###########################################################################
 CWARNOPTS=
 
-DEFINCDIRS=	$(SRCROOT)/include /usr/src/linux/include
+DEFINCDIRS=	$(SRCROOT)/include
 LDPATH=		-L/opt/schily/lib
 RUNPATH=	-R $(INS_BASE)/lib -R /opt/schily/lib -R $(OLIBSDIR)
 
diff -Naur cdrtools-2.01.orig/libscg/scsi-linux-sg.c cdrtools-2.01/libscg/scsi-linux-sg.c
--- cdrtools-2.01.orig/libscg/scsi-linux-sg.c	2004-04-18 10:26:44.000000000 +0000
+++ cdrtools-2.01/libscg/scsi-linux-sg.c	2004-05-07 00:52:47.953227014 +0000
@@ -65,6 +65,14 @@
 
 #if LINUX_VERSION_CODE >= 0x01031a /* <linux/scsi.h> introduced in 1.3.26 */
 #if LINUX_VERSION_CODE >= 0x020000 /* <scsi/scsi.h> introduced somewhere. */
+
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 0)
+	#define __KERNEL__
+	#include <asm/types.h>
+	#include <asm/byteorder.h>
+	#undef __KERNEL__
+#endif
+
 /* Need to fine tune the ifdef so we get the transition point right. */
 #include <scsi/scsi.h>
 #else

--=_server-5150-1092155051-0001-2--
