Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262965AbTLQC7b (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 21:59:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263137AbTLQC7b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 21:59:31 -0500
Received: from roc-24-93-20-125.rochester.rr.com ([24.93.20.125]:22774 "EHLO
	mail.kroptech.com") by vger.kernel.org with ESMTP id S262965AbTLQC73
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 21:59:29 -0500
Date: Tue, 16 Dec 2003 22:04:06 -0500
From: Adam Kropelin <akropel1@rochester.rr.com>
To: greg@kroah.com
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] udev-009: Allow build with empty EXTRAS
Message-ID: <20031216220406.A23608@mail.kroptech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Need to let the shell expand $EXTRAS so it can properly detect an empty
list. Without this patch, the build fails whenever $EXTRAS is empty.

--Adam


--- udev-009/Makefile	Tue Dec 16 19:30:32 2003
+++ udev-009-adk/Makefile	Tue Dec 16 21:47:49 2003
@@ -145,7 +145,7 @@
 CFLAGS += -I$(PWD)/libsysfs
 
 all: $(ROOT)
-	@for target in $(EXTRAS) ; do \
+	@extras="$(EXTRAS)" ; for target in $$extras ; do \
 		echo $$target ; \
 		$(MAKE) prefix=$(prefix) LD="$(LD)" SYSFS="$(SYSFS)" \
 			-C $$target $@ ; \
@@ -223,7 +223,7 @@
 	 | xargs rm -f 
 	-rm -f core $(ROOT) $(GEN_HEADERS) $(GEN_CONFIGS)
 	$(MAKE) -C klibc clean
-	@for target in $(EXTRAS) ; do \
+	@extras="$(EXTRAS)" ; for target in $$extras ; do \
 		echo $$target ; \
 		$(MAKE) prefix=$(prefix) LD="$(LD)" SYSFS="$(SYSFS)" \
 			-C $$target $@ ; \
@@ -286,7 +286,7 @@
 	$(INSTALL_DATA) udev.permissions $(DESTDIR)$(configdir)
 	- rm -f $(DESTDIR)$(hotplugdir)/udev.hotplug
 	- ln -s $(sbindir)/$(ROOT) $(DESTDIR)$(hotplugdir)/udev.hotplug
-	@for target in $(EXTRAS) ; do \
+	@extras="$(EXTRAS)" ; for target in $$extras ; do \
 		echo $$target ; \
 		$(MAKE) prefix=$(prefix) LD="$(LD)" SYSFS="$(SYSFS)" \
 			-C $$target $@ ; \
@@ -303,7 +303,7 @@
 	- rmdir $(hotplugdir)
 	- rmdir $(configdir)
 	- rmdir $(udevdir)
-	@for target in $(EXTRAS) ; do \
+	@extras="$(EXTRAS)" ; for target in $$extras ; do \
 		echo $$target ; \
 		$(MAKE) prefix=$(prefix) LD="$(LD)" SYSFS="$(SYSFS)" \
 			-C $$target $@ ; \

