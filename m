Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263431AbRFNR2r>; Thu, 14 Jun 2001 13:28:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263432AbRFNR2h>; Thu, 14 Jun 2001 13:28:37 -0400
Received: from etpmod.phys.tue.nl ([131.155.111.35]:10509 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S263430AbRFNR2Z>; Thu, 14 Jun 2001 13:28:25 -0400
Date: Thu, 14 Jun 2001 19:27:43 +0200
From: Kurt Garloff <garloff@suse.de>
To: Keith Owens <kaos@ocs.com.au>
Cc: Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: SMP module compilation on UP?
Message-ID: <20010614192743.E23383@garloff.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Keith Owens <kaos@ocs.com.au>,
	Linux kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <3B277C2A.B2CC3FCF@sangate.com> <19041.992451035@ocs4.ocs-net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tmoQ0UElFV5VgXgH"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <19041.992451035@ocs4.ocs-net>; from kaos@ocs.com.au on Thu, Jun 14, 2001 at 02:50:35AM +1000
X-Operating-System: Linux 2.2.19 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TUE/NL, SuSE/FRG
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tmoQ0UElFV5VgXgH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 14, 2001 at 02:50:35AM +1000, Keith Owens wrote:
> On Wed, 13 Jun 2001 17:43:54 +0300,=20
> Mark Mokryn <mark@sangate.com> wrote:
> >Is this the only way - to keep two separately configured kernel source
> >trees? No way to do it via some flag?
>=20
> With 2.4, yes.  You need a complete set of kernel source for every set
> of config files you use because the object code is written to the
> source directory.  With 2.5 you can have a single source tree and
> multiple object trees, one for each config that you are working on.

Use cp -al to replicate your kernel source tree before configuring. It
creates a tree with hard links, so you don't waste disk space.
Just don't forget to unlink() the files, if you edit them manually. (*)

garloff@garloff:~/Physics/numerix $ type unlink
unlink is a function
unlink ()=20
{=20
    for name in $*;
    do
	test -f $name && {=20
	    mv $name $name~$PPID;
	    cp -pd $name~$PPID $name;
	    rm $name~$PPID
	};
    done
}
							=09
(*) If you use emacs, you don't need to unlink before edit. The backup file
    will stay linked, but the edited is unique. patch does unlink, so
    patching is no problem. vi does NOT unlink.

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE GmbH, Nuernberg, FRG                               SCSI, Security

--tmoQ0UElFV5VgXgH
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.5 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7KPQPxmLh6hyYd04RAqdRAJwMlssFYWBkSR2PsFCf9kgebc7BVQCfcTUg
x9BLCL1f8CJEq5TEZDUYdUg=
=rrlC
-----END PGP SIGNATURE-----

--tmoQ0UElFV5VgXgH--
