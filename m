Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261444AbUCAVki (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 16:40:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261450AbUCAVkh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 16:40:37 -0500
Received: from s2.ukfsn.org ([217.158.120.143]:63445 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S261444AbUCAVkZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 16:40:25 -0500
Subject: Re: Ibm Serveraid Problem with 2.4.25
From: Alan Swanson <swanson@ukfsn.org>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-9CgXedFZTxpHHD06zT8Z"
Message-Id: <1078177104.7677.6.camel@zeus.local>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 01 Mar 2004 21:38:25 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-9CgXedFZTxpHHD06zT8Z
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Marcelo Tosatti wrote:
> On Mon, 1 Mar 2004, Chuck Lever wrote:
>
> > hi marcelo-
> >
> > your "fix" will break readahead again for NFS.  with the ">=3D" as you
> > propose, the read ahead code will never be able to read the last page o=
f
> > the file as a coalesced read, it will always be a separate 4KB read.
> >=20
> > the problem is not the readahead code, it is the driver code that tries
> > to read beyond the end of the device.  my change merely exposed this
> > misbehavior.
> >
> > so there is a broken assumption somewhere about how the index of the la=
st
> > page of a file/device is computed.  i think it is a problem when the fi=
le
> > ends exactly on a page boundary.
> >
> > alain, if you don't use the NFS client, marcelo's fix should work just
> > fine for you.  but i believe that in general it is incorrect.
>
> Okey, most drivers do no exhibit this problem indeed.
>
> We should try to fix the problematic drivers, then.
>
> If we can't do it easily and in a straightforward manner, I'm afraid we
> will have to undo your change because even if the "read end beyond of
> device" accesses are harmless (are they really harmless?), they must
> fixed.
>
> Agreed?
>
> I'll take a look at them later today, but I'm no expert, so help is very
> appreciated.
>
> We know that these have problems:
>
> - Promise ATA
> - ips (serveraid)

Also seeing this with the siimage driver with a 3112 SATA chipset.

--=20
Alan.

"One must never be purposelessnessnesslessness."

--=-9CgXedFZTxpHHD06zT8Z
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQBAQ61QagoW53DrKMIRAosDAKCJVbg+ATjv/pEq6DKY5mJ3yNiTEQCgsQUr
lLfqoam2m7glclGNVV08RAw=
=u/16
-----END PGP SIGNATURE-----

--=-9CgXedFZTxpHHD06zT8Z--
