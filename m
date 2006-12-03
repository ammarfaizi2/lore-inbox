Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759678AbWLCNuq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759678AbWLCNuq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 08:50:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759681AbWLCNuq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 08:50:46 -0500
Received: from mtaout01-winn.ispmail.ntl.com ([81.103.221.47]:6618 "EHLO
	mtaout01-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1759678AbWLCNup (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 08:50:45 -0500
From: Ian Campbell <ijc@hellion.org.uk>
To: John Stultz <johnstul@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-sqPSaArBnPVtZTHD/JJA"
Date: Sun, 03 Dec 2006 13:50:34 +0000
Message-Id: <1165153834.5499.40.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
X-SA-Exim-Connect-IP: 192.168.1.5
X-SA-Exim-Mail-From: ijc@hellion.org.uk
Subject: PMTMR running too fast
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on hopkins.hellion.org.uk)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-sqPSaArBnPVtZTHD/JJA
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

In older kernels arch/i386/kernel/timers/timer_pm.c:verify_pmtmr_rate
contained a check for sensible PMTMR rate and disabled that clocksource
if it was found to be out of spec[0]. This check seems to have been lost
in the transition to drivers/clocksource/acpi_pm.c, the removal is in
61743fe445213b87fb55a389c8d073785323ca3e "Time: i386 Conversion - part
4: Remove Old timer_opts Code"[1] and the check is not present in the
replacement 5d0cf410e94b1f1ff852c3f210d22cc6c5a27ffa "Time: i386
Clocksource Drivers"[2].

Is there a specific reason the check was removed (I couldn't see on in
the archives) or was it simply overlooked? Without it I need to pass
clocksource=3Dtsc to have 2.6.18 work correctly on an older K6 system with
an Aladdin chipset (will dig out the precise details if required). Would
a patch to reintroduce the check be acceptable or would some sort of
blacklist based solution be more acceptable?

Cheers,
Ian.

[0] "PM-Timer running at invalid rate: 200% of normal - aborting." from
http://www.kernel.org/git/?p=3Dlinux/kernel/git/tglx/history.git;a=3Dcommit=
;h=3D6d58b1286c7ac88741374c158867f564e602b288
see also http://bugme.osdl.org/show_bug.cgi?id=3D2375
[1]
http://www.kernel.org/git/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3D=
commit;h=3D61743fe445213b87fb55a389c8d073785323ca3e
[2]
http://www.kernel.org/git/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3D=
commit;h=3D5d0cf410e94b1f1ff852c3f210d22cc6c5a27ffa

--=20
Ian Campbell

Any time things appear to be going better, you have overlooked something.

--=-sqPSaArBnPVtZTHD/JJA
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFctYqM0+0qS9rzVkRAk0gAKDJB6C9GQhIvUTiUcxMAAYpgtnXogCgjr48
KlG8z8VYSLyFyOYQ8Y+I+gg=
=e9Sk
-----END PGP SIGNATURE-----

--=-sqPSaArBnPVtZTHD/JJA--

