Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132868AbRDKSue>; Wed, 11 Apr 2001 14:50:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132879AbRDKSuY>; Wed, 11 Apr 2001 14:50:24 -0400
Received: from draal.physics.wisc.edu ([128.104.137.82]:30336 "EHLO
	draal.physics.wisc.edu") by vger.kernel.org with ESMTP
	id <S132868AbRDKSuO>; Wed, 11 Apr 2001 14:50:14 -0400
Date: Wed, 11 Apr 2001 13:49:53 -0500
From: Bob McElrath <mcelrath+linux@draal.physics.wisc.edu>
To: Der Herr Hofrat <der.herr@hofr.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Alpha "process table hang"
Message-ID: <20010411134953.A16185@draal.physics.wisc.edu>
In-Reply-To: <20010411104040.A8773@draal.physics.wisc.edu> <200104111642.f3BGg6930131@kanga.hofr.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <200104111642.f3BGg6930131@kanga.hofr.at>; from der.herr@hofr.at on Wed, Apr 11, 2001 at 06:42:06PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Well, here's the list of modules I have loaded:

nfsd                  102496   8 (autoclean)
lockd                  72976   1 (autoclean) [nfsd]
sunrpc                 87984   1 (autoclean) [nfsd lockd]
nls_iso8859-1           4160   1 (autoclean)
nls_cp437               5664   1 (autoclean)
msdos                   7728   1 (autoclean)
fat                    42784   0 (autoclean) [msdos]
pas2                   17488   1
sound                  83184   1 [pas2]
soundcore               5568   5 [sound]

Are there any known problems with these?  I have at times also used
matroxfb, and usb-uhci (along with visor, usb-storage), but I've seen
the process-table-hang with matroxfb and usb-uhci *not* installed, so I
don't think that's it.  I have the above modules installed consistently
at each bootup.

Der Herr Hofrat [der.herr@hofr.at] wrote:
> > I've been experiencing a particular kind of hang for many versions
> > (since 2.3.99 days, recently seen with 2.4.1, 2.4.2, and 2.4.2-ac4) on
> > the alpha architecture.  The symptom is that any program that tries to
> > access the process table will hang. (ps, w, top) The hang will go away
> > by itself after ~10minutes - 1 hour or so.  When it hangs I run ps and
> > see that it gets halfway through the process list and hangs.  The
> > process that comes next in the list (after hang goes away) almost always
> > has nonsensical memory numbers, like multi-gigabyte SIZE.
> >=20
> >
> I know this effect independant of the platform when you have a proc entry=
 that
> is not corectly unregistered.
>=20
> (the code only compiles for 2.2.X, for 2.4.X you need to change=20
> the proc struct.)
>=20
> ---snip---
> #include <linux/kernel.h>
> #include <linux/module.h>
> #include <linux/proc_fs.h>
>=20
> #define BUF_LEN 1024
> struct proc_dir_entry prockill_proc_file=3D{
> 	0,
> 	0,
> 	"prockill",
> 	S_IFREG|S_IRUGO,
> 	1,
> 	0,
> 	0,
> 	BUF_LEN,
> 	NULL,
> 	NULL,
> 	NULL,=09
> 	};=09
>=20
> int init_module(void) {
> 	printk("prockill.o registering proc entry\n");
> 	return proc_register(&proc_root,&prockill_proc_file);
> }
>=20
> void cleanup_module(void) {
> 	printk("prockill.o fogets to unregister proc entry\n");
> }
> ---snip---
> compile this as kernel module
>=20
> insmod proc_kill.o
> rmmod proc_kill
>=20
> and the system will run without error until you do something like
>=20
> ls /proc/<TAB><TAB>    or=20
> ls -R /proc
>=20
> after this the system will drop dead for minutes to hours or even for goo=
d....
> =20
>=20
> any chance you have a faulty module ??
>=20
>=20
> hofrat
-- Bob

Bob McElrath (rsmcelrath@students.wisc.edu)=20
Univ. of Wisconsin at Madison, Department of Physics

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjrUp1EACgkQjwioWRGe9K2ZBgCfQeT2lDjly82azKgpQ6i1JfE1
iVcAoOPODkqB6hbUvmwgtWXfgGZBY0jY
=0p0V
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--
