Return-Path: <linux-kernel-owner@vger.kernel.org>
thread-index: AcQVpHx9G7eCZyPsQFqC/dJOux7Tuw==
Envelope-to: paul@sumlocktest.fsnet.co.uk
Delivery-date: Sun, 04 Jan 2004 15:42:58 +0000
Message-ID: <020701c415a4$7c7d41e0$d100000a@sbs2003.local>
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft CDO for Exchange 2000
Content-Class: urn:content-classes:message
Importance: normal
Priority: normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.0
Date: Mon, 29 Mar 2004 16:42:48 +0100
From: "Arjan van de Ven" <arjanv@redhat.com>
To: <Administrator@smtp.paston.co.uk>
Cc: <torvalds@osdl.org>, <akpm@osdl.org>, <davej@redhat.com>
Subject: 2.6.1-rc1 arch/i386/kernel/setup.c   wrong parameter order to request resources ?
MIME-Version: 1.0
Content-Type: multipart/signed;
	micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="jq0ap7NbKX2Kqbes"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: <linux-kernel-owner@vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
X-OriginalArrivalTime: 29 Mar 2004 15:42:53.0140 (UTC) FILETIME=[7F841940:01C415A4]

This is a multi-part message in MIME format.

--jq0ap7NbKX2Kqbes
Content-Type: text/plain;
	charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

in setup.c  the kernel tries to reserve ram resources for system ram etc
etc. However it seems it's done with the parameters to request_resource in
the wrong order (it certainly is opposite order from other neighboring
code). Can someone confirm I'm not overlooking something?

Greetings,
   Arjan van de Ven

--- linux-2.6.0/arch/i386/kernel/setup.c~	2004-01-04 16:37:34.622450000 +01=
00
+++ linux-2.6.0/arch/i386/kernel/setup.c	2004-01-04 16:37:34.622450000 +0100
@@ -834,8 +834,8 @@
 			 *  so we try it repeatedly and let the resource manager
 			 *  test it.
 			 */
-			request_resource(res, &code_resource);
-			request_resource(res, &data_resource);
+			request_resource(&code_resource, res);
+			request_resource(&data_resource, res);
 		}
 	}
=20

--jq0ap7NbKX2Kqbes
Content-Transfer-Encoding: 7bit
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/+DOvxULwo51rQBIRAkvVAJ42rjeQxxT13DooNSTfWQFdeFscIwCcCZYT
T5TA0krvvQ1TwdJ+3t+jhxc=
=Ysj1
-----END PGP SIGNATURE-----

--jq0ap7NbKX2Kqbes--
