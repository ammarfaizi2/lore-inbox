Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261614AbTCQLcr>; Mon, 17 Mar 2003 06:32:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261627AbTCQLcq>; Mon, 17 Mar 2003 06:32:46 -0500
Received: from lopsy-lu.misterjones.org ([62.4.18.26]:11020 "EHLO
	young-lust.wild-wind.fr.eu.org") by vger.kernel.org with ESMTP
	id <S261614AbTCQLcp>; Mon, 17 Mar 2003 06:32:45 -0500
To: sam@ravnborg.org
Cc: linux-kernel@vger.kernel.org, torvals@transmeta.com
Subject: [PATCH][KBUILD] Fix filechk_gen-asm-offsets
Organization: Metropolis -- Nowhere
X-Attribution: maz
Reply-to: mzyngier@freesurf.fr
From: Marc Zyngier <mzyngier@freesurf.fr>
Date: 17 Mar 2003 12:42:15 +0100
Message-ID: <wrpisuib4o8.fsf@hina.wild-wind.fr.eu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam,

It looks like kbuild was recently broken by the filechk changes.
At least on Alpha, filechk_gen-asm-offsets is getting nothing but
stdin... Not very useful ;-). All platforms but x86 look broken too.

The enclosed patchlet fixes my compilation problems.

Thanks,

        M.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1065  -> 1.1066 
#	            Makefile	1.396   -> 1.397  
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/03/17	maz@hina.wild-wind.fr.eu.org	1.1066
# Fix Makefile:filechk_gen-asm-offsets.
# It was getting nothing but stdin.
# --------------------------------------------
#
diff -Nru a/Makefile b/Makefile
--- a/Makefile	Mon Mar 17 12:35:17 2003
+++ b/Makefile	Mon Mar 17 12:35:17 2003
@@ -573,7 +573,7 @@
 	 echo ""; \
 	 sed -ne "/^->/{s:^->\([^ ]*\) [\$$#]*\([^ ]*\) \(.*\):#define \1 \2 /* \3 */:; s:->::; p;}"; \
 	 echo ""; \
-	 echo "#endif" )
+	 echo "#endif" ) < $<
 endef
 
 else # ifdef include_config

-- 
Places change, faces change. Life is so very strange.
