Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265742AbUADPmW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 10:42:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265744AbUADPmW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 10:42:22 -0500
Received: from mx1.redhat.com ([66.187.233.31]:57531 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265742AbUADPmU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 10:42:20 -0500
Date: Sun, 4 Jan 2004 16:39:28 +0100
From: Arjan van de Ven <arjanv@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org, akpm@osdl.org, davej@redhat.com
Subject: 2.6.1-rc1 arch/i386/kernel/setup.c   wrong parameter order to request resources ?
Message-ID: <20040104153928.GB2416@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jq0ap7NbKX2Kqbes"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jq0ap7NbKX2Kqbes
Content-Type: text/plain; charset=us-ascii
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
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/+DOvxULwo51rQBIRAkvVAJ42rjeQxxT13DooNSTfWQFdeFscIwCcCZYT
T5TA0krvvQ1TwdJ+3t+jhxc=
=Ysj1
-----END PGP SIGNATURE-----

--jq0ap7NbKX2Kqbes--
