Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261949AbVBOXqn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261949AbVBOXqn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 18:46:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261950AbVBOXqn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 18:46:43 -0500
Received: from moraine.clusterfs.com ([66.96.26.190]:57028 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S261949AbVBOXqk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 18:46:40 -0500
Date: Tue, 15 Feb 2005 16:46:37 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Mitchell Blank Jr <mitch@sfgoth.com>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, Alexey Dobriyan <adobriyan@mail.ru>,
       Andrew Morton <akpm@osdl.org>, ext3 users list <ext3-users@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ext3: Fix sparse -Wbitwise warnings.
Message-ID: <20050215234637.GI27352@schnapps.adilger.int>
Mail-Followup-To: Mitchell Blank Jr <mitch@sfgoth.com>,
	"Stephen C. Tweedie" <sct@redhat.com>,
	Alexey Dobriyan <adobriyan@mail.ru>, Andrew Morton <akpm@osdl.org>,
	ext3 users list <ext3-users@redhat.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <200502151246.06598.adobriyan@mail.ru> <1108476729.3363.9.camel@sisko.sctweedie.blueyonder.co.uk> <20050215232939.GD16892@gaz.sfgoth.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oyqLL/JqMvClXZi1"
Content-Disposition: inline
In-Reply-To: <20050215232939.GD16892@gaz.sfgoth.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--oyqLL/JqMvClXZi1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Feb 15, 2005  15:29 -0800, Mitchell Blank Jr wrote:
> Stephen C. Tweedie wrote:
> > If we want to fix this, let's fix the macros: for example, convert
> > EXT3_HAS_COMPAT_FEATURE to be
> >=20
> > 	( le32_to_cpu(EXT3_SB(sb)->s_es->s_feature_compat) & (mask) )
>=20
> Of course that's less efficient though since "mask" is probably constant..
> so now the endian conversion changed from compile-time to run-time.
>=20
> Would something like
>=20
>  	( ( EXT3_SB(sb)->s_es->s_feature_compat & cpu_to_le32(mask) ) !=3D 0)
>=20
> be enough to satisfy sparse?

Or we could cast "mask" to the appropriate type (I'm not sure what sparse
uses to determine this).

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://members.shaw.ca/adilger/             http://members.shaw.ca/golinux/


--oyqLL/JqMvClXZi1
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFCEondpIg59Q01vtYRAhzoAJ4jWeWP9TNduF+hdJzrs5jEAmItZwCdFvcj
y984j9Zi+asHeFvDLCj1qK8=
=U6IO
-----END PGP SIGNATURE-----

--oyqLL/JqMvClXZi1--
