Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932241AbVLPN2e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932241AbVLPN2e (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 08:28:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932245AbVLPN2e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 08:28:34 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:42683 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S932241AbVLPN2d
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 08:28:33 -0500
Date: Fri, 16 Dec 2005 14:28:34 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, peter.oberparleiter@de.ibm.com,
       linux-kernel@vger.kernel.org
Subject: [patch 1/3] s390: fix invalid return code in sclp_cpi.
Message-ID: <20051216132834.GB8877@skybase.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>

[patch 1/3] s390: fix invalid return code in sclp_cpi.

When the sclp_cpi module is loaded on a system which does not
support the required SCLP call (e.g. on z/VM), ENOSUPP is
returned to user space. The correct return value is EOPNOTSUPP.

Signed-off-by: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

---

 drivers/s390/char/sclp_cpi.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -urpN linux-2.6/drivers/s390/char/sclp_cpi.c linux-2.6-patched/drivers/s390/char/sclp_cpi.c
--- linux-2.6/drivers/s390/char/sclp_cpi.c	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6-patched/drivers/s390/char/sclp_cpi.c	2005-12-16 10:57:22.000000000 +0100
@@ -204,7 +204,7 @@ cpi_module_init(void)
 		printk(KERN_WARNING "cpi: no control program identification "
 		       "support\n");
 		sclp_unregister(&sclp_cpi_event);
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 	}
 
 	req = cpi_prepare_req();
