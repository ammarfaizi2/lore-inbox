Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261831AbVATTMV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261831AbVATTMV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 14:12:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261805AbVATTKK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 14:10:10 -0500
Received: from H190.C26.B96.tor.eicat.ca ([66.96.26.190]:49311 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S261383AbVATTHd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 14:07:33 -0500
Date: Thu, 20 Jan 2005 12:07:26 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Valdis.Kletnieks@vt.edu
Cc: Andreas Gruenbacher <agruen@suse.de>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Tridgell <tridge@osdl.org>,
       "Stephen C. Tweedie" <sct@redhat.com>, Alex Tomas <alex@clusterfs.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Fix ea-in-inode default ACL creation
Message-ID: <20050120190726.GK22715@schnapps.adilger.int>
Mail-Followup-To: Valdis.Kletnieks@vt.edu,
	Andreas Gruenbacher <agruen@suse.de>, Andrew Morton <akpm@osdl.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Andrew Tridgell <tridge@osdl.org>,
	"Stephen C. Tweedie" <sct@redhat.com>,
	Alex Tomas <alex@clusterfs.com>, linux-kernel@vger.kernel.org
References: <1106245344.15959.13.camel@winden.suse.de> <200501201856.j0KIuiif016865@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NqXz6hVRMdSFrLFa"
Content-Disposition: inline
In-Reply-To: <200501201856.j0KIuiif016865@turing-police.cc.vt.edu>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--NqXz6hVRMdSFrLFa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jan 20, 2005  13:56 -0500, Valdis.Kletnieks@vt.edu wrote:
> On Thu, 20 Jan 2005 19:22:25 +0100, Andreas Gruenbacher said:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-2.6.11-latest.orig/fs/ext3/xattr.c
> > +++ linux-2.6.11-latest/fs/ext3/xattr.c
> > @@ -954,6 +954,13 @@ ext3_xattr_set_handle(handle_t *handle,=20
> > +	if (EXT3_I(inode)->i_state & EXT3_STATE_NEW) {
> > +		struct ext3_inode *raw_inode =3D ext3_raw_inode(&is.iloc);
> > +		memset(raw_inode, 0, EXT3_SB(inode->i_sb)->s_inode_size);
> > +		EXT3_I(inode)->i_state &=3D ~EXT3_STATE_NEW;
> > +	}
>=20
> Maybe I'm a total idiot, but I'm failing to see how adding *another* zero
> operation (although quite likely needed at that point) is going to help t=
he
> fact that we zero something out after we've stored data we want to keep i=
n it.
> Is there a missing hunk that *removes* the too-late memset-to-zero in
> ext3_do_update_inode?

Yes, as you can see above the EXT3_STATE_NEW flag is cleared so the later
check in ext3_new_inode() will not again zero the inode

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://members.shaw.ca/adilger/             http://members.shaw.ca/golinux/


--NqXz6hVRMdSFrLFa
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFB8AFupIg59Q01vtYRAndoAKCkyDBjyNpgKgxep0irqYuJaCWPdQCguH01
qs/X9ayH8zs029K2xM6anUE=
=/ciu
-----END PGP SIGNATURE-----

--NqXz6hVRMdSFrLFa--
