Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263637AbTHBNWv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 09:22:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263638AbTHBNVW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 09:21:22 -0400
Received: from coruscant.franken.de ([193.174.159.226]:2006 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id S263637AbTHBNUb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 09:20:31 -0400
Date: Sat, 2 Aug 2003 15:01:38 +0200
From: Harald Welte <laforge@netfilter.org>
To: David Miller <davem@redhat.com>
Cc: Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6] iptables AH/ESP fix (3/3)
Message-ID: <20030802130138.GH6894@naboo>
Mail-Followup-To: Harald Welte <laforge@netfilter.org>,
	David Miller <davem@redhat.com>,
	Netfilter Development Mailinglist <netfilter-devel@lists.netfilter.org>,
	Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Wo0oCZYLrer5S3Oe"
Content-Disposition: inline
X-Operating-System: Linux naboo 2.4.20-nfpom1101
X-Date: Today is Pungenday, the 67th day of Confusion in the YOLD 3169
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Wo0oCZYLrer5S3Oe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Davem!

The below patch (by Patrick McHardy) fixes the iptables 'esp' match to
use the same structure definition like the 2.5/2.6 in-kernel IPsec
implementation.

Please apply, thanks.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1537  -> 1.1538=20
#	net/ipv4/netfilter/ipt_esp.c	1.6     -> 1.7   =20
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/07/21	kaber@trash.net	1.1538
# [NETFILTER]: Use common struct ip_esp_hdr declaration
# --------------------------------------------
#
--- a/net/ipv4/netfilter/ipt_esp.c	Thu May 22 01:35:36 2003
+++ b/net/ipv4/netfilter/ipt_esp.c	Mon Jul 21 02:46:04 2003
@@ -1,6 +1,7 @@
 /* Kernel module to match ESP parameters. */
 #include <linux/module.h>
 #include <linux/skbuff.h>
+#include <linux/ip.h>
=20
 #include <linux/netfilter_ipv4/ipt_esp.h>
 #include <linux/netfilter_ipv4/ip_tables.h>
@@ -13,10 +14,6 @@
 #define duprintf(format, args...)
 #endif
=20
-struct esphdr {
-	__u32   spi;
-};
-
 /* Returns 1 if the spi is matched by the range, 0 otherwise */
 static inline int
 spi_match(u_int32_t min, u_int32_t max, u_int32_t spi, int invert)
@@ -37,7 +34,7 @@
       int offset,
       int *hotdrop)
 {
-	struct esphdr esp;
+	struct ip_esp_hdr esp;
 	const struct ipt_esp *espinfo =3D matchinfo;
=20
 	/* Must not be a fragment. */
--=20
- Harald Welte <laforge@netfilter.org>             http://www.netfilter.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
  "Fragmentation is like classful addressing -- an interesting early
   architectural error that shows how much experimentation was going
   on while IP was being designed."                    -- Paul Vixie

--Wo0oCZYLrer5S3Oe
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/K7YyXaXGVTD0i/8RAnE+AKCCvWPq1auieX1gNINtiwHpP2s6KwCfaj9Q
g+ayN5cUobhA1qVpIrYcRIU=
=nVhV
-----END PGP SIGNATURE-----

--Wo0oCZYLrer5S3Oe--
