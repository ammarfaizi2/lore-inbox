Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267608AbTBURhQ>; Fri, 21 Feb 2003 12:37:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267611AbTBURhP>; Fri, 21 Feb 2003 12:37:15 -0500
Received: from moutvdom.kundenserver.de ([212.227.126.250]:45273 "EHLO
	moutvdom.kundenserver.de") by vger.kernel.org with ESMTP
	id <S267608AbTBURhO>; Fri, 21 Feb 2003 12:37:14 -0500
From: Thomas Stuefe <thomas.stuefe@online.de>
To: linux-kernel@vger.kernel.org
Subject: compile error: isdn, capi2.0, AVM b1 card (b1pci.c)
Date: Fri, 21 Feb 2003 13:19:30 +0100
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200302211319.30639.thomas.stuefe@online.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi all,

For kernel 2.5.62 I get the following error:

   ld -m elf_i386  -r -o init/built-in.o init/main.o init/version.o 
init/do_mounts.o init/initramfs.o
        ld -m elf_i386 -e stext -T arch/i386/vmlinux.lds.s 
arch/i386/kernel/head.o arch/i386/kernel/init_task.o   init/built-in.o 
--start-group  usr/built-in.o  arch/i386/kernel/built-in.o  
arch/i386/mm/built-in.o  arch/i386/mach-default/built-in.o  kernel/built-in.o  
mm/built-in.o  fs/built-in.o  ipc/built-in.o  security/built-in.o  
crypto/built-in.o  lib/lib.a  arch/i386/lib/lib.a  drivers/built-in.o  
sound/built-in.o  arch/i386/pci/built-in.o  net/built-in.o --end-group  -o 
vmlinux
drivers/built-in.o: In function `b1pci_pci_remove':
drivers/built-in.o(.text+0x90665): undefined reference to `b1pciv4_remove'

--------

Reason:

The combination 

ISDN_DRV_AVMB1_B1PCI = Y
ISDN_DRV_AVMB1_B1PCIV4 = N

does not seem to work, as ISDN_DRV_AVMB1_B1PCIV4 undefines the static function 
b1pciv4_remove(). 

If those flags need to be set both, why not make one flag instead of two?

bye thomas


