Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265653AbUATSPj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 13:15:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265654AbUATSPj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 13:15:39 -0500
Received: from fw.osdl.org ([65.172.181.6]:49890 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265653AbUATSPb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 13:15:31 -0500
Date: Tue, 20 Jan 2004 10:11:21 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: arekm@pld-linux.org, marcelo.tosatti@cyclades.com,
       linux-kernel@vger.kernel.org, andersen@codepoet.org
Subject: Re: 2.4.25pre6 and qlogic pcmcia driver
Message-Id: <20040120101121.5ce95f97.rddunlap@osdl.org>
In-Reply-To: <Pine.LNX.4.58L.0401201400490.14726@logos.cnet>
References: <200401180355.01190.arekm@pld-linux.org>
	<Pine.LNX.4.58L.0401201400490.14726@logos.cnet>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Jan 2004 14:01:54 -0200 (BRST) Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:

| 
| 
| Same here, 2.4.24 does not show this behaviour.
| 
| I can't find the guilty modification in 2.4.25-pre.

Same problem with aha152x pcmcia being built as a module.

I also don't see any changes that would be causing this...

It's clear that this problem should be detected, since
scsi/qlogicfas.c and scsi/pcmcia/qlogic_stub.c both
#include <linux/init.h>, so both of them define the module
init and cleanup functions.  I don't see how this worked
in the past, unless it was due to some tools that missed
detecting the duplicated functions.


| On Sun, 18 Jan 2004, Arkadiusz Miskiewicz wrote:
| 
| > Hi,
| >
| > I was compiling 2.4.25pre6 (_but_ with bunch of different patches) with
| > almost everything modular and got this:
| >
| > ake[1]: Wej?cie do katalogu `/home/users/misiek/rpm/BUILD/linux-2.4.24/drivers/scsi/pcmcia'
| > gcc -D__KERNEL__ -I/home/users/misiek/rpm/BUILD/linux-2.4.24/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=athlon -DMODULE  -nostdinc -iwithprefix include -DKBUILD_BASENAME=qlogic_stub  -c -o qlogic_stub.o qlogic_stub.c
| > gcc -D__KERNEL__ -I/home/users/misiek/rpm/BUILD/linux-2.4.24/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=athlon -DMODULE  -nostdinc -iwithprefix include -DKBUILD_BASENAME=qlogicfas -DPCMCIA -D__NO_VERSION__ -c -o qlogicfas.o ../qlogicfas.c
| > ../qlogicfas.c: In function `qlogicfas_detect':
| > ../qlogicfas.c:650: warning: passing arg 1 of `scsi_unregister' from incompatible pointer type
| > ld -m elf_i386 -r -o qlogic_cs.o qlogic_stub.o qlogicfas.o
| > qlogicfas.o(.text+0xe50): In function `init_module':
| > : multiple definition of `init_module'
| > qlogic_stub.o(.text+0x860): first defined here
| > ld: Warning: size of symbol `init_module' changed from 86 in qlogic_stub.o to 75 in qlogicfas.o
| > qlogicfas.o(.text+0xea0): In function `cleanup_module':
| > : multiple definition of `cleanup_module'
| > qlogic_stub.o(.text+0x8c0): first defined here
| > ld: Warning: size of symbol `cleanup_module' changed from 47 in qlogic_stub.o to 27 in qlogicfas.o
| > make[1]: *** [qlogic_cs.o] B??d 1
| >
| > qlogic_cs module is going to be build using drivers/scsi/pcmcia/qlogic_stub.c
| > and drivers/scsi/qlogicfas.c.
| -


--
~Randy
kernel-janitors project:  http://janitor.kernelnewbies.org/
