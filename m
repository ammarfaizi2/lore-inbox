Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422888AbWJVA4p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422888AbWJVA4p (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 20:56:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422891AbWJVA4p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 20:56:45 -0400
Received: from cacti.profiwh.com ([85.93.165.66]:57246 "EHLO cacti.profiwh.com")
	by vger.kernel.org with ESMTP id S1422888AbWJVA4o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 20:56:44 -0400
Message-id: <1731170312466312033@wsc.cz>
Subject: [PATCH 2/5] Char: sx, use kcalloc
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Cc: <R.E.Wolff@BitWizard.nl>
Cc: <support@specialix.co.uk>
Date: Sun, 22 Oct 2006 02:56:45 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sx, use kcalloc

Convert self-implemented kzalloc to kernel kcalloc.

Cc: <R.E.Wolff@BitWizard.nl>
Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit 52aaf84368d81de72e1c4a69756b10ec744fbeab
tree 58d6c89c8c3628ccd0ee85ebc636f8cfce2039cb
parent 56b6b52313a48cbda4c84bd35252337063269d88
author Jiri Slaby <jirislaby@gmail.com> Sun, 22 Oct 2006 01:55:11 +0200
committer Jiri Slaby <jirislaby@gmail.com> Sun, 22 Oct 2006 01:55:11 +0200

 drivers/char/sx.c |   14 +-------------
 1 files changed, 1 insertions(+), 13 deletions(-)

diff --git a/drivers/char/sx.c b/drivers/char/sx.c
index 9b800bd..be6fff2 100644
--- a/drivers/char/sx.c
+++ b/drivers/char/sx.c
@@ -2267,18 +2267,6 @@ static int sx_init_drivers(void)
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
@@ -2291,7 +2279,7 @@ static int sx_init_portstructs (int nboa
 
 	/* Many drivers statically allocate the maximum number of ports
 	   There is no reason not to allocate them dynamically. Is there? -- REW */
-	sx_ports          = ckmalloc(nports * sizeof (struct sx_port));
+	sx_ports = kcalloc(nports, sizeof(struct sx_port), GFP_KERNEL);
 	if (!sx_ports)
 		return -ENOMEM;
 
