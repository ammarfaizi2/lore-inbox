Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964949AbVKGUfV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964949AbVKGUfV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 15:35:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965082AbVKGUfV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 15:35:21 -0500
Received: from nproxy.gmail.com ([64.233.182.199]:27340 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964949AbVKGUfU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 15:35:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=B942E4pCzlf2PspcPOz+FBfe92R1qsfvbR0Jkm2pSVhzngwtcSfH57OudNXhMoaVyYMtLKewK1gUdgxs5EjbjZOzbcxHMNRUlivjCSK0dae/L6zqA5lV5AgZMohGiwaoee94C4FKE98EfPS6JbjhdQ1vVWwMubD4MqHUunrOzg4=
Message-ID: <df33fe7c0511071235u3d59d13ci@mail.gmail.com>
Date: Mon, 7 Nov 2005 21:35:18 +0100
From: Takis <panagiotis.issaris@gmail.com>
Reply-To: takis@issaris.org
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
Subject: Re: [PATCH] ipw2200: Missing kmalloc check
Cc: ipw2100-admin@linux.intel.com, linux-kernel@vger.kernel.org
In-Reply-To: <200511071932.22060@bilbo.math.uni-mannheim.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1125886450.4017.14.camel@nyx>
	 <200511071932.22060@bilbo.math.uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- Use kzalloc for IPW2200
- Fix config dependency for IPW2200

Signed-off-by: Panagiotis Issaris <takis@issaris.org>

---

 drivers/net/wireless/Kconfig   |    2 +-
 drivers/net/wireless/ipw2200.c |    3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

applies-to: b3efbcb770e1202b65aee2fe70ea5a407a60e6a5
7e0cb9f1c4a239d06a0013997fc987c77fa46516
diff --git a/drivers/net/wireless/Kconfig b/drivers/net/wireless/Kconfig
index 7187958..3cf1ae2 100644
--- a/drivers/net/wireless/Kconfig
+++ b/drivers/net/wireless/Kconfig
@@ -192,7 +192,7 @@ config IPW_DEBUG

 config IPW2200
        tristate "Intel PRO/Wireless 2200BG and 2915ABG Network Connection"
-       depends on IEEE80211 && PCI
+       depends on NET_RADIO && IEEE80211 && PCI
        select FW_LOADER
        ---help---
           A driver for the Intel PRO/Wireless 2200BG and 2915ABG Network
diff --git a/drivers/net/wireless/ipw2200.c b/drivers/net/wireless/ipw2200.c
index 3db0c32..6da11b5 100644
--- a/drivers/net/wireless/ipw2200.c
+++ b/drivers/net/wireless/ipw2200.c
@@ -4029,12 +4029,11 @@ static struct ipw_rx_queue *ipw_rx_queue
        struct ipw_rx_queue *rxq;
        int i;

-       rxq = (struct ipw_rx_queue *)kmalloc(sizeof(*rxq), GFP_KERNEL);
+       rxq = kzalloc(sizeof(*rxq), GFP_KERNEL);
        if (unlikely(!rxq)) {
                IPW_ERROR("memory allocation failed\n");
                return NULL;
        }
-       memset(rxq, 0, sizeof(*rxq));
        spin_lock_init(&rxq->lock);
        INIT_LIST_HEAD(&rxq->rx_free);
        INIT_LIST_HEAD(&rxq->rx_used);
---
0.99.9.GIT
