Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291279AbSCRSYl>; Mon, 18 Mar 2002 13:24:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291306AbSCRSYc>; Mon, 18 Mar 2002 13:24:32 -0500
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:35982 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP
	id <S291372AbSCRSYP>; Mon, 18 Mar 2002 13:24:15 -0500
Content-Type: text/plain; charset=US-ASCII
From: Adam Keys <akeys@post.cis.smu.edu>
To: linux-kernel@vger.kernel.org
Subject: [BK][PATCH] Fix tags rules
Date: Mon, 18 Mar 2002 12:23:39 -0600
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020318182409.OZBE2626.rwcrmhc51.attbi.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When using Bitkeeper, having all sorts of SCCS directories lying around 
breaks the rules that generate tag tables for use by vi, emacs and friends.  
The following patch fixes the rules to ignore SCCS directories.  

I have tested the generated TAGS file in XEmacs.  I have not tested the tags 
rule with any vi clones.  The output is the same with my new rule and the old 
rule so I'm making a wild presumption it is doing the same thing.  vi users, 
please let me know if I messed up the tags rule.

Makefile |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)
-- 
akk~

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.525   -> 1.526  
#	            Makefile	1.182   -> 1.183  
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/03/18	akeys@mail.smu.edu	1.526
# Fixed tag rules to ignore SCCS directories.
# --------------------------------------------
#
diff -Nru a/Makefile b/Makefile
--- a/Makefile	Mon Mar 18 12:13:17 2002
+++ b/Makefile	Mon Mar 18 12:13:17 2002
@@ -355,16 +355,16 @@
 	$(MAKE) CFLAGS="$(CFLAGS) $(CFLAGS_KERNEL)" $(subst $@, _dir_$@, $@)
 
 TAGS: dummy
-	etags `find include/asm-$(ARCH) -name '*.h'`
-	find include -type d \( -name "asm-*" -o -name config \) -prune -o -name 
'*.h' -print | xargs etags -a
-	find $(SUBDIRS) init -name '*.[ch]' | xargs etags -a
+	find include/asm-$(ARCH) -path 'include/asm-$(ARCH)/SCCS' -prune -o -name 
'*.h' -print | xargs etags
+	find include -path '*/SCCS' -prune -o -type d \( -name "asm-*" -o -name 
config \) -prune -o -name '*.h' -print | xargs etags -a
+	find $(SUBDIRS) init  -path '*/SCCS' -prune -not -type d -o -name *.[ch] | 
xargs etags -a
 
 # Exuberant ctags works better with -I
 tags: dummy
-	CTAGSF=`ctags --version | grep -i exuberant >/dev/null && echo "-I 
__initdata,__exitdata,EXPORT_SYMBOL,EXPORT_SYMBOL_NOVERS"`; \
-	ctags $$CTAGSF `find include/asm-$(ARCH) -name '*.h'` && \
-	find include -type d \( -name "asm-*" -o -name config \) -prune -o -name 
'*.h' -print | xargs ctags $$CTAGSF -a && \
-	find $(SUBDIRS) init -name '*.[ch]' | xargs ctags $$CTAGSF -a
+	CTAGSF=`ctags --version | grep -i exuberant >/dev/null && echo "-I 
__initdata,__exitdata,EXPORT_SYMBOL,EXPORT_SYMBOL_NOVERS"`;
+	find include/asm-$(ARCH) -path 'include/asm-$(ARCH)/SCCS' -prune -o  -name 
'*.h' | xargs ctags $$CTAGSF
+	find include -path '*/SCCS' -prune -o -type d \( -name "asm-*" -o -name 
config \) -prune -o -name '*.h' -print | xargs ctags $$CTAGSF -a
+	find $(SUBDIRS) init -path '*/SCCS' -prune -not -type d -o -name '*.[ch]' | 
xargs ctags $$CTAGSF -a
 
 ifdef CONFIG_MODULES
 ifdef CONFIG_MODVERSIONS

