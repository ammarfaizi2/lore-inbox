Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261756AbUJ1RCn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261756AbUJ1RCn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 13:02:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261850AbUJ1RCm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 13:02:42 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:50445 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S261756AbUJ1RAC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 13:00:02 -0400
Date: Thu, 28 Oct 2004 21:00:20 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       linux-arch@vger.kernel.org
Subject: New kbuild filename: Kbuild
Message-ID: <20041028190020.GB9004@mars.ravnborg.org>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>, linux-arch@vger.kernel.org
References: <20041028185917.GA9004@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041028185917.GA9004@mars.ravnborg.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kbuild: Prefer Kbuild as name of the kbuild files
   
The kbuild syntax is unique and does only have very few things in common with
usual Makefile syntax. So to avoid confusion make the filename 'Kbuild' be
the preferred name as replacement for 'Makefile'.
No global renaming planned to take place for now, but new stuff expected to use
the new 'Kbuild' filename.
   
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

diff -Nru a/Documentation/kbuild/makefiles.txt b/Documentation/kbuild/makefiles.txt
--- a/Documentation/kbuild/makefiles.txt	2004-10-28 20:46:24 +02:00
+++ b/Documentation/kbuild/makefiles.txt	2004-10-28 20:46:24 +02:00
@@ -6,7 +6,7 @@
 
 	=== 1 Overview
 	=== 2 Who does what
-	=== 3 The kbuild Makefiles
+	=== 3 The kbuild files
 	   --- 3.1 Goal definitions
 	   --- 3.2 Built-in object goals - obj-y
 	   --- 3.3 Loadable module goals - obj-m
@@ -101,11 +101,14 @@
 This document is aimed towards normal developers and arch developers.
 
 
-=== 3 The kbuild Makefiles
+=== 3 The kbuild files
 
 Most Makefiles within the kernel are kbuild Makefiles that use the
 kbuild infrastructure. This chapter introduce the syntax used in the
 kbuild makefiles.
+The preferred name for the kbuild files is 'Kbuild' but 'Makefile' will
+continue to be supported. All new developmen is expected to use the
+Kbuild filename.
 
 Section 3.1 "Goal definitions" is a quick intro, further chapters provide
 more details, with real examples.
diff -Nru a/scripts/Makefile.build b/scripts/Makefile.build
--- a/scripts/Makefile.build	2004-10-28 20:46:24 +02:00
+++ b/scripts/Makefile.build	2004-10-28 20:46:24 +02:00
@@ -10,7 +10,7 @@
 # Read .config if it exist, otherwise ignore
 -include .config
 
-include $(obj)/Makefile
+include $(if $(wildcard $(obj)/Kbuild), $(obj)/Kbuild, $(obj)/Makefile)
 
 include scripts/Makefile.lib
 
diff -Nru a/scripts/Makefile.clean b/scripts/Makefile.clean
--- a/scripts/Makefile.clean	2004-10-28 20:46:24 +02:00
+++ b/scripts/Makefile.clean	2004-10-28 20:46:24 +02:00
@@ -7,7 +7,7 @@
 .PHONY: __clean
 __clean:
 
-include $(obj)/Makefile
+include $(if $(wildcard $(obj)/Kbuild), $(obj)/Kbuild, $(obj)/Makefile)
 
 # Figure out what we need to build from the various variables
 # ==========================================================================
