Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272343AbTG1B1V (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 21:27:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272414AbTG1ACu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 20:02:50 -0400
Received: from zeus.kernel.org ([204.152.189.113]:31477 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S272746AbTG0W7K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 18:59:10 -0400
Date: Sun, 27 Jul 2003 15:22:34 -0500
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] [TRIVIAL] Fix ipt_helper compilation. Was: Linux v2.6.0-test2
Message-ID: <20030727202234.GA7280@iucha.net>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0307271003360.3401-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0307271003360.3401-100000@home.osdl.org>
X-message-flag: Microsoft: Where do you want to go today? Nevermind, you are coming with us!
X-gpg-key: http://iucha.net/florin_iucha.gpg
X-gpg-fingerprint: 41A9 2BDE 8E11 F1C5 87A6  03EE 34B3 E075 3B90 DFE4
User-Agent: Mutt/1.5.4i
From: florin@iucha.net (Florin Iucha)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 27, 2003 at 10:08:40AM -0700, Linus Torvalds wrote:
[snip]
>   o [NETFILTER]: Fix ip_nat_ftp in 2.6.0-test1
>   o [NETFILTER]: Re-sync ipt_REJECT with 2.4.x
>   o [NETFILTER]: Fix a bug in the IRC DCC command parser of
>     ip_conntrack_irc
>   o [NETFILTER]: Fix typo in ipt_MIRROR.c
>   o [NETFILTER]: Make REJECT target compliant with RFC 1812
>   o [NETFILTER]: Fix various problems with MIRROR target
>   o [NETFILTER]: Fix issues with REJECT and MIRROR targets wrt. policy
>     routing
>   o [NETFILTER]: Fix locking of ipt_helper
>   o [NETFILTER]: Drop reference to conntrack after removing confirmed
>     expectation

One of these broke the compilation of net/ipv4/netfilter/ipt_helper.o:
  CC [M]  net/ipv4/netfilter/ipt_helper.o
In file included from net/ipv4/netfilter/ipt_helper.c:13:
include/linux/netfilter_ipv4/ip_conntrack_core.h: In function `ip_conntrack=
_confirm':
include/linux/netfilter_ipv4/ip_conntrack_core.h:46: error: `NF_ACCEPT' und=
eclared (first use in this function)
include/linux/netfilter_ipv4/ip_conntrack_core.h:46: error: (Each undeclare=
d identifier is reported only once
include/linux/netfilter_ipv4/ip_conntrack_core.h:46: error: for each functi=
on it appears in.)

This trivial patch fixes it:

--- net/ipv4/netfilter/ipt_helper.c.orig	2003-07-27 15:19:49.000000000 -0500
+++ net/ipv4/netfilter/ipt_helper.c	2003-07-27 15:07:55.000000000 -0500
@@ -9,6 +9,7 @@
  */
 #include <linux/module.h>
 #include <linux/skbuff.h>
+#include <linux/netfilter.h>
 #include <linux/netfilter_ipv4/ip_conntrack.h>
 #include <linux/netfilter_ipv4/ip_conntrack_core.h>
 #include <linux/netfilter_ipv4/ip_conntrack_helper.h>

florin

--=20

"NT is to UNIX what a doughnut is to a particle accelerator."

--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/JDSKNLPgdTuQ3+QRAnlyAJ0UjesUHwpI89N2ycSf8uyHVkUD7ACffuYw
tqE/eAzkCVZLwZeU4Vah0q8=
=uH4N
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--
