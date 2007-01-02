Return-Path: <linux-kernel-owner+w=401wt.eu-S964810AbXABMPk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964810AbXABMPk (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 07:15:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964823AbXABMPk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 07:15:40 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:1905 "EHLO
	tuxland.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964810AbXABMPj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 07:15:39 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
To: kai.germaschewski@gmx.de
Subject: [PATCH] isdn: capi kfree_skb cleanup
Date: Tue, 2 Jan 2007 13:17:01 +0100
User-Agent: KMail/1.9.5
Cc: isdn4linux@listserv.isdn4linux.de, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701021317.01606.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	This patch removes redundant argument check for kfree_skb().

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

 drivers/isdn/capi/capi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -upr linux-2.6.20-rc2-mm1-a/drivers/isdn/capi/capi.c linux-2.6.20-rc2-mm1-b/drivers/isdn/capi/capi.c
--- linux-2.6.20-rc2-mm1-a/drivers/isdn/capi/capi.c	2006-12-24 05:00:32.000000000 +0100
+++ linux-2.6.20-rc2-mm1-b/drivers/isdn/capi/capi.c	2007-01-02 01:47:41.000000000 +0100
@@ -267,7 +267,7 @@ static void capiminor_free(struct capimi
 	list_del(&mp->list);
 	write_unlock_irqrestore(&capiminor_list_lock, flags);
 
-	if (mp->ttyskb) kfree_skb(mp->ttyskb);
+	kfree_skb(mp->ttyskb);
 	mp->ttyskb = NULL;
 	skb_queue_purge(&mp->inqueue);
 	skb_queue_purge(&mp->outqueue);


-- 
Regards,

	Mariusz Kozlowski
