Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272984AbTGaLPw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 07:15:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272985AbTGaLPw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 07:15:52 -0400
Received: from [213.69.232.58] ([213.69.232.58]:40712 "HELO schottelius.org")
	by vger.kernel.org with SMTP id S272984AbTGaLPu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 07:15:50 -0400
Date: Thu, 31 Jul 2003 13:14:18 +0200
From: Nico Schottelius <nico-kernel@schottelius.org>
To: Steve Lord <lord@sgi.com>
Cc: Nico Schottelius <nico-kernel@schottelius.org>, scholz@wdt.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bug in 2.6.0test2
Message-ID: <20030731111418.GJ264@schottelius.org>
References: <20030728115902.GA18993@schottelius.org> <1059425249.6601.10.camel@jen.americas.sgi.com> <20030728222641.GE10741@schottelius.org> <1059478999.1749.18.camel@laptop.americas.sgi.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7AwgMNpd3VkAVXjS"
Content-Disposition: inline
In-Reply-To: <1059478999.1749.18.camel@laptop.americas.sgi.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux flapp 2.6.0-test2
X-Free86: doesn't compile currently
X-Replacement: please tell me some (working)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--7AwgMNpd3VkAVXjS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Steve Lord [Tue, Jul 29, 2003 at 06:43:17AM -0500]:
> On Mon, 2003-07-28 at 17:26, Nico Schottelius wrote:
> > Steve Lord [Mon, Jul 28, 2003 at 03:47:30PM -0500]:
> > >=20
> > > Something else went wrong before you crashed:
> > >=20
> > > bio too big device loop0 (2 > 0)
> > >=20
> > > This means you cannot use any bio larger than zero to this device,
> >=20
> > assume i didn't understand very much you told me..what is a bio?
> > how do I use it? and why is it too big here?
>=20
> It looks like the loop device may not be correctly initialized yet,
> no I/O is possible to it yet.

=2E..we tried and experiement some more, here the results:
   - first we had old modutils (now: module-init-tools 0.9.13pre)
   - all modules are able to load now (loaded: aes,loop,cryptoloop)
   - losetup -e aes /dev/hda1 /dev/loop0=20
      --> ioctl: LOOP_SET_FD: invalid argument
   - mount /dev/hda1 / -o loop,encryption=3Daes
      --> asks for pass, but doesn't unencrypt it
         --> it fails to mount the xfs filesystem below
            --> "mount: you must specify fs type..."

the filesystem on hda1 is encrypted with a 128 bit key / aes.

> > > which is probably why ext2 said this, since it caught the error when
> > > building the bio.
> >=20
> > ext2? I am wondering..afai understood that, the root wasn't even
> > decrypted, how can the kernel try to ext2-mount it?

oh..btw, the ramdisk is ext2..

> > > EXT2-fs: unable to read superblock
> > >=20
> > > XFS didn't catch the error building the bio and submitted it, at
> > > which point the I/O tripped the BUG. I can fix this part, but
> > > the original problem is something I know nothing about.
> >=20
> > ..or better why does it start mounting/before decrypt?
> >=20
>=20
> I have never used a crypto loop device, so I cannot what is really
> going on. Some initialization step may be missing in the loop device
> which means it is not usable,

looks like the losetup is the problem...

> the mount it happening because the
> kernel was told to mount it. If you are not specifying a filesystem
> type, then possibly what is happening is it is attempting to open
> the device as different filesystems, these all fail, until xfs
> which does not detect the underlying error on the loop device,
> and issues the IO which causes the BUG.

=2E.which you are gonna fix ? :)

> So, we caused the crash, but you were on your way to one anyway,
> eventually it would have failed to find a root device and given
> up that way.

hopefully we'll get it soon..
my co-worker has to switch between 2.4 and 2.6 daily now..

Nico

--=20
echo God bless America | sed 's/.*\(A.*$\)/Why \1?/'
pgp: new id: 0x8D0E27A4 | ftp.schottelius.org/pub/familiy/nico/pgp-key.new

--7AwgMNpd3VkAVXjS
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE/KPoKtnlUggLJsX0RAg7oAJ9FAFc1ZlqezNs2qxt0oYJgI3SqDwCfXnms
42O2IGVTP4M7N6IuZaXhcQU=
=mZuk
-----END PGP SIGNATURE-----

--7AwgMNpd3VkAVXjS--
