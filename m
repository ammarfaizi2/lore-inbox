Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261436AbULFAh4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261436AbULFAh4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 19:37:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261439AbULFAh4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 19:37:56 -0500
Received: from chilli.pcug.org.au ([203.10.76.44]:31673 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S261436AbULFAhk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 19:37:40 -0500
Date: Mon, 6 Dec 2004 11:37:29 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] noone uses HAVE_ARCH_SI_CODES or HAVE_ARCH_SIGEVENT_T
Message-Id: <20041206113729.6b112aed.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 1.0.0beta3 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Mon__6_Dec_2004_11_37_29_+1100_CcYCA6nvWVFr_MpP"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Mon__6_Dec_2004_11_37_29_+1100_CcYCA6nvWVFr_MpP
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Since asm-generic/siginfo.h was created, the architectures have been
slowly fixed/modified until noone uses HAVE_ARCH_SI_CODES or
HAVE_ARCH_SIGEVENT_T any more, so this patch removes the checks for them.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.6.10-rc3/include/asm-generic/siginfo.h 2.6.10-rc3.si_codes/include/asm-generic/siginfo.h
--- 2.6.10-rc3/include/asm-generic/siginfo.h	2004-10-19 10:46:57.000000000 +1000
+++ 2.6.10-rc3.si_codes/include/asm-generic/siginfo.h	2004-12-04 23:53:01.000000000 +1100
@@ -154,7 +154,6 @@
 #define SI_FROMUSER(siptr)	((siptr)->si_code <= 0)
 #define SI_FROMKERNEL(siptr)	((siptr)->si_code > 0)
 
-#ifndef HAVE_ARCH_SI_CODES
 /*
  * SIGILL si_codes
  */
@@ -225,8 +224,6 @@
 #define POLL_HUP	(__SI_POLL|6)	/* device disconnected */
 #define NSIGPOLL	6
 
-#endif
-
 /*
  * sigevent definitions
  * 
@@ -245,8 +242,6 @@
 #define SIGEV_PAD_SIZE	((SIGEV_MAX_SIZE/sizeof(int)) - 3)
 #endif
 
-#ifndef HAVE_ARCH_SIGEVENT_T
-
 typedef struct sigevent {
 	sigval_t sigev_value;
 	int sigev_signo;
@@ -262,8 +257,6 @@
 	} _sigev_un;
 } sigevent_t;
 
-#endif
-
 #define sigev_notify_function	_sigev_un._sigev_thread._function
 #define sigev_notify_attributes	_sigev_un._sigev_thread._attribute
 #define sigev_notify_thread_id	 _sigev_un._tid

--Signature=_Mon__6_Dec_2004_11_37_29_+1100_CcYCA6nvWVFr_MpP
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBs6nK4CJfqux9a+8RAtS+AJ4+CS/sUEHKH56ClqwEDTYkGYO33wCeI3XT
xrLK5jOI9HNRPf1HUtrVO00=
=ufwN
-----END PGP SIGNATURE-----

--Signature=_Mon__6_Dec_2004_11_37_29_+1100_CcYCA6nvWVFr_MpP--
