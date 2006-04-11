Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750870AbWDKSlP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750870AbWDKSlP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 14:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750872AbWDKSlP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 14:41:15 -0400
Received: from nproxy.gmail.com ([64.233.182.190]:18897 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750866AbWDKSlP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 14:41:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=LHyLmFiSRwzjNady8GqnuaiRlVJDAiKNA25zMnfJO1OxYk4xOMHTJtk/RR6GAkmbHIsD3RMdd8eQsF7IVOr8zrFcawJfSqyw3svGK4TiJANYhdBKMtkHsLOqoyBMac8mVDOxCQIYFUqkT5NDWfr1u0G5P9Ey4Q7G5LmaV+6qLJk=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] mtd, nettel: fix build error and implicit declaration
Date: Tue, 11 Apr 2006 20:41:49 +0200
User-Agent: KMail/1.9.1
Cc: Greg Ungerer <gerg@snapgear.com>, dwmw2@infradead.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604112041.49689.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just hit the following error and warning : 
  drivers/mtd/maps/nettel.c: In function `nettel_init':
  drivers/mtd/maps/nettel.c:418: error: `ROOT_DEV' undeclared (first use in this function)
  drivers/mtd/maps/nettel.c:418: error: (Each undeclared identifier is reported only once
  drivers/mtd/maps/nettel.c:418: error: for each function it appears in.)
  drivers/mtd/maps/nettel.c:418: warning: implicit declaration of function `MKDEV'
  make[3]: *** [drivers/mtd/maps/nettel.o] Error 1
  make[2]: *** [drivers/mtd/maps] Error 2
  make[1]: *** [drivers/mtd] Error 2
The patch fixes the missing ROOT_DEV declaration by including linux/root_dev.h
and fixes the implicit declaration of MKDEV by including linux/kdev_t.h .

Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 drivers/mtd/maps/nettel.c |    2 ++
 1 files changed, 2 insertions(+)

--- linux-2.6.17-rc1-git4-orig/drivers/mtd/maps/nettel.c	2006-04-09 13:58:20.000000000 +0200
+++ linux-2.6.17-rc1-git4/drivers/mtd/maps/nettel.c	2006-04-11 20:30:37.000000000 +0200
@@ -20,6 +20,8 @@
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/cfi.h>
 #include <linux/reboot.h>
+#include <linux/kdev_t.h>
+#include <linux/root_dev.h>
 #include <asm/io.h>
 
 /****************************************************************************/





