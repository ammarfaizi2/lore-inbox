Return-Path: <linux-kernel-owner+w=401wt.eu-S1754825AbXABMqT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754825AbXABMqT (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 07:46:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754807AbXABMqS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 07:46:18 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:3759 "EHLO
	tuxland.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753505AbXABMqP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 07:46:15 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH] net: af_netlink module_put cleanup
Date: Tue, 2 Jan 2007 13:47:37 +0100
User-Agent: KMail/1.9.5
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701021347.37952.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	This patch removes redundant argument check for module_put().

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

 net/netlink/af_netlink.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff -upr linux-2.6.20-rc2-mm1-a/net/netlink/af_netlink.c linux-2.6.20-rc2-mm1-b/net/netlink/af_netlink.c
--- linux-2.6.20-rc2-mm1-a/net/netlink/af_netlink.c	2006-12-24 05:00:32.000000000 +0100
+++ linux-2.6.20-rc2-mm1-b/net/netlink/af_netlink.c	2007-01-02 02:23:02.000000000 +0100
@@ -472,8 +472,7 @@ static int netlink_release(struct socket
 				NETLINK_URELEASE, &n);
 	}	
 
-	if (nlk->module)
-		module_put(nlk->module);
+	module_put(nlk->module);
 
 	netlink_table_grab();
 	if (nlk->flags & NETLINK_KERNEL_SOCKET) {


-- 
Regards,

	Mariusz Kozlowski
