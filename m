Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263327AbSITTAU>; Fri, 20 Sep 2002 15:00:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263334AbSITTAU>; Fri, 20 Sep 2002 15:00:20 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:57547 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S263327AbSITTAT>; Fri, 20 Sep 2002 15:00:19 -0400
Date: Fri, 20 Sep 2002 14:04:19 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Bill Davidsen <davidsen@tmr.com>
cc: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.36-mm1 compile (fwd)
In-Reply-To: <Pine.LNX.3.96.1020920120132.29079D-300000@gatekeeper.tmr.com>
Message-ID: <Pine.LNX.4.44.0209201403460.14323-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Sep 2002, Bill Davidsen wrote:

> I tried to build 2.5.36-mm1 on a PII-350 with RH7.3. Make menuconfig, make
> dep, make bzImage. Tried backing up the config, make mrproper, install
> config, make oldconfig, make dep, make bzImage. Still no go.

Could you please let me know if this patch fixes it?

--Kai


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.579   -> 1.580  
#	            Makefile	1.304   -> 1.305  
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/09/20	kai@tp1.ruhr-uni-bochum.de	1.580
# kbuild: Fix modversions generation glitch
# 
# Some people have their "cd" command print $PWD, so they would end
# up with $PWD in their include/modversions.h, which is not quite what we
# want.
# --------------------------------------------
#
diff -Nru a/Makefile b/Makefile
--- a/Makefile	Fri Sep 20 14:03:35 2002
+++ b/Makefile	Fri Sep 20 14:03:35 2002
@@ -436,7 +436,8 @@
 	@( echo "#ifndef _LINUX_MODVERSIONS_H";\
 	   echo "#define _LINUX_MODVERSIONS_H"; \
 	   echo "#include <linux/modsetver.h>"; \
-	   for f in `cd .tmp_export-objs; find modules -name SCCS -prune -o -name BitKeeper -prune -o -name \*.ver -print | sort`; do \
+	   cd .tmp_export-objs >/dev/null; \
+	   for f in `find modules -name \*.ver -print | sort`; do \
 	     echo "#include <linux/$${f}>"; \
 	   done; \
 	   echo "#endif"; \

