Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262469AbTCCJr6>; Mon, 3 Mar 2003 04:47:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262492AbTCCJr5>; Mon, 3 Mar 2003 04:47:57 -0500
Received: from srv1.mail.cv.net ([167.206.112.40]:52916 "EHLO srv1.mail.cv.net")
	by vger.kernel.org with ESMTP id <S262469AbTCCJry>;
	Mon, 3 Mar 2003 04:47:54 -0500
Date: Mon, 03 Mar 2003 04:58:19 -0500 (EST)
From: Pavel Roskin <proski@gnu.org>
Subject: Re: [PATCH] mkdep patch in 2.4.21-pre4-ac7 breaks pci/drivers
In-reply-to: <Pine.LNX.4.51.0303030347020.26129@localhost.localdomain>
X-X-Sender: proski@localhost.localdomain
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>
Message-id: <Pine.LNX.4.51.0303030444310.17059@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <200303020213.h222DM7O003304@eeyore.valparaiso.cl>
 <Pine.LNX.4.51.0303030347020.26129@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> This patch has been tested and works for me.  How to test:

I'm terribly sorry, my testing was incorrect (I was looking at a wrong
window).  One more change needs to be done.  Since name.o becomes the
first rule, it becomes the default rule instead of driver.o, which is not
created.

The trick (already used in drivers/net/hamradio/soundmodem/Makefile) is to
define the first rule as

all: all_targets

Fixed patch:

===================================
--- linux.orig/drivers/pci/Makefile
+++ linux/drivers/pci/Makefile
@@ -35,10 +35,11 @@
 obj-y += syscall.o
 endif

-include $(TOPDIR)/Rules.make
-
+all: all_targets
 names.o: names.c devlist.h classlist.h

+include $(TOPDIR)/Rules.make
+
 devlist.h classlist.h: pci.ids gen-devlist
 	./gen-devlist <pci.ids

===================================

This patch was tested all the way to "make install" and reboot.

-- 
Regards,
Pavel Roskin
