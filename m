Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030382AbWJJVFJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030382AbWJJVFJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 17:05:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030389AbWJJVFI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 17:05:08 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:11186 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030362AbWJJVFG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 17:05:06 -0400
Date: Tue, 10 Oct 2006 16:05:00 -0500
To: akpm@osdl.org
Cc: jeff@garzik.org, Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org,
       James K Lewis <jklewis@us.ibm.com>, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org
Subject: [PATCH 9/21]: powerpc/cell spidernet bogus rx interrupt bit
Message-ID: <20061010210459.GF4381@austin.ibm.com>
References: <20061010204946.GW4381@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061010204946.GW4381@austin.ibm.com>
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The current receive interrupt mask sets a bogus bit that doesn't even
belong to the definition of this register. Remove it.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Cc: James K Lewis <jklewis@us.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>

----
 drivers/net/spider_net.h |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

Index: linux-2.6.18-mm2/drivers/net/spider_net.h
===================================================================
--- linux-2.6.18-mm2.orig/drivers/net/spider_net.h	2006-10-10 12:51:26.000000000 -0500
+++ linux-2.6.18-mm2/drivers/net/spider_net.h	2006-10-10 12:54:06.000000000 -0500
@@ -332,9 +332,8 @@ enum spider_net_int2_status {
 				  (1 << SPIDER_NET_GDTDCEINT) | \
 				  (1 << SPIDER_NET_GDTFDCINT) )
 
-/* we rely on flagged descriptor interrupts*/
-#define SPIDER_NET_RXINT	( (1 << SPIDER_NET_GDAFDCINT) | \
-				  (1 << SPIDER_NET_GRMFLLINT) )
+/* We rely on flagged descriptor interrupts */
+#define SPIDER_NET_RXINT	( (1 << SPIDER_NET_GDAFDCINT) )
 
 #define SPIDER_NET_ERRINT	( 0xffffffff & \
 				  (~SPIDER_NET_TXINT) & \
