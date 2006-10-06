Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751797AbWJFEy3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751797AbWJFEy3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 00:54:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750996AbWJFEy3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 00:54:29 -0400
Received: from mail01.verismonetworks.com ([164.164.99.228]:50101 "EHLO
	mail01.verismonetworks.com") by vger.kernel.org with ESMTP
	id S1751797AbWJFEy2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 00:54:28 -0400
Subject: [PATCH 2/5] ioremap balanced with iounmap for
	drivers/char/istallion.c
From: Amol Lad <amol@verismonetworks.com>
To: linux kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 06 Oct 2006 10:27:09 +0530
Message-Id: <1160110629.19143.92.camel@amol.verismonetworks.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Amol Lad <amol@verismonetworks.com>
---
 istallion.c |    4 ++++
 1 files changed, 4 insertions(+)
---
diff -uprN -X linux-2.6.19-rc1-orig/Documentation/dontdiff linux-2.6.19-rc1-orig/drivers/char/istallion.c linux-2.6.19-rc1/drivers/char/istallion.c
--- linux-2.6.19-rc1-orig/drivers/char/istallion.c	2006-10-05 14:00:43.000000000 +0530
+++ linux-2.6.19-rc1/drivers/char/istallion.c	2006-10-05 14:50:00.000000000 +0530
@@ -3476,6 +3476,8 @@ static int stli_initecp(stlibrd_t *brdp)
 	if (sig.magic != cpu_to_le32(ECP_MAGIC))
 	{
 		release_region(brdp->iobase, brdp->iosize);
+		iounmap(brdp->membase);
+		brdp->membase = NULL;
 		return -ENODEV;
 	}
 
@@ -3632,6 +3634,8 @@ static int stli_initonb(stlibrd_t *brdp)
 	    sig.magic3 != cpu_to_le16(ONB_MAGIC3))
 	{
 		release_region(brdp->iobase, brdp->iosize);
+		iounmap(brdp->membase);
+		brdp->membase = NULL;
 		return -ENODEV;
 	}
 



