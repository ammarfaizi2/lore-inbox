Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262289AbTAIJBp>; Thu, 9 Jan 2003 04:01:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262317AbTAIJBp>; Thu, 9 Jan 2003 04:01:45 -0500
Received: from buitenpost.surfnet.nl ([192.87.108.12]:38388 "EHLO
	buitenpost.surfnet.nl") by vger.kernel.org with ESMTP
	id <S262289AbTAIJBo>; Thu, 9 Jan 2003 04:01:44 -0500
Date: Thu, 9 Jan 2003 10:10:26 +0100
To: linux-kernel@vger.kernel.org
Subject: 2.5.55: local symbols in net/ipv6/af_inet6.o
Message-ID: <20030109091025.GW31387@surly.surfnet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Mailer: Mutt on Debian GNU/Linux sid
X-Editor: vim
X-Organisation: SURFnet bv
X-Address: Radboudburcht, P.O. Box 19035, 3501 DA Utrecht, NL
X-Phone: +31 302 305 305
X-Telefax: +31 302 305 329
From: Niels den Otter <Niels.denOtter@surfnet.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As of 2.5.54bk6 (including 2.5.55) I get the following compilation error:

  gcc-2.95 -Wp,-MD,init/.version.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -Iinclude/asm-i386/mach-default -fomit-frame-pointer -nostdinc -iwithprefix include    -DKBUILD_BASENAME=version -DKBUILD_MODNAME=version   -c -o init/version.o init/version.c
   ld -m elf_i386  -r -o init/built-in.o init/main.o init/version.o init/do_mounts.o init/initramfs.o
        ld -m elf_i386 -e stext -T arch/i386/vmlinux.lds.s arch/i386/kernel/head.o arch/i386/kernel/init_task.o  init/built-in.o --start-group  usr/built-in.o  arch/i386/kernel/built-in.o  arch/i386/mm/built-in.o  arch/i386/mach-default/built-in.o  kernel/built-in.o  mm/built-in.o  fs/built-in.o  ipc/built-in.o  security/built-in.o  crypto/built-in.o  lib/lib.a  arch/i386/lib/lib.a  drivers/built-in.o  sound/built-in.o  arch/i386/pci/built-in.o  net/built-in.o --end-group  -o vmlinux
net/built-in.o(.init.text+0x1a34): In function `inet6_init':
: undefined reference to `local symbols in discarded section .exit.text'
make: *** [vmlinux] Error 1


The reference_discarded.pl script says following:
 pangsit:/usr/src/linux/net> perl ~otter/reference_discarded.pl 
 Finding objects, 245 objects, ignoring 0 module(s)
 Finding conglomerates, ignoring 11 conglomerate(s)
 Scanning objects
 Error: ./ipv6/af_inet6.o .init.text refers to 000003e4 R_386_PC32 .exit.text
 Done

I tried both gcc-2.95 & gcc-3.2.2 .


-- Niels
