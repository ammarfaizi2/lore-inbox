Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312687AbSDLBKP>; Thu, 11 Apr 2002 21:10:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313132AbSDLBKO>; Thu, 11 Apr 2002 21:10:14 -0400
Received: from c16410.randw1.nsw.optusnet.com.au ([210.49.25.29]:44284 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id <S312687AbSDLBKO>; Thu, 11 Apr 2002 21:10:14 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
To: trivial@rustcorp.com.au
Subject: make TAGS to work with bitkeeper
CC: linux-kernel@vger.kernel.org
Comments: Hyperbole mail buttons accepted, v04.18.
Message-Id: <E16vpZl-0005YL-00@mail.chubb.wattle.id.au>
Date: Fri, 12 Apr 2002 11:10:05 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


If you type, `make TAGS' in the top-level of a kernel tree that's been
created with bk clone (or if you're using sccs to maintain your own
copy), then the sccs control files are included in the TAGS file (sccs
distinguishes its control files with an s. prefix rather than using a
suffix, so the matches on '*.h' etc pick them up.)



diff -Nru a/Makefile b/Makefile
--- a/Makefile	Fri Apr 12 11:03:02 2002
+++ b/Makefile	Fri Apr 12 11:03:02 2002
@@ -347,9 +347,9 @@
 	$(MAKE) CFLAGS="$(CFLAGS) $(CFLAGS_KERNEL)" $(subst $@, _dir_$@, $@)
 
 TAGS: dummy
-	etags `find include/asm-$(ARCH) -name '*.h'`
-	find include -type d \( -name "asm-*" -o -name config \) -prune -o -name '*.h' -print | xargs etags -a
-	find $(SUBDIRS) init -name '*.[ch]' | xargs etags -a
+	{ find include/asm-${ARCH} -name '*.h' -print ; \
+	find include -type d \( -name "asm-*" -o -name config \) -prune -o -name '*.h' -print ; \
+	find $(SUBDIRS) init -name '*.[ch]' ; } | grep -v SCCS | etags -
 
 # Exuberant ctags works better with -I
 tags: dummy
