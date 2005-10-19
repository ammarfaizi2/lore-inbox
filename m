Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932440AbVJSBgI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932440AbVJSBgI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 21:36:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932441AbVJSBdi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 21:33:38 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:33043 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S932439AbVJSBdQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 21:33:16 -0400
Date: Tue, 18 Oct 2005 21:30:58 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: jgarzik@pobox.com, proski@gnu.org, hermes@gibson.dropbear.id.au,
       orinoco-devel@lists.sourceforge.net
Subject: [patch 2.6.14-rc4] orinoco: remove redundance skb length check before padding
Message-ID: <10182005213058.12015@bilbo.tuxdriver.com>
User-Agent: PatchPost/0.5
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Checking the skb->len value before calling skb_padto is redundant.

Signed-off-by: John W. Linville <linville@tuxdriver.com>
---

 drivers/net/wireless/orinoco.c |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/orinoco.c b/drivers/net/wireless/orinoco.c
--- a/drivers/net/wireless/orinoco.c
+++ b/drivers/net/wireless/orinoco.c
@@ -505,11 +505,9 @@ static int orinoco_xmit(struct sk_buff *
 
 	/* Check packet length, pad short packets, round up odd length */
 	len = max_t(int, ALIGN(skb->len, 2), ETH_ZLEN);
-	if (skb->len < len) {
-		skb = skb_padto(skb, len);
-		if (skb == NULL)
-			goto fail;
-	}
+	skb = skb_padto(skb, len);
+	if (skb == NULL)
+		goto fail;
 	len -= ETH_HLEN;
 
 	eh = (struct ethhdr *)skb->data;
