Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264927AbTK3PzS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 10:55:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264928AbTK3PzS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 10:55:18 -0500
Received: from gizmo01ps.bigpond.com ([144.140.71.11]:39359 "HELO
	gizmo01ps.bigpond.com") by vger.kernel.org with SMTP
	id S264927AbTK3PzL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 10:55:11 -0500
Mail-Copies-To: never
To: bert hubert <ahu@ds9a.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test11 -- Failed to open /dev/ttyS0: No such device
Keywords: serial,module,core,0-test11
References: <20031130071757.GA9835@node1.opengeometry.net>
	<20031130102351.GB10380@outpost.ds9a.nl>
	<20031130113656.GA28437@finwe.eu.org>
From: Steve Youngs <sryoungs@bigpond.net.au>
X-Face: #/1'_-|5_1$xjR,mVKhpfMJcRh8"k}_a{EkIO:Ox<]@zl/Yr|H,qH#3jJi6Aw(Mg@"!+Z"C
 N_S3!3jzW^FnPeumv4l#,E}J.+e%0q(U>#b-#`~>l^A!_j5AEgpU)>t+VYZ$:El7hLa1:%%L=3%B>n
 K{^jU_{&
Organization: Linux Users - Fanatics Dept.
X-URL: <http://users.bigpond.net.au/sryoungs/>
X-Request-PGP: <http://users.bigpond.net.au/sryoungs/pgp/sryoungs.asc>
X-OpenPGP-Fingerprint: 1659 2093 19D5 C06E D320  3A20 1D27 DB4B A94B 3003
X-Attribution: SY
Mail-Followup-To: bert hubert <ahu@ds9a.nl>, linux-kernel@vger.kernel.org
Date: Mon, 01 Dec 2003 01:54:51 +1000
In-Reply-To: <20031130113656.GA28437@finwe.eu.org> (Jacek Kawa's message of
 "Sun, 30 Nov 2003 12:36:56 +0100")
Message-ID: <microsoft-free.87ekvpc0ms.fsf@eicq.dnsalias.org>
User-Agent: Gnus/5.1003 (Gnus v5.10.3) XEmacs/21.4 (Reasonable Discussion,
 linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

|--==> "JK" == Jacek Kawa <jfk@zeus.polsl.gliwice.pl> writes:

  JK> bert hubert wrote:
  >>> Does anyone have modem working in 2.6.0-test11?
  >>> I have external modem connected to /dev/ttyS0 (COM1).  Kernel
  >>> 2.6.0-test11 give me

  JK> It reminds me, that I had to add serial to the list of modules
  JK> loading at start to get back access to /dev/ttyS* 
  JK> (while upgrading from -test9 to -test10). 

Jacek,

I _think_ this patch will bring back auto-loading of the serial module
for you.  Please let me know how it goes.  (Bert, this won't fix your
problem if you have the serial driver compiled directly into the
kernel, but it might if you have it as a module.)

--- linux-2.6.0-test11/drivers/serial/serial_core.c	2003-11-27 12:12:22.000000000 +1000
+++ linux-2.6.0-test11-sy/drivers/serial/serial_core.c	2003-12-01 01:38:40.000000000 +1000
@@ -2420,3 +2420,4 @@
 
 MODULE_DESCRIPTION("Serial driver core");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS_CHARDEV(drv->major, drv->minor);


-- 
|---<Steve Youngs>---------------<GnuPG KeyID: A94B3003>---|
|              Ashes to ashes, dust to dust.               |
|      The proof of the pudding, is under the crust.       |
|------------------------------<sryoungs@bigpond.net.au>---|

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Eicq - The XEmacs ICQ Client <http://eicq.sf.net/>

iEYEABECAAYFAj/KEtYACgkQHSfbS6lLMAMW7QCeJ7oJNNsmYpKAqp02+PwyDcbv
n0UAni974fsKFHZDI/bD9z5lAVduQeOf
=Z/5E
-----END PGP SIGNATURE-----
--=-=-=--
