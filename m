Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269073AbUIQWxE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269073AbUIQWxE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 18:53:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269082AbUIQWxD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 18:53:03 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:9174
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S269073AbUIQWwz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 18:52:55 -0400
Date: Fri, 17 Sep 2004 15:49:42 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Bob Gill <gillb4@telusplanet.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.9-rc2-bk] Network-related panic on boot
Message-Id: <20040917154942.39034b0c.davem@davemloft.net>
In-Reply-To: <1095459971.8786.14.camel@localhost.localdomain>
References: <1095459971.8786.14.camel@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Already fixed.  Patch below:

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/09/17 11:11:23-07:00 david@gibson.dropbear.id.au 
#   [IPV4]: Initialize newly allocated hash tables in fib_semantics.c
#   
#   When fib_create_info() allocates new hash tables, it neglects to
#   initialize them.  This leads to an oops during boot on at least
#   machine I use.  This patch addresses the problem.
#   
#   Signed-off-by: David Gibson <dwg@au1.ibm.com>
#   Signed-off-by: David S. Miller <davem@davemloft.net>
# 
# net/ipv4/fib_semantics.c
#   2004/09/17 11:11:04-07:00 david@gibson.dropbear.id.au +5 -1
#   [IPV4]: Initialize newly allocated hash tables in fib_semantics.c
#   
#   When fib_create_info() allocates new hash tables, it neglects to
#   initialize them.  This leads to an oops during boot on at least
#   machine I use.  This patch addresses the problem.
#   
#   Signed-off-by: David Gibson <dwg@au1.ibm.com>
#   Signed-off-by: David S. Miller <davem@davemloft.net>
# 
diff -Nru a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
--- a/net/ipv4/fib_semantics.c	2004-09-17 15:33:41 -07:00
+++ b/net/ipv4/fib_semantics.c	2004-09-17 15:33:41 -07:00
@@ -604,8 +604,12 @@
 		if (!new_info_hash || !new_laddrhash) {
 			fib_hash_free(new_info_hash, bytes);
 			fib_hash_free(new_laddrhash, bytes);
-		} else
+		} else {
+			memset(new_info_hash, 0, bytes);
+			memset(new_laddrhash, 0, bytes);
+
 			fib_hash_move(new_info_hash, new_laddrhash, new_size);
+		}
 
 		if (!fib_hash_size)
 			goto failure;
