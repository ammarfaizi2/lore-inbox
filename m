Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261503AbVDJOSM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261503AbVDJOSM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 10:18:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261504AbVDJOSM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 10:18:12 -0400
Received: from postman2.arcor-online.net ([151.189.20.157]:9387 "EHLO
	postman.arcor.de") by vger.kernel.org with ESMTP id S261503AbVDJOSF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 10:18:05 -0400
Date: Sun, 10 Apr 2005 16:18:01 +0200
To: linux-kernel@vger.kernel.org
Subject: Re: unregister_netdevice(): negative refcnt, suggest patch against 2.6.11
Message-ID: <20050410141801.GA4713@palmen.homeip.net>
Mail-Followup-To: fmp, linux-kernel@vger.kernel.org
References: <20050410091625.GA29283@palmen.homeip.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5vNYLRcllDrimb99"
Content-Disposition: inline
In-Reply-To: <20050410091625.GA29283@palmen.homeip.net>
Organization: University of Karlsruhe, Germany
X-Face: K~w3A&?OT;vit*S.e$nb*yhXg?1~W$[{'\ac!fDp)'/c2g@rs-=Rm|%qi`!)J4QmlC2$x-' ^gR/WY=6e$E#PY'(~.5%U"h[yh.C^AK^8%t=tuq`8s`'+a]15|Bo&Uk>PD~Cu:_cJ5B!oVU0*3A!hH dUPeD{&b5hpczhAh&O0oeH.U@[|inep"(ye[R^7_I?8of&8eF\hIAZbRV3(D>n)1\^yjoy}\
User-Agent: Mutt/1.5.6+20040907i
From: Felix Palmen <fmp@palmen.homeip.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Felix M. Palmen <fmp@palmen.homeip.net> [20050410 11:16]:
> So I assume there is a problem in the appletalk code, but I didn't try
> reproducing that on other systems so far.

I've now tested this issue on a vanilla 2.6.11.7 kernel. I only applied
my own patch from the previous post so that I am able to shut down the
computer cleanly. So I did the following:

- boot 2.6.11.7
- create a tap device with 'openvpn --mktun --dev tap0'
- create /etc/netatalk/atalkd.conf with a single line 'tap0'
- launch atalkd, wait.
- stop atalkd.
- destroy tap device with 'openvpn --rmtun --dev tap0'

refcnt was -256, very strange.

Would you consider my patch harmful? I intend using it for now, because
otherwise, my system won't shut down cleanly any more...

Greets, Felix

PS: Please CC replies to me.

--=20
 | /"\   ASCII Ribbon   | Felix M. Palmen (Zirias)    http://zirias.ath.cx/=
 |
 | \ / Campaign Against | fmp@palmen.homeip.net      encrypted mail welcome=
 |
 |  X    HTML In Mail   | PGP key: http://zirias.ath.cx/pub.txt            =
 |
 | / \     And News     | ED9B 62D0 BE39 32F9 2488 5D0C 8177 9D80 5ECF F683=
 |

--5vNYLRcllDrimb99
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iQCVAwUBQlk1mQSq+3gxG9cNAQICaAQAhFR1i1VBaibfvRbYNPfFn1zR9C9OUQwm
KJDRpiXQtrNKtXyr8XKM2G2ureWgL43uDl8IEWHogkgm9K1uiubtfxU6yVuJ1TPP
P+NgHGZzs5tPnWyTiQYANWbDA0nJHwLnEkRXj8B7MD7MEQgoih5+BQJoJl4ZyheG
v4LRZsYurJk=
=b5IZ
-----END PGP SIGNATURE-----

--5vNYLRcllDrimb99--
