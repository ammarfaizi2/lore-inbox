Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262739AbVFWKac@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262739AbVFWKac (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 06:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262683AbVFWK3p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 06:29:45 -0400
Received: from mta09-winn.ispmail.ntl.com ([81.103.221.49]:2696 "EHLO
	mta09-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S262631AbVFWK0K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 06:26:10 -0400
Subject: [PATCH] Allow cscope to index multiple architectures
From: Ian Campbell <ijc@hellion.org.uk>
To: kai@germaschewski.name, sam@ravnborg.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Thu, 23 Jun 2005 11:25:54 +0100
Message-Id: <1119522355.2995.23.camel@icampbell-debian>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a single source tree which I cross compile for a couple of
different architectures using ARHC=foo O=blah etc.

The existing cscope target is very handy but only indexes the current
$(ARCH), which is a pain since inevitably I'm interested in the other
one at any given time ;-). This patch allows me to pass a list of
architectures for cscope to index. e.g.
	make ALLSOURCE_ARCHS="i386 arm" cscope

This change also works for etags etc, and I presume it is just as useful
there.

Signed-off-by: Ian Campbell <ijc@hellion.org.uk>

Index: 2.6/Makefile
===================================================================
--- 2.6.orig/Makefile	2005-06-23 11:15:05.000000000 +0100
+++ 2.6/Makefile	2005-06-23 11:24:12.000000000 +0100
@@ -1156,19 +1156,25 @@
 __srctree = $(srctree)/
 endif
 
+ALLSOURCE_ARCHS := $(ARCH)
+
 define all-sources
 	( find $(__srctree) $(RCS_FIND_IGNORE) \
 	       \( -name include -o -name arch \) -prune -o \
 	       -name '*.[chS]' -print; \
-	  find $(__srctree)arch/$(ARCH) $(RCS_FIND_IGNORE) \
-	       -name '*.[chS]' -print; \
+	  for ARCH in $(ALLSOURCE_ARCHS) ; do \
+	       find $(__srctree)arch/$${ARCH} $(RCS_FIND_IGNORE) \
+	            -name '*.[chS]' -print; \
+	  done ; \
 	  find $(__srctree)security/selinux/include $(RCS_FIND_IGNORE) \
 	       -name '*.[chS]' -print; \
 	  find $(__srctree)include $(RCS_FIND_IGNORE) \
 	       \( -name config -o -name 'asm-*' \) -prune \
 	       -o -name '*.[chS]' -print; \
-	  find $(__srctree)include/asm-$(ARCH) $(RCS_FIND_IGNORE) \
-	       -name '*.[chS]' -print; \
+	  for ARCH in $(ALLSOURCE_ARCHS) ; do \
+	       find $(__srctree)include/asm-$${ARCH} $(RCS_FIND_IGNORE) \
+	            -name '*.[chS]' -print; \
+	  done ; \
 	  find $(__srctree)include/asm-generic $(RCS_FIND_IGNORE) \
 	       -name '*.[chS]' -print )
 endef



-- 
Ian Campbell
Current Noise: Devin Townsend - Seventh Wave

I am a deeply superficial person.
		-- Andy Warhol

