Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268435AbTCCIW3>; Mon, 3 Mar 2003 03:22:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268438AbTCCIW3>; Mon, 3 Mar 2003 03:22:29 -0500
Received: from srv1.mail.cv.net ([167.206.112.40]:23444 "EHLO srv1.mail.cv.net")
	by vger.kernel.org with ESMTP id <S268435AbTCCIW2>;
	Mon, 3 Mar 2003 03:22:28 -0500
Date: Mon, 03 Mar 2003 03:32:55 -0500 (EST)
From: Pavel Roskin <proski@gnu.org>
Subject: Re: mkdep patch in 2.4.21-pre4-ac7 breaks pci/drivers
In-reply-to: <200303020213.h222DM7O003304@eeyore.valparaiso.cl>
X-X-Sender: proski@localhost.localdomain
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <Pine.LNX.4.51.0303030313450.26129@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <200303020213.h222DM7O003304@eeyore.valparaiso.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Sat, 1 Mar 2003, Horst von Brand wrote:

> Pavel Roskin <proski@gnu.org> said:
> > If I compile linux 2.4.21-pre4-ac7, then run "make depend" and "make
> > clean", then "make bzImage" fails in pci/drivers:
>
> make drivers/pci/gen-devlist; pushd drivers/pci; ./gen-devlist < pci.ids; popd
>
> Needed for all 2.4.x I've seen (lately at least).

That shouldn't be needed unless you skip "make depend" completely or do
something else wrong, or your "make" is buggy.  It shouldn't be necessary.

names.o depends on devlist.h explicitly in drivers/pci/Makefile.
As explained in the section "Multiple Rules for One Target" of GNU make
documentation, other rules (i.e. in .depend) don't cancel this dependency.

Further, devlist.h depends on gen-devlist, so whenever drivers/pci/names.o
is to be compiled, devlist.h will be created before that.

> > This is caused by the patch for scripts/mkdep.c (part of the
> > 2.4.21-pre4-ac7 patch)
>
> Nope. It's the same with 2.4 from Marcelo.

Not true.  2.4.20 is fine:

make distclean
cp ~/local/linux/.config .
make oldconfig
make dep
make bzImage

No problems whatsoever.

-- 
Regards,
Pavel Roskin
