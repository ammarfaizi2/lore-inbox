Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266351AbUHBIPa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266351AbUHBIPa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 04:15:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266352AbUHBIPa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 04:15:30 -0400
Received: from grunt4.ihug.co.nz ([203.109.254.44]:59572 "EHLO
	grunt4.ihug.co.nz") by vger.kernel.org with ESMTP id S266351AbUHBIPY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 04:15:24 -0400
Subject: [PATCH] Trivial ipv6 fix.
From: Ralph Loader <suckfish@ihug.co.nz>
To: davem@redhat.com, pekkas@netcore.fi, yoshfuji@linux-ipv6.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Mon, 02 Aug 2004 20:12:08 +1200
Message-Id: <1091434328.16469.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.91 (1.5.91-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

ipv6_addr_hash doesn't do what it's comment says.  The comment was
probably what was intended, not that it'll make much difference in
practice.

Cheers,
Ralph.

Signed-off-by: Ralph Loader <suckfish@ihug.co.nz>

--- include/net/addrconf.h.orig	2004-08-02 19:54:07.772297854 +1200
+++ include/net/addrconf.h	2004-08-02 19:55:25.166824746 +1200
@@ -178,8 +178,8 @@
 	 * This will include the IEEE address token on links that support it.
 	 */
 
-	word = addr->s6_addr[2] ^ addr->s6_addr32[3];
-	word  ^= (word>>16);
+	word = addr->s6_addr32[2] ^ addr->s6_addr32[3];
+	word ^= (word >> 16);
 	word ^= (word >> 8);
 
 	return ((word ^ (word >> 4)) & 0x0f);


