Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264647AbUG2Nmu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264647AbUG2Nmu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 09:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264665AbUG2Nmu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 09:42:50 -0400
Received: from voicebook.com ([128.121.231.235]:14857 "EHLO voicebook.com")
	by vger.kernel.org with ESMTP id S264648AbUG2NmX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 09:42:23 -0400
Subject: Interfaces losing inet6 addresses in ifconfig output after some
	uptime
From: Marcello Barnaba <marcello@softmedia.info>
Reply-To: marcello@softmedia.info
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ION9lnMnxOWgncJ8EhVR"
Organization: Softmedia S.c.r.l.
Message-Id: <1091108537.14310.33.camel@nowhere.openssl.softmedia.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 29 Jul 2004 15:42:17 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ION9lnMnxOWgncJ8EhVR
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

This is somewhat strange, after an average of 25 days of uptime, either
with kernel 2.6.6 or kernel 2.6.7 (didn't notice this with earlier
kernels, but the problem may be there as well, sorry but I didn't care
about this before, and the box is in production so it cannot be rebooted
easily), ifconfig does not display the inet6 addresses of my interfaces
anymore, but the addresses work as expected and are correctly in iproute
output:

 golem:/etc/shorewall# ifconfig eth0
eth0      Link encap:Ethernet  HWaddr 00:50:FC:5A:0B:58 =20
          inet addr:192.168.203.1  Bcast:192.168.203.127=20
Mask:255.255.255.128
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:50564399 errors:0 dropped:0 overruns:0 frame:0
          TX packets:46289378 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000=20
          RX bytes:3363466008 (3.1 GiB)  TX bytes:1097487814 (1.0 GiB)
          Interrupt:10=20

 golem:/etc/shorewall# ip addr show dev eth0
2: eth0: <BROADCAST,MULTICAST,UP> mtu 1500 qdisc pfifo_fast qlen 1000
    link/ether 00:50:fc:5a:0b:58 brd ff:ff:ff:ff:ff:ff
    inet 192.168.203.1/25 brd 192.168.203.127 scope global eth0
    inet 192.168.203.6/25 brd 192.168.203.127 scope global secondary
eth0:1
    inet6 2001:1418:106:1::a1/64 scope global=20
       valid_lft forever preferred_lft forever
    inet6 2001:1418:106:1::1/64 scope global=20
       valid_lft forever preferred_lft forever
    inet6 fe80::250:fcff:fe5a:b58/64 scope link=20
       valid_lft forever preferred_lft forever

oh, as you can see I just now noticed that ifconfig dropped the
secondary interface IP address as well..

This is a vanilla 2.6.7:

Linux golem.softmedia.lan 2.6.7 #1 Fri Jul 2 11:11:30 CEST 2004 i686
unknown
 15:41:42 up 27 days,  4:21,  2 users,  load average: 0.01, 0.00, 0.00

..running a debian woody:=20

net-tools 1.60
ifconfig 1.42 (2001-04-13)

Known kernel bug, ifconfig bug, whatever? A net-tools upgrade from
backports.org is possible, what do you guys think about this issue?

TIA.
--=20
Marcello Barnaba - SoftMedia S.c.r.l.    ::    Mobile: +39 (340) 3698342
Via Mauro Amoruso, 11 - 70124 Bari       ::    Phone:  +39 (080) 5046314
pub 1024D/F04476A2 :: 6807 EEA5 7F97 AC9A D8EF  AE73 64CD 71A2 F044 76A2

--=-ION9lnMnxOWgncJ8EhVR
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBCP65kn504uXeT8sRAnQ7AKCKqecYiFyOPTcpsYUs0+Bf1AsrkACePfXX
nHSpk/bMRi1q3hy//M4Zgmw=
=163b
-----END PGP SIGNATURE-----

--=-ION9lnMnxOWgncJ8EhVR--
