Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751795AbWJFEy1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751795AbWJFEy1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 00:54:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751798AbWJFEy1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 00:54:27 -0400
Received: from mail01.verismonetworks.com ([164.164.99.228]:49589 "EHLO
	mail01.verismonetworks.com") by vger.kernel.org with ESMTP
	id S1751795AbWJFEy0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 00:54:26 -0400
Subject: [PATCH 4/5] ioremap balanced with iounmap for
	drivers/char/rio/rio_linux.c
From: Amol Lad <amol@verismonetworks.com>
To: linux kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 06 Oct 2006 10:27:08 +0530
Message-Id: <1160110628.19143.89.camel@amol.verismonetworks.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Amol Lad <amol@verismonetworks.com>
---
 rio_linux.c |    3 +++
 1 files changed, 3 insertions(+)
---
diff -uprN -X linux-2.6.19-rc1-orig/Documentation/dontdiff linux-2.6.19-rc1-orig/drivers/char/rio/rio_linux.c linux-2.6.19-rc1/drivers/char/rio/rio_linux.c
--- linux-2.6.19-rc1-orig/drivers/char/rio/rio_linux.c	2006-10-05 14:00:43.000000000 +0530
+++ linux-2.6.19-rc1/drivers/char/rio/rio_linux.c	2006-10-05 14:50:00.000000000 +0530
@@ -1181,6 +1181,9 @@ static void __exit rio_exit(void)
 		}
 		/* It is safe/allowed to del_timer a non-active timer */
 		del_timer(&hp->timer);
+
+		if (hp->Caddr)
+			iounmap(hp->Caddr);
 	}
 
 	if (misc_deregister(&rio_fw_device) < 0) {


