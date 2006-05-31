Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751650AbWEaEHb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751650AbWEaEHb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 00:07:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751651AbWEaEHb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 00:07:31 -0400
Received: from wr-out-0506.google.com ([64.233.184.231]:14772 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751649AbWEaEHa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 00:07:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=FLQlv2H0ciOWmZRUtdmnjRKE97jM9QjyRiedG5jDW8LgKH68Umqf7gin0zoDYc6KrfPsWuZGkAPAtwhsstbjYyVtjuMFQwndVS/62TRCzm1E6e5HlQXrU+H2sFe8GvIzOmtHYCEDpj+ocCAWvJgU5XtsRMVRv1wvr2rv5fuI6TY=
Message-ID: <447D17B8.8020106@gmail.com>
Date: Wed, 31 May 2006 00:12:40 -0400
From: Florin Malita <fmalita@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: mostrows@speakeasy.net
CC: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [PATCH] pppoe: missing result check in __pppoe_xmit()
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

skb_clone() may fail, we should check the result.

Coverity CID: 1215.

Signed-off-by: Florin Malita <fmalita@gmail.com>
---

diff --git a/drivers/net/pppoe.c b/drivers/net/pppoe.c
index 475dc93..0d101a1 100644
--- a/drivers/net/pppoe.c
+++ b/drivers/net/pppoe.c
@@ -861,6 +861,9 @@ static int __pppoe_xmit(struct sock *sk,
 		 * give dev_queue_xmit something it can free.
 		 */
 		skb2 = skb_clone(skb, GFP_ATOMIC);
+
+		if (skb2 == NULL)
+			goto abort;
 	}
 
 	ph = (struct pppoe_hdr *) skb_push(skb2, sizeof(struct pppoe_hdr));


