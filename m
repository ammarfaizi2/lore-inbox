Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263204AbUHGQCb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263204AbUHGQCb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 12:02:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263159AbUHGQCb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 12:02:31 -0400
Received: from moutng.kundenserver.de ([212.227.126.191]:20172 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S263147AbUHGQCZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 12:02:25 -0400
From: Amon Ott <ao@rsbac.org>
Organization: RSBAC
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux kernel file offset pointer races
Date: Sat, 7 Aug 2004 18:02:09 +0200
User-Agent: KMail/1.6.2
References: <20040804214056.6369.0@argo.troja.mff.cuni.cz> <200408071438.18878.ao@rsbac.org> <20040807131825.GE12308@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20040807131825.GE12308@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_H0PFBQGyGlusBws";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408071802.15226.ao@rsbac.org>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:e784f4497a7e52bfc8179ee7209408c3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_H0PFBQGyGlusBws
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Samstag, 7. August 2004 15:18, viro@parcelfarce.linux.theplanet.co.uk=20
wrote:
> On Sat, Aug 07, 2004 at 02:38:12PM +0200, Amon Ott wrote:
> > Would it not be useful to have per-process or per-thread offsets? Do=20
> > parallel processes really need to share the offset?
> >=20
> > E.g., the struct file could (optionally) be copied on fork with=20
> > copy-on-write to avoid extra memory consumption.
>=20
> (cat a; cat b) > /tmp/foo

Right, the process running (...) would not know what offset to give "cat b"=
=20
as a start, because it cannot see "cat a"'s final offset. It could seek to=
=20
the end of /tmp/foo before starting "cat b", but this requirement would=20
break existing shells. Bad luck.

As there are probably more examples why it does not work, there will=20
probably have to be a macro for all offset changes, which checks for=20
overruns.

Amon.
=2D-=20
http://www.rsbac.org - GnuPG: 2048g/5DEAAA30 2002-10-22

--Boundary-02=_H0PFBQGyGlusBws
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBFP0Hq9yn6h5RTo8RAlaQAJ9f8WRevpQzkkJ6ipXX/Bg1CbZdmgCcCdJZ
YZRjEpE87oHloveE2bNZf74=
=8V6F
-----END PGP SIGNATURE-----

--Boundary-02=_H0PFBQGyGlusBws--
