Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268339AbUIKVgq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268339AbUIKVgq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 17:36:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268336AbUIKVgq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 17:36:46 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:9262 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S268356AbUIKVg3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 17:36:29 -0400
Date: Sat, 11 Sep 2004 23:36:36 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Tom Rini <trini@kernel.crashing.org>, Olaf Hering <olaf@aepfle.de>,
       linux-kernel@vger.kernel.org
Subject: kbuild/ppc: Fix to enable build of ppc again
Message-ID: <20040911213636.GA22409@mars.ravnborg.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Tom Rini <trini@kernel.crashing.org>, Olaf Hering <olaf@aepfle.de>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus - please apply.

I tricked Tom Rini into doing some wrong modifications to
arch/ppc/boot/lib/Makefile. The result is that ppc cannot
be build (at least not the boot/lib part).

The attaced patch fixes this.
Compile tested.

Please pull from:

	bk pull bk://linux-sam.bkbits.net/kbuild

	(This is the only patch pushed).

	Sam
	

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/09/11 23:25:45+02:00 sam@mars.ravnborg.org 
#   kbuild/ppc: Fix build of zlib in arch/ppc/boot/lib
#   
#   $(addprefix ...) needs a directory relative to current directory, because
#   kbuild prefixes the filename with '$(obj)/'
#   
#   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
# 
# arch/ppc/boot/lib/Makefile
#   2004/09/11 23:25:28+02:00 sam@mars.ravnborg.org +2 -2
#   fix path in addprefix
# 
diff -Nru a/arch/ppc/boot/lib/Makefile b/arch/ppc/boot/lib/Makefile
--- a/arch/ppc/boot/lib/Makefile	2004-09-11 23:26:41 +02:00
+++ b/arch/ppc/boot/lib/Makefile	2004-09-11 23:26:41 +02:00
@@ -4,7 +4,7 @@
 
 CFLAGS_kbd.o	+= -Idrivers/char
 
-lib-y := $(addprefix lib/zlib_inflate/,infblock.o infcodes.o inffast.o \
-				       inflate.o inftrees.o infutil.o)
+lib-y := $(addprefix ../../../../lib/zlib_inflate/, \
+           infblock.o infcodes.o inffast.o inflate.o inftrees.o infutil.o)
 lib-y += div64.o
 lib-$(CONFIG_VGA_CONSOLE) += vreset.o kbd.o
