Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264267AbTLYCtn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Dec 2003 21:49:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264271AbTLYCtn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Dec 2003 21:49:43 -0500
Received: from fmr02.intel.com ([192.55.52.25]:7614 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id S264267AbTLYCtm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Dec 2003 21:49:42 -0500
Date: Thu, 25 Dec 2003 10:43:52 +0800 (CST)
From: "Zhu, Yi" <yi.zhu@intel.com>
X-X-Sender: chuyee@mazda.sh.intel.com
Reply-To: "Zhu, Yi" <yi.zhu@intel.com>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fix make kernel rpm bug
In-Reply-To: <Pine.LNX.4.44.0312101340050.19835-100000@mazda.sh.intel.com>
Message-ID: <Pine.LNX.4.44.0312251035320.16217-100000@mazda.sh.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Below two lines patch makes the rpm rule in top Makefile be aware of
$(ARCH). The old rule will make wrong rpm if ARCH is not the same as
the build machine.


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

