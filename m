Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263011AbRFFNZY>; Wed, 6 Jun 2001 09:25:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263141AbRFFNZO>; Wed, 6 Jun 2001 09:25:14 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:42703 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S263011AbRFFNZF>; Wed, 6 Jun 2001 09:25:05 -0400
Date: Wed, 6 Jun 2001 15:09:11 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
cc: Tom Vier <tmv5@home.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] Re: Linux 2.4.5-ac6
In-Reply-To: <20010606093700.A1445@jurassic.park.msu.ru>
Message-ID: <Pine.GSO.3.96.1010606115046.23232A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Jun 2001, Ivan Kokshaysky wrote:

> > No need to patch arch_get_unmapped_area(), but OSF/1 compatibility code
> > might need fixing.  I suppose an OSF/1 binary must have an appropriate
> > flag set in its header after building with the -taso option so that the
> > system knows the binary wants 32-bit addressing.
> 
> I'm not sure if COFF headers have such flag at all. I'll check this.

 Then how does OSF/1, especially the dynamic linker, know if a binary
needs 32-bit addressing?  I suppose we could use the same way of
selection.

 Hmm...:

$ uname -mprsv
OSF1 V4.0 1091 alpha alpha
$ file /usr/bin/X11/real-netscape
/usr/bin/X11/real-netscape:     COFF format alpha dynamically linked,
demand paged executable or object module stripped - version 3.11-8
$ odump -D /usr/bin/X11/real-netscape | grep FLAGS
                       FLAGS: 0x40000001
$ odump -D /usr/bin/X11/xterm | grep FLAGS
                       FLAGS: 0x00000001

A wild guess: the 32-bit flag is bit 30.

 A second attempt (after a bit of searching in /usr/include):

$ grep ADDRESSES /usr/include/elf_mips.h
#define RHF_USE_31BIT_ADDRESSES     0x40000000

Ah, here it is.  Remember OSF/1 was running on MIPS (DECstation) first and
they never used ELF but apparently reused a few of its properties.

 So what is needed is already in place and ready to use.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

