Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264404AbUFGKnj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264404AbUFGKnj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 06:43:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264411AbUFGKni
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 06:43:38 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:51212 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S264404AbUFGKnf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 06:43:35 -0400
Date: Mon, 7 Jun 2004 20:43:18 +1000
To: David Woodhouse <dwmw2@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [MTD] Tone down overly noisy JEDEC probing
Message-ID: <20040607104318.GA18030@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Nq2Wo0NMKNjxTN9z"
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi:

If you have a look at

http://bugs.debian.org/cgi-bin/bugreport.cgi/dmesg.dump?bug=250093&msg=3&att=2

you'll see that JEDEC probing is way too noisy.  Since that module
is now being loaded automatically by hotplug, it should probably
be toned down.

The following patch turns the printk's into DEBUG calls.  Please let
me know if you've got any problems with that.

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p

===== drivers/mtd/chips/gen_probe.c 1.4 vs edited =====
--- 1.4/drivers/mtd/chips/gen_probe.c	2003-09-30 10:25:16 +10:00
+++ edited/drivers/mtd/chips/gen_probe.c	2004-06-07 20:30:46 +10:00
@@ -65,8 +65,9 @@
 	   interleave and device type, etc. */
 	if (!genprobe_new_chip(map, cp, &cfi)) {
 		/* The probe didn't like it */
-		printk(KERN_WARNING "%s: Found no %s device at location zero\n",
-		       cp->name, map->name);
+		DEBUG(MTD_DEBUG_LEVEL3,
+		      "MTD %s(): %s: Found no %s device at location zero\n",
+		      __func__, cp->name, map->name);
 		return NULL;
 	}		
 
===== drivers/mtd/chips/jedec_probe.c 1.11 vs edited =====
--- 1.11/drivers/mtd/chips/jedec_probe.c	2004-06-05 18:14:08 +10:00
+++ edited/drivers/mtd/chips/jedec_probe.c	2004-06-07 20:42:08 +10:00
@@ -1668,8 +1668,10 @@
 		
 		cfi->mfr = jedec_read_mfr(map, base, cfi);
 		cfi->id = jedec_read_id(map, base, cfi);
-		printk(KERN_INFO "Search for id:(%02x %02x) interleave(%d) type(%d)\n", 
-			cfi->mfr, cfi->id, cfi->interleave, cfi->device_type);
+		DEBUG(MTD_DEBUG_LEVEL3,
+		      "MTD %s(): Search for id:(%02x %02x) interleave(%d) type(%d)\n", 
+		      __func__, cfi->mfr, cfi->id, cfi->interleave,
+		      cfi->device_type);
 		for (i=0; i<sizeof(jedec_table)/sizeof(jedec_table[0]); i++) {
 			if ( jedec_match( base, map, cfi, &jedec_table[i] ) ) {
 				DEBUG( MTD_DEBUG_LEVEL3,

--Nq2Wo0NMKNjxTN9z--
