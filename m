Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271534AbTGQVBC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 17:01:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271543AbTGQVBB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 17:01:01 -0400
Received: from coruscant.franken.de ([193.174.159.226]:56036 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id S271029AbTGQU7k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 16:59:40 -0400
Date: Thu, 17 Jul 2003 23:12:54 +0200
From: Harald Welte <laforge@netfilter.org>
To: David Miller <davem@redhat.com>
Cc: Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix ip_nat_ftp in 2.6.0-test1
Message-ID: <20030717211254.GA27685@sunbeam.de.gnumonks.org>
Mail-Followup-To: Harald Welte <laforge@netfilter.org>,
	David Miller <davem@redhat.com>,
	Netfilter Development Mailinglist <netfilter-devel@lists.netfilter.org>,
	Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cWoXeonUoKmBZSoM"
Content-Disposition: inline
X-Operating-System: Linux sunbeam 2.4.20-nfpom
X-Date: Today is Pungenday, the 52nd day of Confusion in the YOLD 3169
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi DaveM!

This is a 2.6 only fix for the FTP NAT helper code.  The patch below
(by Martin Josefsson) also closes Bug 933 in the kernel bug tracker.

The bug was introduced while making the helper compliant to the recently
introduced support for nonlinear skb's in netfilter.

Thanks!

--- linux-2.5.75/net/ipv4/netfilter/ip_nat_helper.c.orig	2003-07-17 19:27:5=
3.000000000 +0200
+++ linux-2.5.75/net/ipv4/netfilter/ip_nat_helper.c	2003-07-17 19:30:29.000=
000000 +0200
@@ -191,7 +191,7 @@
 				   csum_partial((char *)tcph, tcph->doff*4,
 						(*pskb)->csum));
 	adjust_tcp_sequence(ntohl(tcph->seq),
-			    (int)match_len - (int)rep_len,
+			    (int)rep_len - (int)match_len,
 			    ct, ctinfo);
 	return 1;
 }

--=20
- Harald Welte <laforge@netfilter.org>             http://www.netfilter.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
  "Fragmentation is like classful addressing -- an interesting early
   architectural error that shows how much experimentation was going
   on while IP was being designed."                    -- Paul Vixie

--cWoXeonUoKmBZSoM
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/FxFWXaXGVTD0i/8RAl/TAJ9qngo+Q/wXe3YjyJpJbSsUVcOrFQCdFdKm
D0ib6i4JzbpE9l2xEEwfpi4=
=5BrF
-----END PGP SIGNATURE-----

--cWoXeonUoKmBZSoM--
