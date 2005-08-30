Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751178AbVH3EL6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178AbVH3EL6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 00:11:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751186AbVH3EL6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 00:11:58 -0400
Received: from ccerelbas04.cce.hp.com ([161.114.21.107]:28313 "EHLO
	ccerelbas04.cce.hp.com") by vger.kernel.org with ESMTP
	id S1751178AbVH3EL5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 00:11:57 -0400
Date: Tue, 30 Aug 2005 14:11:33 +1000
From: James Cameron <james.cameron@hp.com>
To: Matt Domsch <Matt_Domsch@dell.com>
Cc: linux-kernel@vger.kernel.org, fcusack@fcusack.com, dsd@gentoo.org,
       akpm@osdl.org
Subject: Re: ppp_mppe+pptp for 2.6.14?
Message-ID: <20050830041133.GA3389@hp.com>
References: <431341F4.8010200@gentoo.org> <20050829221034.GA4161@lists.us.dell.com> <20050829235131.GB20452@hp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Content-Disposition: inline
In-Reply-To: <20050829235131.GB20452@hp.com>
Organization: Netrek Vanilla Server Dictator
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

My problems with ENOPROTOOPT were due to lack of coffee.  They were
caused by ICMP protocol unreachable responses from the test server
because I'd taken away it's pppd.  My mistake.

On Mon, Aug 29, 2005 at 05:10:34PM -0500, Matt Domsch wrote:
> I've asked James Cameron, pptp project lead, to try a test to force
> the server side to issue a CCP DOWN, to make sure the client-side
> kernel ppp_generic module does the right thing and drops packets.

I've tested this now with a host running kernel 2.6.13 with Matt's
SC_MUST_COMP patch to the kernel and to ppp 2.4.4b1, sending SIGUSR2 to
the pppd while flooding the connection with pings from the server.

The result is an LCP TermReq from the server to the client, after which
no further data packets appear.  All the data packets up to the LCP
TermReq are encrypted.  The client sends an LCP TermAck, then takes down
the interface.  There's sign of CCP down, in that a CCP ConfReq appears
=66rom the server just after the LCP TermReq.

I'm not sure this is an adequate test, and will take advice on that.

Test configuration;

- server, 2.6.13 + SC_MUST_COMP, ppp 2.4.4b1 + SC_MUST_COMP, pptpd 1.3.1
- client, 2.6.12.5 + SC_MUST_COMP, ppp 2.4.4b1 + SC_MUST_COMP, pptp 1.5.0

Client side pppd log fragment;

local  IP address 10.8.0.2
remote IP address 10.8.0.1
Script /etc/ppp/ip-up started (pid 5036)
Script /etc/ppp/ip-up finished (pid 5036), status =3D 0x0
rcvd [LCP TermReq id=3D0x2 "MPPE disabled"]
LCP terminated by peer (MPPE disabled)
Connect time 0.4 minutes.
Sent 262920 bytes, received 262920 bytes.
Script /etc/ppp/ip-down started (pid 5048)
sent [LCP TermAck id=3D0x2]
rcvd [CCP ConfReq id=3D0x2 <mppe +H -M +S -L -D -C>]
Discarded non-LCP packet when LCP not open
Script /etc/ppp/ip-down finished (pid 5048), status =3D 0x0
Connection terminated.
Modem hangup

--=20
James Cameron

--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDE9x1IiWKUhK+Mj4RAnwNAJoCYo0aoeRET9Gq5oxeresVR6zUbQCeMDKI
9PF1nQcVakl3eHdBaWinDnk=
=/bpU
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--
