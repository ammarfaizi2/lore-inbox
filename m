Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261604AbUD3WMV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261604AbUD3WMV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 18:12:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261615AbUD3WMU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 18:12:20 -0400
Received: from linux.us.dell.com ([143.166.224.162]:35018 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S261604AbUD3WMR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 18:12:17 -0400
Date: Fri, 30 Apr 2004 17:12:07 -0500
From: Matt Domsch <Matt_Domsch@dell.com>
To: axboe@suse.de, marcelo.tosatti@cyclades.com
Cc: linux-kernel@vger.kernel.org
Subject: 2.4 Remove blk: queue xxxx I/O limit xxxx  messages printed by all devices
Message-ID: <20040430221207.GC9853@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ncSAzJYg3Aa9+CRW"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ncSAzJYg3Aa9+CRW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Jens, please review and ack this patch against 2.4.

Remove blk: queue xxxx I/O limit xxxx  messages printed by all block
devices

This was a debug message and is no longer needed.

--=20
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

=3D=3D=3D=3D=3D drivers/block/ll_rw_blk.c 1.53 vs edited =3D=3D=3D=3D=3D
--- 1.53/drivers/block/ll_rw_blk.c	Mon Mar 15 10:52:56 2004
+++ edited/drivers/block/ll_rw_blk.c	Fri Apr 30 17:06:36 2004
@@ -280,21 +280,6 @@
 void blk_queue_bounce_limit(request_queue_t *q, u64 dma_addr)
 {
 	unsigned long bounce_pfn =3D dma_addr >> PAGE_SHIFT;
-	unsigned long mb =3D dma_addr >> 20;
-	static request_queue_t *old_q;
-
-	/*
-	 * keep this for debugging for now...
-	 */
-	if (dma_addr !=3D BLK_BOUNCE_HIGH && q !=3D old_q) {
-		old_q =3D q;
-		printk("blk: queue %p, ", q);
-		if (dma_addr =3D=3D BLK_BOUNCE_ANY)
-			printk("no I/O memory limit\n");
-		else
-			printk("I/O limit %luMb (mask 0x%Lx)\n", mb,
-			       (long long) dma_addr);
-	}
=20
 	q->bounce_pfn =3D bounce_pfn;
 }

--ncSAzJYg3Aa9+CRW
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAks83Iavu95Lw/AkRApnoAKCW+l4y7ceo7kHK4wIGBh/9de16IACfc8FW
wknCcTGk9qkZ7uNMVu3jY4k=
=nuSW
-----END PGP SIGNATURE-----

--ncSAzJYg3Aa9+CRW--
