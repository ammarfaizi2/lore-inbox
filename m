Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161338AbWASTLy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161338AbWASTLy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 14:11:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161340AbWASTLy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 14:11:54 -0500
Received: from ns1.coraid.com ([65.14.39.133]:18856 "EHLO coraid.com")
	by vger.kernel.org with ESMTP id S1161338AbWASTLw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 14:11:52 -0500
Message-ID: <b842da86bf0aaa6897a11b3fb13756aa@coraid.com>
Date: Thu, 19 Jan 2006 13:46:25 -0500
To: linux-kernel@vger.kernel.org
CC: ecashin@coraid.com, Greg K-H <greg@kroah.com>
Subject: [PATCH 2.6.15-git9] aoe [5/8]: allow network interface migration on packet retransmit
From: "Ed L. Cashin" <ecashin@coraid.com>
References: <E1EzelK-0006sT-00@kokone>
Gcc: nnfolder:Mail/sent-200601
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: "Ed L. Cashin" <ecashin@coraid.com>

Retransmit to the current network interface for an AoE device.

diff -upr 2.6.15-git9-orig/drivers/block/aoe/aoecmd.c 2.6.15-git9-aoe/drivers/block/aoe/aoecmd.c
--- 2.6.15-git9-orig/drivers/block/aoe/aoecmd.c	2006-01-19 13:31:22.000000000 -0500
+++ 2.6.15-git9-aoe/drivers/block/aoe/aoecmd.c	2006-01-19 13:31:23.000000000 -0500
@@ -286,6 +286,8 @@ rexmit(struct aoedev *d, struct frame *f
 	h = (struct aoe_hdr *) f->data;
 	f->tag = n;
 	h->tag = cpu_to_be32(n);
+	memcpy(h->dst, d->addr, sizeof h->dst);
+	memcpy(h->src, d->ifp->dev_addr, sizeof h->src);
 
 	skb = skb_prepare(d, f);
 	if (skb) {


-- 
  "Ed L. Cashin" <ecashin@coraid.com>
