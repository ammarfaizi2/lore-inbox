Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272330AbTGYUkL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 16:40:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272328AbTGYUj5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 16:39:57 -0400
Received: from coruscant.franken.de ([193.174.159.226]:46226 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id S272320AbTGYUik (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 16:38:40 -0400
Date: Fri, 25 Jul 2003 22:51:11 +0200
From: Harald Welte <laforge@netfilter.org>
To: David Miller <davem@redhat.com>
Cc: Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.4] netfilter ipt_REJECT: Add RFC1812 ICMP_PKT_FILTERED
Message-ID: <20030725205111.GO3244@sunbeam.de.gnumonks.org>
Mail-Followup-To: Harald Welte <laforge@netfilter.org>,
	David Miller <davem@redhat.com>,
	Netfilter Development Mailinglist <netfilter-devel@lists.netfilter.org>,
	Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3wDDcJ525A5nbDoJ"
Content-Disposition: inline
X-Operating-system: Linux sunbeam 2.6.0-test1-nftest
X-Date: Today is Prickle-Prickle, the 53rd day of Confusion in the YOLD 3169
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--3wDDcJ525A5nbDoJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dave!

The seven patch set of bugfixes for 2.4 is now complete.  Well, one more
thing, depending on the definition of 'bug' (since Marcelo only accepts
bug fixes from now on).

We now have a small patch that adds an ICMP type to the REJECT target.
But since before this patch, we don't fully comply with RFC1812, you
might also consider it as a bugfix.


Author: Maciej Soltysiak <solt@dns.toxicfilms.tv>

This patch adds support for the iptables '--reject-with admin-prohib'
option of the REJECT target, making it compliant with RFC 1812.


Please apply,


diff -Nru linux.bak/include/linux/netfilter_ipv4/ipt_REJECT.h linux/include=
/linux/netfilter_ipv4/ipt_REJECT.h
--- linux.bak/include/linux/netfilter_ipv4/ipt_REJECT.h	2003-04-08 20:21:22=
=2E000000000 +0200
+++ linux/include/linux/netfilter_ipv4/ipt_REJECT.h	2003-04-09 16:40:05.000=
000000 +0200
@@ -9,7 +9,8 @@
 	IPT_ICMP_ECHOREPLY,
 	IPT_ICMP_NET_PROHIBITED,
 	IPT_ICMP_HOST_PROHIBITED,
-	IPT_TCP_RESET
+	IPT_TCP_RESET,
+	IPT_ICMP_ADMIN_PROHIBITED
 };

 struct ipt_reject_info {
diff -Nru linux.bak/net/ipv4/netfilter/ipt_REJECT.c linux/net/ipv4/netfilte=
r/ipt_REJECT.c
--- linux.bak/net/ipv4/netfilter/ipt_REJECT.c	2003-04-08 20:21:56.000000000=
 +0200
+++ linux/net/ipv4/netfilter/ipt_REJECT.c	2003-04-09 16:41:07.000000000 +02=
00
@@ -1,6 +1,7 @@
 /*
  * This is a module which is used for rejecting packets.
  * Added support for customized reject packets (Jozsef Kadlecsik).
+ * Added support for ICMP type-3-code-13 (Maciej Soltysiak). [RFC 1812]
  */
 #include <linux/config.h>
 #include <linux/module.h>
@@ -330,6 +331,9 @@
 	case IPT_ICMP_HOST_PROHIBITED:
     		send_unreach(*pskb, ICMP_HOST_ANO);
     		break;
+    	case IPT_ICMP_ADMIN_PROHIBITED:
+		send_unreach(*pskb, ICMP_PKT_FILTERED);
+		break;
 	case IPT_TCP_RESET:
 		send_reset(*pskb, hooknum =3D=3D NF_IP_LOCAL_IN);
 	case IPT_ICMP_ECHOREPLY:
--=20
- Harald Welte <laforge@netfilter.org>             http://www.netfilter.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
  "Fragmentation is like classful addressing -- an interesting early
   architectural error that shows how much experimentation was going
   on while IP was being designed."                    -- Paul Vixie

--3wDDcJ525A5nbDoJ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/IZg/XaXGVTD0i/8RAogtAJ9Bun71ggWdzdulCYV/gpF8edroDACbB4xi
WpNqZGf8gYpG70DyiwXqTjo=
=zYbt
-----END PGP SIGNATURE-----

--3wDDcJ525A5nbDoJ--
