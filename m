Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275120AbRJJJUB>; Wed, 10 Oct 2001 05:20:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275121AbRJJJTv>; Wed, 10 Oct 2001 05:19:51 -0400
Received: from web20501.mail.yahoo.com ([216.136.226.136]:42763 "HELO
	web20501.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S275120AbRJJJTn>; Wed, 10 Oct 2001 05:19:43 -0400
Message-ID: <20011010092011.50158.qmail@web20501.mail.yahoo.com>
Date: Wed, 10 Oct 2001 11:20:11 +0200 (CEST)
From: =?iso-8859-1?q?willy=20tarreau?= <wtarreau@yahoo.fr>
Subject: Re: Linux 2.4.10-ac10
To: Adrian Bunk <bunk@fs.tum.de>
Cc: linux-kernel@vger.kernel.org, acme@conectiva.com.br
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian,

I think this simple patch should solve your problem.
It may have
been a simple thinko replacing check_region with
request_region.

Cheers,
Willy

--- linux/drivers/sound/ad1816.c        Wed Oct 10
11:15:53 2001
+++ linux/drivers/sound/ad1816.c        Wed Oct 10
11:16:12 2001
@@ -1015,7 +1015,7 @@
               options,
               isa_dma_bridge_buggy);

-       if (request_region(io_base, 16, "AD1816
Sound")) {
+       if (!request_region(io_base, 16, "AD1816
Sound")) {
                printk(KERN_WARNING "ad1816: I/O port
0x%03x not free\n",
                                    io_base);
                goto err;


___________________________________________________________
Un nouveau Nokia Game commence. 
Allez sur http://fr.yahoo.com/nokiagame avant le 3 novembre
pour participer à cette aventure tous médias.
