Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261682AbUHGMie@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261682AbUHGMie (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 08:38:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261857AbUHGMie
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 08:38:34 -0400
Received: from moutng.kundenserver.de ([212.227.126.183]:53499 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261682AbUHGMi3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 08:38:29 -0400
From: Amon Ott <ao@rsbac.org>
Organization: RSBAC
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux kernel file offset pointer races
Date: Sat, 7 Aug 2004 14:38:12 +0200
User-Agent: KMail/1.6.2
References: <20040804214056.6369.0@argo.troja.mff.cuni.cz> <1091796995.16306.20.camel@localhost.localdomain>
In-Reply-To: <1091796995.16306.20.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_60MFBrpp+wLtUTl";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408071438.18878.ao@rsbac.org>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:e784f4497a7e52bfc8179ee7209408c3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_60MFBrpp+wLtUTl
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Freitag, 6. August 2004 14:56, Alan Cox wrote:
> On Mer, 2004-08-04 at 21:36, Pavel Kankovsky wrote:
> > IMHO, the proper fix is to serialize all operations modifying a shared
> > file pointer (file->f_pos): read(), readv(), write(), writev(),
> > lseek()/llseek(). As far as I can tell, this is required by POSIX:
>=20
> Not if you want to get any useful work done. No Unix does this. The
> situation with multiple parallel lseek/read/writes is somewhat undefined
> anyway since you don't know if the seek or the write occurred first in
> user space.

Would it not be useful to have per-process or per-thread offsets? Do=20
parallel processes really need to share the offset?

E.g., the struct file could (optionally) be copied on fork with=20
copy-on-write to avoid extra memory consumption.

Amon.
=2D-=20
http://www.rsbac.org - GnuPG: 2048g/5DEAAA30 2002-10-22

--Boundary-02=_60MFBrpp+wLtUTl
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBFM06q9yn6h5RTo8RAkTsAJwNA3UIiqwr/YO7f51s4ygzIB7sbACfdskx
cucAAG6hnuFc+g9DwsrmlmQ=
=HN/H
-----END PGP SIGNATURE-----

--Boundary-02=_60MFBrpp+wLtUTl--
