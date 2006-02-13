Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932136AbWBMRxP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932136AbWBMRxP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 12:53:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932233AbWBMRxO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 12:53:14 -0500
Received: from master.altlinux.org ([62.118.250.235]:55050 "EHLO
	master.altlinux.org") by vger.kernel.org with ESMTP id S932136AbWBMRxN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 12:53:13 -0500
Date: Mon, 13 Feb 2006 20:52:55 +0300
From: Sergey Vlasov <vsu@altlinux.ru>
To: Bernd Schubert <bernd-schubert@gmx.de>
Cc: Jeff Mahoney <jeffm@suse.com>, Chris Wright <chrisw@sous-sol.org>,
       John M Flinchbaugh <john@hjsoft.com>, reiserfs-list@namesys.com,
       Sam Vilain <sam@vilain.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.15 Bug? New security model?
Message-ID: <20060213175255.GA8639@procyon.home>
References: <200602080212.27896.bernd-schubert@gmx.de> <20060212175740.GB8805@locomotive.unixthugs.org> <20060212192115.GB8544@procyon.home> <200602130003.15698.bernd-schubert@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xHFwDpU9dbj6ez1V"
Content-Disposition: inline
In-Reply-To: <200602130003.15698.bernd-schubert@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 13, 2006 at 12:03:15AM +0100, Bernd Schubert wrote:
> > diff --git a/fs/reiserfs/super.c b/fs/reiserfs/super.c
> > index ef5e541..acafe32 100644
> > --- a/fs/reiserfs/super.c
> > +++ b/fs/reiserfs/super.c
> > @@ -1124,7 +1124,9 @@ static void handle_attrs(struct super_bl
> >  					 "reiserfs: cannot support attributes until flag is set in
> > super-block"); REISERFS_SB(s)->s_mount_opt &=3D ~(1 << REISERFS_ATTRS);
> >  		}
> > -	} else if (le32_to_cpu(rs->s_flags) & reiserfs_attrs_cleared) {
> > +	} else if ((le32_to_cpu(rs->s_flags) & reiserfs_attrs_cleared) &&
> > +		(get_inode_sd_version(s->s_root->d_inode) =3D=3D STAT_DATA_V2)) {
> > +		/* Enable attrs by default on v3.6-native file systems */
> >  		REISERFS_SB(s)->s_mount_opt |=3D (1 << REISERFS_ATTRS);
> >  	}
> >  }
>=20
> I'm afraid that still doesn't solve the problem for me, I added two print=
k to=20
> be sure whats going on - get_inode_sd_version(s->s_root->d_inode) returns=
=20
> STAT_DATA_V2 for all of my partitions.

Too bad.  Looks like autoenabling of the "attrs" options won't fly,
and the only safe solution is to revert those patches and require
explicit "attrs" option.

--xHFwDpU9dbj6ez1V
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFD8Md3W82GfkQfsqIRAg6LAKCFrYygHMVe7DA6bZof+IMMH9x4QACaAzUr
+F8wzAczvACbr7J93AXySQU=
=kk1X
-----END PGP SIGNATURE-----

--xHFwDpU9dbj6ez1V--
