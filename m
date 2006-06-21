Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932339AbWFUS43@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932339AbWFUS43 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 14:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932364AbWFUS43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 14:56:29 -0400
Received: from mail.gmx.de ([213.165.64.21]:55744 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932339AbWFUS42 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 14:56:28 -0400
X-Authenticated: #704063
Subject: [Patch] Array overrun in drivers/infiniband/core/cma.c
From: Eric Sesterhenn <snakebyte@gmx.de>
To: linux-kernel@vger.kernel.org
Cc: mshefty@ichips.intel.com
Content-Type: text/plain
Date: Wed, 21 Jun 2006 20:56:26 +0200
Message-Id: <1150916186.23613.1.camel@alice>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

this was spotted by coverity #id 1300. Since
the array has only four elements, we should 
just use those four.

Patch is against todays git tree.

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>

--- linux-2.6/drivers/infiniband/core/cma.c.orig	2006-06-21 20:54:10.000000000 +0200
+++ linux-2.6/drivers/infiniband/core/cma.c	2006-06-21 20:54:22.000000000 +0200
@@ -476,7 +476,7 @@ static inline int cma_zero_addr(struct s
 	else {
 		ip6 = &((struct sockaddr_in6 *) addr)->sin6_addr;
 		return (ip6->s6_addr32[0] | ip6->s6_addr32[1] |
-			ip6->s6_addr32[3] | ip6->s6_addr32[4]) == 0;
+			ip6->s6_addr32[2] | ip6->s6_addr32[3]) == 0;
 	}
 }
 


