Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270626AbTHSOeK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 10:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270627AbTHSOeJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 10:34:09 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:11790 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S270626AbTHSOaz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 10:30:55 -0400
Date: Tue, 19 Aug 2003 16:30:51 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Flameeyes <daps_mls@libero.it>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, Sam Ravnborg <sam@ravnborg.org>
Subject: Re: 2.6.0-test3-mm3
Message-ID: <20030819143051.GA1261@mars.ravnborg.org>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Flameeyes <daps_mls@libero.it>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Sam Ravnborg <sam@ravnborg.org>
References: <20030819013834.1fa487dc.akpm@osdl.org> <1061287775.5995.7.camel@defiant.flameeyes> <20030819032350.55339908.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030819032350.55339908.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 19, 2003 at 03:23:50AM -0700, Andrew Morton wrote:
> > there's a problem with make xconfig:
The following patch fixes it.
I will submit to Linus in separate mail.

	Sam

===== scripts/kconfig/Makefile 1.7 vs edited =====
--- 1.7/scripts/kconfig/Makefile	Sun Aug 17 00:17:57 2003
+++ edited/scripts/kconfig/Makefile	Tue Aug 19 16:27:03 2003
@@ -65,12 +65,20 @@
 conf-objs	:= conf.o  libkconfig.so
 mconf-objs	:= mconf.o libkconfig.so
 
-ifeq ($(MAKECMDGOALS),$(obj)/qconf)
+ifeq ($(MAKECMDGOALS),xconfig)
+	qconf-target := 1
+endif
+ifeq ($(MAKECMDGOALS),gconfig)
+	gconf-target := 1
+endif
+
+
+ifeq ($(qconf-target),1)
 qconf-cxxobjs	:= qconf.o
 qconf-objs	:= kconfig_load.o
 endif
 
-ifeq ($(MAKECMDGOALS),$(obj)/gconf)
+ifeq ($(gconf-target),1)
 gconf-objs	:= gconf.o kconfig_load.o
 endif
 
@@ -91,7 +99,7 @@
 
 $(obj)/qconf.o: $(obj)/.tmp_qtcheck
 
-ifeq ($(MAKECMDGOALS),$(obj)/qconf)
+ifeq ($(qconf-target),1)
 MOC = $(QTDIR)/bin/moc
 -include $(obj)/.tmp_qtcheck
 
@@ -121,7 +129,7 @@
 
 $(obj)/gconf.o: $(obj)/.tmp_gtkcheck
 
-ifeq ($(MAKECMDGOALS),$(obj)/gconf)
+ifeq ($(gconf-target),1)
 -include $(obj)/.tmp_gtkcheck
 
 # GTK needs some extra effort, too...
