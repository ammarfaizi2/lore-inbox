Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271230AbRICE2M>; Mon, 3 Sep 2001 00:28:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271239AbRICE2C>; Mon, 3 Sep 2001 00:28:02 -0400
Received: from draal.physics.wisc.edu ([128.104.137.82]:20363 "EHLO
	draal.physics.wisc.edu") by vger.kernel.org with ESMTP
	id <S271230AbRICE1r>; Mon, 3 Sep 2001 00:27:47 -0400
Date: Sun, 2 Sep 2001 23:27:30 -0500
From: Bob McElrath <mcelrath+linux@draal.physics.wisc.edu>
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Editing-in-place of a large file
Message-ID: <20010902232730.S23180@draal.physics.wisc.edu>
In-Reply-To: <20010902152137.L23180@draal.physics.wisc.edu> <20010902233008.Q9870@nightmaster.csn.tu-chemnitz.de> <20010902175938.D21576@work.bitmover.com> <20010903032439.A802@nightmaster.csn.tu-chemnitz.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="APvmIexg9DiduZOF"
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20010903032439.A802@nightmaster.csn.tu-chemnitz.de>; from ingo.oeser@informatik.tu-chemnitz.de on Mon, Sep 03, 2001 at 03:24:39AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--APvmIexg9DiduZOF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Ingo Oeser [ingo.oeser@informatik.tu-chemnitz.de] wrote:
> On Sun, Sep 02, 2001 at 05:59:38PM -0700, Larry McVoy wrote:
> > > What's needed is a generalisation of sparse files and truncate().
> > > They both handle similar problems.
> >=20
> > how about=20
> >=20
> > 	fzero(int fd, off_t off, size_t len)
> > 	fdelete(int fd, off_t off, size_t len)
> =20
> and=20
>=20
>    finsert(int fd, off_t off, size_t len, void *buf, size_t buflen)
>=20
> > The main problem with this is if the off/len are not block aligned.  If=
 they
> > are, then this is just block twiddling, if they aren't, then this is a =
file
> > rewrite anyway.

*exactly*  I don't know enough about ext2fs to know if this is possible
(i.e. a partially filled block in the middle of a file) so that's why I
asked.

> Another solution for the original problem is to rewrite the file
> in-place by coping from the end of the gap to the beginning of
> the gap until the gap is shifted to the end of the file and thus
> can be left to ftruncate().

For editing commercials, you'd still have to copy 90% of the data.  In
the US, there's roughly 5 minutes of commercials for every 15 of the
show, so that would only save copying the first 15 minutes...

> This will at least not require more space on disk, but will take
> quite a while and risk data corruption for this file in case of
> abortion.

Yep.  I should mention that the Linux/mjpeg tools
(http://mjpeg.sourceforge.net) already have an elegant way of "marking"
a portion of a video and skipping it when playing it, through the use of
"edit lists".  (use xlav/glav to mark it, and then you can lavplay the
edit list, which just contains the start/end of skipped sections)  They
also have a program to apply the edit list and create a new video
(lavtrans).  But this requires copying the desired sections of video to
a new file, which requires 75% more disk space than the original file,
and takes a looong time.

The idea behind my first message should be obvious here...an almost
atomic operation modifying at most 2 blocks (and marking a bunch as
free) wouldn't require nearly as much disk-thrashing, and would be
nearly instantaneous from the user's perspective.

Disk fragmentation is unimportant when the contiguous chunks are 300MB
long.

> But fzero, fdelete and finsert might be worth considering, since
> some file systems, which pack tails could also pack these kind of
> partial used blocks and handle them properly.=20

Do the journaling filesystems use blocks in a similar manner to ext2fs?
Anyone know if any of them can handle partially filled blocks in the
middle of a file?

Are there any media-filesystems out there that have these kinds of
extensions?  I'm not sure these extensions would be useful for anything
but editing media...

> We already handle partial pages, so why not handle them with
> offset/size pairs and enable this mechanisms? Multi media streams
> would love these kind of APIs ;-)

Yep yep yep.  What do multimedia people use?  Custom multi-thousand
dollar programs with their own filesystem layer?  What about TiVo?
Didn't they contribute some fs-layer modifications a while back?

Cheers,
-- Bob

Bob McElrath (rsmcelrath@students.wisc.edu)=20
Univ. of Wisconsin at Madison, Department of Physics

--APvmIexg9DiduZOF
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjuTBrIACgkQjwioWRGe9K0U3wCgmuLrke43A6q4ijzpFSyLLiAo
2QMAn0u7xk+IPdmRn9y7lB21Q9kP1ODO
=Fz/y
-----END PGP SIGNATURE-----

--APvmIexg9DiduZOF--
