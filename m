Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262318AbUBXRoO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 12:44:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262330AbUBXRoO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 12:44:14 -0500
Received: from intra.cyclades.com ([64.186.161.6]:33000 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S262318AbUBXRnv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 12:43:51 -0500
Date: Tue, 24 Feb 2004 15:38:24 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Brian Gerst <bgerst@didntduck.org>, Russell King <rmk@arm.linux.org.uk>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove LDFLAGS_BLOB
In-Reply-To: <20040222093221.GA2266@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.58L.0402241536120.23951@logos.cnet>
References: <4037D3D1.9000207@quark.didntduck.org> <20040222093221.GA2266@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 22 Feb 2004, Sam Ravnborg wrote:

> On Sat, Feb 21, 2004 at 04:55:29PM -0500, Brian Gerst wrote:
> > LDFLAGS_BLOB is no longer used for anything.
>
> Hi Brian.
>
> It was kept in ARM on purpose, because Russell King replied that the binutils
> in widely use for arm did not support .incbin.
>
> So rmk should ack this patch before it's getting applied.

This is useful for people who happen to be using older binutils but want
to use 2.6.

Dont remove it.

> > diff -urN linux-bk/usr/initramfs_data.S linux/usr/initramfs_data.S
> > --- linux-bk/usr/initramfs_data.S	2003-12-17 21:59:42.000000000 -0500
> > +++ linux/usr/initramfs_data.S	2004-02-20 19:18:31.250879280 -0500
> > @@ -1,28 +1,6 @@
> >  /*
> >    initramfs_data includes the compressed binary that is the
> >    filesystem used for early user space.
> > -  Note: Older versions of "as" (prior to binutils 2.11.90.0.23
> > -  released on 2001-07-14) dit not support .incbin.
> > -  If you are forced to use older binutils than that then the
> > -  following trick can be applied to create the resulting binary:
> > -
> > -
> > -  ld -m elf_i386  --format binary --oformat elf32-i386 -r \
> > -  -T initramfs_data.scr initramfs_data.cpio.gz -o initramfs_data.o
> > -   ld -m elf_i386  -r -o built-in.o initramfs_data.o
> > -
> > -  initramfs_data.scr looks like this:
> > -SECTIONS
> > -{
> > -       .init.ramfs : { *(.data) }
> > -}
> > -
> > -  The above example is for i386 - the parameters vary from architectures.
> > -  Eventually look up LDFLAGS_BLOB in an older version of the
> > -  arch/$(ARCH)/Makefile to see the flags used before .incbin was introduced.
> > -
> > -  Using .incbin has the advantage over ld that the correct flags are set
> > -  in the ELF header, as required by certain architectures.
> >  */
> >
> >  .section .init.ramfs,"a"
