Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751065AbWDULR2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751065AbWDULR2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 07:17:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750946AbWDULR2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 07:17:28 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:10391 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP
	id S1750905AbWDULR1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 07:17:27 -0400
Subject: Re: [Ext2-devel] Re: [RFC][PATCH 0/2]Extend ext3 filesystem limit
	from 8TB to 16TB
From: Laurent Vivier <Laurent.Vivier@bull.net>
To: Mingming Cao <cmm@us.ibm.com>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Ravikiran G Thirumalai <kiran@scalex86.org>,
       Andrew Morton <akpm@osdl.org>, Takashi Sato <sho@tnes.nec.co.jp>,
       linux-kernel@vger.kernel.org,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <1145543970.5872.38.camel@openx2.frec.bull.fr>
References: <1143530126.11560.6.camel@openx2.frec.bull.fr>
	 <1143568905.3935.13.camel@dyn9047017067.beaverton.ibm.com>
	 <1143623605.5046.11.camel@openx2.frec.bull.fr>
	 <1143682730.4045.145.camel@dyn9047017067.beaverton.ibm.com>
	 <20060329175446.67149f32.akpm@osdl.org>
	 <1144660270.5816.3.camel@openx2.frec.bull.fr>
	 <20060410012431.716d1000.akpm@osdl.org>
	 <1144941999.2914.1.camel@openx2.frec.bull.fr>
	 <20060417210746.GB3945@localhost.localdomain>
	 <1145308176.2847.90.camel@laptopd505.fenrus.org>
	 <20060417213201.GC3945@localhost.localdomain>
	 <1145344481.17767.1.camel@openx2.frec.bull.fr>
	 <1145345407.2976.13.camel@laptopd505.fenrus.org>
	 <1145394113.3771.11.camel@dyn9047017067.beaverton.ibm.com>
	 <1145543970.5872.38.camel@openx2.frec.bull.fr>
Message-Id: <1145618233.7795.13.camel@openx2.frec.bull.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-14) 
Date: Fri, 21 Apr 2006 13:17:13 +0200
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 21/04/2006 13:19:58,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 21/04/2006 13:20:00,
	Serialize complete at 21/04/2006 13:20:00
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-jbeFcBwhLxsSrRSpZTK+"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-jbeFcBwhLxsSrRSpZTK+
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Le jeu 20/04/2006 =C3=A0 16:39, Laurent Vivier a =C3=A9crit :=20
> The functions added by my patch are following and as they are atomic
> (one machine instruction) they are not measurable and don't appears in
> oprofile.
>=20
> atomic_long_add
> atomic_long_read
> atomic_long_set
> atomic_long_inc

I think, as these commands are atomic/inlined we should measure the time
of the functions modified by the patches.

The functions modified by the patch are:

ext3_free_blocks_sb
ext3_has_free_blocks
ext3_new_block
ext3_put_super
ext3_fill_super
ext3_fill_super
ext3_free_inode
find_group_dir
find_group_orlov
ext3_new_inode
ext3_group_add

If we make a "grep" on tiobench oprofile.out, we have:

atomic_t:

26919     0.0119  vmlinux                  vmlinux                  ext3_ne=
w_block
2195     9.7e-04  vmlinux                  vmlinux                  ext3_fr=
ee_blocks_sb
1192     5.2e-04  vmlinux                  vmlinux                  ext3_ha=
s_free_blocks
189      8.3e-05  vmlinux                  vmlinux                  ext3_ne=
w_inode
40       1.8e-05  vmlinux                  vmlinux                  ext3_fr=
ee_inode
2        8.8e-07  vmlinux                  vmlinux                  find_gr=
oup_orlov

percpu_counter:

16290     0.0067  vmlinux                  vmlinux                  ext3_ne=
w_block
2075     8.5e-04  vmlinux                  vmlinux                  ext3_fr=
ee_blocks_sb
428      1.8e-04  vmlinux                  vmlinux                  ext3_ha=
s_free_blocks
162      6.7e-05  vmlinux                  vmlinux                  ext3_ne=
w_inode
25       1.0e-05  vmlinux                  vmlinux                  ext3_fr=
ee_inode

As we can using atomic_long_t is slower than percpu_counter so ...
forget my patch.

Regards,
Laurent=20

--=20
Laurent Vivier
Bull, Architect of an Open World (TM)
http://www.bullopensource.org/ext4

--=-jbeFcBwhLxsSrRSpZTK+
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e=2E?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.7 (GNU/Linux)

iD8DBQBESL859Kffa9pFVzwRAu0lAJ94nDde2NU6PhZ4MLhWPnp+04KB5gCdF8S1
jM8U/jLVYgX+fYuNN/fmVz4=
=RSq2
-----END PGP SIGNATURE-----

--=-jbeFcBwhLxsSrRSpZTK+--

