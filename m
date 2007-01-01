Return-Path: <linux-kernel-owner+w=401wt.eu-S932685AbXABAPb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932685AbXABAPb (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 19:15:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754803AbXABAPb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 19:15:31 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:2575 "EHLO
	tuxland.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754800AbXABAPa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 19:15:30 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
To: hadi@cyberus.ca
Subject: [PATCH] net: ifb error path loop fix
Date: Tue, 2 Jan 2007 00:55:51 +0100
User-Agent: KMail/1.9.5
Cc: netdev@vger.kernel.org, jeff@garzik.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701020055.51805.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	On error we should start freeing resources at [i-1] not [i-2].

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

 drivers/net/ifb.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff -upr linux-2.6.20-rc2-mm1-a/drivers/net/ifb.c linux-2.6.20-rc2-mm1-b/drivers/net/ifb.c
--- linux-2.6.20-rc2-mm1-a/drivers/net/ifb.c	2006-12-24 05:00:32.000000000 +0100
+++ linux-2.6.20-rc2-mm1-b/drivers/net/ifb.c	2007-01-02 00:25:34.000000000 +0100
@@ -271,8 +271,7 @@ static int __init ifb_init_module(void)
 	for (i = 0; i < numifbs && !err; i++)
 		err = ifb_init_one(i);
 	if (err) {
-		i--;
-		while (--i >= 0)
+		while (i--)
 			ifb_free_one(i);
 	}
 


-- 
Regards,

	Mariusz Kozlowski
