Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268430AbUILJNz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268430AbUILJNz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 05:13:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268540AbUILJNz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 05:13:55 -0400
Received: from [211.58.254.17] ([211.58.254.17]:17388 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S268430AbUILJNu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 05:13:50 -0400
Date: Sun, 12 Sep 2004 18:13:46 +0900
To: linux-kernel@vger.kernel.org
Cc: kai@germaschewski.name
Message-ID: <20040912091346.GA13359@home-tj.org>
Reply-To: patsubstforLOCALVERSIONand-fno-omit-frame-pointer@home-tj.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="7AUc2qLy4jB3hD7Z"
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040818i
From: Tejun Heo <tj@home-tj.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

 Hello, I'm attaching two patches for the top Makefile.

 The first patch modifies LOCALVERSION definition such taht it uses
patsubst instead of subst to remove surrounding double quotes from
CONFIG_LOCALVERSION.  This helps syntax-highlighting editors.

 The second patch addes -fno-omit-frame-pointer to CFLAGS when
CONFIG_FRAME_POINTER is set.  My gcc (gcc-3.3.4 Debian 1:3.3.4-11)
automatically turns on -fomit-frame-pointer when -O2 is specified and
thus breaks CONFIG_FRAME_POINTER option.  I'm not sure if other
versions of gcc wouldn't choke with -fno-omit-frame-pointer.  My 2.95
(2.95.4) seems to be OK though.

-- 
tejun


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="patsubst_localversion.patch"

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/09/12 16:29:12+09:00 tj@htj.dyndns.org 
#   Use patsubst instead of subst to remove surrounding double quotes
#   from CONFIG_LOCALVERSION.  This helps syntax-highlighting editors.
# 
# Makefile
#   2004/09/12 16:29:06+09:00 tj@htj.dyndns.org +1 -1
#   Use patsubst instead of subst to remove surrounding double quotes
#   from CONFIG_LOCALVERSION.  This helps syntax-highlighting editors.
# 
diff -Nru a/Makefile b/Makefile
--- a/Makefile	2004-09-12 18:04:33 +09:00
+++ b/Makefile	2004-09-12 18:04:33 +09:00
@@ -157,7 +157,7 @@
 
 LOCALVERSION = $(subst $(space),, \
 	       $(shell cat /dev/null $(localversion-files)) \
-	       $(subst ",,$(CONFIG_LOCALVERSION)))
+	       $(patsubst "%",%,$(CONFIG_LOCALVERSION)))
 
 KERNELRELEASE=$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)$(LOCALVERSION)
 

--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="noomitframepointer.patch"

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/09/12 16:31:46+09:00 tj@htj.dyndns.org 
#   Newer gcc versions automatically turns on -fomit-frame-pointer when
#   -O2 is specified thus breaking CONFIG_FRAME_POINTER option.
#   Explicitly specifying -fno-omit-frame-pointer fixes it.
# 
# Makefile
#   2004/09/12 16:31:40+09:00 tj@htj.dyndns.org +3 -1
#   Newer gcc versions automatically turns on -fomit-frame-pointer when
#   -O2 is specified thus breaking CONFIG_FRAME_POINTER option.
#   Explicitly specifying -fno-omit-frame-pointer fixes it.
# 
diff -Nru a/Makefile b/Makefile
--- a/Makefile	2004-09-12 18:04:54 +09:00
+++ b/Makefile	2004-09-12 18:04:54 +09:00
@@ -486,7 +486,9 @@
 CFLAGS		+= -O2
 endif
 
-ifndef CONFIG_FRAME_POINTER
+ifdef CONFIG_FRAME_POINTER
+CFLAGS		+= -fno-omit-frame-pointer
+else
 CFLAGS		+= -fomit-frame-pointer
 endif
 

--7AUc2qLy4jB3hD7Z--
