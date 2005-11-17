Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751340AbVKQVaZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751340AbVKQVaZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 16:30:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751347AbVKQVaZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 16:30:25 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:10471 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1751340AbVKQVaY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 16:30:24 -0500
Message-Id: <200511172130.jAHLUCP0010033@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-rc1-mm1 
In-Reply-To: Your message of "Thu, 17 Nov 2005 11:18:07 PST."
             <20051117111807.6d4b0535.akpm@osdl.org> 
From: Valdis.Kletnieks@vt.edu
References: <20051117111807.6d4b0535.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1132263011_2731P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 17 Nov 2005 16:30:12 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1132263011_2731P
Content-Type: text/plain; charset=us-ascii

On Thu, 17 Nov 2005 11:18:07 PST, Andrew Morton said:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15-rc1/2.6.15-rc1-mm1

> +keys-permit-running-process-to-instantiate-keys.patch
> 
>  key management updates

This causes a compile issue:

  CC      security/keys/keyctl.o
security/keys/keyctl.c:1029: error: conflicting types for 'keyctl_assume_authority'
security/keys/internal.h:141: error: previous declaration of 'keyctl_assume_authority' was here
make[2]: *** [security/keys/keyctl.o] Error 1

Why does keyctl.c declare it as 'asmlinkage'?

--- linux-2.6.15-rc1-mm1/security/keys/keyctl.c.dist	2005-11-17 15:59:04.000000000 -0500
+++ linux-2.6.15-rc1-mm1/security/keys/keyctl.c	2005-11-17 16:28:05.000000000 -0500
@@ -1025,7 +1025,7 @@
 /*
  * assume the authority to instantiate the specified key
  */
-asmlinkage long keyctl_assume_authority(key_serial_t id)
+long keyctl_assume_authority(key_serial_t id)
 {
 	struct key *authkey;
 	long ret;



--==_Exmh_1132263011_2731P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFDfPZjcC3lWbTT17ARAtldAKCXlCSsMVOFh3KW+CIlxLfQNTtbyQCeINkP
ZSprebylgwenZuuiIBy7GSM=
=Mokc
-----END PGP SIGNATURE-----

--==_Exmh_1132263011_2731P--
