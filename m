Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262794AbUJ0XWW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262794AbUJ0XWW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 19:22:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262777AbUJ0XTb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 19:19:31 -0400
Received: from gandalf.tausq.org ([64.81.244.94]:48612 "EHLO pippin.tausq.org")
	by vger.kernel.org with ESMTP id S262754AbUJ0XSL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 19:18:11 -0400
Date: Wed, 27 Oct 2004 16:18:14 -0700
From: Randolph Chung <randolph@tausq.org>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [patch/Makefile] Fix cc-option call for xcompiles
Message-ID: <20041027231814.GF12356@tausq.org>
Reply-To: Randolph Chung <randolph@tausq.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GPG: for GPG key, see http://www.tausq.org/gpg.txt
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If an arch Makefile overrides CROSS_COMPILE (e.g. parisc, mips, ...)
then the cc-option call in the main Makefile uses the wrong compiler 
to check for options.

Signed-off-by: Randolph Chung <tausq@debian.org>

Index: Makefile
===================================================================
RCS file: /var/cvs/linux-2.6/Makefile,v
retrieving revision 1.281
diff -u -p -r1.281 Makefile
--- Makefile	27 Oct 2004 21:23:19 -0000	1.281
+++ Makefile	27 Oct 2004 23:16:30 -0000
@@ -494,10 +494,10 @@ ifdef CONFIG_DEBUG_INFO
 CFLAGS		+= -g
 endif
 
+include $(srctree)/arch/$(ARCH)/Makefile
+
 # warn about C99 declaration after statement
 CFLAGS += $(call cc-option,-Wdeclaration-after-statement,)
-
-include $(srctree)/arch/$(ARCH)/Makefile
 
 # Default kernel image to build when no specific target is given.
 # KBUILD_IMAGE may be overruled on the commandline or

-- 
Randolph Chung
Debian GNU/Linux Developer, hppa/ia64 ports
http://www.tausq.org/
