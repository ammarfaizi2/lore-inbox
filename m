Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267285AbSKPPTr>; Sat, 16 Nov 2002 10:19:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267286AbSKPPTr>; Sat, 16 Nov 2002 10:19:47 -0500
Received: from host194.steeleye.com ([66.206.164.34]:29970 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S267285AbSKPPTr>; Sat, 16 Nov 2002 10:19:47 -0500
Message-Id: <200211161526.gAGFQbq02692@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Gregoire Favre <greg@ulima.unil.ch>
cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re:  2.5.47-ac5:undefined reference to `boot_gdt_table'
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 16 Nov 2002 10:26:36 -0500
From: "J.E.J. Bottomley" <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   	ld -m elf_i386 -e stext -T arch/i386/vmlinux.lds.s arch/i386/kernel/
> head.o \ arch/i386/kernel/init_task.o  init/built-in.o --start-group
> usr/built-in.o  \ arch/i386/kernel/built-in.o  arch/i386/mm/built-in.o
>  \ arch/i386/mach-generic/built-in.o  kernel/built-in.o  mm/built-in.o
>  fs/built-in.o  \ ipc/built-in.o  security/built-in.o  crypto/
> built-in.o  drivers/built-in.o  \ sound/built-in.o  arch/i386/pci/
> built-in.o  net/built-in.o  lib/lib.a  \ arch/i386/lib/lib.a
> --end-group  -o .tmp_vmlinux1 \ arch/i386/kernel/built-in.o(.data+0x15a
> 5): In function `gdt_48': : undefined \
>                 reference to `boot_gdt_table' make: ***
> [.tmp_vmlinux1] Error 1

I think this is because -ac5 has X86_TRAMPOLINE dependent on X86_LOCAL_APIC.  
If you change

config X86_TRAMPOLINE
	bool
	depends on SMP || (VOYAGER && SMP) || X86_LOCAL_APIC

to

	depends on SMP

in arch/i386/Kconfig

does this fix the problem?

Alan: I'm just getting -ac5 up and running on voyager now, so I'll send in 
this as part of the rebased patches.

James


