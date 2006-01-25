Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750890AbWAYAXp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750890AbWAYAXp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 19:23:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750889AbWAYAXp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 19:23:45 -0500
Received: from uproxy.gmail.com ([66.249.92.199]:8361 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750883AbWAYAXo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 19:23:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=ZuULIN0mdS/4OpdPCj0cGOpZPyskSKEnuIFVtDCAjIvtA1d0Hh1/2Fya6raYLzG92rfBO4Qt+IaFt8+tCmCTVjLb5UPDCNHxNGB08I8Blo0U4IwljvgmCXIRUBGzESjClUklpTZoQCfb9uMqBLxbA+S5Na5NFS1rCeGp3GNXVLU=
Date: Wed, 25 Jan 2006 03:41:27 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, romieu@cogenit.fr
Subject: [PATCH] dscc4: fix dscc4_init_dummy_skb check
Message-ID: <20060125004127.GB3234@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It returns a pointer.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 drivers/net/wan/dscc4.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/wan/dscc4.c
+++ b/drivers/net/wan/dscc4.c
@@ -1943,7 +1943,7 @@ static int dscc4_init_ring(struct net_de
 					(++i%TX_RING_SIZE)*sizeof(*tx_fd));
 	} while (i < TX_RING_SIZE);
 
-	if (dscc4_init_dummy_skb(dpriv) < 0)
+	if (!dscc4_init_dummy_skb(dpriv))
 		goto err_free_dma_tx;
 
 	memset(dpriv->rx_skbuff, 0, sizeof(struct sk_buff *)*RX_RING_SIZE);

