Return-Path: <linux-kernel-owner+w=401wt.eu-S932339AbWLLTMF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932339AbWLLTMF (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 14:12:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932341AbWLLTMF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 14:12:05 -0500
Received: from nz-out-0506.google.com ([64.233.162.224]:35166 "EHLO
	nz-out-0102.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932339AbWLLTMD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 14:12:03 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:to:cc:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=omzhHwUMIsM5/PBYjK/D6iFLTM7TstjxHMwksIZKbZSuM9lg9Yj2t3ftDtCy+2W3I/PdfSVeUl7nkc/8OYC0h+ScnYHuce1YTg2MnS7vZH5qCw+ofv31QHLxhkGZ0KbGO6zjnQkdhHL6iXCnCYp5NVEfvv4Qc2XQJ0R/942jDPo=
Subject: [PATCH 2.6.19] tg3: replace kmalloc+memset with kzalloc
From: Yan Burman <burman.yan@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: trivial@kernel.org, mchan@broadcom.com
Content-Type: text/plain
Date: Tue, 12 Dec 2006 21:10:54 +0200
Message-Id: <1165950654.10231.5.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 (2.6.0-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace kmalloc+memset with kzalloc

Signed-off-by: Yan Burman <burman.yan@gmail.com>

diff -rubp linux-2.6.19-rc5_orig/drivers/net/tg3.c linux-2.6.19-rc5_kzalloc/drivers/net/tg3.c
--- linux-2.6.19-rc5_orig/drivers/net/tg3.c	2006-11-09 12:16:21.000000000 +0200
+++ linux-2.6.19-rc5_kzalloc/drivers/net/tg3.c	2006-11-11 22:44:18.000000000 +0200
@@ -4416,7 +4416,7 @@ static void tg3_free_consistent(struct t
  */
 static int tg3_alloc_consistent(struct tg3 *tp)
 {
-	tp->rx_std_buffers = kmalloc((sizeof(struct ring_info) *
+	tp->rx_std_buffers = kzalloc((sizeof(struct ring_info) *
 				      (TG3_RX_RING_SIZE +
 				       TG3_RX_JUMBO_RING_SIZE)) +
 				     (sizeof(struct tx_ring_info) *
@@ -4425,13 +4425,6 @@ static int tg3_alloc_consistent(struct t
 	if (!tp->rx_std_buffers)
 		return -ENOMEM;
 
-	memset(tp->rx_std_buffers, 0,
-	       (sizeof(struct ring_info) *
-		(TG3_RX_RING_SIZE +
-		 TG3_RX_JUMBO_RING_SIZE)) +
-	       (sizeof(struct tx_ring_info) *
-		TG3_TX_RING_SIZE));
-
 	tp->rx_jumbo_buffers = &tp->rx_std_buffers[TG3_RX_RING_SIZE];
 	tp->tx_buffers = (struct tx_ring_info *)
 		&tp->rx_jumbo_buffers[TG3_RX_JUMBO_RING_SIZE];




