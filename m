Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261531AbVALWVU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261531AbVALWVU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 17:21:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261521AbVALWSF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 17:18:05 -0500
Received: from H190.C26.B96.tor.eicat.ca ([66.96.26.190]:7049 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S261520AbVALWN3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 17:13:29 -0500
Date: Wed, 12 Jan 2005 15:13:09 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Greg KH <greg@kroah.com>
Cc: "Michael S. Tsirkin" <mst@mellanox.co.il>, Andrew Morton <akpm@osdl.org>,
       Takashi Iwai <tiwai@suse.de>, ak@suse.de, mingo@elte.hu,
       rlrevell@joe-job.com, linux-kernel@vger.kernel.org, pavel@suse.cz,
       gordon.jin@intel.com, VANDROVE@vc.cvut.cz
Subject: Re: [PATCH] fix: macros to detect existance of unlocked_ioctl and compat_ioctl
Message-ID: <20050112221309.GW8098@schnapps.adilger.int>
Mail-Followup-To: Greg KH <greg@kroah.com>,
	"Michael S. Tsirkin" <mst@mellanox.co.il>,
	Andrew Morton <akpm@osdl.org>, Takashi Iwai <tiwai@suse.de>,
	ak@suse.de, mingo@elte.hu, rlrevell@joe-job.com,
	linux-kernel@vger.kernel.org, pavel@suse.cz, gordon.jin@intel.com,
	VANDROVE@vc.cvut.cz
References: <20041215065650.GM27225@wotan.suse.de> <20041217014345.GA11926@mellanox.co.il> <20050103011113.6f6c8f44.akpm@osdl.org> <20050105144043.GB19434@mellanox.co.il> <s5hd5wjybt8.wl@alsa2.suse.de> <20050105133448.59345b04.akpm@osdl.org> <20050106140636.GE25629@mellanox.co.il> <20050112203606.GA23307@mellanox.co.il> <20050112212954.GA13558@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BrzieSmlpF6NDzIw"
Content-Disposition: inline
In-Reply-To: <20050112212954.GA13558@kroah.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--BrzieSmlpF6NDzIw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jan 12, 2005  13:29 -0800, Greg KH wrote:
> On Wed, Jan 12, 2005 at 10:36:06PM +0200, Michael S. Tsirkin wrote:
> > To make life bearable for out-of kernel modules, the following patch
> > adds 2 macros so that existance of unlocked_ioctl and compat_ioctl
> > can be easily detected.
> > =20
> > Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
> >=20
> > diff -puN include/linux/fs.h~ioctl-rework include/linux/fs.h
> > --- 25/include/linux/fs.h~ioctl-rework	Thu Dec 16 15:48:31 2004
> > +++ 25-akpm/include/linux/fs.h	Thu Dec 16 15:48:31 2004
> > @@ -907,6 +907,12 @@ typedef struct {
> > =20
> >  typedef int (*read_actor_t)(read_descriptor_t *, struct page *, unsign=
ed long, unsigned long);
> > =20
> > +/* These macros are for out of kernel modules to test that
> > + * the kernel supports the unlocked_ioctl and compat_ioctl
> > + * fields in struct file_operations. */
> > +#define HAVE_COMPAT_IOCTL 1
> > +#define HAVE_UNLOCKED_IOCTL 1
>=20
> No, we do not do that in the kernel today, and I'm pretty sure we don't
> want to start doing it (it would get _huge_ very quickly...)
>=20
> Please don't apply this.  Remember, out-of-the-tree modules are on their
> own.

Gee, thanks.  It's not like some out-of-tree code doesn't _want_ to go
into the core kernel, but usually the time between some code being
developed and when it is included is lengthy (i.e. "this feature won't
be accepted until lots of people use it").

You can't claim that this has never been done (e.g. KERNEL_HAS_O_DIRECT,
KERNEL_HAS_DIRECT_FILEIO in 2.4 kernels).  For code that needs to handle
multiple kernel versions this makes life far easier and doesn't actually
hurt anything.  It used to be that you could use LINUX_VERSION_CODE for
this kind of check, but that breaks down quickly with vendor kernels and
the long development cycle.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://members.shaw.ca/adilger/             http://members.shaw.ca/golinux/


--BrzieSmlpF6NDzIw
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFB5aD1pIg59Q01vtYRApZUAKCJKWsSBcOY7ZUdo0uc3hL/ra2VogCgnrQJ
D/858mJKCwwMxaW96Yowo20=
=PjdB
-----END PGP SIGNATURE-----

--BrzieSmlpF6NDzIw--
