Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129552AbQLABbP>; Thu, 30 Nov 2000 20:31:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131080AbQLABbF>; Thu, 30 Nov 2000 20:31:05 -0500
Received: from ezri.xs4all.nl ([194.109.253.9]:9153 "HELO ezri.xs4all.nl")
	by vger.kernel.org with SMTP id <S129552AbQLABaw>;
	Thu, 30 Nov 2000 20:30:52 -0500
Date: Fri, 1 Dec 2000 02:00:19 +0100 (CET)
From: Eric Lammerts <eric@lammerts.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] /lib/modules/`uname -r`/build is not created
Message-ID: <Pine.LNX.4.21.0012010147220.8169-100000@ally.lammerts.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Since 2.2.18pre20, the symlink /lib/modules/`uname -r`/build is not
created because of a non-escaped $ in Makefile.

Patch:

--- linux/Makefile.orig	Fri Dec  1 01:39:24 2000
+++ linux/Makefile	Fri Dec  1 01:39:32 2000
@@ -335,7 +335,7 @@
 	MODLIB=$(INSTALL_MOD_PATH)/lib/modules/$(KERNELRELEASE); \
 	mkdir -p $$MODLIB; \
 	rm -f $$MODLIB/build; \
-	[ `/sbin/insmod -V 2>&1 | head -1 | awk '/^insmod version /{split("$3", a, /\./); printf "%d%03d%03d\n", a[1], a[2], a[3];}'`0 -ge 20030140 ] && \
+	[ `/sbin/insmod -V 2>&1 | head -1 | awk '/^insmod version /{split($$3, a, /\./); printf "%d%03d%03d\n", a[1], a[2], a[3];}'`0 -ge 20030140 ] && \
 	ln -s `pwd` $$MODLIB/build; \
 	cd modules; \
 	MODULES=""; \


Eric

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
