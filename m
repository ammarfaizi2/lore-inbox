Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932098AbVIWXaI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932098AbVIWXaI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 19:30:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751346AbVIWXaI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 19:30:08 -0400
Received: from smtp06.auna.com ([62.81.186.16]:59279 "EHLO smtp06.retemail.es")
	by vger.kernel.org with ESMTP id S1751345AbVIWXaG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 19:30:06 -0400
Date: Sat, 24 Sep 2005 01:30:21 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] reduce sizeof(struct file)
Message-ID: <20050924013021.1130f3c8@werewolf.able.es>
In-Reply-To: <20050923100541.GA18447@infradead.org>
References: <17AB476A04B7C842887E0EB1F268111E026FC5@xpserver.intra.lexbox.org>
	<4333CF4C.2000306@anagramm.de>
	<4333D2AA.6020009@cosmosbay.com>
	<20050923100541.GA18447@infradead.org>
X-Mailer: Sylpheed-Claws 1.9.14cvs49 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary="Signature_Sat__24_Sep_2005_01_30_21_+0200_E6/xO.VY+7dn8Mn8";
 protocol="application/pgp-signature"; micalg=PGP-SHA1
X-Auth-Info: Auth:LOGIN IP:[83.138.209.17] Login:jamagallon@able.es Fecha:Sat, 24 Sep 2005 01:30:03 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature_Sat__24_Sep_2005_01_30_21_+0200_E6/xO.VY+7dn8Mn8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 23 Sep 2005 11:05:41 +0100, Christoph Hellwig <hch@infradead.org> w=
rote:

> On Fri, Sep 23, 2005 at 12:02:18PM +0200, Eric Dumazet wrote:
> > Hi all
> >=20
> > Now that RCU applied on 'struct file' seems stable, we can place f_rcuh=
ead=20
> > in a memory location that is not anymore used at call_rcu(&f->f_rcuhead=
,=20
> > file_free_rcu) time, to reduce the size of this critical kernel object.
> >=20
> > The trick I used is to move f_rcuhead and f_list in an union and defini=
ng=20
> > macros to access f_list and f_rcuhead
> >=20
> > Unfortunatly f_list was also used in IPVS so I had to change=20
> > include/net/ip_vs.h and net/ipv4/ipvs/ip_vs_ctl.c, changing their f_lis=
t to=20
> > ipvs_f_list to avoid name clash.
> >=20
> > (This is why I send this mail to IPVS maintainers)
>=20
> Please just change all callers to use the union, there's not very many
> of them.
>=20

How about anonymous unions ? gcc-3.3.3 and above support them.
Is 2.6 supposed to be built with 2.95 ?

--
J.A. Magallon <jamagallon()able!es>     \               Software is like se=
x:
werewolf!able!es                         \         It's better when it's fr=
ee
Mandriva Linux release 2006.0 (2006 rc2) for i586
Linux 2.6.13-jam6 (gcc 4.0.1 (4.0.1-5mdk for Mandriva Linux release 2006.0))

--Signature_Sat__24_Sep_2005_01_30_21_+0200_E6/xO.VY+7dn8Mn8
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDNJANRlIHNEGnKMMRAnzUAJ4z2oPZtuG8exwiEs2eR8JLKWGANwCgq6h0
FJ28gXorGQgKYkZ6fAeskwA=
=TDCV
-----END PGP SIGNATURE-----

--Signature_Sat__24_Sep_2005_01_30_21_+0200_E6/xO.VY+7dn8Mn8--
