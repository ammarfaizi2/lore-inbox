Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030411AbVKHXsl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030411AbVKHXsl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 18:48:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030407AbVKHXsl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 18:48:41 -0500
Received: from outmx016.isp.belgacom.be ([195.238.2.115]:34960 "EHLO
	outmx016.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S1030411AbVKHXsk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 18:48:40 -0500
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Cleanup: Use kcalloc instead of custom local function.
Message-Id: <20051108234758.7441220A1A@localhost.localdomain>
Date: Wed,  9 Nov 2005 00:47:58 +0100 (CET)
From: takis@issaris.org (Panagiotis Issaris)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup: The statically defined ckmalloc is only used once in the sourcefile and
it can easily be replaced by kcalloc.

Signed-off-by: Panagiotis Issaris <takis@issaris.org>

---

 drivers/char/sx.c |   14 +-------------
 1 files changed, 1 insertions(+), 13 deletions(-)

applies-to: 83b352286b6bd3b144b5f9ce337f70505719a088
f3ccf337c07daf203f997608bb528d84ee8388d7
diff --git a/drivers/char/sx.c b/drivers/char/sx.c
index 3ad758a..fead587 100644
--- a/drivers/char/sx.c
+++ b/drivers/char/sx.c
@@ -2279,18 +2279,6 @@ static int sx_init_drivers(void)
 	return 0;
 }
 
-
-static void * ckmalloc (int size)
-{
-	void *p;
-
-	p = kmalloc(size, GFP_KERNEL);
-	if (p) 
-		memset(p, 0, size);
-	return p;
-}
-
-
 static int sx_init_portstructs (int nboards, int nports)
 {
 	struct sx_board *board;
@@ -2303,7 +2291,7 @@ static int sx_init_portstructs (int nboa
 
 	/* Many drivers statically allocate the maximum number of ports
 	   There is no reason not to allocate them dynamically. Is there? -- REW */
-	sx_ports          = ckmalloc(nports * sizeof (struct sx_port));
+	sx_ports = kcalloc(nports, sizeof (struct sx_port), GFP_KERNEL);
 	if (!sx_ports)
 		return -ENOMEM;
 
---
0.99.9.GIT
