Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263808AbTCUSvo>; Fri, 21 Mar 2003 13:51:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263806AbTCUSuj>; Fri, 21 Mar 2003 13:50:39 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:24964
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263800AbTCUSt1>; Fri, 21 Mar 2003 13:49:27 -0500
Date: Fri, 21 Mar 2003 20:04:43 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303212004.h2LK4hLH026223@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH; tidy up make rpm
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/Makefile linux-2.5.65-ac2/Makefile
--- linux-2.5.65/Makefile	2003-03-18 16:46:45.000000000 +0000
+++ linux-2.5.65-ac2/Makefile	2003-03-20 18:02:29.000000000 +0000
@@ -164,6 +164,8 @@
 OBJCOPY		= $(CROSS_COMPILE)objcopy
 OBJDUMP		= $(CROSS_COMPILE)objdump
 AWK		= awk
+RPM 		:= $(shell if [ -x "/usr/bin/rpmbuild" ]; then echo rpmbuild; \
+		    	else echo rpm; fi)
 GENKSYMS	= scripts/genksyms/genksyms
 DEPMOD		= /sbin/depmod
 KALLSYMS	= scripts/kallsyms
@@ -768,9 +770,7 @@
 	rm $(KERNELPATH) ; \
 	cd $(TOPDIR) ; \
 	$(CONFIG_SHELL) $(srctree)/scripts/mkversion > .version ; \
-	RPM=`which rpmbuild`; \
-	if [ -z "$$RPM" ]; then RPM=rpm; fi; \
-	$$RPM -ta $(TOPDIR)/../$(KERNELPATH).tar.gz ; \
+	$(RPM) -ta $(TOPDIR)/../$(KERNELPATH).tar.gz ; \
 	rm $(TOPDIR)/../$(KERNELPATH).tar.gz
 
 # Brief documentation of the typical targets used
