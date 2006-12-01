Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031699AbWLATAI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031699AbWLATAI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 14:00:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031700AbWLATAI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 14:00:08 -0500
Received: from cattelan-host202.dsl.visi.com ([208.42.117.202]:24796 "EHLO
	slurp.thebarn.com") by vger.kernel.org with ESMTP id S1031699AbWLATAG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 14:00:06 -0500
Subject: Re: [GFS2] Change argument to gfs2_dinode_in [18/70]
From: Russell Cattelan <cattelan@thebarn.com>
To: Steven Whitehouse <swhiteho@redhat.com>
Cc: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <1164888939.3752.340.camel@quoit.chygwyn.com>
References: <1164888939.3752.340.camel@quoit.chygwyn.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-hHFz/xCo9jbsa5mPaP5L"
Date: Fri, 01 Dec 2006 12:59:58 -0600
Message-Id: <1164999598.1194.74.camel@xenon.msp.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1-1mdv2007.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-hHFz/xCo9jbsa5mPaP5L
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-11-30 at 12:15 +0000, Steven Whitehouse wrote:
> >From 891ea14712da68e282de8583e5fa14f0d3f3731e Mon Sep 17 00:00:00 2001
> From: Steven Whitehouse <swhiteho@redhat.com>
> Date: Tue, 31 Oct 2006 15:22:10 -0500
> Subject: [PATCH] [GFS2] Change argument to gfs2_dinode_in
>=20
> This is a preliminary patch to enable the removal of fields
> in gfs2_dinode_host which are duplicated in struct inode.
Deferred till the complete "cleanup" work is done?


>=20
> Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
> ---
>  fs/gfs2/inode.c             |    2 +-
>  fs/gfs2/ondisk.c            |    4 ++--
>  include/linux/gfs2_ondisk.h |    2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
> index b861ddb..9875e93 100644
> --- a/fs/gfs2/inode.c
> +++ b/fs/gfs2/inode.c
> @@ -229,7 +229,7 @@ int gfs2_inode_refresh(struct gfs2_inode
>  		return -EIO;
>  	}
> =20
> -	gfs2_dinode_in(&ip->i_di, dibh->b_data);
> +	gfs2_dinode_in(ip, dibh->b_data);
> =20
>  	brelse(dibh);
> =20
> diff --git a/fs/gfs2/ondisk.c b/fs/gfs2/ondisk.c
> index 2c50fa0..edf8756 100644
> --- a/fs/gfs2/ondisk.c
> +++ b/fs/gfs2/ondisk.c
> @@ -155,8 +155,9 @@ void gfs2_quota_in(struct gfs2_quota_hos
>  	qu->qu_value =3D be64_to_cpu(str->qu_value);
>  }
> =20
> -void gfs2_dinode_in(struct gfs2_dinode_host *di, const void *buf)
> +void gfs2_dinode_in(struct gfs2_inode *ip, const void *buf)
>  {
> +	struct gfs2_dinode_host *di =3D &ip->i_di;
>  	const struct gfs2_dinode *str =3D buf;
> =20
>  	gfs2_meta_header_in(&di->di_header, buf);
> @@ -186,7 +187,6 @@ void gfs2_dinode_in(struct gfs2_dinode_h
>  	di->di_entries =3D be32_to_cpu(str->di_entries);
> =20
>  	di->di_eattr =3D be64_to_cpu(str->di_eattr);
> -
>  }
> =20
>  void gfs2_dinode_out(const struct gfs2_inode *ip, void *buf)
> diff --git a/include/linux/gfs2_ondisk.h b/include/linux/gfs2_ondisk.h
> index 550effa..08d8240 100644
> --- a/include/linux/gfs2_ondisk.h
> +++ b/include/linux/gfs2_ondisk.h
> @@ -534,8 +534,8 @@ extern void gfs2_rindex_out(const struct
>  extern void gfs2_rgrp_in(struct gfs2_rgrp_host *rg, const void *buf);
>  extern void gfs2_rgrp_out(const struct gfs2_rgrp_host *rg, void *buf);
>  extern void gfs2_quota_in(struct gfs2_quota_host *qu, const void *buf);
> -extern void gfs2_dinode_in(struct gfs2_dinode_host *di, const void *buf)=
;
>  struct gfs2_inode;
> +extern void gfs2_dinode_in(struct gfs2_inode *ip, const void *buf);
>  extern void gfs2_dinode_out(const struct gfs2_inode *ip, void *buf);
>  extern void gfs2_ea_header_in(struct gfs2_ea_header *ea, const void *buf=
);
>  extern void gfs2_ea_header_out(const struct gfs2_ea_header *ea, void *bu=
f);
--=20
Russell Cattelan <cattelan@thebarn.com>

--=-hHFz/xCo9jbsa5mPaP5L
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFcHutNRmM+OaGhBgRAr5hAJ9+EESPf1nWSCReaZ5RCTWVUYNLkQCdE7bg
5iRWq3gzraYDIzZ9S4M2Gss=
=eHCs
-----END PGP SIGNATURE-----

--=-hHFz/xCo9jbsa5mPaP5L--

