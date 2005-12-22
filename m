Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030294AbVLVSab@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030294AbVLVSab (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 13:30:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030289AbVLVS2k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 13:28:40 -0500
Received: from waste.org ([64.81.244.121]:4816 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1030263AbVLVS1y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 13:27:54 -0500
Date: Thu, 22 Dec 2005 12:26:36 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
       linux-tiny@selenic.com
In-Reply-To: <7.150843412@selenic.com>
Message-Id: <8.150843412@selenic.com>
Subject: [PATCH 7/20] inflate: eliminate memzero usage
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

inflate: replace call to memzero with simple loop

This is the only user of memzero in the inflate code and it's only for
16 bytes. Removing this lets us drop a copy of memzero from most
lib/inflate users.

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: 2.6.14/lib/inflate.c
===================================================================
--- 2.6.14.orig/lib/inflate.c	2005-10-31 12:21:21.000000000 -0800
+++ 2.6.14/lib/inflate.c	2005-10-31 12:21:22.000000000 -0800
@@ -365,8 +365,10 @@ static int INIT huft_build(unsigned *b, 
 
 	DEBG("huft1 ");
 
+	for (i = 0; i < BMAX + 1; i++)
+		c[i] = 0;
+
 	/* Generate counts for each bit length */
-	memzero(c, sizeof(c));
 	p = b;
 	i = n;
 	do {
