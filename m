Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266048AbUIIP53@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266048AbUIIP53 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 11:57:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265930AbUIIPyb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 11:54:31 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:64644
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S266128AbUIIPuO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 11:50:14 -0400
Date: Thu, 9 Sep 2004 08:49:51 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Herbert Poetzl <herbert@13thfloor.at>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc1-bk16: DHCPACK, compile time error ...
Message-Id: <20040909084951.41ef2288.davem@davemloft.net>
In-Reply-To: <20040909141403.GD14891@MAIL.13thfloor.at>
References: <20040909141403.GD14891@MAIL.13thfloor.at>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Sep 2004 16:14:04 +0200
Herbert Poetzl <herbert@13thfloor.at> wrote:

> net/ipv4/ipconfig.c:969: error: `i' undeclared (first use in this function)
> net/ipv4/ipconfig.c:969: error: (Each undeclared identifier is reported only once
> net/ipv4/ipconfig.c:969: error: for each function it appears in.)

Already fixed in my tree like so, on it's way to Linus:

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/09/08 17:38:20-07:00 peter@pantasys.com 
#   [IPV4]: Fix DHCPACK checking in ipconfig.c
#   
#   Signed-off-by: Peter Buckingham <peter@pantasys.com>
#   Signed-off-by: David S. Miller <davem@davemloft.net>
# 
# net/ipv4/ipconfig.c
#   2004/09/08 17:37:44-07:00 peter@pantasys.com +1 -3
#   [IPV4]: Fix DHCPACK checking in ipconfig.c
# 
diff -Nru a/net/ipv4/ipconfig.c b/net/ipv4/ipconfig.c
--- a/net/ipv4/ipconfig.c	2004-09-09 08:31:35 -07:00
+++ b/net/ipv4/ipconfig.c	2004-09-09 08:31:35 -07:00
@@ -966,9 +966,7 @@
 				break;
 
 			case DHCPACK:
-				for (i = 0; (dev->dev_addr[i] == b->hw_addr[i])
-						&& (i < dev->addr_len); i++);
-				if (i < dev->addr_len)
+				if (memcmp(dev->dev_addr, b->hw_addr, dev->addr_len) != 0)
 					goto drop_unlock;
 
 				/* Yeah! */
