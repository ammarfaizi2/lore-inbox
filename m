Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261167AbVAWAfF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261167AbVAWAfF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 19:35:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261168AbVAWAfF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 19:35:05 -0500
Received: from null.rsn.bth.se ([194.47.142.3]:61634 "EHLO null.rsn.bth.se")
	by vger.kernel.org with ESMTP id S261167AbVAWAe6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 19:34:58 -0500
Subject: Re: Linux 2.6.11-rc2
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: sean <seandarcy@hotmail.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <41F2E7BB.2050405@hotmail.com>
References: <Pine.LNX.4.58.0501211806130.3053@ppc970.osdl.org>
	 <20050121223247.65c544f8@laptop.hypervisor.org>
	 <1106402669.20995.23.camel@tux.rsn.bth.se>  <41F2E7BB.2050405@hotmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-uDCiRUVEJul94BkDUCTc"
Date: Sun, 23 Jan 2005 01:34:54 +0100
Message-Id: <1106440494.20995.44.camel@tux.rsn.bth.se>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-uDCiRUVEJul94BkDUCTc
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2005-01-22 at 18:54 -0500, sean wrote:

> I'm compiling with NAT, and get a different problem:
>=20
>    LD      net/ipv4/netfilter/built-in.o
> net/ipv4/netfilter/ip_nat_tftp.o(.bss+0x0): multiple definition of `ip_na=
t_tftp_hook'
> net/ipv4/netfilter/ip_conntrack_tftp.o(.bss+0x0): first defined here
> make[3]: *** [net/ipv4/netfilter/built-in.o] Error 1
> make[2]: *** [net/ipv4/netfilter] Error 2

Ok, another problem intriduced by the recent patches... sigh
Try this patch:

diff -X dontdiff.ny -urNp linux-2.6.11-rc2.orig/include/linux/netfilter_ipv=
4/ip_conntrack_tftp.h linux-2.6.11-rc2/include/linux/netfilter_ipv4/ip_conn=
track_tftp.h
--- linux-2.6.11-rc2.orig/include/linux/netfilter_ipv4/ip_conntrack_tftp.h	=
2005-01-22 15:23:45.000000000 +0100
+++ linux-2.6.11-rc2/include/linux/netfilter_ipv4/ip_conntrack_tftp.h	2005-=
01-23 01:31:25.000000000 +0100
@@ -13,7 +13,7 @@ struct tftphdr {
 #define TFTP_OPCODE_ACK		4
 #define TFTP_OPCODE_ERROR	5
=20
-unsigned int (*ip_nat_tftp_hook)(struct sk_buff **pskb,
+extern unsigned int (*ip_nat_tftp_hook)(struct sk_buff **pskb,
 				 enum ip_conntrack_info ctinfo,
 				 struct ip_conntrack_expect *exp);
=20

--=20
/Martin

--=-uDCiRUVEJul94BkDUCTc
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBB8vEuWm2vlfa207ERAqCPAJ9QOVYfCF/49GvEX5N6q/OEh2iBgQCaA7Gp
yZw+VtzbTyiZF+M0uB7oCiM=
=+IuM
-----END PGP SIGNATURE-----

--=-uDCiRUVEJul94BkDUCTc--
