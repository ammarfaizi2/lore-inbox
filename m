Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261686AbVGaKzV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261686AbVGaKzV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 06:55:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261675AbVGaKyY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 06:54:24 -0400
Received: from ganesha.gnumonks.org ([213.95.27.120]:29854 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S261670AbVGaKyU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 06:54:20 -0400
Date: Sun, 31 Jul 2005 12:50:07 +0200
From: Harald Welte <laforge@netfilter.org>
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org
Subject: Re: iptables redirect is broken on bridged setup
Message-ID: <20050731105007.GH14874@rama.de.gnumonks.org>
Mail-Followup-To: Harald Welte <laforge@netfilter.org>,
	Denis Vlasenko <vda@ilport.com.ua>,
	Jan Engelhardt <jengelh@linux01.gwdg.de>,
	netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org
References: <200507291209.37247.vda@ilport.com.ua> <Pine.LNX.4.61.0507291316140.10775@yvahk01.tjqt.qr> <200507291511.35081.vda@ilport.com.ua>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jaoouwwPWoQSJZYp"
Content-Disposition: inline
In-Reply-To: <200507291511.35081.vda@ilport.com.ua>
User-Agent: mutt-ng devel-20050619 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jaoouwwPWoQSJZYp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 29, 2005 at 03:11:35PM +0300, Denis Vlasenko wrote:

> Note that REDIRECT loads ip_conntrack, and this seem to
> cause problems, see another bugzilla entry at
> https://bugzilla.netfilter.org/bugzilla/show_bug.cgi?id=3D339

REDIRECT is a for of DNAT, like you correctly state. DNAT _needs_
ip_conntrack, so that's not what is causing problems.

Causing problems is probably the nf_reset() and other hacks that were
put into the briding code to remove conntrack references once a packet
enters the bridge (in order to make the 'fake iptables hooks' from
the bridging code work). =20

There were recently a number of fixes for this issue, which each caused
new bugs. =20

Could you please try with a current development kernel (linus' git tree,
or davem's net-2.6.14 tree) and see if the problem persists?

--=20
- Harald Welte <laforge@netfilter.org>                 http://netfilter.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
  "Fragmentation is like classful addressing -- an interesting early
   architectural error that shows how much experimentation was going
   on while IP was being designed."                    -- Paul Vixie

--jaoouwwPWoQSJZYp
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFC7KzfXaXGVTD0i/8RApbHAJ9dlwEUlPxuFwOolOBjIeOQ/KEwpgCfUHJu
cz6dmoLw8svSZLBmSGB537I=
=2wDI
-----END PGP SIGNATURE-----

--jaoouwwPWoQSJZYp--
