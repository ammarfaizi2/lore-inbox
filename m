Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264922AbUFHKGC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264922AbUFHKGC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 06:06:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262361AbUFHKGC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 06:06:02 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:28432 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S264922AbUFHKFq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 06:05:46 -0400
Date: Tue, 8 Jun 2004 20:05:30 +1000
To: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Vincent Sanders <vince@kyllikki.org>
Subject: [VGA16FB] Fix bogus mem_start value
Message-ID: <20040608100530.GA26292@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="HcAYCG3uE/tztfnV"
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Andrew:

The recent change to vga16fb's memory mapping that you partially
reverted is still broken.  In particular, it's setting fix.mem_start
to a virtual address on i386.  The value of fix.mem_start is meant
to be physical.

We could simply apply virt_to_phys to it, but somehow I doubt that
is what it's meant to do on arm.  So until we hear from someone who
knows how it works on arm, let's just revert this change.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p

===== drivers/video/vga16fb.c 1.38 vs edited =====
--- 1.38/drivers/video/vga16fb.c	2004-05-22 18:18:20 +10:00
+++ edited/drivers/video/vga16fb.c	2004-06-08 19:57:40 +10:00
@@ -1372,8 +1372,6 @@
 	vga16fb.par = &vga16_par;
 	vga16fb.flags = FBINFO_FLAG_DEFAULT;
 
-	vga16fb.fix.smem_start	= VGA_MAP_MEM(vga16fb.fix.smem_start);
-
 	i = (vga16fb_defined.bits_per_pixel == 8) ? 256 : 16;
 	ret = fb_alloc_cmap(&vga16fb.cmap, i, 0);
 	if (ret) {

--HcAYCG3uE/tztfnV--
