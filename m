Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271737AbRICOsn>; Mon, 3 Sep 2001 10:48:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271723AbRICOsf>; Mon, 3 Sep 2001 10:48:35 -0400
Received: from draal.physics.wisc.edu ([128.104.137.82]:35213 "EHLO
	draal.physics.wisc.edu") by vger.kernel.org with ESMTP
	id <S271728AbRICOsW>; Mon, 3 Sep 2001 10:48:22 -0400
Date: Mon, 3 Sep 2001 09:46:36 -0500
From: Bob McElrath <mcelrath+linux@draal.physics.wisc.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        linux-kernel@vger.kernel.org
Subject: Re: Editing-in-place of a large file
Message-ID: <20010903094636.V23180@draal.physics.wisc.edu>
In-Reply-To: <20010903035025.B802@nightmaster.csn.tu-chemnitz.de> <E15drHT-0001TX-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oIKd4Ysag+ysiDHn"
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <E15drHT-0001TX-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Mon, Sep 03, 2001 at 11:48:39AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--oIKd4Ysag+ysiDHn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Alan Cox [alan@lxorguk.ukuu.org.uk] wrote:
> > That is reimplementing file system functionality in user space.=20
> > I'm in doubts that this is considered good design...
>=20
> Keeping things out of the kernel is good design. Your block indirections
> are no different to other database formats. Perhaps you think we should
> have fsql_operation() and libdb in kernel 8)

Well, a filesystem that is:
1) synchronous
2) bypasses linux's buffer cache
3) insert() and delete() to insert and delete from the middle of a file.
4) Has large block sizes

Sounds like a possibility for the kernel to me.  As with most things,
you could do raw disk I/O from userspace, but it seems reasonable to put
it in the kernel.  Call it "mediafs" or something.

I agree that "normal" filesystems like ext2 should not do the insert()
and delete() that were mentioned.  It'd be a lot of work and could
easily get someone in to trouble (imagine doing it on small files!)

It appears that SGI's XFS does some of this in IRIX.  They play some
tricks to keep from copying the streaming data.  (i.e. same buffer gets
passed around as a target for the video device, a source for a userspace
program, and a source for DMA to disk)  They also have some special
flags:
    fcentl(fd, F_SETFL, FDIRECT); /* enables direct disk access */
    open(filename, O_DIRECT);     /* likewise */
See this page for details:
    http://reality.sgi.com/cpirazzi_engr/lg/uv/disk.html

Can linux disable its buffer cache for a particular filesystem
(something like a 'nocache' mount option?)

Cheers,
-- Bob

Bob McElrath (rsmcelrath@students.wisc.edu)=20
Univ. of Wisconsin at Madison, Department of Physics

--oIKd4Ysag+ysiDHn
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjuTl8wACgkQjwioWRGe9K190gCgzP4soXkJnSQ9et6IKK3+m32T
qzsAoLE+xcNbjgo9oxjHWOGaM/t5QOXe
=7VMW
-----END PGP SIGNATURE-----

--oIKd4Ysag+ysiDHn--
