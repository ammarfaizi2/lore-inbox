Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751296AbWGCUqw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296AbWGCUqw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 16:46:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751293AbWGCUqv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 16:46:51 -0400
Received: from rgminet01.oracle.com ([148.87.113.118]:5812 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1751291AbWGCUq0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 16:46:26 -0400
Message-ID: <44A98283.9020607@oracle.com>
Date: Mon, 03 Jul 2006 13:48:03 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: samuel@sortiz.org, lkml <linux-kernel@vger.kernel.org>
CC: akpm <akpm@osdl.org>, netdev <netdev@vger.kernel.org>
Subject: [Ubuntu PATCH] via-ircc: fix memory leak
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chuck Short <chuck@maggie>

[UBUNTU: via-ircc] Fix memory leak.

Coverity id# 653

patch location:
http://www.kernel.org/git/?p=linux/kernel/git/bcollins/ubuntu-dapper.git;a=commitdiff;h=a1f34cb68b16807ed9d5ebb0f6a6ec5ff8a5fc78

Signed-off-by: Chuck Short <zulcss@gmail.com>
Signed-off-by: Ben Collins <bcollins@ubuntu.com>
---
 drivers/net/irda/via-ircc.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- linux-2617-g21.orig/drivers/net/irda/via-ircc.c
+++ linux-2617-g21/drivers/net/irda/via-ircc.c
@@ -1220,8 +1220,13 @@ static int upload_rxdata(struct via_ircc
 
 	IRDA_DEBUG(2, "%s(): len=%x\n", __FUNCTION__, len);
 
+	if ((len - 4) < 2) {
+		self->stats.rx_dropped++;
+		return FALSE;
+	}
+
 	skb = dev_alloc_skb(len + 1);
-	if ((skb == NULL) || ((len - 4) < 2)) {
+	if (skb == NULL) {
 		self->stats.rx_dropped++;
 		return FALSE;
 	}



