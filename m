Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261475AbSJMJLF>; Sun, 13 Oct 2002 05:11:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261476AbSJMJLF>; Sun, 13 Oct 2002 05:11:05 -0400
Received: from 62-190-219-54.pdu.pipex.net ([62.190.219.54]:10756 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S261475AbSJMJLE>; Sun, 13 Oct 2002 05:11:04 -0400
From: jbradford@dial.pipex.com
Message-Id: <200210130925.g9D9Ptj2004902@darkstar.example.net>
Subject: ALSA still broken in 2.5.42
To: linux-kernel@vger.kernel.org
Date: Sun, 13 Oct 2002 10:25:55 +0100 (BST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trying to compile 2.5.42 with:

CONFIG_SOUND=y
CONFIG_SND=y
CONFIG_SND_SBAWE=y

fails:

  Generating build number
make -f init/Makefile 
  Generating include/linux/compile.h (updated)
  gcc -Wp,-MD,init/.version.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i586 -Iarch/i386/mach-generic -nostdinc -iwithprefix include    -DKBUILD_BASENAME=version   -c -o init/version.o init/version.c
   ld -m elf_i386  -r -o init/built-in.o init/main.o init/version.o init/do_mounts.o
        ld -m elf_i386 -e stext -T arch/i386/vmlinux.lds.s arch/i386/kernel/head.o arch/i386/kernel/init_task.o  init/built-in.o --start-group  arch/i386/kernel/built-in.o  arch/i386/mm/built-in.o  arch/i386/mach-generic/built-in.o  kernel/built-in.o  mm/built-in.o  fs/built-in.o  ipc/built-in.o  security/built-in.o  lib/lib.a  arch/i386/lib/lib.a  drivers/built-in.o  sound/built-in.o  arch/i386/pci/built-in.o  net/built-in.o --end-group  -o vmlinux
sound/built-in.o: In function `snd_emu8000_new':
sound/built-in.o(.text.init+0x13b3): undefined reference to `snd_seq_device_new'
make: *** [vmlinux] Error 1

Works fine when I configure the dummy sound card device instead.

Same with 2.5.41 and 2.5.40.

John.
