Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932723AbVLSKp1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932723AbVLSKp1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 05:45:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932725AbVLSKp1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 05:45:27 -0500
Received: from bantam.cisco.com ([64.102.19.199]:34009 "EHLO
	av-tac-rtp.cisco.com") by vger.kernel.org with ESMTP
	id S932723AbVLSKp0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 05:45:26 -0500
X-TACSUNS: Virus Scanned
Date: Mon, 19 Dec 2005 11:45:42 +0100
From: Guy Martin <gmsoft@tuxicoman.be>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] compat_ioctl.c : VIDIOCSWIN using the wrong variable as
 argument
Message-Id: <20051219114542.68b09732.gmsoft@tuxicoman.be>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Mon__19_Dec_2005_11_45_42_+0100_tdLPpIP8kU86PI=x"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Mon__19_Dec_2005_11_45_42_+0100_tdLPpIP8kU86PI=x
Content-Type: multipart/mixed;
 boundary="Multipart=_Mon__19_Dec_2005_11_45_42_+0100_MtinuWwi88YY9PcI"


--Multipart=_Mon__19_Dec_2005_11_45_42_+0100_MtinuWwi88YY9PcI
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable



Hi,

There is a bug in the VIDIOCSWIN ioctl32. The 32->64bit wrapper passes the =
wrong variable to the 64bit ioctl.
It should pass the video_window (vm) instead of the clips (p).

The attached patch fixes this and has been tested successfully on a sparc64=
 with the pwc driver.


  Guy

--Multipart=_Mon__19_Dec_2005_11_45_42_+0100_MtinuWwi88YY9PcI
Content-Type: text/x-patch;
 name="compat_ioctl.c-VIDIOCSWIN.patch"
Content-Disposition: attachment;
 filename="compat_ioctl.c-VIDIOCSWIN.patch"
Content-Transfer-Encoding: quoted-printable

--- fs/compat_ioctl.c.old	2005-12-19 08:10:17.000000000 +0100
+++ fs/compat_ioctl.c	2005-12-19 09:13:14.000000000 +0100
@@ -343,7 +343,7 @@
 		}
 	}
=20
-	return sys_ioctl(fd, VIDIOCSWIN, (unsigned long)p);
+	return sys_ioctl(fd, VIDIOCSWIN, (unsigned long)vw);
 }
=20
 static int do_video_ioctl(unsigned int fd, unsigned int cmd, unsigned long=
 arg)

--Multipart=_Mon__19_Dec_2005_11_45_42_+0100_MtinuWwi88YY9PcI--

--Signature=_Mon__19_Dec_2005_11_45_42_+0100_tdLPpIP8kU86PI=x
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDpo9YrpShrnoH4YYRAs1kAJ9BLypGsM/KtXZ5OMTOkRMr4Se7UACeOO4V
vegG4LqP36zF03Jwt+A2XTo=
=MXIi
-----END PGP SIGNATURE-----

--Signature=_Mon__19_Dec_2005_11_45_42_+0100_tdLPpIP8kU86PI=x--
