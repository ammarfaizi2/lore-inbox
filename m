Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262731AbRFGS1T>; Thu, 7 Jun 2001 14:27:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262733AbRFGS1J>; Thu, 7 Jun 2001 14:27:09 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:57570 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S262731AbRFGS1G>; Thu, 7 Jun 2001 14:27:06 -0400
Date: Thu, 7 Jun 2001 20:28:04 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
cc: Tom Vier <tmv5@home.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] Re: Linux 2.4.5-ac6
In-Reply-To: <20010607212015.A17908@jurassic.park.msu.ru>
Message-ID: <Pine.GSO.3.96.1010607193120.16852B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Jun 2001, Ivan Kokshaysky wrote:

> Thanks for the info. I dug a bit that OSF stuff (on Compaq's testdrive
> boxes), and found no traces of 32-bit addressing support in the OSF kernel.
> Everything seems to be done by dynamic linker (i.e. /sbin/loader) in user
> space.

 Their docs imply just that.

> I don't think so. The EF_ALPHA_32BIT in the ELF header flags
> is elegant and easy to use. Unlike this, RHF_USE_31BIT_ADDRESSES is
> not in the headers, but somewhere in .dynamic section. And what

 You are right.

> about a static binary calling mmap()? ;-)

 DU seems to map as low as possible, it would seem.  Maybe we could just
do the same for OSF/1 binaries by setting TASK_UNMAPPED_BASE
appropriately? 

> BTW, OSF/1 manpages say nothing about first argument of mmap(2) being
> just a hint:

 Nope, see:

  The new region is placed at the requested address if the requested address
  is not null and it is possible to place the region at this address.  When
  the requested address is null or the region cannot be placed at the
  requested address, the MAP_VARIABLE and MAP_FIXED flags control the place-
  ment of the region.  One of these flags must be selected.

  If MAP_VARIABLE is set in the flags parameter:

    +  If the requested address is null or if it is not possible for the sys-
       tem to place the region at the requested address, the region is placed
       at an address selected by the system.

  If MAP_FIXED is set in the flags parameter:
[...]

We don't have MAP_VARIABLE but it's expands to zero in OSF/1 anyway.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

