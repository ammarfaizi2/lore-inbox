Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261744AbVDEVoP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261744AbVDEVoP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 17:44:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261865AbVDEVlL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 17:41:11 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:45327 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S262054AbVDEVid
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 17:38:33 -0400
Date: Tue, 5 Apr 2005 23:38:36 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Jan Dittmer <j.dittmer@portrix.net>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc2-mm1
Message-ID: <20050405213836.GA11735@mars.ravnborg.org>
References: <20050405000524.592fc125.akpm@osdl.org> <4252B2B6.9020302@portrix.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4252B2B6.9020302@portrix.net>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2005 at 05:45:58PM +0200, Jan Dittmer wrote:
> Something has broken make O= :
> 
>   HOSTCC  scripts/kallsyms
>   HOSTCC  scripts/conmakehash
> make[1]: *** No rule to make target `include/asm', needed by `arch/alpha/kernel/asm-offsets.s'.  Stop.
> make: *** [_all] Error 2
> 
> Happens for most archs. See http://l4x.org/k/

Thanks - here is a patch:

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2005/04/05 23:37:09+02:00 sam@mars.ravnborg.org 
#   kbuild: fix make O=... build
#   
#   It fixes the following error:
#   
#   make[1]: *** No rule to make target `include/asm', needed by `arch/alpha/kernel/asm-offsets.s'.  Stop.
#   
#   Reported by:
#   From: Jan Dittmer <j.dittmer@portrix.net>
#   
#   In same patch fix spaces to tabs as reported by:
#   From: Adrian Bunk <bunk@stusta.de>
#   
#   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
# 
# Makefile
#   2005/04/05 23:36:45+02:00 sam@mars.ravnborg.org +3 -3
#   fix make O=... build
# 
diff -Nru a/Makefile b/Makefile
--- a/Makefile	2005-04-05 23:37:38 +02:00
+++ b/Makefile	2005-04-05 23:37:38 +02:00
@@ -576,7 +576,7 @@
 
 ifdef CONFIG_LOCALVERSION_AUTO
 	localversion-auto := \
-        	$(shell $(PERL) $(srctree)/scripts/setlocalversion $(srctree))
+		$(shell $(PERL) $(srctree)/scripts/setlocalversion $(srctree))
 	LOCALVERSION := $(LOCALVERSION)$(localversion-auto)
 endif
 
@@ -808,7 +808,7 @@
 # prepare1 creates a makefile if using a separate output directory
 prepare1: prepare2 outputmakefile
 
-prepare0: prepare1 include/linux/version.h $(objtree)/include/asm \
+prepare0: prepare1 include/linux/version.h include/asm \
                    include/config/MARKER
 ifneq ($(KBUILD_MODULES),)
 	$(Q)rm -rf $(MODVERDIR)
@@ -845,7 +845,7 @@
 #	hard to detect, but I suppose "make mrproper" is a good idea
 #	before switching between archs anyway.
 
-$(objtree)/include/asm:
+include/asm:
 	@echo '  SYMLINK $@ -> include/asm-$(ARCH)'
 	$(Q)if [ ! -d include ]; then mkdir -p include; fi;
 	@ln -fsn asm-$(ARCH) $@
