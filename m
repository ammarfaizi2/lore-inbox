Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757422AbWK2AMq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757422AbWK2AMq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 19:12:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757425AbWK2AMq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 19:12:46 -0500
Received: from smtp.osdl.org ([65.172.181.25]:9940 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1757422AbWK2AMp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 19:12:45 -0500
Date: Tue, 28 Nov 2006 16:09:02 -0800
From: Andrew Morton <akpm@osdl.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Adrian Bunk <bunk@stusta.de>, linux-mtd@lists.infradead.org,
       linux-kernel@vger.kernel.org, Akinobu Mita <akinobu.mita@gmail.com>
Subject: Re: [-mm patch] drivers/mtd/nand/rtc_from4.c: use lib/bitrev.c
Message-Id: <20061128160902.915fe8da.akpm@osdl.org>
In-Reply-To: <1164754336.14595.29.camel@pmac.infradead.org>
References: <20061114014125.dd315fff.akpm@osdl.org>
	<20061122043811.GG5200@stusta.de>
	<1164752376.14595.22.camel@pmac.infradead.org>
	<20061128144907.a9f4bb21.akpm@osdl.org>
	<1164754336.14595.29.camel@pmac.infradead.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Nov 2006 22:52:16 +0000
David Woodhouse <dwmw2@infradead.org> wrote:

> > I'll take that as an ack and shall merge this once
> > crc32-replace-bitreverse-by-bitrev32.patch is merged ;)
> 
> I assume the bitrev thing will be going in as soon as 2.6.19 is actually
> released,

It will take over a week after 2.6.19 - I prefer to wait until the git tree
laggards^Wowners have merged before merging -mm stuff, so things land in
appropriate order.

> so there's no point in me reverting it from the mtd tree?

Your call.

I do have a fixlet against this patch:

--- a/drivers/mtd/nand/rtc_from4.c~drivers-mtd-nand-rtc_from4c-use-lib-bitrevc-tidy
+++ a/drivers/mtd/nand/rtc_from4.c
@@ -357,7 +357,7 @@ static int rtc_from4_correct_data(struct
 	/* Read the syndrom pattern from the FPGA and correct the bitorder */
 	rs_ecc = (volatile unsigned short *)(rtc_from4_fio_base + RTC_FROM4_RS_ECC);
 	for (i = 0; i < 8; i++) {
-		ecc[i] = byte_rev_table[(*rs_ecc) & 0xFF];
+		ecc[i] = bitrev8(*rs_ecc);
 		rs_ecc++;
 	}
 
_


