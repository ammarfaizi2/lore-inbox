Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265585AbUATQTH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 11:19:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265586AbUATQTG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 11:19:06 -0500
Received: from intra.cyclades.com ([64.186.161.6]:26049 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S265585AbUATQTE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 11:19:04 -0500
Date: Tue, 20 Jan 2004 14:01:54 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org, Erik Andersen <andersen@codepoet.org>
Subject: Re: 2.4.25pre6 and qlogic pcmcia driver
In-Reply-To: <200401180355.01190.arekm@pld-linux.org>
Message-ID: <Pine.LNX.4.58L.0401201400490.14726@logos.cnet>
References: <200401180355.01190.arekm@pld-linux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Same here, 2.4.24 does not show this behaviour.

I can't find the guilty modification in 2.4.25-pre.

On Sun, 18 Jan 2004, Arkadiusz Miskiewicz wrote:

> Hi,
>
> I was compiling 2.4.25pre6 (_but_ with bunch of different patches) with
> almost everything modular and got this:
>
> ake[1]: Wej?cie do katalogu `/home/users/misiek/rpm/BUILD/linux-2.4.24/drivers/scsi/pcmcia'
> gcc -D__KERNEL__ -I/home/users/misiek/rpm/BUILD/linux-2.4.24/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=athlon -DMODULE  -nostdinc -iwithprefix include -DKBUILD_BASENAME=qlogic_stub  -c -o qlogic_stub.o qlogic_stub.c
> gcc -D__KERNEL__ -I/home/users/misiek/rpm/BUILD/linux-2.4.24/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=athlon -DMODULE  -nostdinc -iwithprefix include -DKBUILD_BASENAME=qlogicfas -DPCMCIA -D__NO_VERSION__ -c -o qlogicfas.o ../qlogicfas.c
> ../qlogicfas.c: In function `qlogicfas_detect':
> ../qlogicfas.c:650: warning: passing arg 1 of `scsi_unregister' from incompatible pointer type
> ld -m elf_i386 -r -o qlogic_cs.o qlogic_stub.o qlogicfas.o
> qlogicfas.o(.text+0xe50): In function `init_module':
> : multiple definition of `init_module'
> qlogic_stub.o(.text+0x860): first defined here
> ld: Warning: size of symbol `init_module' changed from 86 in qlogic_stub.o to 75 in qlogicfas.o
> qlogicfas.o(.text+0xea0): In function `cleanup_module':
> : multiple definition of `cleanup_module'
> qlogic_stub.o(.text+0x8c0): first defined here
> ld: Warning: size of symbol `cleanup_module' changed from 47 in qlogic_stub.o to 27 in qlogicfas.o
> make[1]: *** [qlogic_cs.o] B??d 1
>
> qlogic_cs module is going to be build using drivers/scsi/pcmcia/qlogic_stub.c
> and drivers/scsi/qlogicfas.c.
