Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262331AbVCIUl0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262331AbVCIUl0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 15:41:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262456AbVCIUlL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 15:41:11 -0500
Received: from mail.satronet.sk ([217.144.16.198]:47305 "EHLO mail.satronet.sk")
	by vger.kernel.org with ESMTP id S262415AbVCIUYk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 15:24:40 -0500
From: Michal Vanco <vanco@satro.sk>
Organization: Satro, s.r.o.
To: netdev@oss.sgi.com
Subject: Re: 2.6.11 on AMD64 traps
Date: Wed, 9 Mar 2005 21:24:34 +0100
User-Agent: KMail/1.7.2
Cc: Patrick McHardy <kaber@trash.net>, Andre Tomt <andre@tomt.net>,
       linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
References: <200503081900.18686.vanco@satro.sk> <422DF07D.7010908@tomt.net> <422F525F.90404@trash.net>
In-Reply-To: <422F525F.90404@trash.net>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1903376.zXjrLv5dby";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200503092124.35190.vanco@satro.sk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1903376.zXjrLv5dby
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 09 March 2005 20:45, Patrick McHardy wrote:
> > Michal Vanco wrote:
> >> I see this problem running 2.6.11 on dual AMD64:
> >>
> >> Running quagga routing daemon (ospf+bgp) and issuing "netstat -rn |wc
> >> -l" command
> >> while quagga tries to load more than 154000 routes from its bgp
> >> neighbours causes this trap:
>
> This patch should fix it. The crash is caused by stale pointers,
> the pointers in fib_iter_state are not reloaded after seq->stop()
> followed by seq->start(pos > 0).

Well. Trap vanished after applying this patch, but another weird thing occu=
rs:

# ip route show | wc -l
156033
# date; time ip route show > /dev/null; date; time netstat -rn > /dev/null
Wed Mar  9 22:15:21 CET 2005

real    0m0.656s
user    0m0.415s
sys     0m0.242s
Wed Mar  9 22:15:22 CET 2005

real    6m41.472s
user    0m1.261s
sys     6m40.143s

regards,
=2D-=20
Ing. Michal Van=C4=8Do
Network Engineer
SATRO s.r.o.
e-mail: vanco@satro.sk

--nextPart1903376.zXjrLv5dby
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCL1uDSBxxqpMaGkMRAqKtAKDbWteVSdcPVqH09x6ah6WAIUdcvgCdEULr
p5lFlgeARv7hYiXkAz7mMMY=
=KAOp
-----END PGP SIGNATURE-----

--nextPart1903376.zXjrLv5dby--
