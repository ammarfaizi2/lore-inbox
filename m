Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932070AbWGXHbv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932070AbWGXHbv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 03:31:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751437AbWGXHbv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 03:31:51 -0400
Received: from stats.hypersurf.com ([209.237.0.12]:3854 "EHLO
	stats.hypersurf.com") by vger.kernel.org with ESMTP
	id S1751435AbWGXHbu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 03:31:50 -0400
From: HighPoint Linux Team <linux@highpoint-tech.com>
Organization: HighPoint Technologies, Inc.
To: James.Bottomley@SteelEye.com
Subject: [PATCH] hptiop: wrong register used in hptiop_reset_hba()
Date: Mon, 24 Jul 2006 15:48:54 +0800
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, akpm@osdl.org
References: <200606111706.52930.linux@highpoint-tech.com> <200606141650.57740.linux@highpoint-tech.com>
In-Reply-To: <200606141650.57740.linux@highpoint-tech.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607241548.54593.linux@highpoint-tech.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

IOP reset message should be posted to inbound message register
instead of outbound message register.

Signed-off-by: HighPoint Linux Team <linux@highpoint-tech.com>
---

diff --git a/drivers/scsi/hptiop.c b/drivers/scsi/hptiop.c
index ab2f8b2..74d4d22 100644
--- a/drivers/scsi/hptiop.c
+++ b/drivers/scsi/hptiop.c
@@ -577,7 +577,7 @@ static int hptiop_reset_hba(struct hptio
 	if (atomic_xchg(&hba->resetting, 1) == 0) {
 		atomic_inc(&hba->reset_count);
 		writel(IOPMU_INBOUND_MSG0_RESET,
-				&hba->iop->outbound_msgaddr0);
+				&hba->iop->inbound_msgaddr0);
 		hptiop_pci_posting_flush(hba->iop);
 	}
 

