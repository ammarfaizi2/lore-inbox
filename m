Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264781AbSJaJa0>; Thu, 31 Oct 2002 04:30:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264785AbSJaJa0>; Thu, 31 Oct 2002 04:30:26 -0500
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:27661 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S264781AbSJaJaZ>; Thu, 31 Oct 2002 04:30:25 -0500
Date: Thu, 31 Oct 2002 10:36:42 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Aaron Lehmann <aaronl@vitelus.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] check QT only if needed 
In-Reply-To: <20021031013436.GG23438@vitelus.com>
Message-ID: <Pine.LNX.4.44.0210311032530.13258-100000@serv>
References: <Pine.LNX.4.44.0210301651120.6719-100000@penguin.transmeta.com>
 <20021031013436.GG23438@vitelus.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 30 Oct 2002, Aaron Lehmann wrote:

> Now running 'make oldconfig' or 'make menuconfig' requires a Qt
> installation. I believe that this is a bug because these still work
> fine without Qt when the -k flag is passed to make.

Yes, it's a bug. The patch below fixes this without breaking xconfig.
Linus, please apply.

bye, Roman

# Only check for the qt installation if a qconf build is requested

--- linux-2.5/scripts/kconfig/Makefile.org	2002-10-28 00:15:29.000000000 +0100
+++ linux-2.5/scripts/kconfig/Makefile	2002-10-31 10:23:07.000000000 +0100
@@ -34,6 +34,7 @@
 
 $(obj)/qconf.o: $(obj)/.tmp_qtcheck
 
+ifeq ($(MAKECMDGOALS),$(obj)/qconf)
 -include $(obj)/.tmp_qtcheck
 
 # QT needs some extra effort...
@@ -52,6 +53,7 @@
 	LIB=qt; \
 	if [ -f $$DIR/lib/libqt-mt.so ]; then LIB=qt-mt; fi; \
 	echo "QTDIR=$$DIR" > $@; echo "QTLIB=$$LIB" >> $@
+endif
 
 $(obj)/zconf.tab.o: $(obj)/lex.zconf.c
 

