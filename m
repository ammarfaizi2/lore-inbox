Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964964AbWFNOHv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964964AbWFNOHv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 10:07:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964955AbWFNOHv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 10:07:51 -0400
Received: from mtagate5.de.ibm.com ([195.212.29.154]:61101 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP id S964959AbWFNOHi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 10:07:38 -0400
Date: Wed, 14 Jun 2006 16:02:15 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, wein@de.ibm.com
Subject: [patch 11/24] s390: missing check in dasd_eer_open.
Message-ID: <20060614140215.GL9475@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Weinhuber <wein@de.ibm.com>

[S390] missing check in dasd_eer_open.

Check the return value of kzalloc in dasd_eer_open.

Signed-off-by: Stefan Weinhuber <wein@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/block/dasd_eer.c |    2 ++
 1 files changed, 2 insertions(+)

diff -urpN linux-2.6/drivers/s390/block/dasd_eer.c linux-2.6-patched/drivers/s390/block/dasd_eer.c
--- linux-2.6/drivers/s390/block/dasd_eer.c	2006-06-14 14:29:18.000000000 +0200
+++ linux-2.6-patched/drivers/s390/block/dasd_eer.c	2006-06-14 14:29:45.000000000 +0200
@@ -521,6 +521,8 @@ static int dasd_eer_open(struct inode *i
 	unsigned long flags;
 
 	eerb = kzalloc(sizeof(struct eerbuffer), GFP_KERNEL);
+	if (!eerb)
+		return -ENOMEM;
 	eerb->buffer_page_count = eer_pages;
 	if (eerb->buffer_page_count < 1 ||
 	    eerb->buffer_page_count > INT_MAX / PAGE_SIZE) {
