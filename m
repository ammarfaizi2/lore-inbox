Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030530AbWBHFhg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030530AbWBHFhg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 00:37:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030531AbWBHFhg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 00:37:36 -0500
Received: from rwcrmhc14.comcast.net ([204.127.192.84]:15577 "EHLO
	rwcrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S1030530AbWBHFhf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 00:37:35 -0500
Date: Wed, 8 Feb 2006 00:37:32 -0500
From: John M Flinchbaugh <john@hjsoft.com>
To: Sam Vilain <sam@vilain.net>
Cc: Bernd Schubert <bernd-schubert@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.15 Bug? New security model?
Message-ID: <20060208053732.GA13560@butterfly.hjsoft.com>
References: <200602080212.27896.bernd-schubert@gmx.de> <43E94A02.2080205@vilain.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Content-Disposition: inline
In-Reply-To: <43E94A02.2080205@vilain.net>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 08, 2006 at 02:31:46PM +1300, Sam Vilain wrote:
> Bernd Schubert wrote:
> >With 2.6.15:
> >bathl:~# touch /var/run/test
> >touch: cannot touch `/var/run/test': Permission denied
> >With 2.6.13:
> >bathl:~# touch /var/run/test
> >(No error message)
>=20
> Some ideas; ACLs, SELinux, Attributes, Capabilities.

lsattr -d /var/run && lsattr /var/run

I saw very similar things going from 2.6.15.1 to 2.6.15.2.  2.6.15.2's
changelog advertises a fix to reenable extended attributes on reiserfs.
On one machine this is fine, and lsattr shows no attributes enabled
(----------), but on another machine, I ended up with all sorts of crazy
attributes set seemingly randomly -- compression, experimental flags,
immutable, append-only, all over the map.

I tried clearing them (chattr -R =3D /var ...etc), but I still found a
file here and there which refused to be removed, even though lsattr
showed no flags for it.  After a restart or 2, I saw some attributes
revert back and I started having trouble removing files from /var/run
and other places again.

I ended up reverting back to 2.6.15.1 until I have a chance to
investigate further and try to come up with something reportable.  In
2.6.15.1, attributes didn't work at all, giving an ioctl error, though
the same kernel options were used.  I suspect this is the fix to which
the Changelog is referring.

I must wonder if I'm suffering from some sort of fs corruption which
only manifests itself in the attribute settings, and which a reisefsck
doesn't recognize or correct.  I could be tempted to recreate the
filesystems from scratch to see if they still have issues.
--=20
John M Flinchbaugh
john@hjsoft.com

--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFD6YOcCGPRljI8080RAp1IAJ42B2FGEgTgw4qG3T/VU5pxf+B63QCePl+v
J9kCr5SWEK1bamygs+QuhIk=
=27BD
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
