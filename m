Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261729AbUKUKlH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261729AbUKUKlH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 05:41:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261542AbUKUKlC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 05:41:02 -0500
Received: from cimice4.lam.cz ([212.71.168.94]:1251 "EHLO vagabond.light.src")
	by vger.kernel.org with ESMTP id S261576AbUKUKkj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 05:40:39 -0500
Date: Sun, 21 Nov 2004 11:39:56 +0100
From: Jan Hudec <bulb@ucw.cz>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: pavel@ucw.cz, akpm@osdl.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
Message-ID: <20041121103956.GW2870@vagabond>
References: <E1CToBi-0008V7-00@dorka.pomaz.szeredi.hu> <20041117190055.GC6952@openzaurus.ucw.cz> <E1CUVkG-0005sV-00@dorka.pomaz.szeredi.hu> <20041117204424.GC11439@elf.ucw.cz> <E1CUhTd-0006c8-00@dorka.pomaz.szeredi.hu> <20041118144634.GA7922@openzaurus.ucw.cz> <E1CVmN5-0007qq-00@dorka.pomaz.szeredi.hu> <20041121095038.GV2870@vagabond> <E1CVp0g-0008Cw-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="APvmIexg9DiduZOF"
Content-Disposition: inline
In-Reply-To: <E1CVp0g-0008Cw-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--APvmIexg9DiduZOF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 21, 2004 at 11:31:58 +0100, Miklos Szeredi wrote:
> > But you won't bundle the *write* requests. And that's what will be
> > painfuly slow.
>=20
> Well, painfully slow is just about 100Mbytes/sec on my 1GHz C3
> machine.  Be real.

Measured under what conditions?

> >     3) Use a real disk file to back the page cache. Exactly like coda
> >        does it.
>=20
> Yes, that could be done.  Not exactly like coda, because the
> filesystem would have no way of knowing exacty _what_ was written.
> For many applications it's _way_ too inefficient to write back the
> whole file on every little change.  And writing back the file on
> release would mean a) big latency b) inconsistency between the backing
> filesystem and the virtual one.
>=20
> Actually latency _is_ the major problem with the CODA like interface.
> Try doing a 'less bigfile' with an sftp filesystem based on CODA and
> FUSE, and you'll see what I mean.  It will _feel_ a hell of a lot
> slower with CODA, just because you'd have to wait for the whole file
> to download to get the first byte.
>=20
> > I would not be so sure about this. The deadlock is caused by the fact
> > that such pages may exist, not by their number. Limiting the number will
> > only decrease the probability the deadlock will happen, but won't make
> > it go away.
>=20
> No.  The problem _is_ caused by their number, because it will only
> happen if pages cannot be freed in any other way, only by doing
> writeback to the userspace filesystem.  If there are pages which _can_
> be freed other ways, then deadlock won't happen.
>=20
> Now if you limit the total number of pages that FUSE can use for
> writable memory mappings to 10% of the total memory in the machine,
> you can be pretty sure, that the remaining 90% will not be filled with
> unpageable memory (otherwise you'd be in pretty big trouble anyway).

There may be only one dirty page in the whole system and it may be the
one backed by FUSE. Now yes, if it was not backed by FUSE, I would be in
trouble -- but the OOM killer would get me out. It will *NOT* get me out
with fuse, because it thinks the page will be cleaned, which it won't.

Thus by limiting the numeber of pages, you decrease the probability that
the deadlock will happen. You may even get to reasonably small numbers.
But you can't get to 0. The deadlock will still be there, it will just
be unlikely.

---------------------------------------------------------------------------=
----
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--APvmIexg9DiduZOF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBoHB8Rel1vVwhjGURAruVAKChjfBYcDACdEhNMErX5K+6cNyP2ACfWPM+
moGUdGDWWPDqOMW3c/ITmRY=
=1NQA
-----END PGP SIGNATURE-----

--APvmIexg9DiduZOF--
