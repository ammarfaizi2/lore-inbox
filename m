Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756958AbWK0FKF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756958AbWK0FKF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 00:10:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756989AbWK0FKF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 00:10:05 -0500
Received: from nz-out-0102.google.com ([64.233.162.205]:64994 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1756958AbWK0FKD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 00:10:03 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:mime-version:content-type:content-disposition:user-agent;
        b=YrFO6vYIwlvOlPogadkxQLYh7VN6yruvl31ZBG4j7HOw8s8Bi+lR7E7PSbTJVXzeG36MjF/NufF9gY0s+VccsX6QtTR/DX9vWWgwoermluum6bawj30JprN50o14u1wm6QTtrYoPl5bJ3gvYa7PzBKpy7xM8FHV8te6mQk7FGS4=
Date: Mon, 27 Nov 2006 14:02:54 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Dmitry Yusupov <dmitry_yus@yahoo.com>, Alex Aizman <itn780@yahoo.com>
Subject: [PATCH] iscsi: fix crypto_alloc_hash() error check
Message-ID: <20061127050254.GF1231@APFDCB5C>
Mail-Followup-To: Akinobu Mita <akinobu.mita@gmail.com>,
	linux-kernel@vger.kernel.org, Dmitry Yusupov <dmitry_yus@yahoo.com>,
	Alex Aizman <itn780@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The return value of crypto_alloc_hash() should be checked by
IS_ERR().

Cc: Dmitry Yusupov <dmitry_yus@yahoo.com>
Cc: Alex Aizman <itn780@yahoo.com>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

---
 drivers/scsi/iscsi_tcp.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: work-fault-inject/drivers/scsi/iscsi_tcp.c
===================================================================
--- work-fault-inject.orig/drivers/scsi/iscsi_tcp.c
+++ work-fault-inject/drivers/scsi/iscsi_tcp.c
@@ -1777,13 +1777,13 @@ iscsi_tcp_conn_create(struct iscsi_cls_s
 	tcp_conn->tx_hash.tfm = crypto_alloc_hash("crc32c", 0,
 						  CRYPTO_ALG_ASYNC);
 	tcp_conn->tx_hash.flags = 0;
-	if (!tcp_conn->tx_hash.tfm)
+	if (IS_ERR(tcp_conn->tx_hash.tfm))
 		goto free_tcp_conn;
 
 	tcp_conn->rx_hash.tfm = crypto_alloc_hash("crc32c", 0,
 						  CRYPTO_ALG_ASYNC);
 	tcp_conn->rx_hash.flags = 0;
-	if (!tcp_conn->rx_hash.tfm)
+	if (IS_ERR(tcp_conn->rx_hash.tfm))
 		goto free_tx_tfm;
 
 	return cls_conn;
