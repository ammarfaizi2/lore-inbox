Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268890AbUHZNNm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268890AbUHZNNm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 09:13:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268828AbUHZNKQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 09:10:16 -0400
Received: from websrv2.werbeagentur-aufwind.de ([213.239.197.240]:65170 "EHLO
	websrv2.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S268886AbUHZNAr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 09:00:47 -0400
Subject: Re: silent semantic changes with reiser4
From: Christophe Saout <christophe@saout.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@osdl.org>, Hans Reiser <reiser@namesys.com>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, torvalds@osdl.org, reiserfs-list@namesys.com
In-Reply-To: <20040826124929.GA542@lst.de>
References: <20040824202521.GA26705@lst.de> <412CEE38.1080707@namesys.com>
	 <20040825152805.45a1ce64.akpm@osdl.org> <412D9FE6.9050307@namesys.com>
	 <20040826014542.4bfe7cc3.akpm@osdl.org>
	 <1093522729.9004.40.camel@leto.cs.pocnet.net> <20040826124929.GA542@lst.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-eW1SCWInrBIoPelU0I9A"
Date: Thu, 26 Aug 2004 15:00:34 +0200
Message-Id: <1093525234.9004.55.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.92.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-eW1SCWInrBIoPelU0I9A
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Donnerstag, den 26.08.2004, 14:49 +0200 schrieb Christoph Hellwig:

> Now that part is interesting from the how to sell it to non-Linux users
> POV, but not for the linux kernel.

Why? The question was what these plugins are exactly. This is the
answer.

> > *And* there are plugins which are users of the "reiser4 client API" and
> > implement the actual VFS methods.
>=20
> Here comes the problem.  All the access checking/race avoidance/loop
> creation avoiced, in short the posix+extension semantics are implemented
> in the Linux VFS layer.  If you want to allow a second access method
> (e.g. Hans' pet syscall) you'd have to duplicate all VFS functioanlity
> inside reiser4.

Are you actually listening? If you implement a filesystem there's a
place where you have to implement the Linux VFS methods. I'm talking
about inode_operations and these things. This has nothing to do with
doing anything outside the Linux VFS. And I'm not talking about these
metas either. These really don't belong inside the filesystem.

> So if you want to provide an additional API you'll have to go through
> the VFS to get it right - ergo a plugin architecture for upper plugins
> is worthless.

See, you didn't listen. ;-)

The reiser4 core doesn't know about inodes, directories or files. It's
the glue code between the VFS and the storage layer that does. It's
implemented as a plugin. This has nothing to do with semantic
enhancements yet. These should be removed for now and made a 2.7 topic.

Maybe Namesys could provide them as an additional patch from their
webpage for those who need it. The plugins that would benefit from this
(encrypted and compressed file storage) aren't ready yet anyway.


--=-eW1SCWInrBIoPelU0I9A
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBLd7yZCYBcts5dM0RAgSwAKCrFn8HjcjarD9IA89hzzu4aqeR0ACgi9ee
0CKrmnScLo/dccB+U2K+gIY=
=4//l
-----END PGP SIGNATURE-----

--=-eW1SCWInrBIoPelU0I9A--

