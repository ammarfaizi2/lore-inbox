Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262565AbUCONgS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 08:36:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262566AbUCONgS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 08:36:18 -0500
Received: from alpha.zarz.agh.edu.pl ([149.156.122.231]:12555 "EHLO
	alpha.zarz.agh.edu.pl") by vger.kernel.org with ESMTP
	id S262565AbUCONgP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 08:36:15 -0500
Date: Mon, 15 Mar 2004 14:41:10 +0100 (CET)
From: "Wojciech 'Sas' Cieciwa" <cieciwa@alpha.zarz.agh.edu.pl>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [SPARC64][PPC] strange error ..
Message-ID: <Pine.LNX.4.58L.0403151437360.16193@alpha.zarz.agh.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I try to build 2.6.4 + cset-20040314_2208
on SPARC64 and got error:

[...]
  CHK     include/linux/version.h
  UPD     include/linux/version.h
  SYMLINK include/asm -> include/asm-sparc64
  HOSTCC  scripts/fixdep
  HOSTCC  scripts/split-include
  HOSTCC  scripts/conmakehash
  HOSTCC  scripts/docproc
  HOSTCC  scripts/kallsyms
  CC      scripts/empty.o
  HOSTCC  scripts/mk_elfconfig
  MKELF   scripts/elfconfig.h
  HOSTCC  scripts/file2alias.o
  HOSTCC  scripts/modpost.o
  HOSTCC  scripts/sumversion.o
  HOSTLD  scripts/modpost
  HOSTCC  scripts/pnmtologo
  HOSTCC  scripts/bin2c
make[2]: `scripts/fixdep' is up to date.
  SHIPPED scripts/kconfig/zconf.tab.h
  HOSTCC  scripts/kconfig/conf.o
  HOSTCC  scripts/kconfig/mconf.o
  SHIPPED scripts/kconfig/zconf.tab.c
  SHIPPED scripts/kconfig/lex.zconf.c
  HOSTCC  -fPIC scripts/kconfig/zconf.tab.o
  HOSTLLD -shared scripts/kconfig/libkconfig.so
  HOSTLD  scripts/kconfig/conf
scripts/kconfig/conf -s arch/sparc64/Kconfig
#
# using defaults found in .config
#
  SPLIT   include/linux/autoconf.h -> include/config/*
  CC      init/main.o
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  CC      init/do_mounts.o
  CC      init/do_mounts_devfs.o
  CC      init/do_mounts_rd.o
  CC      init/do_mounts_initrd.o
In file included from include/linux/unistd.h:9,
                 from init/do_mounts_initrd.c:2:
include/asm/unistd.h:446: syntax error before "unsigned"
include/asm/unistd.h:451: syntax error before "long"
make[1]: *** [init/do_mounts_initrd.o] Error 1
make: *** [init] Error 2

line 446 is:
asmlinkage unsigned long sys_mmap(
				unsigned long addr, unsigned long len,
				unsigned long prot, unsigned long flags,
				unsigned long fd, unsigned long off);

line 451:
asmlinkage long sys_rt_sigaction(int sig,
				const struct sigaction __user *act,
				struct sigaction __user *oact,
				void __user *restorer,
				size_t sigsetsize);


When I add to init/do_mounts_initrd.c 
#include <linux/linkage.h> before unistd.h 
All looks like OK.
This is bug, or I miss something?

Thanx.
					Sas.
-- 
{Wojciech 'Sas' Cieciwa}  {Member of PLD Team                               }
{e-mail: cieciwa@alpha.zarz.agh.edu.pl, http://www2.zarz.agh.edu.pl/~cieciwa}
