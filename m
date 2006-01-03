Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964926AbWACVbF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964926AbWACVbF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 16:31:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964928AbWACVaY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 16:30:24 -0500
Received: from ns1.coraid.com ([65.14.39.133]:60105 "EHLO coraid.com")
	by vger.kernel.org with ESMTP id S1751483AbWACV3n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 16:29:43 -0500
To: linux-kernel@vger.kernel.org
CC: ecashin@coraid.com, Greg K-H <greg@kroah.com>
Subject: [PATCH 2.6.15-rc7] aoe [5/7]: allow network interface migration on
 packet retransmit
From: "Ed L. Cashin" <ecashin@coraid.com>
References: <87hd8l2fb4.fsf@coraid.com>
Date: Tue, 03 Jan 2006 16:08:17 -0500
Message-ID: <87sls5yq7y.fsf@coraid.com>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: "Ed L. Cashin" <ecashin@coraid.com>

Retransmit to the current network interface for an AoE device.

Index: 2.6.15-rc7-aoe/drivers/block/aoe/aoecmd.c
===================================================================
--- 2.6.15-rc7-aoe.orig/drivers/block/aoe/aoecmd.c	2006-01-02 13:35:14.000000000 -0500
+++ 2.6.15-rc7-aoe/drivers/block/aoe/aoecmd.c	2006-01-02 13:35:14.000000000 -0500
@@ -239,6 +239,8 @@
 	h = (struct aoe_hdr *) f->data;
 	f->tag = n;
 	h->tag = cpu_to_be32(n);
+	memcpy(h->dst, d->addr, sizeof h->dst);
+	memcpy(h->src, d->ifp->dev_addr, sizeof h->src);
 
 	skb = skb_prepare(d, f);
 	if (skb) {


-- 
  Ed L. Cashin <ecashin@coraid.com>

