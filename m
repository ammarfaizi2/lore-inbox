Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319615AbSH2XZS>; Thu, 29 Aug 2002 19:25:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319617AbSH2XZS>; Thu, 29 Aug 2002 19:25:18 -0400
Received: from ppp-217-133-223-7.dialup.tiscali.it ([217.133.223.7]:64918 "EHLO
	home.ldb.ods.org") by vger.kernel.org with ESMTP id <S319615AbSH2XZR>;
	Thu, 29 Aug 2002 19:25:17 -0400
Subject: Re: [PATCH 1 / ...] i386 dynamic fixup/self modifying code
From: Luca Barbieri <ldb@ldb.ods.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Pavel Machek <pavel@suse.cz>,
       Linux-Kernel ML <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <1030663192.1326.20.camel@irongate.swansea.linux.org.uk>
References: <1030506106.1489.27.camel@ldb>  <20020828121129.A35@toy.ucw.cz>
	 <1030663192.1326.20.camel@irongate.swansea.linux.org.uk>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-tI9gYL6qaVymjP+ZjZev"
X-Mailer: Ximian Evolution 1.0.5 
Date: 30 Aug 2002 01:29:32 +0200
Message-Id: <1030663772.1491.107.camel@ldb>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-tI9gYL6qaVymjP+ZjZev
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2002-08-30 at 01:19, Alan Cox wrote:
> On Wed, 2002-08-28 at 13:11, Pavel Machek wrote:
> > > Unfortunately with this patch executing invalid code will cause the
> > > processor to enter an infinite exception loop rather than panic. Fixing
> > > this is not trivial for SMP+preempt so it's not done at the moment.
> > 
> > Using 0xcc for everything should fix that, right?
> 
> Except you can't do the fixup on SMP without risking hitting the CPU
> errata.
Worked around by making sure all other processors are stopped (iret is
serializing) sending IPIs if they are not already spinning on the fixup
lock. See patch #2.

> You also break debugging tools that map kernel code pages r/o
> and people who ROM it.
> 
> The latter aren't a big problem (they can compile without runtime
> fixups).
OK, I'll add a config option for this.

> For the other fixups though you -have- to do them before you
> run the code. That isnt hard (eg sparc btfixup). You generate a list of
> the addresses in a segment, patch them all and let the init freeup blow 
> the table away
Is doing them at runtime with the aforementioned workaround fine?


--=-tI9gYL6qaVymjP+ZjZev
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9bq5cdjkty3ft5+cRAvgyAJ4oVhbtLcFjhTUPYd6DKC6Q/hHn9gCg0ORF
XdVKJ8uwCzYzD63oYN7LLAg=
=JK7u
-----END PGP SIGNATURE-----

--=-tI9gYL6qaVymjP+ZjZev--
