Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262290AbTHJLAl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 07:00:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262321AbTHJLAl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 07:00:41 -0400
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:28428 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id S262290AbTHJLAj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 07:00:39 -0400
Date: Sun, 10 Aug 2003 20:00:47 +0900 (JST)
Message-Id: <20030810.200047.92301620.yoshfuji@linux-ipv6.org>
To: davem@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/9] introduce virt_to_pagoff()
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

In article <20030810020444.48cb740b.davem@redhat.com> (at Sun, 10 Aug 2003 02:04:44 -0700), "David S. Miller" <davem@redhat.com> says:

> Yoshfuji, feel free to do your conversions, and use this
> linux/mm.h placement of the virt_to_pageoff() macro instead
> of having to put it into every asm header.

[1/9] introduce virt_to_pageoff().

Index: linux-2.6/Documentation/DMA-mapping.txt
===================================================================
RCS file: /home/cvs/linux-2.5/Documentation/DMA-mapping.txt,v
retrieving revision 1.17
diff -u -r1.17 DMA-mapping.txt
--- linux-2.6/Documentation/DMA-mapping.txt	1 Aug 2003 19:02:34 -0000	1.17
+++ linux-2.6/Documentation/DMA-mapping.txt	10 Aug 2003 08:40:50 -0000
@@ -689,7 +689,7 @@
 and offset using something like this:
 
 	struct page *page = virt_to_page(ptr);
-	unsigned long offset = ((unsigned long)ptr & ~PAGE_MASK);
+	unsigned long offset = virt_to_pageoff(ptr);
 
 Here are the interfaces:
 
Index: linux-2.6/include/linux/mm.h
===================================================================
RCS file: /home/cvs/linux-2.5/include/linux/mm.h,v
retrieving revision 1.125
diff -u -r1.125 mm.h
--- linux-2.6/include/linux/mm.h	1 Aug 2003 17:02:32 -0000	1.125
+++ linux-2.6/include/linux/mm.h	10 Aug 2003 08:40:55 -0000
@@ -400,6 +400,8 @@
 #define VM_FAULT_MINOR	1
 #define VM_FAULT_MAJOR	2
 
+#define virt_to_pageoff(p)	((unsigned long)(p) & ~PAGE_MASK)
+
 extern void show_free_areas(void);
 
 struct page *shmem_nopage(struct vm_area_struct * vma,


-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
