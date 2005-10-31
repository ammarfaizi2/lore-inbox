Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932548AbVJaVBA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932548AbVJaVBA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 16:01:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932546AbVJaVAl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 16:00:41 -0500
Received: from waste.org ([216.27.176.166]:9112 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S932533AbVJaVAd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 16:00:33 -0500
Date: Mon, 31 Oct 2005 14:54:47 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-arch@vger.kernel.org
In-Reply-To: <7.196662837@selenic.com>
Message-Id: <8.196662837@selenic.com>
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
