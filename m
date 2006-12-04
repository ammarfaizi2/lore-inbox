Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760204AbWLDBwA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760204AbWLDBwA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 20:52:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760205AbWLDBwA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 20:52:00 -0500
Received: from mo31.po.2iij.net ([210.128.50.54]:289 "EHLO mo31.po.2iij.net")
	by vger.kernel.org with ESMTP id S1760204AbWLDBv7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 20:51:59 -0500
Date: Mon, 4 Dec 2006 10:51:14 +0900
From: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To: drzeus-mmc@drzeus.cx
Cc: yoichi_yuasa@tripeaks.co.jp,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] mmc: fix au1xmmc build error
Message-Id: <20061204105114.475f74a4.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch has fixed the following build error abou au1xmmc.

drivers/mmc/au1xmmc.c: In function `au1xmmc_poll_event':
drivers/mmc/au1xmmc.c:835: warning: unused variable `status'
drivers/mmc/au1xmmc.c: At top level:
drivers/mmc/au1xmmc.c:878: error: parse error before "const"
drivers/mmc/au1xmmc.c: In function `au1xmmc_probe':
drivers/mmc/au1xmmc.c:909: error: `au1xmmc_ops' undeclared (first use in this function)
drivers/mmc/au1xmmc.c:909: error: (Each undeclared identifier is reported only once
drivers/mmc/au1xmmc.c:909: error: for each function it appears in.)
drivers/mmc/au1xmmc.c: At top level:
drivers/mmc/au1xmmc.c:659: warning: 'au1xmmc_request' defined but not used
drivers/mmc/au1xmmc.c:719: warning: 'au1xmmc_set_ios' defined but not used
make[2]: *** [drivers/mmc/au1xmmc.o] Error 1
make[1]: *** [drivers/mmc] Error 2
make: *** [drivers] Error 2

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X linux-2.6.19-rc6-mm2/Documentation/dontdiff linux-2.6.19-rc6-mm2-orig/drivers/mmc/au1xmmc.c linux-2.6.19-rc6-mm2/drivers/mmc/au1xmmc.c
--- linux-2.6.19-rc6-mm2-orig/drivers/mmc/au1xmmc.c	2006-11-29 10:11:46.026275500 +0900
+++ linux-2.6.19-rc6-mm2/drivers/mmc/au1xmmc.c	2006-11-29 13:46:27.293077250 +0900
@@ -875,7 +875,7 @@ static void au1xmmc_init_dma(struct au1x
 	host->rx_chan = rxchan;
 }
 
-struct const mmc_host_ops au1xmmc_ops = {
+static const struct mmc_host_ops au1xmmc_ops = {
 	.request	= au1xmmc_request,
 	.set_ios	= au1xmmc_set_ios,
 };
