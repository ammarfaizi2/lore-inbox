Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932451AbWBXUOI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932451AbWBXUOI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 15:14:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932450AbWBXUMX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 15:12:23 -0500
Received: from dsl093-016-182.msp1.dsl.speakeasy.net ([66.93.16.182]:44234
	"EHLO cinder.waste.org") by vger.kernel.org with ESMTP
	id S932449AbWBXUMV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 15:12:21 -0500
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <0.399206195@selenic.com>
Message-Id: <8.399206195@selenic.com>
Subject: [PATCH 7/7] inflate pt1: eliminate memzero usage
Date: Fri, 24 Feb 2006 14:12:17 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

inflate: replace call to memzero with simple loop

This is the only user of memzero in the inflate code and it's only for
16 bytes. Removing this lets us drop a copy of memzero from most
lib/inflate users.

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: 2.6.16-rc4-inflate/lib/inflate.c
===================================================================
--- 2.6.16-rc4-inflate.orig/lib/inflate.c	2006-02-22 17:16:10.000000000 -0600
+++ 2.6.16-rc4-inflate/lib/inflate.c	2006-02-22 17:16:12.000000000 -0600
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
