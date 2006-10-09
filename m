Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751902AbWJIWkx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751902AbWJIWkx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 18:40:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751909AbWJIWkx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 18:40:53 -0400
Received: from lug-owl.de ([195.71.106.12]:3783 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S1751902AbWJIWkw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 18:40:52 -0400
Date: Tue, 10 Oct 2006 00:40:51 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Eric Sandeen <sandeen@sandeen.net>
Cc: Andrew Morton <akpm@osdl.org>, Dave Jones <davej@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, esandeen@redhat.com,
       Badari Pulavarty <pbadari@us.ibm.com>, Jan Kara <jack@ucw.cz>
Subject: Re: 2.6.18 ext3 panic.
Message-ID: <20061009224050.GD30283@lug-owl.de>
Mail-Followup-To: Eric Sandeen <sandeen@sandeen.net>,
	Andrew Morton <akpm@osdl.org>, Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>, esandeen@redhat.com,
	Badari Pulavarty <pbadari@us.ibm.com>, Jan Kara <jack@ucw.cz>
References: <20061002194711.GA1815@redhat.com> <20061003052219.GA15563@redhat.com> <4521F865.6060400@sandeen.net> <20061002231945.f2711f99.akpm@osdl.org> <452AA716.7060701@sandeen.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="T7nyQ/KeiTWBaOH9"
Content-Disposition: inline
In-Reply-To: <452AA716.7060701@sandeen.net>
X-Operating-System: Linux mail 2.6.12.3lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--T7nyQ/KeiTWBaOH9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 2006-10-09 14:46:30 -0500, Eric Sandeen <sandeen@sandeen.net> wrote:
> Andrew Morton wrote:
> > On Tue, 03 Oct 2006 00:43:01 -0500
> > Eric Sandeen <sandeen@sandeen.net> wrote:
> > > Dave Jones wrote:
> > > > So I managed to reproduce it with an 'fsx foo' and a
> > > > 'fsstress -d . -r -n 100000 -p 20 -r'. This time I grabbed it from
> > > > a vanilla 2.6.18 with none of the Fedora patches..
> > > >
> > > > I'll give 2.6.18-git a try next.
> > > >
> > > > ----------- [cut here ] --------- [please bite here ] ---------
> > > > Kernel BUG at fs/buffer.c:2791
> > > I had thought/hoped that this was fixed by Jan's patch at=20
> > > http://lkml.org/lkml/2006/9/7/236 from the thread started at=20
> > > http://lkml.org/lkml/2006/9/1/149, but it seems maybe not.  Dave hit =
this bug=20
> > > first by going through that new codepath....
> >=20
> > Yes, Jan's patch is supposed to fix that !buffer_mapped() assertion.  i=
irc,
> > Badari was hitting that BUG and was able to confirm that Jan's patch
> > (3998b9301d3d55be8373add22b6bc5e11c1d9b71 in post-2.6.18 mainline) fixed
> > it.
>=20
> Looking at some BH traces*, it appears that what Dave hit is a truncate
> racing with a sync...
>=20
> truncate ...
>   ext3_invalidate_page
>     journal_invalidatepage
>       journal_unmap buffer
>=20
> going off at the same time as
>=20
> sync ...
>   journal_dirty_data
>     sync_dirty_buffer
>       submit_bh <-- finds unmapped buffer, boom.

Is this possibly related to the issues that are discussed in another
thread? We're seeing problems while unlinking large files (usually get
it within some hours with 200MB files, but couldn't yet reproduce it
with 20MB.)

MfG, JBG
--=20
      Jan-Benedict Glaw      jbglaw@lug-owl.de              +49-172-7608481
Signature of:         Alles wird gut! ...und heute wirds schon ein bi=C3=9F=
chen besser.
the second  :

--T7nyQ/KeiTWBaOH9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFKs/yHb1edYOZ4bsRAp7lAKCHADKp9PcLLjxRqW3Xu1LspY1CfwCfU2ev
d+HsHavV5lqQCvqbLPhqCP4=
=/u+b
-----END PGP SIGNATURE-----

--T7nyQ/KeiTWBaOH9--
