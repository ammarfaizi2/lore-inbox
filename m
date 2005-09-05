Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932181AbVIECOL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932181AbVIECOL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 22:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932182AbVIECOL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 22:14:11 -0400
Received: from wproxy.gmail.com ([64.233.184.202]:55233 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932181AbVIECOL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 22:14:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:to:cc:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=G1h/8U27wpWmRJiMonvx+h8ZUafCq2u+ykYsW02XP9jJjJwl8GExwP+6NrYyyx4KUhCUX/0mHBIHCq3pkStTZlPyTdcghE9iUfUYmzTmPNHYs0UGauIJBdOLF5XsqOVfwumhT6+Yx/KayvVlXkSTl5+NzxFyX+9yq4w3AwA8QLY=
Subject: [PATCH] ipw2200: Missing kmalloc check
From: Panagiotis Issaris <panagiotis.issaris@gmail.com>
To: ipw2100-admin@linux.intel.com
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Mon, 05 Sep 2005 04:14:10 +0200
Message-Id: <1125886450.4017.14.camel@nyx>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The ipw2200 driver code in current GIT contains a kmalloc() followed by
a memset() without handling a possible memory allocation failure.

Signed-off-by: Panagiotis Issaris <panagiotis.issaris@gmail.com>
---

 drivers/net/wireless/ipw2200.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

8e288419b49346fee512739acac446c951727d04
diff --git a/drivers/net/wireless/ipw2200.c
b/drivers/net/wireless/ipw2200.c
--- a/drivers/net/wireless/ipw2200.c
+++ b/drivers/net/wireless/ipw2200.c
@@ -3976,6 +3976,10 @@ static struct ipw_rx_queue *ipw_rx_queue
 	int i;
 
 	rxq = (struct ipw_rx_queue *)kmalloc(sizeof(*rxq), GFP_KERNEL);
+	if (unlikely(!rxq)) {
+		IPW_ERROR("memory allocation failed\n");
+		return NULL;
+	}
 	memset(rxq, 0, sizeof(*rxq));
 	spin_lock_init(&rxq->lock);
 	INIT_LIST_HEAD(&rxq->rx_free);


