Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264962AbUFOE1l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264962AbUFOE1l (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 00:27:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264965AbUFOE1k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 00:27:40 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:61996 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S264962AbUFOE1i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 00:27:38 -0400
Date: Tue, 15 Jun 2004 06:36:28 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 4/5] kbuild: make clean improved
Message-ID: <20040615043628.GA16664@mars.ravnborg.org>
Mail-Followup-To: Tom Rini <trini@kernel.crashing.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>
References: <20040614204029.GA15243@mars.ravnborg.org> <20040614204655.GE15243@mars.ravnborg.org> <20040614215034.K14403@flint.arm.linux.org.uk> <20040614211940.GA15555@mars.ravnborg.org> <20040614213835.GA11113@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040614213835.GA11113@smtp.west.cox.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2004 at 02:38:35PM -0700, Tom Rini wrote:
> 
> I'd agrue the exact opposite.  If you're starting from scratch (new
> patchset, etc, where you might do something like mv mm/slab.c.old
> mm/slab.c) use 'distclean' or 'mrproper'.  If you just want to do a
> 'make clean' because you can't be sure you trust the build system to get
> things right, you don't want the version being reset.

I follow both Russell's and your points.
So let's stick to the historic behaviour then.
Updated hand-edited patch below.

	Sam

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/06/14 22:09:53+02:00 sam@mars.ravnborg.org 
#   kbuild: make clean deletes a few more unneeded files
#   
#   Make clean shall leave behind only what is needed to build
#   external modules. A few more files can be deleted and modules may still be
#   build successfully.
#   Originally noticed by Andreas Gruenbach
#   
#   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
# 
# Makefile
#   2004/06/14 22:09:39+02:00 sam@mars.ravnborg.org +2 -2
#   kbuild: make clean deletes a few more unneeded files
#   
#   Make clean shall leave behind only what is needed to build
#   external modules. A few more files can be deleted and modules may still be
#   build successfully.
#   Originally noticed by Andreas Gruenbach
#   
#   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
# 
diff -Nru a/Makefile b/Makefile
--- a/Makefile	2004-06-14 22:25:31 +02:00
+++ b/Makefile	2004-06-14 22:25:31 +02:00
@@ -796,12 +796,12 @@
 
 # Directories & files removed with 'make clean'
 CLEAN_DIRS  += $(MODVERDIR)
-CLEAN_FILES +=	vmlinux System.map \
+CLEAN_FILES +=	vmlinux System.map .config.old \
                 .tmp_kallsyms* .tmp_version .tmp_vmlinux*
 
 # Directories & files removed with 'make mrproper'
 MRPROPER_DIRS  += include/config include2
-MRPROPER_FILES += .config .config.old include/asm \
+MRPROPER_FILES += .config include/asm .version \
                   include/linux/autoconf.h include/linux/version.h \
                   Module.symvers tags TAGS cscope*
 
