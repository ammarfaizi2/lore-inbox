Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263536AbRFML7k>; Wed, 13 Jun 2001 07:59:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263745AbRFML7b>; Wed, 13 Jun 2001 07:59:31 -0400
Received: from point41.gts.donpac.ru ([213.59.116.41]:58118 "EHLO orbita1.ru")
	by vger.kernel.org with ESMTP id <S263536AbRFML7X>;
	Wed, 13 Jun 2001 07:59:23 -0400
Date: Wed, 13 Jun 2001 15:59:16 +0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH] pc keyboard driver minor cleanup
Message-ID: <20010613155916.A22257@orbita1.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yNb1oOkm5a9FJOVX"
User-Agent: Mutt/1.0.1i
X-Uptime: 2:41pm  up 13 days, 22:22,  2 users,  load average: 0.00, 0.02, 0.12
From: <pazke@orbita1.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--yNb1oOkm5a9FJOVX
Content-Type: multipart/mixed; boundary="8t9RHnE3ZwKMSgU+"


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

Hi,

added misc_register() return value checking and removed panic() in case of=
=20
kmalloc failure (IMHO it's possible to live without PS/2 mouse :)

Best regards.

--=20
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: http://www.orbita1.ru/~pazke/AndreyPanin=
.asc
--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-pckeyb
Content-Transfer-Encoding: quoted-printable

diff -u -X /usr/dontdiff /linux.vanilla/drivers/char/pc_keyb.c /linux/drive=
rs/char/pc_keyb.c
--- /linux.vanilla/drivers/char/pc_keyb.c	Tue Jun 12 10:51:25 2001
+++ /linux/drivers/char/pc_keyb.c	Tue Jun 12 13:51:26 2001
@@ -1011,13 +1011,20 @@
=20
 static int __init psaux_init(void)
 {
+	int retval;
+
 	if (!detect_auxiliary_port())
 		return -EIO;
=20
-	misc_register(&psaux_mouse);
+	if ((retval =3D misc_register(&psaux_mouse)))
+		return retval;
+
 	queue =3D (struct aux_queue *) kmalloc(sizeof(*queue), GFP_KERNEL);
-	if (queue =3D=3D NULL)
-		panic("psaux_init(): out of memory");
+	if (queue =3D=3D NULL) {
+		printk(KERN_ERR "psaux_init(): out of memory\n");
+		misc_deregister(&psaux_mouse);
+		return -ENOMEM;
+	}
 	memset(queue, 0, sizeof(*queue));
 	queue->head =3D queue->tail =3D 0;
 	init_waitqueue_head(&queue->proc_list);

--8t9RHnE3ZwKMSgU+--

--yNb1oOkm5a9FJOVX
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7J1WUBm4rlNOo3YgRAm55AJ9ReH7tLW/2MXeR5mzXb8v9SH2NfwCeLI4f
o3T2kgFfl6cltySQTCQyBTk=
=Dgrn
-----END PGP SIGNATURE-----

--yNb1oOkm5a9FJOVX--
