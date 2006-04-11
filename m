Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750788AbWDKMI3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750788AbWDKMI3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 08:08:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750789AbWDKMI3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 08:08:29 -0400
Received: from chilli.pcug.org.au ([203.10.76.44]:45021 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S1750788AbWDKMI3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 08:08:29 -0400
Date: Tue, 11 Apr 2006 22:08:07 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix block device symlink name
Message-ID: <20060411220807.357e253d@localhost>
In-Reply-To: <Pine.LNX.4.61.0604111337450.928@yvahk01.tjqt.qr>
References: <20060410151651.01fd6167.sfr@canb.auug.org.au>
	<Pine.LNX.4.61.0604111337450.928@yvahk01.tjqt.qr>
X-Mailer: Sylpheed-Claws 2.1.0 (GTK+ 2.8.16; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; boundary=Sig_oq1+5K0V6oaikP0Qhpp.mbd;
 protocol="application/pgp-signature"; micalg=PGP-SHA1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_oq1+5K0V6oaikP0Qhpp.mbd
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 11 Apr 2006 13:38:09 +0200 (MEST) Jan Engelhardt <jengelh@linux01.g=
wdg.de> wrote:
>
> >@@ -352,6 +353,10 @@ static char *make_block_name(struct gend
> > 		return NULL;
> > 	strcpy(name, block_str);
> > 	strcat(name, disk->disk_name);
> >+	/* ewww... some of these buggers have / in name... */
> >+	s =3D strchr(name, '/');
> >+	if (s)
> >+		*s =3D '!';
> > 	return name;
> > }
> >=20
>=20
> Can they have multiple '/'? If so, we need a while loop.

The other place that fixes this (just 10 or so lines further on in this
file) does not loop.  Looking through the block devices, there is no
obvious place that creates a name with more than one '/'.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Sig_oq1+5K0V6oaikP0Qhpp.mbd
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFEO5wuFdBgD/zoJvwRAo2GAJ0SibgC9wbcxZhAnSBnX6JIVCnJzwCeKNVW
efn6wdnXH5z00+MuBwbA3BQ=
=gS6i
-----END PGP SIGNATURE-----

--Sig_oq1+5K0V6oaikP0Qhpp.mbd--
