Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262566AbTL2DZN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Dec 2003 22:25:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262569AbTL2DZN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Dec 2003 22:25:13 -0500
Received: from fmr05.intel.com ([134.134.136.6]:51609 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S262566AbTL2DZH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Dec 2003 22:25:07 -0500
Date: Mon, 29 Dec 2003 11:19:07 +0800 (CST)
From: "Zhu, Yi" <yi.zhu@intel.com>
X-X-Sender: chuyee@mazda.sh.intel.com
Reply-To: "Zhu, Yi" <yi.zhu@intel.com>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fix make kernel rpm bug (revised)
In-Reply-To: <Pine.LNX.4.44.0312251035320.16217-100000@mazda.sh.intel.com>
Message-ID: <Pine.LNX.4.44.0312291113340.10106-100000@mazda.sh.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks for Jeff and Russell King's help, I now revised the patch as
below.


diff -Nru a/Makefile b/Makefile
--- a/Makefile	Wed Dec 10 13:47:52 2003
+++ b/Makefile	Wed Dec 10 13:47:52 2003
@@ -872,7 +872,7 @@
 	$(CONFIG_SHELL) $(srctree)/scripts/mkversion > $(objtree)/.tmp_version;\
 	mv -f $(objtree)/.tmp_version $(objtree)/.version;
 
-	$(RPM) -ta ../$(KERNELPATH).tar.gz
+	$(RPM) --target $(UTS_MACHINE) -ta ../$(KERNELPATH).tar.gz
 	rm ../$(KERNELPATH).tar.gz
 
 # Brief documentation of the typical targets used
diff -Nru a/scripts/mkspec b/scripts/mkspec
--- a/scripts/mkspec	Wed Dec 10 13:47:52 2003
+++ b/scripts/mkspec	Wed Dec 10 13:47:52 2003
@@ -9,7 +9,7 @@
 #	Patched for non-x86 by Opencon (L) 2002 <opencon@rio.skydome.net>
 #
 # That's the voodoo to see if it's a x86.
-ISX86=`arch | grep -ie i.86`
+ISX86=`echo ${ARCH:=\`arch\`} | grep -ie i.86`
 if [ ! -z $ISX86 ]; then
 	PC=1
 else


Thanks,
-- 
-----------------------------------------------------------------
Opinions expressed are those of the author and do not represent
Intel Corp.

-yi

