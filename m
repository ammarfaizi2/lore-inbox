Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261254AbRE1L7J>; Mon, 28 May 2001 07:59:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261297AbRE1L67>; Mon, 28 May 2001 07:58:59 -0400
Received: from point41.gts.donpac.ru ([213.59.116.41]:52493 "EHLO orbita1.ru")
	by vger.kernel.org with ESMTP id <S261254AbRE1L6p>;
	Mon, 28 May 2001 07:58:45 -0400
Date: Mon, 28 May 2001 15:58:41 +0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH][RFC][REPOST] __init_msg(x) and friends macro
Message-ID: <20010528155841.A24736@orbita1.ru>
Reply-To: pazke@orbita1.ru
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wq9mPyueHGvFACwf"
User-Agent: Mutt/1.0.1i
X-Uptime: 3:24pm  up 2 days, 23:49,  3 users,  load average: 0.00, 0.00, 0.00
From: <pazke@orbita1.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--wq9mPyueHGvFACwf
Content-Type: multipart/mixed; boundary="bp/iNruPH9dso1Pn"


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

Hi all,

soryy for such ugly subject line, but I already sent this patch=20
to LKML and didn't get any reply.

Patch adds __init_msg (and friends) macro that places its argument=20
(string constant) into corresponding .data.init section and returns
pointer to it. The goal of this patch is to allow constructions like this:

        static void __init foo(void)
	{
		printk(__init_msg(KERN_INFO "Some random long message "
				  "going to .data.init and then to bit bucket\n"));
	}

I hope this patch can save some memory and will be usefull :))

Best regards.

--=20
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: http://www.orbita1.ru/~pazke/AndreyPanin=
.asc
--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-__init_msg
Content-Transfer-Encoding: quoted-printable

diff -ur linux.vanilla/include/linux/init.h linux/include/linux/init.h
--- linux.vanilla/include/linux/init.h	Mon May 14 15:51:20 2001
+++ linux/include/linux/init.h	Mon May 14 15:54:05 2001
@@ -155,4 +155,9 @@
 #define __devexitdata __exitdata
 #endif
=20
+#define __init_msg(x) ({ static char msg[] __initdata =3D (x); msg; })
+#define __exit_msg(x) ({ static char msg[] __exitdata =3D (x); msg; })
+#define __devinit_msg(x) ({ static char msg[] __devinitdata =3D (x); msg; =
})
+#define __devexit_msg(x) ({ static char msg[] __devexitdata =3D (x); msg; =
})
+
 #endif /* _LINUX_INIT_H */

--bp/iNruPH9dso1Pn--

--wq9mPyueHGvFACwf
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7Ej1xBm4rlNOo3YgRAgk9AKCD31y8TGPtgLl6TLnXs0n7PriyhQCgiFUp
SqabDiYMl+HuxHZ7O+Ga+os=
=VoaD
-----END PGP SIGNATURE-----

--wq9mPyueHGvFACwf--
