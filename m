Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266650AbUIENUm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266650AbUIENUm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 09:20:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266648AbUIENUl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 09:20:41 -0400
Received: from pauli.thundrix.ch ([213.239.201.101]:42151 "EHLO
	pauli.thundrix.ch") by vger.kernel.org with ESMTP id S266633AbUIENUc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 09:20:32 -0400
Date: Sun, 5 Sep 2004 15:16:11 +0200
From: Tonnerre <tonnerre@thundrix.ch>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jamie Lokier <jamie@shareable.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@fs.tum.de>,
       Hans Reiser <reiser@namesys.com>,
       viro@parcelfarce.linux.theplanet.co.uk, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: The argument for fs assistance in handling archives (was: silent semantic changes with reiser4)
Message-ID: <20040905131611.GL26560@thundrix.ch>
References: <20040826150202.GE5733@mail.shareable.org> <200408282314.i7SNErYv003270@localhost.localdomain> <20040901200806.GC31934@mail.shareable.org> <Pine.LNX.4.58.0409011311150.2295@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1hKfHPzOXWu1rh0v"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0409011311150.2295@ppc970.osdl.org>
X-GPG-KeyID: 0x8BE1C38D
X-GPG-Fingerprint: 1AB0 9AD6 D0C8 B9D5 C5C9  9C2A FF86 CBEE 8BE1 C38D
X-GPG-KeyURL: http://users.thundrix.ch/~tonnerre/tonnerre.asc
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1hKfHPzOXWu1rh0v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Salut,

On Wed, Sep 01, 2004 at 01:50:56PM -0700, Linus Torvalds wrote:
> 	#define MAXNAME 1024
> 	int open_cached_view(int base_fd, char *type, char *subname)
> 	{
> 	        struct stat st;
> 	        char filename[PATH_MAX];
> 	        char name[MAXNAME];
> 	        int len, cachefd;
> =09
> 	        if (fstat(base_fd, &st) < 0)
> 	                return -1;
> 	        sprintf(name, "/proc/self/fd/%d", base_fd);
> 	        len =3D readlink(name, filename, sizeof(filename)-1);
> 	        if (len < 0)
> 	                return -1;
> 	        filename[len] =3D 0;
> =09
> 	        /* FIXME! Replace '/' with '#' in "type" and "subname" */
> 	        len =3D snprintf(name, sizeof(name),
> 	                        "%04llx/%04llx/%s/%s/%s",
> 	                        (unsigned long long) st.st_dev,
> 	                        (unsigned long long) st.st_ino,
> 	                        type ? : "default",
> 	                        subname,
> 	                        filename);
> 	        errno =3D ENAMETOOLONG;
> 	        if (len >=3D sizeof(name))
> 	                return -1;
> 	        cachefd =3D open(name, O_RDONLY);
> 	        if (cachefd >=3D 0) {
> 	                /* Check mtime here - maybe we could have kernel support=
 */
> 	                return cachefd;
> 	        }
> 	        if (errno !=3D ENOENT)
> 	                return -1;
> 	        /*
> 	        .. try to generate cache file here ..
> 	         */

Around of  what I've  had in  mind. Only that  one might  use libmagic
instead of the type argument. The  rest can be done by a corresponding
MIME plugin.

				Tonnerre

--1hKfHPzOXWu1rh0v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.2 (GNU/Linux)

iD8DBQFBOxGb/4bL7ovhw40RAoEfAJ9AbkigPKlAckF7oQca9IPJVLPaRwCdExly
TqLQD7tcWT+j9XE6X3mqpL4=
=D17r
-----END PGP SIGNATURE-----

--1hKfHPzOXWu1rh0v--
