Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261405AbUIVHlU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261405AbUIVHlU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 03:41:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261426AbUIVHlU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 03:41:20 -0400
Received: from chilli.pcug.org.au ([203.10.76.44]:31459 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S261405AbUIVHlR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 03:41:17 -0400
Date: Wed, 22 Sep 2004 17:41:10 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@osdl.org>
Cc: boutcher@us.ibm.com, LKML <linux-kernel@vger.kernel.org>,
       linuxppc64-dev@lists.linuxppc.org
Subject: [PATCH] PPC64 iSeries: allow ibmvscsic to initialise
Message-Id: <20040922174110.6b79a6f2.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Wed__22_Sep_2004_17_41_10_+1000_yrgddrIeVcm4YAz3"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Wed__22_Sep_2004_17_41_10_+1000_yrgddrIeVcm4YAz3
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hi Andrew,

This patch supplies an device so that ibmvscsic will actually have
its probe routine called and so allow ti to actually initialise on
(legacy) iSeries machines.

It also adds a device for the virtual console (for consistency only
at the moment).

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.6.9-rc2-bk7/arch/ppc64/kernel/vio.c 2.6.9-rc2-bk7-vio.1/arch/ppc64/kernel/vio.c
--- 2.6.9-rc2-bk7/arch/ppc64/kernel/vio.c	2004-08-19 17:02:00.000000000 +1000
+++ 2.6.9-rc2-bk7-vio.1/arch/ppc64/kernel/vio.c	2004-09-22 17:14:32.000000000 +1000
@@ -225,6 +225,10 @@
 	struct vio_dev *viodev;
 	int i;
 
+	/* there is only one of each of these */
+	vio_register_device_iseries("viocons", 0);
+	vio_register_device_iseries("vscsi", 0);
+
 	vlan_map = HvLpConfig_getVirtualLanIndexMap();
 	for (i = 0; i < HVMAXARCHITECTEDVIRTUALLANS; i++) {
 		if ((vlan_map & (0x8000 >> i)) == 0)

--Signature=_Wed__22_Sep_2004_17_41_10_+1000_yrgddrIeVcm4YAz3
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBUSyW4CJfqux9a+8RAkc3AJ0eUGWImfIbrdAUMICp5dayJK6gjgCbBmF1
PPrzlyPyH2ZpUx/AiuAiOYA=
=ORcU
-----END PGP SIGNATURE-----

--Signature=_Wed__22_Sep_2004_17_41_10_+1000_yrgddrIeVcm4YAz3--
