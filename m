Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267636AbTBYEz7>; Mon, 24 Feb 2003 23:55:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267637AbTBYEz7>; Mon, 24 Feb 2003 23:55:59 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:12492 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267636AbTBYEz5>;
	Mon, 24 Feb 2003 23:55:57 -0500
Subject: [PATCH] linux-2.5.63_notsc-panic_A1
From: john stultz <johnstul@us.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Dave H <haveblue@us.ibm.com>,
       Andrew Morton <akpm@digeo.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-JbBGMX/l0WVt+9k+1DyJ"
Organization: 
Message-Id: <1046149232.18311.337.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 24 Feb 2003 21:00:33 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-JbBGMX/l0WVt+9k+1DyJ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Linus, all

	In my exuberance to remove #ifdef CONFIG_X86_TSC, I accidentally yanked
one that is needed as long as the symbol itself exists. I've actually
been sitting on this patch for a while, thinking I would get around to
killing off the remaining uses of _X86_TSC, but I've just been too
swamped to get around to it.

This patch ensures that the "notsc" boot parameter is ignored (with a
warning) if the option is passed to a kernel that has been compiled with
CONFIG_X86_TSC. Currently the code will unreasonably panic when this
occurs.=20

And since this patch does add an #ifdef _X86_TSC, as a show of goodwill,
I'll follow this patch with another that removes one instance of
_X86_TSC.=20

Please apply,

thanks
-john

PS: If anyone is looking for a little project, the usage in pkt_sched.h
and profile.h (include/net) could use some attention :)

diff -Nru a/arch/i386/kernel/timers/timer_tsc.c b/arch/i386/kernel/timers/t=
imer_tsc.c
--- a/arch/i386/kernel/timers/timer_tsc.c	Mon Feb 24 20:57:33 2003
+++ b/arch/i386/kernel/timers/timer_tsc.c	Mon Feb 24 20:57:33 2003
@@ -299,6 +299,7 @@
 	return -ENODEV;
 }
=20
+#ifndef CONFIG_X86_TSC
 /* disable flag for tsc.  Takes effect by clearing the TSC cpu flag
  * in cpu/common.c */
 static int __init tsc_setup(char *str)
@@ -306,7 +307,14 @@
 	tsc_disable =3D 1;
 	return 1;
 }
-
+#else
+static int __init tsc_setup(char *str)
+{
+	printk(KERN_WARNING "notsc: Kernel compiled with CONFIG_X86_TSC, "
+				"cannot disable TSC.\n");
+	return 1;
+}
+#endif
 __setup("notsc", tsc_setup);
=20
=20



--=-JbBGMX/l0WVt+9k+1DyJ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA+WvhwMDAZ/OmgHwwRAkEtAKCj7W+9+34w+OrB29ds6T7N1d4jBACfQ8jv
UeBClySppICazCVN5L3eHEE=
=7cq5
-----END PGP SIGNATURE-----

--=-JbBGMX/l0WVt+9k+1DyJ--

