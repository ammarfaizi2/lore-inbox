Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263355AbTHJLJz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 07:09:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263590AbTHJLJz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 07:09:55 -0400
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:34060 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id S263355AbTHJLJu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 07:09:50 -0400
Date: Sun, 10 Aug 2003 20:09:58 +0900 (JST)
Message-Id: <20030810.200958.132808552.yoshfuji@linux-ipv6.org>
To: davem@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 5/9] convert drivers/ide to virt_to_pageoff()
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <20030810020444.48cb740b.davem@redhat.com>
References: <20030810013041.679ddc4c.davem@redhat.com>
	<20030810090556.GY31810@waste.org>
	<20030810020444.48cb740b.davem@redhat.com>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 90 22 65 EB 1E CF 3A D1 0B DF 80 D8 48 07 F8 94 E0 62 0E EA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[5/9] convert drivers/ide to virt_to_pageoff().

Index: linux-2.6/drivers/ide/ide-dma.c
===================================================================
RCS file: /home/cvs/linux-2.5/drivers/ide/ide-dma.c,v
retrieving revision 1.60
diff -u -r1.60 ide-dma.c
--- linux-2.6/drivers/ide/ide-dma.c	7 Aug 2003 07:35:12 -0000	1.60
+++ linux-2.6/drivers/ide/ide-dma.c	10 Aug 2003 08:40:52 -0000
@@ -255,7 +255,7 @@
 #endif
 		memset(&sg[nents], 0, sizeof(*sg));
 		sg[nents].page = virt_to_page(virt_addr);
-		sg[nents].offset = (unsigned long) virt_addr & ~PAGE_MASK;
+		sg[nents].offset = virt_to_pageoff(virt_addr);
 		sg[nents].length = 128  * SECTOR_SIZE;
 		nents++;
 		virt_addr = virt_addr + (128 * SECTOR_SIZE);
@@ -263,7 +263,7 @@
 	}
 	memset(&sg[nents], 0, sizeof(*sg));
 	sg[nents].page = virt_to_page(virt_addr);
-	sg[nents].offset = (unsigned long) virt_addr & ~PAGE_MASK;
+	sg[nents].offset = virt_to_pageoff(virt_addr);
 	sg[nents].length =  sector_count  * SECTOR_SIZE;
 	nents++;
 
Index: linux-2.6/drivers/ide/arm/icside.c
===================================================================
RCS file: /home/cvs/linux-2.5/drivers/ide/arm/icside.c,v
retrieving revision 1.8
diff -u -r1.8 icside.c
--- linux-2.6/drivers/ide/arm/icside.c	19 May 2003 17:48:30 -0000	1.8
+++ linux-2.6/drivers/ide/arm/icside.c	10 Aug 2003 08:40:52 -0000
@@ -233,7 +233,7 @@
 
 		memset(sg, 0, sizeof(*sg));
 		sg->page   = virt_to_page(rq->buffer);
-		sg->offset = ((unsigned long)rq->buffer) & ~PAGE_MASK;
+		sg->offset = virt_to_pageoff(rq->buffer);
 		sg->length = rq->nr_sectors * SECTOR_SIZE;
 		nents = 1;
 	} else {
Index: linux-2.6/drivers/ide/ppc/pmac.c
===================================================================
RCS file: /home/cvs/linux-2.5/drivers/ide/ppc/pmac.c,v
retrieving revision 1.13
diff -u -r1.13 pmac.c
--- linux-2.6/drivers/ide/ppc/pmac.c	6 Jul 2003 19:33:43 -0000	1.13
+++ linux-2.6/drivers/ide/ppc/pmac.c	10 Aug 2003 08:40:52 -0000
@@ -971,7 +971,7 @@
 	if (sector_count > 127) {
 		memset(&sg[nents], 0, sizeof(*sg));
 		sg[nents].page = virt_to_page(virt_addr);
-		sg[nents].offset = (unsigned long) virt_addr & ~PAGE_MASK;
+		sg[nents].offset = virt_to_pageoff(virt_addr);
 		sg[nents].length = 127  * SECTOR_SIZE;
 		nents++;
 		virt_addr = virt_addr + (127 * SECTOR_SIZE);
@@ -979,7 +979,7 @@
 	}
 	memset(&sg[nents], 0, sizeof(*sg));
 	sg[nents].page = virt_to_page(virt_addr);
-	sg[nents].offset = (unsigned long) virt_addr & ~PAGE_MASK;
+	sg[nents].offset = virt_to_pageoff(virt_addr);
 	sg[nents].length =  sector_count  * SECTOR_SIZE;
 	nents++;
    

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
