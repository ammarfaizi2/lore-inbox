Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262639AbVDLUBO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262639AbVDLUBO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 16:01:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262638AbVDLT7o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 15:59:44 -0400
Received: from fire.osdl.org ([65.172.181.4]:39368 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262151AbVDLKbp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:31:45 -0400
Message-Id: <200504121031.j3CAVUiI005332@shell0.pdx.osdl.net>
Subject: [patch 052/198] ppc64: remove bogus f50 hack in prom.c
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, benh@kernel.crashing.org
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:31:24 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

The code that parses the OF device tree contains an old bogus hack which
was killed a long time ago on ppc32, but survived in ppc64.  It was
supposed to help with a problem on the f50 which is ...  a 32 bits machine
:) Additionally, that hack is causing problems, so let's just get rid of
it.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/arch/ppc64/kernel/prom.c |    6 ------
 1 files changed, 6 deletions(-)

diff -puN arch/ppc64/kernel/prom.c~ppc64-remove-bogus-f50-hack-in-promc arch/ppc64/kernel/prom.c
--- 25/arch/ppc64/kernel/prom.c~ppc64-remove-bogus-f50-hack-in-promc	2005-04-12 03:21:15.945712784 -0700
+++ 25-akpm/arch/ppc64/kernel/prom.c	2005-04-12 03:21:15.949712176 -0700
@@ -544,12 +544,6 @@ static int __devinit finish_node(struct 
 	if (ip != NULL)
 		nsizec = *ip;
 
-	/* the f50 sets the name to 'display' and 'compatible' to what we
-	 * expect for the name -- Cort
-	 */
-	if (!strcmp(np->name, "display"))
-		np->name = get_property(np, "compatible", NULL);
-
 	if (!strcmp(np->name, "device-tree") || np->parent == NULL)
 		ifunc = interpret_root_props;
 	else if (np->type == 0)
_
