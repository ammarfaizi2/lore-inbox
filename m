Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274866AbTGaToQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 15:44:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274867AbTGaToQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 15:44:16 -0400
Received: from 200-55-45-243-tntats2.dial-up.net.ar ([200.55.45.243]:51630
	"EHLO smtp.bensa.ar") by vger.kernel.org with ESMTP id S274866AbTGaToL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 15:44:11 -0400
From: Norberto BENSA <nbensa@gmx.net>
Reply-To: nbensa@yahoo.com
Organization: BENSA.ar
To: root@chaos.analogic.com, Erik Andersen <andersen@codepoet.org>
Subject: Re: Turning off automatic screen clanking
Date: Thu, 31 Jul 2003 16:15:08 -0300
User-Agent: KMail/1.5.2
Cc: linux-kernel <linux-kernel@vger.kernel.org>
References: <20030730061454.GA19808@codepoet.org> <Pine.LNX.4.53.0307300855540.193@chaos>
In-Reply-To: <Pine.LNX.4.53.0307300855540.193@chaos>
X-Operating-System: Gentoo GNU/Linux 1.4
X-PGP-Key: http://pgp.mit.edu:11371/pks/lookup?op=get&search=0x49664BBE
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_/qWK/KA6gNkP0Jw";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200307311615.11660.nbensa@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_/qWK/KA6gNkP0Jw
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Description: signed data
Content-Disposition: inline

Richard B. Johnson wrote:
> The 'kindest and gentlist' approach was to simply set the timer
> variable "blankinterval" (line 165 in console.c) to 0 instead of
> 10*60*HZ. This doesn't work. The screen still blanks in 10 minutes.

console.c line 2491 (function con_init:)

	init_timer(&console_timer);
	console_timer.function =3D blank_screen;
	if (blankinterval) {
		mod_timer(&console_timer, jiffies + blankinterval);
	}


So the trick appears to be to not initialize console_timer.  Then, on line=
=20
1283 (function setterm_command:)

	case 9: /* set blanking interval */
		blankinterval =3D ((par[1] < 60) ? par[1] : 60) * 60 * HZ;
  		poke_blanked_console();
		break;


Do some "magic" to initialize console_timer if it is not.

I think blanking by default is bad. Many times it bite me in the past. Same=
=20
old history: only monitor, no keyboard, couldn't see what's going on until =
I=20
plugged a keyboard (which of course, was in another room.)

BTW:

Zwane Mwaikambo wrote:
> On Tue, 29 Jul 2003, Richard B. Johnson wrote:
> > If the machine had blanking disabled by default, then the
> > usual SYS-V startup scripts could execute setterm to enable
> > it IFF it was wanted.
>
> optimise for the common case, just fix your box and be done with it.

*IF* Linux primary target is the server market then, what kind of optimizat=
ion=20
in console blanking if you need to hack your init script and insert "setter=
m=20
=2Dblank 0" somewhere??=20



Regards,
Norberto


--Boundary-02=_/qWK/KA6gNkP0Jw
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/KWq/FXVF50lmS74RAlxVAKCMUTi5RpPCQBlWfaBuR1N/0a5+7ACfSpuP
fYuZVDcVR6ExxBk8ayO99OY=
=3N9u
-----END PGP SIGNATURE-----

--Boundary-02=_/qWK/KA6gNkP0Jw--

