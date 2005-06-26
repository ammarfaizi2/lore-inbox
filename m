Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261534AbVFZSbD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261534AbVFZSbD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 14:31:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261537AbVFZSbD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 14:31:03 -0400
Received: from mta7.srv.hcvlny.cv.net ([167.206.4.202]:52320 "EHLO
	mta7.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S261534AbVFZSax (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 14:30:53 -0400
Date: Sun, 26 Jun 2005 14:30:49 -0400
From: Jeff Sipek <jeffpc@optonline.net>
Subject: [PATCH][TRIVIAL] Allocate kprobe_table at runtime
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: trivial@rustcorp.com.au
Message-id: <20050626183049.GA22898@optonline.net>
MIME-version: 1.0
Content-type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Content-disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Allocates kprobe_table at runtime.

Signed-off-by: Josef "Jeff" Sipek <jeffpc@optonline.net>


diff --git a/kernel/kprobes.c b/kernel/kprobes.c
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -40,7 +40,7 @@
 #define KPROBE_HASH_BITS 6
 #define KPROBE_TABLE_SIZE (1 << KPROBE_HASH_BITS)
=20
-static struct hlist_head kprobe_table[KPROBE_TABLE_SIZE];
+static struct hlist_head *kprobe_table;
=20
 unsigned int kprobe_cpu =3D NR_CPUS;
 static DEFINE_SPINLOCK(kprobe_lock);
@@ -261,7 +261,10 @@ static int __init init_kprobes(void)
 {
 	int i, err =3D 0;
=20
-	/* FIXME allocate the probe table, currently defined statically */
+	kprobe_table =3D kmalloc(sizeof(struct hlist_head)*KPROBE_TABLE_SIZE, GFP=
_ATOMIC);
+	if (!kprobe_table)
+		return -ENOMEM;
+
 	/* initialize all list heads */
 	for (i =3D 0; i < KPROBE_TABLE_SIZE; i++)
 		INIT_HLIST_HEAD(&kprobe_table[i]);

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCvvRZwFP0+seVj/4RAi/4AJ4sAPsu7TMLvEE5hVShM6UZnQHI3ACgncfh
o5L+767hUZf4vBJGAFCKPtM=
=QHPX
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
