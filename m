Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264745AbTAWDSq>; Wed, 22 Jan 2003 22:18:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264836AbTAWDSq>; Wed, 22 Jan 2003 22:18:46 -0500
Received: from fmr02.intel.com ([192.55.52.25]:56552 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S264745AbTAWDSp>; Wed, 22 Jan 2003 22:18:45 -0500
Subject: [PATCH] cscope support in Makefile
From: Louis Zhuang <louis.zhuang@linux.co.intel.com>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Intel Crop.
Message-Id: <1043292462.1022.15.camel@hawk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 23 Jan 2003 11:27:42 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Kai,
	I add cscope support as well as tags/TAGS in Makefile. If you like it,
pls apply. ;-)
-- 
Yours truly,
Louis Zhuang
---------------
Fault Injection Test Harness Project
BK tree: http://fault-injection.bkbits.net/linux-2.5
Home Page: http://sf.net/projects/fault-injection

===== Makefile 1.357 vs edited =====
--- 1.357/Makefile	Fri Jan 17 10:20:27 2003
+++ edited/Makefile	Thu Jan 23 11:15:26 2003
@@ -190,7 +190,7 @@
 noconfig_targets := xconfig menuconfig config oldconfig randconfig \
 		    defconfig allyesconfig allnoconfig allmodconfig \
 		    clean mrproper distclean \
-		    help tags TAGS sgmldocs psdocs pdfdocs htmldocs \
+		    help tags TAGS cscope sgmldocs psdocs pdfdocs htmldocs \
 		    checkconfig checkhelp checkincludes
 
 RCS_FIND_IGNORE := \( -name SCCS -o -name BitKeeper -o -name .svn -o -name CVS \) -prune -o
@@ -718,7 +718,7 @@
 	.menuconfig.log \
 	include/asm \
 	.hdepend include/linux/modversions.h \
-	tags TAGS kernel.spec \
+	tags TAGS cscope kernel.spec \
 	.tmp*
 
 # Directories removed with 'make mrproper'
@@ -775,6 +775,9 @@
 	       -name '*.[chS]' -print )
 endef
 
+quiet_cmd_cscope = MAKE   $@
+cmd_cscope = $(all-sources) | cscope -k -b -i -
+
 quiet_cmd_TAGS = MAKE   $@
 cmd_TAGS = $(all-sources) | etags -
 
@@ -786,6 +789,9 @@
 	CTAGSF=`ctags --version | grep -i exuberant >/dev/null && echo "-I __initdata,__exitdata,EXPORT_SYMBOL,EXPORT_SYMBOL_NOVERS"`; \
 	$(all-sources) | xargs ctags $$CTAGSF -a
 endef
+
+cscope: FORCE
+	$(call cmd,cscope)
 
 TAGS: FORCE
 	$(call cmd,TAGS)


