Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293642AbSCERnG>; Tue, 5 Mar 2002 12:43:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293638AbSCERm5>; Tue, 5 Mar 2002 12:42:57 -0500
Received: from chaos.analogic.com ([204.178.40.224]:20352 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S293642AbSCERmo>; Tue, 5 Mar 2002 12:42:44 -0500
Date: Tue, 5 Mar 2002 12:42:37 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Christoph Seifert <seifert@ILP.Physik.Uni-Essen.DE>
cc: linux-kernel@vger.kernel.org
Subject: Re: Problems using ISA card
In-Reply-To: <Pine.LNX.3.96.1020305172319.12258A-100000@wap8.ilp.physik.uni-essen.de>
Message-ID: <Pine.LNX.3.95.1020305123423.7616A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Mar 2002, Christoph Seifert wrote:

> [1.] One line summary of the problem:
> Acessing memory on PC31 ISA cards does work with 2.2.x, but not with
> 2.4.x and higher
> [2.] Full description of the problem/report:
> Measurement program tries to use home-made(and rebuilt for 2.4.x) kernel
> module to access so called Dual-Port RAM on the measurement card at
> address 0xd8000. The kernel reacts with a message, that the the page
> request for virtual memory at address 000d8000 could not be fulfilled.
> The measurement program crashes and the kernel resources are not freed
> again . rmmod mod does not work, as the device is still seen as to
> busy.
> I report this as bug, as I think that there should be
> backward-compatibility in memory access. I don't get any clue from
> /var/log/messages as to why the request could not be fulfilled, e.g.
> whether the requested memory space is protected by some other part for
> e.g. a PCI card or whether it can't find any memory in that space.
> I tried some different 2.4.x kernels with the same result.
> There is no difference in hardware or BIOS settings for 2.2.x and 2.4.x
> verions. The only difference is using a device with major number 240 
> instead of 254.
> 

Some modules did not access memory properly. The fact that they 'worked'
does not mean anything. Look at ../linux/Documentation/IO-mapping.txt
and fix your module.

If the program crashes, it's another module bug, not a kernel bug.
Again, fix your module.

There is no problem accessing memory in the range you suggest.
You just have to do it correctly.


Your memory range:

000D8000 FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF ................
000D8010 FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF ................
000D8020 FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF ................
000D8030 FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF ................
000D8040 FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF ................
000D8050 FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF ................
000D8060 FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF ................
000D8070 FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF ................
000D8080 FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF ................
000D8090 FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF ................
000D80A0 FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF ................
000D80B0 FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF ................
000D80C0 FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF ................
000D80D0 FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF ................
000D80E0 FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF ................
000D80F0 FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF ................

The screen-regen buffer:

000B8000 64 02 69 02 67 02 69 02 65 02 70 02 63 02 61 02 d.i.g.i.e.p.c.a.
000B8010 2E 02 74 02 78 02 74 02 20 07 20 07 20 07 20 07 ..t.x.t. . . . .
000B8020 20 07 20 07 20 07 20 07 6D 02 65 02 6D 02 6F 02  . . . .m.e.m.o.
000B8030 72 02 79 02 2E 02 74 02 78 02 74 02 20 07 20 07 r.y...t.x.t. . .
000B8040 20 07 20 07 20 07 20 07 20 07 20 07 20 07 20 07  . . . . . . . .
000B8050 20 07 20 07 20 07 20 07 20 07 20 07 20 07 73 02  . . . . . . .s.
000B8060 70 02 65 02 63 02 69 02 61 02 6C 02 69 02 78 02 p.e.c.i.a.l.i.x.
000B8070 2E 02 74 02 78 02 74 02 20 07 20 07 20 07 20 07 ..t.x.t. . . . .
000B8080 20 07 20 07 20 07 20 07 20 07 20 07 20 07 20 07  . . . . . . . .
000B8090 20 07 20 07 20 07 20 07 20 07 20 07 20 07 20 07  . . . . . . . .
000B80A0 64 02 6E 02 6F 02 74 02 69 02 66 02 79 02 2E 02 d.n.o.t.i.f.y...
000B80B0 74 02 78 02 74 02 20 07 20 07 20 07 20 07 20 07 t.x.t. . . . . .
000B80C0 20 07 20 07 20 07 20 07 6D 02 6F 02 64 02 75 02  . . . .m.o.d.u.
000B80D0 6C 02 65 02 73 02 2E 02 74 02 78 02 74 02 20 07 l.e.s...t.x.t. .
000B80E0 20 07 20 07 20 07 20 07 20 07 20 07 20 07 20 07  . . . . . . . .
000B80F0 20 07 20 07 20 07 20 07 20 07 20 07 20 07 73 02  . . . . . . .s.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (799.53 BogoMips).

	Bill Gates? Who?

