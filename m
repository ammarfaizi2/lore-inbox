Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262388AbSI2EVR>; Sun, 29 Sep 2002 00:21:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262389AbSI2EVR>; Sun, 29 Sep 2002 00:21:17 -0400
Received: from [61.149.36.14] ([61.149.36.14]:30731 "HELO bj.soulinfo.com")
	by vger.kernel.org with SMTP id <S262388AbSI2EVQ>;
	Sun, 29 Sep 2002 00:21:16 -0400
Date: Sun, 29 Sep 2002 12:17:59 +0800
From: Hu Gang <gang_hu@soul.com.cn>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [patch] Serial 2/2
Message-Id: <20020929121759.51685230.gang_hu@soul.com.cn>
Organization: Beijing Soul
X-Mailer: Sylpheed version 0.8.2claws28 (GTK+ 1.2.10; i386-linux-debian-i386-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.cFrrB97Nmn)eCf"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.cFrrB97Nmn)eCf
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hello all:

fix ret check bug: 2.5.39

--- drivers/serial/8250.c~old	Sun Sep 29 12:06:03 2002
+++ drivers/serial/8250.c	Sun Sep 29 12:17:05 2002
@@ -1564,7 +1565,7 @@
 
 	if (up->port.type == PORT_RSA) {
 		ret = serial8250_request_rsa_resource(up, &res_rsa);
-		if (ret)
+		if (ret == 0)
 			return ret;
 	}
 
@@ -1582,10 +1583,10 @@
 			ret = -ENOMEM;
 	}
 
-	if (ret) {
-		if (res_rsa)
+	if (ret == 0) {
+		if (res_rsa == 0)
 			release_resource(res_rsa);
-		if (res)
+		if (res == 0)
 			release_resource(res);
 	}
 	return ret;
@@ -1611,11 +1612,11 @@
 	 * tells us whether we can probe for the type of port.
 	 */
 	ret = serial8250_request_std_resource(up, &res_std);
-	if (ret)
+	if (ret == 0)
 		return;
 
 	ret = serial8250_request_rsa_resource(up, &res_rsa);
-	if (ret)
+	if (ret == 0)
 		probeflags &= ~PROBE_RSA;
 
 	if (flags & UART_CONFIG_TYPE)


-- 
		- Hu Gang

--=.cFrrB97Nmn)eCf
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE9ln73PM4uCy7bAJgRAmAyAJoDMLJFUzg3rVbaeiuOOWXzBom+wACdHmPr
QD74RPZTNZ9COtq8I62FUJg=
=ZdDF
-----END PGP SIGNATURE-----

--=.cFrrB97Nmn)eCf--
