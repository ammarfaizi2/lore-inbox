Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262370AbSI2CRD>; Sat, 28 Sep 2002 22:17:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262371AbSI2CRC>; Sat, 28 Sep 2002 22:17:02 -0400
Received: from [61.149.36.14] ([61.149.36.14]:61957 "HELO bj.soulinfo.com")
	by vger.kernel.org with SMTP id <S262370AbSI2CRC>;
	Sat, 28 Sep 2002 22:17:02 -0400
Date: Sun, 29 Sep 2002 10:15:23 +0800
From: Hu Gang <hugang@soulinfo.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: a bug in 8250.c
Message-Id: <20020929101523.2400f335.hugang@soulinfo.com>
Organization: Beijing Soul
X-Mailer: Sylpheed version 0.8.2claws28 (GTK+ 1.2.10; i386-linux-debian-i386-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.pceS+CCCdFk5'i"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.pceS+CCCdFk5'i
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Russell King:

In serial8250_request_std_resource@825.c, if all is pass it return 0, or failed return -XX, But you use 
        ret = serial8250_request_std_resource(up, &res_std);
->      if (ret)
                return;
I'm guess it use as . 
->      if (ret == 0) 

After change code, 2.5.39 Can found my modem.
Please check, If not proble, Please apply.
--------------
Here is the patch.
--- 8250.c	Sat Sep 28 11:15:16 2002
+++ 8250.c~fix	Sat Sep 28 22:07:36 2002
@@ -1564,7 +1564,7 @@
 
 	if (up->port.type == PORT_RSA) {
 		ret = serial8250_request_rsa_resource(up, &res_rsa);
-		if (ret)
+		if (ret == 0)
 			return ret;
 	}
 
@@ -1611,11 +1611,11 @@
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



--=.pceS+CCCdFk5'i
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE9lmI7PM4uCy7bAJgRAlVuAJ93cDWpJADxoD+U+qArzG7rBVb0HwCfeJ0u
/gyFIgZuSc7ZGuRMIJ0lORw=
=M2pp
-----END PGP SIGNATURE-----

--=.pceS+CCCdFk5'i--
