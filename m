Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269386AbRHGToJ>; Tue, 7 Aug 2001 15:44:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269385AbRHGTn7>; Tue, 7 Aug 2001 15:43:59 -0400
Received: from tux.creighton.edu ([147.134.5.192]:21671 "EHLO
	tux.creighton.edu") by vger.kernel.org with ESMTP
	id <S269380AbRHGTno>; Tue, 7 Aug 2001 15:43:44 -0400
Date: Tue, 7 Aug 2001 14:43:53 -0500 (CDT)
From: Phil Brutsche <pbrutsch@tux.creighton.edu>
To: Mike Fedyk <mfedyk@matchmail.com>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Compile failure: 2.2.19 + eide patch on PPC
In-Reply-To: <20010807122439.A22612@mikef-linux.matchmail.com>
Message-ID: <Pine.LNX.4.33.0108071429460.30593-100000@tux.creighton.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A long time ago, in a galaxy far, far way, someone said...

> I am trying to compile 2.2.19 + ide.2.2.19.05042001.patch.  When doing this,
> I get the errors below.
>
> I've also tried:
> ide.2.2.19.03252001.patch
> ide.2.2.19.04092001.patch

These patches are broken for PPC machines and have been for some time.  I
suppose I should file a bug report...

It's simple enough to fix however.

> I've tried compiling on several different machines, though they were all
> setup with Debian 2.2.
>
> I haven't tried a 2.4.x on ppc,

Be aware that 2.4.x on non-x86 architectures is still somewhat
experimental (much more so than on x86).

> but I want to try to get 2.2 working.  Is there another patch I need?

Yes - see below

> # gcc -v
> Reading specs from /usr/lib/gcc-lib/powerpc-linux/2.95.2/specs
> gcc version 2.95.2 20000220 (Debian GNU/Linux)
>
> Error:
> make[3]: Entering directory /usr/src/lk2.2/2.2.19-ide-05042001/drivers/block'
> cc -D__KERNEL__ -I/usr/src/lk2.2/2.2.19-ide-05042001/include -Wall
> -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing
> -D__powerpc__ -fsigned-char -msoft-float -pipe -fno-builtin -ffixed-r2
> -Wno-uninitialized -mmultiple -mstring   -DEXPORT_SYMTAB -c ll_rw_blk.c
> In file included from ll_rw_blk.c:28:
> /usr/src/lk2.2/2.2.19-ide-05042001/include/asm/ide.h:53: parse error before *'
> /usr/src/lk2.2/2.2.19-ide-05042001/include/asm/ide.h:56: warning: function
> declaration isn't a prototype

You need an

#include <linux/ide.h>

before the

#include <asm/ide.h>

in ll_rw_blk.c.

Lines 27-30 of ll_rw_blk.c would end up looking like this:

#ifdef CONFIG_POWERMAC
#include <linux/ide.h>
#include <asm/ide.h>
#endif

There are a number of other compilation problems in the code that will
need similar "fixes".

Note that you will need the PCI fixup patch from
http://www.cpu.lu/~mlan/linux/dev/pci.html if you want to be able to use a
PCI IDE controller card, like the Promise Ultra33/Ultra66/Ultra100, in
your PowerMac.  It seems that the PCI resources won't get seupt correctly
by OpenFirmware otherwise.


Phil

