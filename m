Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272329AbTGYUnw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 16:43:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272310AbTGYUnQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 16:43:16 -0400
Received: from coruscant.franken.de ([193.174.159.226]:54930 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id S272329AbTGYUkB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 16:40:01 -0400
Date: Fri, 25 Jul 2003 22:52:33 +0200
From: Harald Welte <laforge@netfilter.org>
To: David Miller <davem@redhat.com>
Cc: Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6] netfilter ipt_REJECT: Add RFC1812 ICMP_PKT_FILTERED
Message-ID: <20030725205233.GE3244@sunbeam.de.gnumonks.org>
Mail-Followup-To: Harald Welte <laforge@netfilter.org>,
	David Miller <davem@redhat.com>,
	Netfilter Development Mailinglist <netfilter-devel@lists.netfilter.org>,
	Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C2AE+UNCNp5RBAjn"
Content-Disposition: inline
X-Operating-system: Linux sunbeam 2.6.0-test1-nftest
X-Date: Today is Prickle-Prickle, the 53rd day of Confusion in the YOLD 3169
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--C2AE+UNCNp5RBAjn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dave!

The six patch set of 2.6 merges of recent bugfixes is now complete.

Author: Maciej Soltysiak <solt@dns.toxicfilms.tv>

This patch adds support for the iptables '--reject-with admin-prohib'
option of the REJECT target, making it compliant with RFC 1812.

[... now off my email until arrival at ksummit + OLS]

Please apply,


diff -Nru --exclude .depend --exclude '*.o' --exclude '*.ko' --exclude '*.v=
er' --exclude '.*.flags' --exclude '*.orig' --exclude '*.rej' --exclude '*.=
cmd' --exclude '*.mod.c' --exclude '*~' linux-2.6.0-test1-nftest5/include/l=
inux/netfilter_ipv4/ipt_REJECT.h linux-2.6.0-test1-nftest6/include/linux/ne=
tfilter_ipv4/ipt_REJECT.h
--- linux-2.6.0-test1-nftest5/include/linux/netfilter_ipv4/ipt_REJECT.h	200=
3-07-14 05:37:19.000000000 +0200
+++ linux-2.6.0-test1-nftest6/include/linux/netfilter_ipv4/ipt_REJECT.h	200=
3-07-19 16:40:11.000000000 +0200
@@ -9,7 +9,8 @@
 	IPT_ICMP_ECHOREPLY,
 	IPT_ICMP_NET_PROHIBITED,
 	IPT_ICMP_HOST_PROHIBITED,
-	IPT_TCP_RESET
+	IPT_TCP_RESET,
+	IPT_ICMP_ADMIN_PROHIBITED
 };
=20
 struct ipt_reject_info {
diff -Nru --exclude .depend --exclude '*.o' --exclude '*.ko' --exclude '*.v=
er' --exclude '.*.flags' --exclude '*.orig' --exclude '*.rej' --exclude '*.=
cmd' --exclude '*.mod.c' --exclude '*~' linux-2.6.0-test1-nftest5/net/ipv4/=
netfilter/ipt_REJECT.c linux-2.6.0-test1-nftest6/net/ipv4/netfilter/ipt_REJ=
ECT.c
--- linux-2.6.0-test1-nftest5/net/ipv4/netfilter/ipt_REJECT.c	2003-07-19 16=
:13:32.000000000 +0200
+++ linux-2.6.0-test1-nftest6/net/ipv4/netfilter/ipt_REJECT.c	2003-07-19 16=
:40:11.000000000 +0200
@@ -1,6 +1,7 @@
 /*
  * This is a module which is used for rejecting packets.
  * Added support for customized reject packets (Jozsef Kadlecsik).
+ * Added support for ICMP type-3-code-13 (Maciej Soltysiak). [RFC 1812]
  */
 #include <linux/config.h>
 #include <linux/module.h>
@@ -387,6 +388,9 @@
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

--C2AE+UNCNp5RBAjn
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/IZiRXaXGVTD0i/8RAmbJAJ9V2V7tQR5rIaoUtpimCAn78mXP6wCeP0Rb
KCNMGEW/cfMCZoGcUUYVWJ0=
=cb/p
-----END PGP SIGNATURE-----

--C2AE+UNCNp5RBAjn--
