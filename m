Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269530AbUHZT47@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269530AbUHZT47 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 15:56:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269528AbUHZTzt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 15:55:49 -0400
Received: from websrv2.werbeagentur-aufwind.de ([213.239.197.240]:57508 "EHLO
	websrv2.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S269266AbUHZTnZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 15:43:25 -0400
Subject: Re: silent semantic changes with reiser4
From: Christophe Saout <christophe@saout.de>
To: Jamie Lokier <jamie@shareable.org>
Cc: Rik van Riel <riel@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       Diego Calleja <diegocg@teleline.es>, vda@port.imtp.ilyichevsk.odessa.ua,
       christer@weinigel.se, spam@tnonline.net, akpm@osdl.org,
       wichert@wiggy.net, jra@samba.org, reiser@namesys.com, hch@lst.de,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
In-Reply-To: <20040826192918.GW5733@mail.shareable.org>
References: <Pine.LNX.4.58.0408261149510.2304@ppc970.osdl.org>
	 <Pine.LNX.4.44.0408261457320.27909-100000@chimarrao.boston.redhat.com>
	 <20040826192918.GW5733@mail.shareable.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-UTY8BQPSlIcDd/cYJiSS"
Date: Thu, 26 Aug 2004 21:42:55 +0200
Message-Id: <1093549375.13881.19.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.92.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-UTY8BQPSlIcDd/cYJiSS
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Donnerstag, den 26.08.2004, 20:29 +0100 schrieb Jamie Lokier:

> (1) O_CREAT creates something with "file-like
>     attributes", meaning stat() says it's a regular file.
>=20
> (2) File-like means it can be unlinked, linked and renamed, even if
>     someone has something inside it open.  Nothing that can be created
>     inside it will prevent it from being unlinked (unlike a
>     directory-like object, where rmdir() will refuse if it's not empty).

I would say hat the file and all of its directory gets invalidated and
deleted as soon as the last opener of the file's main stream or some of
its directory content disappears. How would that be?

> > Does this create a new class of "symlink attack" style security
> > holes ?
>=20
> Yes, but they don't need O_CREAT.
>=20
> An adversary creates a symlink to metadata inside your file.  You
> write to it: it has interesting effects that weren't anticipated, such
> as either modifying another (virtual) file, or altering permissions or
> other parameters which writing doesn't normally do.

Hmm.

> This is very difficult to prevent.

Right. But to change some properties you usually need to be the owner of
that file anyway, or root.

> In Hans Reiser's example of expanded /etc/passwd, atimes
> and mtimes of individual passwd entries is security information that
> perhaps shouldn't be exposed.

Only assuming mtime/ctime/atime/rwx/uid/gid of file contents can
actually be independant of those from the main stream. I would say that
the rights (read and write) for non-pseudo sub-files should the same as
the file, uid and gid 644 (only owner can change these), something like
that. mtime, atime and ctime always show the same as the file itself.
Hmm.

> The solution is the same as for /proc (I hope): make sure the read
> permissions on all metadata inside a directory branch are restricted
> to the permissions of the file branch, and write permissions even more
> restricted at least by default.

That's what I was thinking.


--=-UTY8BQPSlIcDd/cYJiSS
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBLj0/ZCYBcts5dM0RAtbhAKCCN8FjzZEkj+eqSfc1wt4f8b8KwQCeIvr3
4j55Gn/lj+UD5Fj1nL/Obpc=
=r2z0
-----END PGP SIGNATURE-----

--=-UTY8BQPSlIcDd/cYJiSS--

