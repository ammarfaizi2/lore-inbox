Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267625AbUHPNyL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267625AbUHPNyL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 09:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267626AbUHPNyK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 09:54:10 -0400
Received: from mx1.redhat.com ([66.187.233.31]:45491 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267625AbUHPNyF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 09:54:05 -0400
Date: Mon, 16 Aug 2004 09:53:04 -0400
From: Alan Cox <alan@redhat.com>
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: PATCH: fix 32bit compile problem with IDE changes
Message-ID: <20040816135304.GA26511@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the 32bit compile problem some people had. Since we fixed the
underlying issue now we can lose the geometry hack


--- drivers/ide/ide-probe.c~	2004-08-16 14:51:06.071010312 +0100
+++ drivers/ide/ide-probe.c	2004-08-16 14:51:06.071010312 +0100
@@ -557,17 +557,6 @@
 	if(strstr(id->model, "Integrated Technology Express"))
 	{
 		/* IT821x raid volume with bogus ident block */
-		if(id->lba_capacity >= 0x200000)
-		{
-			id->sectors = 63;
-			id->heads = 255;
-		}
-		else
-		{
-			id->sectors = 32;
-			id->heads = 64;
-		}
-		id->cyls = id->lba_capacity_2 / (id->heads * id->sectors);
 		/* LBA28 is ok, DMA is ok, UDMA data is valid */
 		id->capability |= 3;
 		id->field_valid |= 7;

Signed-off-by: Alan Cox

