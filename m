Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262787AbSJEWYy>; Sat, 5 Oct 2002 18:24:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262776AbSJEWYl>; Sat, 5 Oct 2002 18:24:41 -0400
Received: from maila.telia.com ([194.22.194.231]:41182 "EHLO maila.telia.com")
	by vger.kernel.org with ESMTP id <S262760AbSJEWYE>;
	Sat, 5 Oct 2002 18:24:04 -0400
X-Original-Recipient: linux-kernel@vger.kernel.org
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Subject: Re: Linux v2.5.40 - and a feature freeze reminder
References: <Pine.LNX.4.33.0210010021400.25527-100000@penguin.transmeta.com>
From: Peter Osterlund <petero2@telia.com>
Date: 06 Oct 2002 00:28:21 +0200
In-Reply-To: <Pine.LNX.4.33.0210010021400.25527-100000@penguin.transmeta.com>
Message-ID: <m2ptuo8qre.fsf@p4.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:

> Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>:
>   o kbuild: Make KBUILD_VERBOSE=0 work better under emacs

This change has the unfortunate side effect that compilation doesn't
stop after a compile error if I run make without arguments. I observed
this when enabling debugging in yenta.c. Building with "make
KBUILD_VERBOSE=1" does stop after the error.

I'm using make 3.79.1 on a RH73 system.


p4:~/kernel/linus/main/linux$ make drivers/pcmcia/yenta.o 
make[1]: Entering directory `/home/petero/kernel/linus/main/linux/drivers/pcmcia'
  gcc -Wp,-MD,./.yenta.o.d -D__KERNEL__ -I/home/petero/kernel/linus/main/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i586 -I/home/petero/kernel/linus/main/linux/arch/i386/mach-generic -nostdinc -iwithprefix include    -DKBUILD_BASENAME=yenta -DEXPORT_SYMTAB  -c -o yenta.o yenta.c
drivers/pcmcia/yenta.c: In function `cb_readl':
drivers/pcmcia/yenta.c:42: parse error before string constant
[cut]
drivers/pcmcia/yenta.c:118: parse error before string constant
make[1]: Leaving directory `/home/petero/kernel/linus/main/linux/drivers/pcmcia'
p4:~/kernel/linus/main/linux$ echo $?
0
p4:~/kernel/linus/main/linux$ make KBUILD_VERBOSE=1 drivers/pcmcia/yenta.o
make[1]: Entering directory `/home/petero/kernel/linus/main/linux/drivers/pcmcia'
  gcc -Wp,-MD,./.yenta.o.d -D__KERNEL__ -I/home/petero/kernel/linus/main/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i586 -I/home/petero/kernel/linus/main/linux/arch/i386/mach-generic -nostdinc -iwithprefix include    -DKBUILD_BASENAME=yenta -DEXPORT_SYMTAB  -c -o yenta.o yenta.c
yenta.c: In function `cb_readl':
yenta.c:42: parse error before string constant
[cut]
yenta.c:118: parse error before string constant
make[1]: *** [yenta.o] Error 1
make[1]: Leaving directory `/home/petero/kernel/linus/main/linux/drivers/pcmcia'
make: *** [drivers/pcmcia/yenta.o] Error 2
p4:~/kernel/linus/main/linux$ echo $?
2
p4:~/kernel/linus/main/linux$ 

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
