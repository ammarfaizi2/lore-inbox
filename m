Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129183AbQK1Tzy>; Tue, 28 Nov 2000 14:55:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129543AbQK1Tzo>; Tue, 28 Nov 2000 14:55:44 -0500
Received: from etpmod.phys.tue.nl ([131.155.111.35]:52490 "EHLO
        etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
        id <S129183AbQK1Tz2>; Tue, 28 Nov 2000 14:55:28 -0500
Date: Tue, 28 Nov 2000 20:22:59 +0100
From: Kurt Garloff <garloff@suse.de>
To: Keith Owens <kaos@ocs.com.au>
Cc: Linux kernel list <linux-kernel@vger.kernel.org>
Subject: modutils-2.3.21: modprobe looping
Message-ID: <20001128202259.E27219@garloff.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
        Keith Owens <kaos@ocs.com.au>,
        Linux kernel list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
        protocol="application/pgp-signature"; boundary="fwblGvOBo7NCOYks"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Operating-System: Linux 2.2.16 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TUE/NL, SuSE/FRG
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--fwblGvOBo7NCOYks
Content-Type: multipart/mixed; boundary="Ioqcch2Htvy99P9q"
Content-Disposition: inline


--Ioqcch2Htvy99P9q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Keith,

thanks for your modutils-2.3.21!

During testing I found a problem:
modprobe pppoe was recursing endlessly in build_stack().

Find attached the modules.dep that caused this: There is a circular
dependency of pppoe on pppox on pppoe on ....

modprobe has code to detect this in build_stack(), but it seems to not work.
The old dep is thrown away and the new one is taken. And checked for
dependencies again :-(
Of course, one could also think of depmod making sure that such circular
dependencies do not occur, but I guess, it's more robust if depmod has a
working test in any case.

Test system was a PPC machine running 2.4.0-test9.

Do you have a fix for this?

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE GmbH, Nuernberg, FRG                               SCSI, Security

--Ioqcch2Htvy99P9q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="modules.dep"

/lib/modules/2.4.0-test9/kernel/drivers/net/ppp_async.o:	/lib/modules/2.4.0-test9/kernel/drivers/net/ppp_generic.o

/lib/modules/2.4.0-test9/kernel/drivers/net/ppp_deflate.o:	/lib/modules/2.4.0-test9/kernel/drivers/net/ppp_generic.o

/lib/modules/2.4.0-test9/kernel/drivers/net/ppp_generic.o:

/lib/modules/2.4.0-test9/kernel/drivers/net/ppp_synctty.o:	/lib/modules/2.4.0-test9/kernel/drivers/net/ppp_generic.o

/lib/modules/2.4.0-test9/kernel/drivers/net/pppoe.o:	/lib/modules/2.4.0-test9/kernel/drivers/net/pppox.o \
	/lib/modules/2.4.0-test9/kernel/drivers/net/ppp_generic.o

/lib/modules/2.4.0-test9/kernel/drivers/net/pppox.o:	/lib/modules/2.4.0-test9/kernel/drivers/net/pppoe.o \
	/lib/modules/2.4.0-test9/kernel/drivers/net/ppp_generic.o

/lib/modules/2.4.0-test9/kernel/drivers/net/skfp/skfp.o:

/lib/modules/2.4.0-test9/kernel/drivers/net/slip.o:


--Ioqcch2Htvy99P9q--

--fwblGvOBo7NCOYks
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6JAYSxmLh6hyYd04RAqyDAJ9Z9i3dKA1VqCLnrzRqt8I+tBo7ogCgtCs4
2myOgYkdJpQbHNe6Xc/EJAI=
=PHPJ
-----END PGP SIGNATURE-----

--fwblGvOBo7NCOYks--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
