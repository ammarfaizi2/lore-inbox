Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261330AbVBGXm3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261330AbVBGXm3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 18:42:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261343AbVBGXm3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 18:42:29 -0500
Received: from vds-320151.amen-pro.com ([62.193.204.86]:60813 "EHLO
	vds-320151.amen-pro.com") by vger.kernel.org with ESMTP
	id S261330AbVBGXmV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 18:42:21 -0500
Subject: Re: [PATCH] sys_chroot() hook for additional chroot() jails
	enforcing
From: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?=
	 =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
To: "Serge E.Hallyn" <serue@us.ibm.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "linux-security-module@wirex.com" <linux-security-module@wirex.com>
In-Reply-To: <20050207225056.GA2388@IBM-BWN8ZTBWA01.austin.ibm.com>
References: <1107814610.3754.260.camel@localhost.localdomain>
	 <20050207225056.GA2388@IBM-BWN8ZTBWA01.austin.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-AQjOvCp3URxqdHoAw9AG"
Date: Tue, 08 Feb 2005 00:41:55 +0100
Message-Id: <1107819715.3754.263.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-AQjOvCp3URxqdHoAw9AG
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

El lun, 07-02-2005 a las 16:50 -0600, Serge E. Hallyn escribi=F3:
> Hi,
>=20
> If I understood you correct earlier, the only policy you needed to
> enforce was to prevent double-chrooting.  If that is the case, why is it
> not sufficient to keep a "process-has-used-chroot" flag in
> current->security which is set on the first call to
> capable(CAP_SYS_CHROOT) and inherited by forked children, after which
> calls to capable(CAP_SYS_CHROOT) are refused?
>=20
> Of course if you need to do more, then a hook might be necessary.

Yeah, checking that process is chrooted using the current macro and
denying if capable() gets it trying to access CAP_SYS_CHROOT it's the
way that vSecurity currently does it.

But the hook will have to handle some chdir enforcing that can't be done
with current hooks, I will explain it further tomorrow.

It's too late here ;)

Cheers,
--=20
Lorenzo Hern=E1ndez Garc=EDa-Hierro <lorenzo@gnu.org>=20
[1024D/6F2B2DEC] & [2048g/9AE91A22][http://tuxedo-es.org]

--=-AQjOvCp3URxqdHoAw9AG
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Esta parte del mensaje =?ISO-8859-1?Q?est=E1?= firmada
	digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBCB/zDDcEopW8rLewRArnjAJ93zXpxOAoACdSltzTanWSiAIyf8QCgkMAV
mM6fMtxVQB6UAPUBuosPhwA=
=ZJ7h
-----END PGP SIGNATURE-----

--=-AQjOvCp3URxqdHoAw9AG--

