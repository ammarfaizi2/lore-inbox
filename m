Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261820AbUKCTIn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261820AbUKCTIn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 14:08:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261826AbUKCTIm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 14:08:42 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:35235 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261820AbUKCTGl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 14:06:41 -0500
Message-Id: <200411031906.iA3J6QCj018875@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.1 10/11/2004 with nmh-1.1-RC3
To: gene.heskett@verizon.net
Cc: linux-kernel@vger.kernel.org, DervishD <lkml@dervishd.net>,
       =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Subject: Re: is killing zombies possible w/o a reboot? 
In-Reply-To: Your message of "Wed, 03 Nov 2004 13:53:39 EST."
             <200411031353.39468.gene.heskett@verizon.net> 
From: Valdis.Kletnieks@vt.edu
References: <200411030751.39578.gene.heskett@verizon.net> <200411031147.14179.gene.heskett@verizon.net> <20041103174459.GA23015@DervishD>
            <200411031353.39468.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-614154796P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 03 Nov 2004 14:06:26 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-614154796P
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

On Wed, 03 Nov 2004 13:53:39 EST, Gene Heskett said:
> On Wednesday 03 November 2004 12:44, DervishD wrote:

> >    Then the children are reparented to 'init' and 'init' gets rid
> > of them. That's the way UNIX behaves.
>=20
> Unforch, I've *never* had it work that way.  Any dead process I've=20
> ever had while running linux has only been disposable by a reboot.

The problem  likely isn't the true =22zombie=22 - the only thing that *th=
ose*
processes have left is a process table entry to save the exit code for a =
wait()
syscall that might not happen anytime soon.  And unless you have hundreds=

of them sitting around causing pressure on the 32K process limit, they're=

probably not a big problem.

More likely, what you're looking at is some process that has gone down in=
to the
kernel on some syscall or other and gotten blocked.  Since signals aren't=

delivered until it returns, it ends up =22unkillable=22.

Traditionally, a common cause for such wedging was a lost/misplaced inter=
rupt
from an I/O operation, so a read()/write()/ioctl() call wouldn't return b=
ecause
the device hadn't reported it completed. (tape drives were notorious for =
this).
Often, power-cycling the I/O device would cause an unsolicited interrupt =
to be
generated, which would clear the =22waiting for interrupt=22 issue and al=
low the
process to return....


--==_Exmh_-614154796P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBiSwxcC3lWbTT17ARAio7AJ0VndjhgEwWLQ6SE9YEsTyvmi56IgCggfm6
vArg7bWap6s1+jEGQyqdBxM=
=jYNZ
-----END PGP SIGNATURE-----

--==_Exmh_-614154796P--
