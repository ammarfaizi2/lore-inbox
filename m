Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261369AbUKOV2C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261369AbUKOV2C (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 16:28:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261333AbUKOV1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 16:27:48 -0500
Received: from hera.cwi.nl ([192.16.191.8]:10730 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S261369AbUKOV0h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 16:26:37 -0500
Date: Mon, 15 Nov 2004 22:26:32 +0100 (MET)
From: <Andries.Brouwer@cwi.nl>
Message-Id: <200411152126.iAFLQWa26071@apps.cwi.nl>
To: akpm@osdl.org, torvalds@osdl.org
Subject: [PATCH] fix appletalk locking
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just tried the new toy. It works.

diff -uprN -X /linux/dontdiff a/net/appletalk/ddp.c b/net/appletalk/ddp.c
--- a/net/appletalk/ddp.c	2004-11-15 20:02:25.000000000 +0100
+++ b/net/appletalk/ddp.c	2004-11-15 22:33:43.000000000 +0100
@@ -563,7 +563,7 @@ static int atrtr_create(struct rtentry *
 
 		retval = -ENOBUFS;
 		if (!rt)
-			goto out;
+			goto out_unlock;
 		memset(rt, 0, sizeof(*rt));
 
 		rt->next = atalk_routes;
