Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263468AbTJQNL4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 09:11:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263470AbTJQNL4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 09:11:56 -0400
Received: from alpha.zarz.agh.edu.pl ([149.156.122.231]:11525 "EHLO
	alpha.zarz.agh.edu.pl") by vger.kernel.org with ESMTP
	id S263468AbTJQNLy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 09:11:54 -0400
Date: Fri, 17 Oct 2003 15:13:21 +0200 (CEST)
From: "Wojciech 'Sas' Cieciwa" <cieciwa@alpha.zarz.agh.edu.pl>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.0-test7 broken
Message-ID: <Pine.LNX.4.58L.0310171508480.20432@alpha.zarz.agh.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I try to compile linux-2.6.0-test7 from ftp.kernel.org on SMP machine
and I god something like this:

[...]
make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
  CHK     include/linux/compile.h
  LD      kernel/built-in.o
  GEN     .version
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
  KSYM    .tmp_kallsyms1.S
  AS      .tmp_kallsyms1.o
  LD      .tmp_vmlinux2
  KSYM    .tmp_kallsyms2.S
  AS      .tmp_kallsyms2.o
  LD      vmlinux
  AS      arch/i386/boot/setup.o
  LD      arch/i386/boot/setup
  OBJCOPY arch/i386/boot/compressed/vmlinux.bin
  GZIP    arch/i386/boot/compressed/vmlinux.bin.gz
  LD      arch/i386/boot/compressed/piggy.o
  LD      arch/i386/boot/compressed/vmlinux
  OBJCOPY arch/i386/boot/vmlinux.bin
  BUILD   arch/i386/boot/bzImage
Root device is (8, 1)
Boot sector 512 bytes.
Setup is 4943 bytes.
System is 1298 kB
Kernel: arch/i386/boot/bzImage is ready
  Building modules, stage 2.
  MODPOST
[...]
*** Warning: "set_special_pids" [fs/jffs/jffs.ko] undefined!
*** Warning: "percpu_counter_mod" [fs/ext3/ext3.ko] undefined!
*** Warning: "percpu_counter_mod" [fs/ext2/ext2.ko] undefined!

and ext2 dosn't work.
Fast workaround is make file kernel/ksyms.c and add to this file two lines
#include <linux/percpu_counter.h>
EXPORT_SYMBOL(percpu_counter_mod);
and fix kernel/Makefile.

Please don't tell me that this is wrong, I try to understand WHY 
EXPORT_SYMBOL(percpu_counter_mod) from lib/percpu_counter.c didn't work
but I faild.

This work for me.

Thanx 
					Sas.
-- 
{Wojciech 'Sas' Cieciwa}  {Member of PLD Team                               }
{e-mail: cieciwa@alpha.zarz.agh.edu.pl, http://www2.zarz.agh.edu.pl/~cieciwa}
