Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263637AbTHJLMh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 07:12:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263597AbTHJLK7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 07:10:59 -0400
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:37900 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id S263637AbTHJLKC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 07:10:02 -0400
Date: Sun, 10 Aug 2003 20:10:11 +0900 (JST)
Message-Id: <20030810.201011.34756119.yoshfuji@linux-ipv6.org>
To: davem@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 8/9] convert drivers/usb to virt_to_pageoff()
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

[8/9] convert drivers/usb to virt_to_pageoff().

Index: linux-2.6/drivers/usb/misc/usbtest.c
===================================================================
RCS file: /home/cvs/linux-2.5/drivers/usb/misc/usbtest.c,v
retrieving revision 1.19
diff -u -r1.19 usbtest.c
--- linux-2.6/drivers/usb/misc/usbtest.c	1 Aug 2003 18:12:47 -0000	1.19
+++ linux-2.6/drivers/usb/misc/usbtest.c	10 Aug 2003 08:40:53 -0000
@@ -271,7 +271,7 @@
 
 		/* kmalloc pages are always physically contiguous! */
 		sg [i].page = virt_to_page (buf);
-		sg [i].offset = ((unsigned) buf) & ~PAGE_MASK;
+		sg [i].offset = virt_to_pageoff (buf);
 		sg [i].length = size;
 
 		if (vary) {
Index: linux-2.6/drivers/usb/storage/sddr09.c
===================================================================
RCS file: /home/cvs/linux-2.5/drivers/usb/storage/sddr09.c,v
retrieving revision 1.23
diff -u -r1.23 sddr09.c
--- linux-2.6/drivers/usb/storage/sddr09.c	17 Jul 2003 22:58:33 -0000	1.23
+++ linux-2.6/drivers/usb/storage/sddr09.c	10 Aug 2003 08:40:54 -0000
@@ -1127,7 +1127,7 @@
 		char *vaddr = kmalloc(alloc_req, GFP_NOIO);
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,3)
 		sg[i].page = virt_to_page(vaddr);
-		sg[i].offset = ((unsigned long)vaddr & ~PAGE_MASK);
+		sg[i].offset = virt_to_pageoff(vaddr);
 #else
 		sg[i].address = vaddr;
 #endif

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
