Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268843AbUHYVPR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268843AbUHYVPR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 17:15:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268813AbUHYVLc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 17:11:32 -0400
Received: from websrv2.werbeagentur-aufwind.de ([213.239.197.240]:52711 "EHLO
	websrv2.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S268707AbUHYVAQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 17:00:16 -0400
Subject: Re: silent semantic changes with reiser4
From: Christophe Saout <christophe@saout.de>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@lst.de>,
       Hans Reiser <reiser@namesys.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
In-Reply-To: <20040825204240.GI21964@parcelfarce.linux.theplanet.co.uk>
References: <20040824202521.GA26705@lst.de> <412CEE38.1080707@namesys.com>
	 <20040825200859.GA16345@lst.de>
	 <Pine.LNX.4.58.0408251314260.17766@ppc970.osdl.org>
	 <20040825204240.GI21964@parcelfarce.linux.theplanet.co.uk>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-P50iur+ziqPql9646vnW"
Date: Wed, 25 Aug 2004 23:00:00 +0200
Message-Id: <1093467601.9749.14.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.92.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-P50iur+ziqPql9646vnW
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Mittwoch, den 25.08.2004, 21:42 +0100 schrieb :

> > > For one thing _I_ didn't decide about xattrs anyway.  And I still
> > > haven't seen a design from you on -fsdevel how you try to solve the
> > > problems with files as directories.
> >=20
> > Hey, files-as-directories are one of my pet things, so I have to side w=
ith=20
> > Hans on this one. I think it just makes sense. A hell of a lot more sen=
se=20
> > than xattrs, anyway, since it allows scripts etc standard tools to touc=
h=20
> > the attributes.
> >=20
> > It's the UNIX way.
>=20
> Not if you allow link(2) on them.

That doesn't make sense anyway. (actually, I tried what happens and the
result was an Oops ;))

It should be completely forbidden to link into a meta-directory or out
of such a directory. You could think of those meta-directory as a sysfs
for that inode. Of course it's not an own filesystem and that means that
there need to be a lot of security precautions in the VFS layer. Where
something like that belongs anyway, if done correctly.

>   And not if you design and market your
> stuff as a general-purpose backdoor into kernel.  Note how *EVERY* *DAMN*
> *OPERATION* is made possible to override by "plugins".  Which is the reas=
on
> for deadlocks in question, BTW.

What do you mean? If you tell that file that you want it to be
compressed or encrypted or modify some attributes (like ACLs) this isn't
necessarily a backdoor.

> Don't fool yourself - that's what Hans is selling.  Target market: ISV.
> Marketed product: a set of hooks, the wider the better, no matter how
> little sense it makes.  The reason for doing that outside of core kernel:
> bypassing any review and being able to control the product being sold (se=
e
> above).

Yes, I don't think it was a good idea either. Probably someone should
remove these features and make it a "normal" filesystem. The people who
need it now can turn it on again and a real solution could be worked out
in Linux 2.7.

I wouldn't use it on a public server anyway now because I'm not
convinced some malicious guy could find a way to exploit that. What if
you changed into a meta directory using ftp and some manage to break
things? This might be very dangerous.

I personally think that the idea of doing something like this (I'm not
speaking of the current implementation which I think is really bad) is
the right way to go in the long term.


--=-P50iur+ziqPql9646vnW
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBLP3QZCYBcts5dM0RAm6vAJ0Tp4cjC+VjlzXQBpQTlQhENgBeCQCeIJWq
A+PI0RhfPqccic2Ue7FBCLM=
=EjhV
-----END PGP SIGNATURE-----

--=-P50iur+ziqPql9646vnW--

