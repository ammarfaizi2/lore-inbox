Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264113AbUJLPW5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264113AbUJLPW5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 11:22:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265093AbUJLPW5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 11:22:57 -0400
Received: from lug-owl.de ([195.71.106.12]:176 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S264113AbUJLPVA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 11:21:00 -0400
Date: Tue, 12 Oct 2004 17:20:59 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Christoph Lameter <clameter@sgi.com>
Cc: linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au, linux-mm@kvack.org
Subject: Re: NUMA: Patch for node based swapping
Message-ID: <20041012152059.GB5033@lug-owl.de>
Mail-Followup-To: Christoph Lameter <clameter@sgi.com>,
	linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au,
	linux-mm@kvack.org
References: <Pine.LNX.4.58.0410120751010.11558@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LtWARj4qtdVynAWs"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0410120751010.11558@schroedinger.engr.sgi.com>
X-Operating-System: Linux mail 2.6.8-rc4 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--LtWARj4qtdVynAWs
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-10-12 08:02:40 -0700, Christoph Lameter <clameter@sgi.com>
wrote in message <Pine.LNX.4.58.0410120751010.11558@schroedinger.engr.sgi.c=
om>:
> --- linux-2.6.9-rc4.orig/mm/page_alloc.c	2004-10-10 19:57:03.000000000 -0=
700
> +++ linux-2.6.9-rc4/mm/page_alloc.c	2004-10-11 12:54:51.000000000 -0700
> @@ -483,6 +486,13 @@
>  	p =3D &z->pageset[cpu];
>  	if (pg =3D=3D orig) {
>  		z->pageset[cpu].numa_hit++;
> +		/*
> +		 * If zone allocation leaves less than a (sysctl_node_swap * 10) %
> +		 * of the zone free then invoke kswapd.
> +		 * (to make it efficient we do (pages * sysctl_node_swap) / 1024))
> +		 */
> +		if (z->free_pages < (z->present_pages * sysctl_node_swap) << 10)
> +			wakeup_kswapd(z);
>  	} else {
>  		p->numa_miss++;
>  		zonelist->zones[0]->pageset[cpu].numa_foreign++;

Shouldn't the comment read "less than (sysctl_node_swap / 10) %",
because the value in sysctl_node_swap is actually percent*10, so you
need the reverse action here?!

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Irak! =
  O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--LtWARj4qtdVynAWs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBa/ZaHb1edYOZ4bsRAi4DAJ408cUnPWVqcbS93ncV6qHSueeL3ACfd01W
5Ni66rH7QktvlXyrSxZVpiY=
=Y40U
-----END PGP SIGNATURE-----

--LtWARj4qtdVynAWs--
