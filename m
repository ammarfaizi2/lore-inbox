Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268589AbUIXIfF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268589AbUIXIfF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 04:35:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268582AbUIXIfF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 04:35:05 -0400
Received: from witte.sonytel.be ([80.88.33.193]:50160 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S268602AbUIXIdw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 04:33:52 -0400
Date: Fri, 24 Sep 2004 10:33:12 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: =?utf-8?q?Pawe=C5=82_Sikora?= <pluto@pld-linux.org>
cc: Donald Duckie <schipperke2000@yahoo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: unresolved symbol __udivsi3_i4
In-Reply-To: <200409240801.57848.pluto@pld-linux.org>
Message-ID: <Pine.GSO.4.61.0409241031410.27692@waterleaf.sonytel.be>
References: <20040924021050.689.qmail@web53608.mail.yahoo.com>
 <200409240801.57848.pluto@pld-linux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Sep 2004, [utf-8] Pawe? Sikora wrote:
> On Friday 24 of September 2004 04:10, Donald Duckie wrote:
> > can somebody please help me how to overcome this
> > problem:
> > unresolved symbol __udivsi3_i4
> 
> the kernel module tries to use a divide operation on machine
> that doesn't support that. this could be caused by %,/ operators
> or floating point arithmetic. gcc uses emulation in these cases.
> 
> # objdump -T /lib/libgcc_s.so.1|grep div
> 000024c0 g    DF .text  00000162  GLIBC_2.0   __divdi3
> 00002b80 g    DF .text  000001ed  GCC_3.0     __udivmoddi4
> 00002870 g    DF .text  00000120  GLIBC_2.0   __udivdi3
> 
> you can link module with libgcc.a or fix it.

Just add an implementation for __udivsi3_i4 to arch/sh/lib/. They already have
udivdi3.c over there.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
