Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263187AbTHJLHo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 07:07:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263355AbTHJLHo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 07:07:44 -0400
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:32780 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id S263187AbTHJLHk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 07:07:40 -0400
Date: Sun, 10 Aug 2003 20:07:41 +0900 (JST)
Message-Id: <20030810.200741.02346150.yoshfuji@linux-ipv6.org>
To: davem@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 4/9] convert drivers/block to virt_to_pageoff()
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

[4/9] convert drivers/block to virt_to_pageoff().

Index: linux-2.6/drivers/block/cryptoloop.c
===================================================================
RCS file: /home/cvs/linux-2.5/drivers/block/cryptoloop.c,v
retrieving revision 1.3
diff -u -r1.3 cryptoloop.c
--- linux-2.6/drivers/block/cryptoloop.c	17 Jul 2003 17:43:53 -0000	1.3
+++ linux-2.6/drivers/block/cryptoloop.c	10 Aug 2003 08:40:52 -0000
@@ -112,11 +112,11 @@
 		iv[0] = cpu_to_le32(IV & 0xffffffff);
 
 		sg_in.page = virt_to_page(in);
-		sg_in.offset = (unsigned long)in & ~PAGE_MASK;
+		sg_in.offset = virt_to_pageoff(in);
 		sg_in.length = sz;
 
 		sg_out.page = virt_to_page(out);
-		sg_out.offset = (unsigned long)out & ~PAGE_MASK;
+		sg_out.offset = virt_to_pageoff(out);
 		sg_out.length = sz;
 
 		encdecfunc(tfm, &sg_out, &sg_in, sz, (u8 *)iv);

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
