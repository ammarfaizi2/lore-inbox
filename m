Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266147AbUBCXni (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 18:43:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266194AbUBCXni
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 18:43:38 -0500
Received: from fw.osdl.org ([65.172.181.6]:51945 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266147AbUBCXng (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 18:43:36 -0500
Date: Tue, 3 Feb 2004 15:33:37 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>
Subject: [PATCH] oss/ad1889: correct printk of dma_addr_t
Message-Id: <20040203153337.5818aa35.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


description:	fix dma_addr_t type error with CONFIG_HIGHMEM64G=y;
product_versions: linux-262-rc3

diffstat:=
 sound/oss/ad1889.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -Naurp ./sound/oss/ad1889.c~dmatype ./sound/oss/ad1889.c
--- ./sound/oss/ad1889.c~dmatype	2004-01-08 22:59:26.000000000 -0800
+++ ./sound/oss/ad1889.c	2004-02-03 14:08:55.000000000 -0800
@@ -354,9 +354,9 @@ int ad1889_read_proc (char *page, char *
 	for (i = 0; i < AD_MAX_STATES; i++) {
 		out += sprintf(out, "DMA status for %s:\n", 
 			(i == AD_WAV_STATE ? "WAV" : "ADC")); 
-		out += sprintf(out, "\t\t0x%p (IOVA: 0x%u)\n", 
+		out += sprintf(out, "\t\t0x%p (IOVA: 0x%llu)\n", 
 			dev->state[i].dmabuf.rawbuf,
-			dev->state[i].dmabuf.dma_handle);
+			(unsigned long long)dev->state[i].dmabuf.dma_handle);
 
 		out += sprintf(out, "\tread ptr: offset %u\n", 
 			(unsigned int)dev->state[i].dmabuf.rd_ptr);



--
~Randy
