Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263572AbUCTXlS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 18:41:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263573AbUCTXlS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 18:41:18 -0500
Received: from ns.suse.de ([195.135.220.2]:35813 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263572AbUCTXlQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 18:41:16 -0500
Date: Sun, 21 Mar 2004 00:41:14 +0100
From: Olaf Hering <olh@suse.de>
To: sam@ravnborg.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.4-mm2
Message-ID: <20040320234114.GA19604@suse.de>
References: <20040320231248.89BBA15C1E@post1.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040320231248.89BBA15C1E@post1.dk>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Sun, Mar 21, sam@ravnborg.org wrote:

> Date: Lør, 20 Mar 2004 23:50:30 +0100 skrev Olaf Hering <olh@suse.de> : 
> 
> >
> >I think that one made it into rc2. It breaks uml compilation, 
> >
> >  CC	   kernel/acct.o
> >  IKCFG   kernel/ikconfig.h
> >  GZIP    kernel/config_data.gz
> >  IKCFG   kernel/config_data.h
> >/bin/sh: line 1: scripts/bin2c: No such file or directory
> >make[1]: *** [kernel/config_data.h] Error 1
> >make: *** [kernel] Error 2
> >error: Bad exit status from /var/tmp/rpm-tmp.18419 (%build)
> >
> >looks like IKCFG does not depend on scripts/bin2c anymore?
> 
> There is a missing dependency on 'scripts' in the Makefile.

This patch is needed to fix the compile. Odd, make -jN works.


--- linux-2.6.4.um/arch/um/Makefile-i386~	2004-03-20 21:13:52.000000000 +0100
+++ linux-2.6.4.um/arch/um/Makefile-i386	2004-03-20 21:16:14.000000000 +0100
@@ -30,7 +30,7 @@ filechk_$(SYS_DIR)/thread.h := $(SYS_UTI
 $(SYS_DIR)/thread.h: $(SYS_UTIL_DIR)/mk_thread 
 	$(call filechk,$@)
 
-$(SYS_UTIL_DIR)/mk_sc: scripts/fixdep include/config/MARKER FORCE ; 
+$(SYS_UTIL_DIR)/mk_sc: scripts/basic/fixdep include/config/MARKER FORCE ; 
 	$(Q)$(MAKE) $(build)=$(SYS_UTIL_DIR) $@
 
 $(SYS_UTIL_DIR)/mk_thread: $(ARCH_SYMLINKS) $(GEN_HEADERS) sys_prepare FORCE ; 
--- ./Makefile~	2004-03-21 00:12:23.000000000 +0100
+++ ./Makefile	2004-03-21 00:22:28.000000000 +0100
@@ -568,7 +568,7 @@ $(sort $(vmlinux-objs)) arch/$(ARCH)/ker
 # 	Handle descending into subdirectories listed in $(SUBDIRS)
 
 .PHONY: $(SUBDIRS)
-$(SUBDIRS): prepare-all
+$(SUBDIRS): prepare-all scripts
 	$(Q)$(MAKE) $(build)=$@
 
 # Things we need to do before we recursively start building the kernel

-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
