Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261987AbTHTOlu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 10:41:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261989AbTHTOlu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 10:41:50 -0400
Received: from mx02.qsc.de ([213.148.130.14]:37059 "EHLO mx02.qsc.de")
	by vger.kernel.org with ESMTP id S261987AbTHTOls (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 10:41:48 -0400
Date: Wed, 20 Aug 2003 16:43:04 +0200
From: Wiktor Wodecki <wodecki@gmx.de>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [OT] Connection tracking for IPSec
Message-ID: <20030820144304.GC725@gmx.de>
Reply-To: Johoho <johoho@hojo-net.de>
References: <1061378568.668.9.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nVMJ2NtxeReIH9PS"
Content-Disposition: inline
In-Reply-To: <1061378568.668.9.camel@teapot.felipe-alfaro.com>
X-message-flag: Linux - choice of the GNU generation
X-Operating-System: Linux 2.6.0-test3-O16.2 i686
X-PGP-KeyID: 182C9783
X-Info: X-PGP-KeyID, send an email with the subject 'public key request' to wodecki@gmx.de
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--nVMJ2NtxeReIH9PS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2003 at 01:22:49PM +0200, Felipe Alfaro Solana wrote:
> I'm starting with IPSec right now. To make it work, I must open up
> protocols 50 and 51 to pass across my Linux firewalls, but I want to use
> connection tracking much like I do when not using IPSec.
>=20
> For example,
>=20
> iptables -A INPUT -m state --state RELATED,ESTABLISHED
>=20
> When using IPSec, if I open up protocols 50 and 51, all IPSec-protected
> traffic passes through the firewall, but it's not checked against the
> connection tracking module. How can I configure iptables so an
> IPSec-protected packet, after being classified as IP protocol 50 or 51,
> loop back one more time to pass through the connection tracking module?
>=20
> I don't want to set up IPSec to get addititional protection by using AH
> and ESP and then let any machine talking IPSec pass entirely through my
> firewall ignoring the rest of rules.

you can use iptables to open proto 50 and 51 to specific ip's, too:

iptables -A INPUT -i eth0 -p 50 -s n.n.n.n -j ACCEPT
iptables -A INPUT -i eth0 -p 51 -s n.n.n.n -j ACCEPT
iptables -A INPUT -i eth0 -p 51 -s n.m.n.n -j DROP

this will work. If you want netfilter to fully recognize ipsec states
you have to do it yourself, afaik there is no ipsec support for the
statefull/conntrack system.

But you are better of asking here: netfilter-devel@lists.samba.org

--=20
Regards,

Wiktor Wodecki

--nVMJ2NtxeReIH9PS
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/Q4j46SNaNRgsl4MRAiD7AJ4sowB2ySQYk3IbWMRYzScEzCRsMQCgwyhV
O2ePEkPJCbAU5W+x1F3ut6M=
=B2py
-----END PGP SIGNATURE-----

--nVMJ2NtxeReIH9PS--
