Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262644AbVDHAv0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262644AbVDHAv0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 20:51:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262642AbVDHAux
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 20:50:53 -0400
Received: from fire.osdl.org ([65.172.181.4]:60113 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262638AbVDHAuX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 20:50:23 -0400
Date: Thu, 7 Apr 2005 17:50:51 -0700
From: Nick Wilson <njw@osdl.org>
To: linux-kernel@vger.kernel.org, akpm@osdl.org, rddunlap@osdl.org
Subject: [PATCH 4/6] kernel/resource.c: use generic round_up_pow2() macro
Message-ID: <20050408005051.GE4260@njw.pdx.osdl.net>
References: <20050408004428.GA4260@njw.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050408004428.GA4260@njw.pdx.osdl.net>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Wilson <njw@osdl.org>

Use the generic round_up_pow2() instead of a custom rounding method.

Signed-off-by: Nick Wilson <njw@osdl.org>
---


 resource.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux/kernel/resource.c
===================================================================
--- linux.orig/kernel/resource.c	2005-04-07 15:13:56.000000000 -0700
+++ linux/kernel/resource.c	2005-04-07 15:45:57.000000000 -0700
@@ -263,7 +263,7 @@ static int find_resource(struct resource
 			new->start = min;
 		if (new->end > max)
 			new->end = max;
-		new->start = (new->start + align - 1) & ~(align - 1);
+		new->start = round_up_pow2(new->start, align);
 		if (alignf)
 			alignf(alignf_data, new, size, align);
 		if (new->start < new->end && new->end - new->start + 1 >= size) {
_
