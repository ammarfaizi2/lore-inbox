Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264536AbUAIVtQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 16:49:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264538AbUAIVtQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 16:49:16 -0500
Received: from smtp1.clear.net.nz ([203.97.33.27]:13771 "EHLO
	smtp1.clear.net.nz") by vger.kernel.org with ESMTP id S264536AbUAIVtF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 16:49:05 -0500
Date: Sat, 10 Jan 2004 10:41:45 +1300
From: Nigel Cunningham <ncunningham@users.sourceforge.net>
Subject: Re: Swapfiles broken on XFS.
In-reply-to: <1073679200.4566.12.camel@laptop-linux>
To: Christoph Hellwig <hch@infradead.org>
Cc: XFS list <linux-xfs@oss.sgi.com>, Karol Kozimor <sziwan@hell.org.pl>,
       swsusp-devel <swsusp-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Reply-to: ncunningham@users.sourceforge.net
Message-id: <1073684450.4596.55.camel@laptop-linux>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.4.4-8mdk
Content-type: multipart/signed; boundary="=-ePjdu5KETZ8GaqY+6/RR";
 protocol="application/pgp-signature"; micalg=pgp-sha1
References: <1073620506.3790.21.camel@laptop-linux>
 <20040109161653.A25678@infradead.org> <1073679200.4566.12.camel@laptop-linux>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ePjdu5KETZ8GaqY+6/RR
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi.

Actually, i_sb->s_blocksize and blocksize_bits both reflect a block size
of 4096 too, so that didn't help. What does help is using blksize_size.
I'll prepare a patch for Karol and I to try before submitting it to
LKML.

Regards,

Nigel

On Sat, 2004-01-10 at 22:13, Nigel Cunningham wrote:
> Hi again.
>=20
> Perhaps I wasn't clear enough.
>=20
> Both the page_io and Suspend can cope fine with block size < 4096. The
> issue is where they get the information from as to how many blocks per
> page they actually need to use when called brw_page. At the moment, they
> both assume that i_sb->s_blocksize and blocksize_bits is the place to
> go. What you're saying sounds right to me. They should both be looking
> at i_blkbits and i_blksize in the struct inode, shouldn't they? I'll
> make the change, test and submit a patch to LKML.
>=20
> Regards,
>=20
> Nigel
>=20
> On Sat, 2004-01-10 at 05:16, Christoph Hellwig wrote:
> > On Fri, Jan 09, 2004 at 04:55:09PM +1300, Nigel Cunningham wrote:
> > > It appears to me that a swapfile on an XFS filesystem will not work, =
at
> > > least some of the time.
> >=20
> > XFS sets s_blocksize to the filesystem blocksize and bdev->bd_block_siz=
e /
> > i_blkbits to the XFS sector size.  The first would be 4096 in your
> > case and the latter 512.  We cannot set a bigger device block size beca=
use
> > XFS log writes are in 512b units.
> >=20
> > I don't think the swap code should do any assumptions about any relatio=
n
> > of the above two.
--=20
My work on Software Suspend is graciously brought to you by
LinuxFund.org.

--=-ePjdu5KETZ8GaqY+6/RR
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA//x/iVfpQGcyBBWkRAvsqAJ98kigsmKa9XAYxFrvUzX41X4zZLACbBfYv
qWLLsa4UOb7PVuCLqYu03xc=
=ePrR
-----END PGP SIGNATURE-----

--=-ePjdu5KETZ8GaqY+6/RR--

