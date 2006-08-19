Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751775AbWHSTN7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751775AbWHSTN7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 15:13:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751777AbWHSTN7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 15:13:59 -0400
Received: from mail.gmx.net ([213.165.64.20]:65475 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751775AbWHSTN7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 15:13:59 -0400
X-Authenticated: #704063
Subject: [Patch] Signedness issue in drivers/scsi/ipr.c
From: Eric Sesterhenn <snakebyte@gmx.de>
To: linux-kernel@vger.kernel.org
Cc: brking@us.ibm.com
Content-Type: text/plain
Date: Sat, 19 Aug 2006 21:13:55 +0200
Message-Id: <1156014835.19657.3.camel@alice>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

gcc 4.1 with some extra warnings show the following:

drivers/scsi/ipr.c:6361: warning: comparison of unsigned expression < 0 is always false
drivers/scsi/ipr.c:6385: warning: comparison of unsigned expression < 0 is always false
drivers/scsi/ipr.c:6415: warning: comparison of unsigned expression < 0 is always false

The problem is that rc is of the type u32, which can never be smaller than zero,
therefore all three error handling checks get useless. This patch changes it to
a normal int, because all usages / all functions it get used with expect an int.

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>

--- linux-2.6.18-rc4/drivers/scsi/ipr.c.orig	2006-08-19 21:10:18.000000000 +0200
+++ linux-2.6.18-rc4/drivers/scsi/ipr.c	2006-08-19 21:10:25.000000000 +0200
@@ -6324,7 +6324,7 @@ static int __devinit ipr_probe_ioa(struc
 	struct Scsi_Host *host;
 	unsigned long ipr_regs_pci;
 	void __iomem *ipr_regs;
-	u32 rc = PCIBIOS_SUCCESSFUL;
+	int rc = PCIBIOS_SUCCESSFUL;
 	volatile u32 mask, uproc;
 
 	ENTER;


