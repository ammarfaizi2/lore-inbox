Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262580AbRFGRZf>; Thu, 7 Jun 2001 13:25:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262583AbRFGRZZ>; Thu, 7 Jun 2001 13:25:25 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:15111 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S262580AbRFGRZL>; Thu, 7 Jun 2001 13:25:11 -0400
Date: Thu, 7 Jun 2001 21:20:15 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Tom Vier <tmv5@home.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] Re: Linux 2.4.5-ac6
Message-ID: <20010607212015.A17908@jurassic.park.msu.ru>
In-Reply-To: <20010606093700.A1445@jurassic.park.msu.ru> <Pine.GSO.3.96.1010606115046.23232A-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1010606115046.23232A-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Wed, Jun 06, 2001 at 03:09:11PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 06, 2001 at 03:09:11PM +0200, Maciej W. Rozycki wrote:
> $ odump -D /usr/bin/X11/real-netscape | grep FLAGS
>                        FLAGS: 0x40000001
> $ odump -D /usr/bin/X11/xterm | grep FLAGS
>                        FLAGS: 0x00000001
> 
> A wild guess: the 32-bit flag is bit 30.

Thanks for the info. I dug a bit that OSF stuff (on Compaq's testdrive
boxes), and found no traces of 32-bit addressing support in the OSF kernel.
Everything seems to be done by dynamic linker (i.e. /sbin/loader) in user
space.

>  A second attempt (after a bit of searching in /usr/include):
> 
> $ grep ADDRESSES /usr/include/elf_mips.h
> #define RHF_USE_31BIT_ADDRESSES     0x40000000

Same in /usr/include/coff_dyn.h, True64 v5.1.

>  So what is needed is already in place and ready to use.

I don't think so. The EF_ALPHA_32BIT in the ELF header flags
is elegant and easy to use. Unlike this, RHF_USE_31BIT_ADDRESSES is
not in the headers, but somewhere in .dynamic section. And what
about a static binary calling mmap()? ;-)
BTW, OSF/1 manpages say nothing about first argument of mmap(2) being
just a hint:
...
PARAMETERS

  addr      Specifies the starting address of the new region (truncated to a
            page boundary).

  len       Specifies the length in bytes of the new region (rounded up to a
            page boundary).
...

Ivan.
