Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261280AbUKHWen@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261280AbUKHWen (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 17:34:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261275AbUKHWem
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 17:34:42 -0500
Received: from pfepc.post.tele.dk ([195.41.46.237]:22812 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S261280AbUKHWdn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 17:33:43 -0500
Date: Mon, 8 Nov 2004 23:34:09 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.10-rc1-mm3: (fix for make xconfig)
Message-ID: <20041108223409.GB16261@mars.ravnborg.org>
Mail-Followup-To: "Rafael J. Wysocki" <rjw@sisk.pl>,
	linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>,
	Andrew Morton <akpm@osdl.org>
References: <20041105001328.3ba97e08.akpm@osdl.org> <200411051907.19008.rjw@sisk.pl> <200411051948.32936.rjw@sisk.pl> <20041105202601.GA8785@mars.opasia.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041105202601.GA8785@mars.opasia.dk>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2004 at 09:26:01PM +0100, Sam Ravnborg wrote:
 
> Wrong fix.
> I will look into it later tonight.

Here is the fix. Tested with both xconfg and gconfig.

	Sam

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/11/06 21:18:02+01:00 sam@mars.ravnborg.org 
#   kconfig: fix xconfig and gconfig
#   
#   Patch that disabled use of loadable modules broke qconf and gconf.
#   Fixed by disabling this also for these targets.
#   
#   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
# 
# scripts/kconfig/Makefile
#   2004/11/06 21:17:26+01:00 sam@mars.ravnborg.org +5 -4
#   Enable build of qconf anf gconf without loadable module support
# 
diff -Nru a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
--- a/scripts/kconfig/Makefile	2004-11-08 23:33:26 +01:00
+++ b/scripts/kconfig/Makefile	2004-11-08 23:33:26 +01:00
@@ -84,11 +84,11 @@
 
 ifeq ($(qconf-target),1)
 qconf-cxxobjs	:= qconf.o
-qconf-objs	:= kconfig_load.o
+qconf-objs	:= kconfig_load.o zconf.tab.o
 endif
 
 ifeq ($(gconf-target),1)
-gconf-objs	:= gconf.o kconfig_load.o
+gconf-objs	:= gconf.o kconfig_load.o zconf.tab.o
 endif
 
 clean-files	:= lkc_defs.h qconf.moc .tmp_qtcheck \
@@ -99,10 +99,11 @@
 HOSTCFLAGS_zconf.tab.o	:= -I$(src)
 
 HOSTLOADLIBES_qconf	= -L$(QTLIBPATH) -Wl,-rpath,$(QTLIBPATH) -l$(QTLIB) -ldl
-HOSTCXXFLAGS_qconf.o	= -I$(QTDIR)/include 
+HOSTCXXFLAGS_qconf.o	= -I$(QTDIR)/include -D LKC_DIRECT_LINK
 
 HOSTLOADLIBES_gconf	= `pkg-config gtk+-2.0 gmodule-2.0 libglade-2.0 --libs`
-HOSTCFLAGS_gconf.o	= `pkg-config gtk+-2.0 gmodule-2.0 libglade-2.0 --cflags`
+HOSTCFLAGS_gconf.o	= `pkg-config gtk+-2.0 gmodule-2.0 libglade-2.0 --cflags` \
+                          -D LKC_DIRECT_LINK
 
 $(obj)/conf.o $(obj)/mconf.o $(obj)/qconf.o $(obj)/gconf.o: $(obj)/zconf.tab.h
 
