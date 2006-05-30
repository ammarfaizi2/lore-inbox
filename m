Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932367AbWE3TMK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932367AbWE3TMK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 15:12:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932427AbWE3TMK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 15:12:10 -0400
Received: from wr-out-0506.google.com ([64.233.184.233]:13321 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932367AbWE3TMJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 15:12:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=LwtyOLcDBglgPIKI9LggJcrXQHJHVB5uRYfuYHlKpHqi77i9cipyglPWLkemJ+MCmwYOUNqSWcBrQymR5UT5vSMJVKEbBGWa7aoL9XCB87J4ea7piw0TFkZgDvv0Az7YHlFLz6UwKsAHq49NPFbT80r+tb8j9srNI7kH0u4Ttas=
Message-ID: <447C98FA.7030903@gmail.com>
Date: Tue, 30 May 2006 15:11:54 -0400
From: Florin Malita <fmalita@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: [PATCH] nmclan_cs: dereferencing skb after netif_rx()
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The skb may be gone after netif_rx(), we can't use 'skb->len' to update
the stats. 'pkt_len' should work instead.

Coverity CID: 911.

Signed-off-by: Florin Malita <fmalita@gmail.com>
---

diff --git a/drivers/net/pcmcia/nmclan_cs.c b/drivers/net/pcmcia/nmclan_cs.c
index 4260c21..a8f6bfc 100644
--- a/drivers/net/pcmcia/nmclan_cs.c
+++ b/drivers/net/pcmcia/nmclan_cs.c
@@ -1204,7 +1204,7 @@ static int mace_rx(struct net_device *de
 
 	dev->last_rx = jiffies;
 	lp->linux_stats.rx_packets++;
-	lp->linux_stats.rx_bytes += skb->len;
+	lp->linux_stats.rx_bytes += pkt_len;
 	outb(0xFF, ioaddr + AM2150_RCV_NEXT); /* skip to next frame */
 	continue;
       } else {



