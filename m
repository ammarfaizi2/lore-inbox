Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266125AbUFILUr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266125AbUFILUr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 07:20:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266126AbUFILUr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 07:20:47 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:3855 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S266125AbUFILUp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 07:20:45 -0400
Date: Wed, 9 Jun 2004 21:20:25 +1000
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: [HPT366] Fix /proc/ide/hpt366 crash
Message-ID: <20040609112024.GC23623@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="6zdv2QT/q3FMhpsV"
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--6zdv2QT/q3FMhpsV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Marcelo:

The following patch which fixes fixes the disk spindown problem when
/proc/ide/hpt366 is read has been in 2.6 for a couple of months.  It
has just been verified that the same fix is needed and works under
2.4 (see http://bugs.debian.org/250171).

So please apply it.

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--6zdv2QT/q3FMhpsV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p

===== drivers/ide/pci/hpt366.c 1.14 vs edited =====
--- 1.14/drivers/ide/pci/hpt366.c	2004-05-01 08:27:08 +10:00
+++ edited/drivers/ide/pci/hpt366.c	2004-06-09 21:20:01 +10:00
@@ -123,7 +123,7 @@
 				"                             %s\n",
 			(c0 & 0x80) ? "no" : "yes",
 			(c1 & 0x80) ? "no" : "yes");
-
+#if 0
 		if (hpt_minimum_revision(dev, 3)) {
 			u8 cbl;
 			cbl = inb(iobase + 0x7b);
@@ -136,7 +136,7 @@
 				(cbl & 0x01) ? 33 : 66);
 			p += sprintf(p, "\n");
 		}
-
+#endif
 		p += sprintf(p, "--------------- drive0 --------- drive1 "
 				"------- drive0 ---------- drive1 -------\n");
 		p += sprintf(p, "DMA capable:    %s              %s" 

--6zdv2QT/q3FMhpsV--
