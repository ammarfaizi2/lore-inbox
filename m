Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263485AbTLJJMj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 04:12:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263486AbTLJJMj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 04:12:39 -0500
Received: from fmr99.intel.com ([192.55.52.32]:47765 "EHLO
	hermes-pilot.fm.intel.com") by vger.kernel.org with ESMTP
	id S263485AbTLJJMi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 04:12:38 -0500
Date: Wed, 10 Dec 2003 17:06:43 +0800 (CST)
From: "Zhu, Yi" <yi.zhu@intel.com>
X-X-Sender: chuyee@mazda.sh.intel.com
Reply-To: "Zhu, Yi" <yi.zhu@intel.com>
To: linux-kernel@vger.kernel.org
Subject: Make rpm patch for cross compile 2.6.0-test11
Message-ID: <Pine.LNX.4.44.0312101340050.19835-100000@mazda.sh.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I found the rpm rule in top Makefile has some problem when I was cross
compiling a ia64 kernel in a ia32 build machine. Below patch can fix this
bug.


diff -Nru a/Makefile b/Makefile
--- a/Makefile	Wed Dec 10 13:47:52 2003
+++ b/Makefile	Wed Dec 10 13:47:52 2003
@@ -872,7 +872,7 @@
 	$(CONFIG_SHELL) $(srctree)/scripts/mkversion > $(objtree)/.tmp_version;\
 	mv -f $(objtree)/.tmp_version $(objtree)/.version;
 
-	$(RPM) -ta ../$(KERNELPATH).tar.gz
+	$(RPM) --target $(ARCH) -ta ../$(KERNELPATH).tar.gz
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

Zhu Yi (Chuyee)

GnuPG v1.0.6 (GNU/Linux)
http://cn.geocities.com/chewie_chuyee/gpg.txt or
$ gpg --keyserver wwwkeys.pgp.net --recv-keys 71C34820
1024D/71C34820 C939 2B0B FBCE 1D51 109A  55E5 8650 DB90 71C3 4820

