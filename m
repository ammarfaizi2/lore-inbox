Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261716AbULGAgT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261716AbULGAgT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 19:36:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261719AbULGAgT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 19:36:19 -0500
Received: from mout0.freenet.de ([194.97.50.131]:7904 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id S261716AbULGAgD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 19:36:03 -0500
From: Michael Buesch <mbuesch@freenet.de>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC] dynamic syscalls revisited
Date: Tue, 7 Dec 2004 01:20:00 +0100
User-Agent: KMail/1.7.1
References: <1101741118.25841.40.camel@localhost.localdomain> <20041205234605.GF2953@stusta.de> <1102349255.25841.189.camel@localhost.localdomain>
In-Reply-To: <1102349255.25841.189.camel@localhost.localdomain>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       LKML <linux-kernel@vger.kernel.org>, Adrian Bunk <bunk@stusta.de>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1709729.gW4H5ztCDg";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200412070120.05996.mbuesch@freenet.de>
X-Warning: freenet.de is listed at abuse.rfc-ignorant.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1709729.gW4H5ztCDg
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Quoting Steven Rostedt <rostedt@goodmis.org>:
> Done!
>=20
> Updated on http://home.stny.rr.com/rostedt/dynamic as well as included
> in this email for ease. =20
>=20
> Now, I guess you can still get around this if the "Bad Vendor" were to
> write a GPL module with their added system calls, and have that module
> include hooks to their binary module.  So, until we can fix that, I
> guess Linus won't allow for this module to be included in the main line.
>=20
> -- Steve
[SNIP]
> Index: arch/i386/kernel/entry.S
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- arch/i386/kernel/entry.S (revision 15)
> +++ arch/i386/kernel/entry.S (working copy)
> @@ -906,5 +906,10 @@
>   .long sys_vperfctr_unlink
>   .long sys_vperfctr_iresume
>   .long sys_vperfctr_read
> +#ifdef CONFIG_DSYSCALL
> + .long sys_dsyscall  /* 295 */
> +#else
> + .long sys_ni_syscall  /* 295 */
> +#endif

Wouldn't it be better to do a
cond_syscall(sys_dsyscall)
in kernel/sys_ni.c

=2D-=20
Regards Michael Buesch  [ http://www.tuxsoft.de.vu ]



--nextPart1709729.gW4H5ztCDg
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBtPc1FGK1OIvVOP4RAn+MAJoDJkoSopEsaPMnHo8FVrChKuwGWgCfUFJB
sc8B78Dw+2E0CHmZ5pgs0Hw=
=1S2M
-----END PGP SIGNATURE-----

--nextPart1709729.gW4H5ztCDg--
