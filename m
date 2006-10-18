Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751045AbWJRKFw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751045AbWJRKFw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 06:05:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932143AbWJRKFw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 06:05:52 -0400
Received: from ozlabs.org ([203.10.76.45]:1739 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751045AbWJRKFu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 06:05:50 -0400
Subject: Re: 2.6.19-rc2-mm1
From: Michael Ellerman <michael@ellerman.id.au>
Reply-To: michael@ellerman.id.au
To: Andrew Morton <akpm@osdl.org>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, linux-kernel@vger.kernel.org,
       Paul Mackerras <paulus@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Rusty Russell <rusty@rustcorp.com.au>
In-Reply-To: <20061017132245.12499c1d.akpm@osdl.org>
References: <20061016230645.fed53c5b.akpm@osdl.org>
	 <4535310C.40708@goop.org>  <20061017132245.12499c1d.akpm@osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-xO0IaBYpQdhczhnTKZTc"
Date: Wed, 18 Oct 2006 20:05:48 +1000
Message-Id: <1161165948.7906.33.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-xO0IaBYpQdhczhnTKZTc
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-10-17 at 13:22 -0700, Andrew Morton wrote:
> On Tue, 17 Oct 2006 12:37:48 -0700
> Jeremy Fitzhardinge <jeremy@goop.org> wrote:
>=20
> > Andrew Morton wrote:
> > > -generic-implementatation-of-bug.patch
> > > -generic-implementatation-of-bug-fix.patch
> > > +generic-bug-implementation.patch
> > >  generic-bug-for-i386.patch
> > >  generic-bug-for-x86-64.patch
> > >  uml-add-generic-bug-support.patch
> > >  use-generic-bug-for-ppc.patch
> > >  bug-test-1.patch
> > >
> > >  Updated generic-BUG-handling patches
> > >  =20
> > I thought the powerpc patch had been given a clean bill of health?  Or=20
> > was there still a problem with it?
>=20
> No, last time I tested it the machine still froze after "returning from
> prom_init".  ie: before it had done any WARNs or BUGs.  It's rather
> mysterious.

Works for me:

Diego5:~# uname -a
Linux Diego5 2.6.19-rc2-mm1-git #9 SMP Wed Oct 18 19:30:38 EST 2006 ppc64 G=
NU/Linux
Diego5:~# echo 4 > /proc/sys/vm/drop_caches
Badness in drop_caches_sysctl_handler at /home/michael/src/auto/git/fs/drop=
_caches.c:67
Call Trace:
[C0000000431F7760] [C00000000000F8E4] .show_stack+0x6c/0x1a0 (unreliable)
[C0000000431F7800] [C000000000447B8C] .program_check_exception+0x19c/0x5cc
[C0000000431F78A0] [C00000000000446C] program_check_common+0xec/0x100
--- Exception: 700 at .drop_caches_sysctl_handler+0x5c/0x88
    LR =3D .drop_caches_sysctl_handler+0x20/0x88
[C0000000431F7C20] [C00000000005725C] .do_rw_proc+0x168/0x230
[C0000000431F7CF0] [C0000000000BC76C] .vfs_write+0xd0/0x1b4
[C0000000431F7D90] [C0000000000BD134] .sys_write+0x4c/0x8c
[C0000000431F7E30] [C00000000000861C] syscall_exit+0x0/0x40
Diego5:~# echo 8 > /proc/sys/vm/drop_caches
kernel BUG in drop_caches_sysctl_handler at /home/michael/src/auto/git/fs/d=
rop_caches.c:69!
cpu 0xd: Vector: 700 (Program Check) at [c0000000431f7910]
    pc: c0000000000e3a5c: .drop_caches_sysctl_handler+0x68/0x88
    lr: c0000000000e3a14: .drop_caches_sysctl_handler+0x20/0x88
    sp: c0000000431f7b90
   msr: 8000000000029032
  current =3D 0xc00000000fc8c810
  paca    =3D 0xc000000000564e00
    pid   =3D 1465, comm =3D bash
kernel BUG in drop_caches_sysctl_handler at /home/michael/src/auto/git/fs/d=
rop_caches.c:69!
enter ? for help
[c0000000431f7c20] c00000000005725c .do_rw_proc+0x168/0x230
[c0000000431f7cf0] c0000000000bc76c .vfs_write+0xd0/0x1b4
[c0000000431f7d90] c0000000000bd134 .sys_write+0x4c/0x8c
[c0000000431f7e30] c00000000000861c syscall_exit+0x0/0x40
--- Exception: c01 (System Call) at 000000000fec9aac
SP (ff8416f0) is in userspace
d:mon>=20

There's some NUMA badness going around that you might be hitting.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-xO0IaBYpQdhczhnTKZTc
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBFNfx8dSjSd0sB4dIRAgLxAKCV0R0ZMZ8xGT9L3IIZA/WPqHINDACfTUTW
N9hV87S6MqNR1RLARAV3hEU=
=qHug
-----END PGP SIGNATURE-----

--=-xO0IaBYpQdhczhnTKZTc--

