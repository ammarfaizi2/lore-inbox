Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263240AbVCDXnf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263240AbVCDXnf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 18:43:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263229AbVCDXig
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 18:38:36 -0500
Received: from keetweej.xs4all.nl ([213.84.46.114]:60599 "EHLO
	keetweej.vanheusden.com") by vger.kernel.org with ESMTP
	id S263263AbVCDVdt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 16:33:49 -0500
Date: Fri, 4 Mar 2005 22:33:47 +0100
To: Lorenzo Hern?ndez Garc?a-Hierro <lorenzo@gnu.org>
Cc: linux-kernel@vger.kernel.org
Subject: Suggestions for patch
Message-ID: <20050304213337.GJ6156@vanheusden.com>
References: <20050210123719.GU1991@vanheusden.com> <1108313818.9095.166.camel@localhost.localdomain> <20050213171321.GM4895@vanheusden.com> <1108317508.9095.183.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
Content-Disposition: inline
In-Reply-To: <1108317508.9095.183.camel@localhost.localdomain>
Organization: www.unixexpert.nl
Read-Receipt-To: <folkert@vanheusden.com>
X-Chameleon-Return-To: folkert@vanheusden.com
X-Xfmail-Return-To: folkert@vanheusden.com
X-Phonenumber: +31-6-41278122
X-URL: http://www.vanheusden.com/
X-PGP-KeyID: 1F28D8AE
X-GPG-fingerprint: AC89 09CE 41F2 00B4 FCF2  B174 3019 0E8C 1F28 D8AE
X-Key: http://pgp.surfnet.nl:11371/pks/lookup?op=get&search=0x1F28D8AE
Reply-By: Sat Mar  5 18:55:34 CET 2005
X-MSMail-Priority: High
User-Agent: Mutt/1.5.6+20040907i
From: folkert@vanheusden.com (Folkert van Heusden)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I have a suggestion for the openbsd net security patch.
In the function static int tcp_v4_get_port(struct sock *sk, unsigned short snum)
there's the code that says:
	rover = tcp_port_rover;
(like 224 on the version of tcp_ipv4.c patched with your patch for rc2 of 2.6.11)
I would like to suggest to change it to:
	get_random_bytes(&rover, sizeof(rover));
no checks around it: that's already been taken care of in the original
code.

And for the ipv6 code:
diff -uNr tcp_ipv6.c.org tcp_ipv6.c
--- tcp_ipv6.c.org      2005-03-04 22:28:53.181183066 +0100
+++ tcp_ipv6.c  2005-03-04 22:32:56.425994913 +0100
@@ -138,8 +138,8 @@
                int remaining = (high - low) + 1;
                int rover;

+               get_random_bytes(&rover, sizeof(rover));
                spin_lock(&tcp_portalloc_lock);
-               rover = tcp_port_rover;
                do {    rover++;
                        if ((rover < low) || (rover > high))
                                rover = low;


Folkert van Heusden

Op zoek naar een IT of Finance baan? Mail me voor de mogelijkheden!
+------------------------------------------------------------------+
|UNIX admin? Then give MultiTail (http://vanheusden.com/multitail/)|
|a try, it brings monitoring logfiles to a different level! See    |
|http://vanheusden.com/multitail/features.html for a feature list. |
+------------------------------------------= www.unixsoftware.nl =-+
Phone: +31-6-41278122, PGP-key: 1F28D8AE
Get your PGP/GPG key signed at www.biglumber.com!

--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCKNQxMBkOjB8o2K4RAjgRAJsErtAy6YsbovM4uE6HRMHys7NTwACeL7Vy
WRBOtWlBw01aK1he9LKKEgI=
=tCfW
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--
