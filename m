Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261547AbVBAE7V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261547AbVBAE7V (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 23:59:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261546AbVBAE7V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 23:59:21 -0500
Received: from chilli.pcug.org.au ([203.10.76.44]:1183 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S261547AbVBAE7P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 23:59:15 -0500
Date: Tue, 1 Feb 2005 15:59:01 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus <torvalds@osdl.org>, ppc64-dev <linuxppc64-dev@ozlabs.org>,
       paulus@ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] ppc64 iseries: can't remove viocd module when no cdroms
Message-Id: <20050201155901.62d7c14d.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Tue__1_Feb_2005_15_59_01_+1100_8vFeHku_A0rUpqkx"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Tue__1_Feb_2005_15_59_01_+1100_8vFeHku_A0rUpqkx
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hi Andrew,

This patch fixes a bug where attempting to remove the viocd module
when no virtual cdroms where actually present would cause an oops.
The driver was not completing its initialisation in this case.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN linus-bk/drivers/cdrom/viocd.c linus-bk.viocd.1/drivers/cdrom/viocd.c
--- linus-bk/drivers/cdrom/viocd.c	2004-11-16 16:05:11.000000000 +1100
+++ linus-bk.viocd.1/drivers/cdrom/viocd.c	2005-02-01 15:52:03.000000000 +1100
@@ -765,8 +765,6 @@
 	vio_setHandler(viomajorsubtype_cdio, vio_handle_cd_event);
 
 	get_viocd_info();
-	if (viocd_numdev == 0)
-		goto out_undo_vio;
 
 	spin_lock_init(&viocd_reqlock);
 
@@ -786,7 +784,6 @@
 	dma_free_coherent(iSeries_vio_dev,
 			sizeof(*viocd_unitinfo) * VIOCD_MAX_CD,
 			viocd_unitinfo, unitinfo_dmaaddr);
-out_undo_vio:
 	vio_clearHandler(viomajorsubtype_cdio);
 	viopath_close(viopath_hostLp, viomajorsubtype_cdio, MAX_CD_REQ + 2);
 out_unregister:

--Signature=_Tue__1_Feb_2005_15_59_01_+1100_8vFeHku_A0rUpqkx
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFB/wyV4CJfqux9a+8RAnpHAKCXa+904e0QBc1XRbZSKpMYYfWPEgCfR1Lr
3KmiLz12UlCp+Son7mHv5Og=
=Mm8F
-----END PGP SIGNATURE-----

--Signature=_Tue__1_Feb_2005_15_59_01_+1100_8vFeHku_A0rUpqkx--
