Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262825AbUJ1IYO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262825AbUJ1IYO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 04:24:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262826AbUJ1IYO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 04:24:14 -0400
Received: from chilli.pcug.org.au ([203.10.76.44]:61900 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S262825AbUJ1IYI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 04:24:08 -0400
Date: Thu, 28 Oct 2004 18:23:58 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       ppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: [PATCH] ppc64 iSeries: fix for generic irq changes
Message-Id: <20041028182358.6b69eeac.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.9.99 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Thu__28_Oct_2004_18_23_58_+1000_Bj8qKu/nYBkKIm0y"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Thu__28_Oct_2004_18_23_58_+1000_Bj8qKu/nYBkKIm0y
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hi Andrew,

The generic irq patches broke pci irqs on ppc64 iSeries.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Please merge and send to Linus.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.6.10-rc1-bk6/arch/ppc64/kernel/iSeries_irq.c 2.6.10-rc1-bk6-irq.1/arch/ppc64/kernel/iSeries_irq.c
--- 2.6.10-rc1-bk6/arch/ppc64/kernel/iSeries_irq.c	2004-05-10 15:31:04.000000000 +1000
+++ 2.6.10-rc1-bk6-irq.1/arch/ppc64/kernel/iSeries_irq.c	2004-10-28 18:06:30.000000000 +1000
@@ -110,6 +110,7 @@
 	/* Unmask bridge interrupts in the FISR */
 	mask = 0x01010000 << function;
 	HvCallPci_unmaskFisr(bus, subBus, deviceId, mask);
+	iSeries_enable_IRQ(irq);
 	return 0;
 }
 

--Signature=_Thu__28_Oct_2004_18_23_58_+1000_Bj8qKu/nYBkKIm0y
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBgKye4CJfqux9a+8RAoz2AJ9/ThwL2xVx5Tm7GGjSqQPcXfrK5wCfQP8F
rRjp5UCD+ihkipXZf6zsq3A=
=7ES1
-----END PGP SIGNATURE-----

--Signature=_Thu__28_Oct_2004_18_23_58_+1000_Bj8qKu/nYBkKIm0y--
