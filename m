Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317572AbSGXVKA>; Wed, 24 Jul 2002 17:10:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317577AbSGXVKA>; Wed, 24 Jul 2002 17:10:00 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:52494 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S317572AbSGXVJ7>;
	Wed, 24 Jul 2002 17:09:59 -0400
Date: Wed, 24 Jul 2002 23:20:21 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: torvalds@transmeta.com, davej@suse.de, rmk@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Made 'make sgmldocs' work again after serial merge [1/9]
Message-ID: <20020724232021.A12622@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

9 patches follows dealing with the kernel-documentation.
1	Changes after move of serial drivers
2-4	Corrections to kernel-doc, mainly forward porting from 2.4
5-7	Rewrite of docproc, docbook makefile + related stuff
8-9	Changes in top-level makefile

Except for the changes in kernel-doc this is equal to the single patch
submitted yesterday. But reading the patch I felt a few more comments were
needed, so I decided to split it up a bit.

Applies to Linus'es BK-latest.

	Sam

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.431   -> 1.432  
#	Documentation/DocBook/kernel-api.tmpl	1.15    -> 1.16   
#	Documentation/DocBook/Makefile	1.27    -> 1.28   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/07/24	sam@mars.ravnborg.org	1.432
# [PATCH] Made 'make sgmldocs' work again after serial merge [1/8]
# o Changed targets in documentation/DocBook/Makefile
# o New filenames in DocBook/kernel-api.tmpl
# --------------------------------------------
#
diff -Nru a/Documentation/DocBook/Makefile b/Documentation/DocBook/Makefile
--- a/Documentation/DocBook/Makefile	Wed Jul 24 22:06:00 2002
+++ b/Documentation/DocBook/Makefile	Wed Jul 24 22:06:00 2002
@@ -107,7 +107,8 @@
 		$(TOPDIR)/kernel/printk.c \
 		$(TOPDIR)/drivers/net/net_init.c \
 		$(TOPDIR)/drivers/net/8390.c \
-		$(TOPDIR)/drivers/char/serial.c \
+		$(TOPDIR)/drivers/serial/core.c \
+		$(TOPDIR)/drivers/serial/8250.c \
 		$(TOPDIR)/drivers/pci/pci.c \
 		$(TOPDIR)/drivers/hotplug/pci_hotplug_core.c \
 		$(TOPDIR)/drivers/hotplug/pci_hotplug_util.c \
diff -Nru a/Documentation/DocBook/kernel-api.tmpl b/Documentation/DocBook/kernel-api.tmpl
--- a/Documentation/DocBook/kernel-api.tmpl	Wed Jul 24 22:06:00 2002
+++ b/Documentation/DocBook/kernel-api.tmpl	Wed Jul 24 22:06:00 2002
@@ -305,7 +305,8 @@
 
   <chapter id="uart16x50">
      <title>16x50 UART Driver</title>
-!Edrivers/char/serial.c
+!Edrivers/serial/core.c
+!Edrivers/serial/8250.c
   </chapter>
 
   <chapter id="z85230">
