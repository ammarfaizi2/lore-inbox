Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316880AbSGZFPT>; Fri, 26 Jul 2002 01:15:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316886AbSGZFPT>; Fri, 26 Jul 2002 01:15:19 -0400
Received: from smtprelay6.dc2.adelphia.net ([64.8.50.38]:4329 "EHLO
	smtprelay6.dc2.adelphia.net") by vger.kernel.org with ESMTP
	id <S316880AbSGZFPR>; Fri, 26 Jul 2002 01:15:17 -0400
Message-ID: <004401c23463$df58a350$6a01a8c0@wa1hco>
From: "jeff millar" <wa1hco@adelphia.net>
To: "jeff millar" <wa1hco@adelphia.net>,
       "Kernel Mailing List" <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0207241803410.4293-100000@home.transmeta.com> <00a501c2338c$25365170$6a01a8c0@wa1hco>
Subject: Linux-2.5.27-28 "undefined reference to local symbols in discarded section .text.exit"
Date: Fri, 26 Jul 2002 01:18:26 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I need some ideas here.

I fixed the one mentioned below by changing md.c to a module.  Then I2C had
the same problem and fixed it by changing to a module.  Now parport(?) has
the problem and it's already a module.  The current linker error is...

make[1]: Entering directory `/usr/src/v2.5.28/init'
  Generating /usr/src/v2.5.28/include/linux/compile.h (updated)


gcc -Wp,-MD,./.version.o.d -D__KERNEL__ -I/usr/src/v2.5.28/include -Wall -Ws
trict-prototypes -
Wno-trigraphs -O2 -g -fomit-frame-pointer -fno-strict-aliasing -fno-common -
pipe -mpreferred-sta
ck-boundary=2 -march=athlon  -nostdinc -iwithprefix
lude    -DKBUILD_BASENAME=version   -c -o
 version.o version.c
   ld -m elf_i386  -r -o init.o main.o version.o do_mounts.o
make[1]: Leaving directory `/usr/src/v2.5.28/init'
  ld -m elf_i386 -T arch/i386/vmlinux.lds -e stext arch/i386/kernel/head.o
arch/i386/kernel/init
_task.o init/init.o --start-group arch/i386/kernel/kernel.o
arch/i386/mm/mm.o kernel/kernel.o mm
/mm.o fs/fs.o ipc/ipc.o security/built-in.o
/usr/src/v2.5.28/arch/i386/lib/lib.a lib/lib.a /usr/
src/v2.5.28/arch/i386/lib/lib.a drivers/built-in.o sound/sound.o
arch/i386/pci/pci.o net/network
.o --end-group -o vmlinux
drivers/built-in.o: In function `parport_ieee1284_epp_write_data':
/usr/src/v2.5.28/include/asm/io.h:400: undefined reference to `local symbols
in discarded sectio
n .text.exit'
make: *** [vmlinux] Error 1


----- Original Message -----
From: "jeff millar" <wa1hco@adelphia.net>
To: "Kernel Mailing List" <linux-kernel@vger.kernel.org>
Sent: Wednesday, July 24, 2002 11:34 PM
Subject: Linux-2.5.28 link problem


> ...need help getting a compile to complete.  This problem exists with
> 2.5.27-28.
> Here's the last lines from make...
>
>   ld -m elf_i386 -T arch/i386/vmlinux.lds -e stext arch/i386/kernel/head.o
> arch/i386/kernel/init
> _task.o init/init.o --start-group arch/i386/kernel/kernel.o
> arch/i386/mm/mm.o kernel/kernel.o mm
> /mm.o fs/fs.o ipc/ipc.o security/built-in.o
> /usr/src/v2.5.28/arch/i386/lib/lib.a lib/lib.a /usr/
> src/v2.5.28/arch/i386/lib/lib.a drivers/built-in.o sound/sound.o
> arch/i386/pci/pci.o net/network
> .o --end-group -o vmlinux
> drivers/built-in.o: In function `md_run_setup':
> /usr/src/v2.5.28/drivers/md/md.c(.data+0xee34): undefined reference to
> `local symbols in discard
> ed section .text.exit'
> make: *** [vmlinux] Error 1
>
> All the programs are better than specified in "Changes"...
>     Gcc = 2.96-110 (RH7.3)
>     binutils: ld = 2.11
>
> thanks in advance, jeff
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

