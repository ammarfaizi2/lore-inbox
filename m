Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265847AbUIIPao@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265847AbUIIPao (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 11:30:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265887AbUIIPan
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 11:30:43 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:12987 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S265847AbUIIPad (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 11:30:33 -0400
Date: Thu, 9 Sep 2004 08:30:31 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6.9-rc1-bk16] ppc32: Use $(addprefix ...) on arch/ppc/boot/lib/
Message-ID: <20040909153031.GA2945@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following makes arch/ppc/boot/lib/Makefile use $(addprefix ...) to
get lib/zlib_inflate/ source code.  Previously we were manually setting
the dependancy and invoking cc_o_c.  Worse, we were invoking the cmd
version, not the rule version and thus when MODVERSIONS=y, we wouldn't
do the .tmp_foo.o -> foo.o rename, and thus the compile would break.
Using $(addprefix ...) gets us using the standard rules again (and is
shorter to boot).

Signed-off-by: Tom Rini <trini@kernel.crashing.org>

--- 1.7/arch/ppc/boot/lib/Makefile	2004-09-07 23:33:06 -07:00
+++ edited/arch/ppc/boot/lib/Makefile	2004-09-09 08:26:23 -07:00
@@ -4,18 +4,8 @@
 
 CFLAGS_kbd.o	+= -Idrivers/char
 
-$(obj)/infblock.o: lib/zlib_inflate/infblock.c
-	$(call cmd,cc_o_c)
-$(obj)/infcodes.o: lib/zlib_inflate/infcodes.c
-	$(call cmd,cc_o_c)
-$(obj)/inffast.o: lib/zlib_inflate/inffast.c
-	$(call cmd,cc_o_c)
-$(obj)/inflate.o: lib/zlib_inflate/inflate.c
-	$(call cmd,cc_o_c)
-$(obj)/inftrees.o: lib/zlib_inflate/inftrees.c
-	$(call cmd,cc_o_c)
-$(obj)/infutil.o: lib/zlib_inflate/infutil.c
-	$(call cmd,cc_o_c)
+INFLATE		= $(addprefix ../../../../lib/zlib_inflate/, infblock.o	\
+			infcodes.o inffast.o inflate.o inftrees.o infutil.o)
 
-lib-y := infblock.o infcodes.o inffast.o inflate.o inftrees.o infutil.o div64.o
+lib-y := $(INFLATE) div64.o
 lib-$(CONFIG_VGA_CONSOLE) += vreset.o kbd.o

-- 
Tom Rini
http://gate.crashing.org/~trini/
