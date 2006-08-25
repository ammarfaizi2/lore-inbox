Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422786AbWHYSZU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422786AbWHYSZU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 14:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422782AbWHYSZU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 14:25:20 -0400
Received: from mx.pathscale.com ([64.160.42.68]:41090 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1422711AbWHYSZS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 14:25:18 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 4 of 23] IB/ipath - fix handling of kpiobufs
X-Mercurial-Node: 599649f41f050c5a267c4a00d0819d78bae619c8
Message-Id: <599649f41f050c5a267c.1156530269@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1156530265@eng-12.pathscale.com>
Date: Fri, 25 Aug 2006 11:24:29 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Change comment: no longer imply that user can set ipath_kpiobufs to zero.
Actually set ipath_kpiobufs from parameter. Previously only altered
per-device ipath_lastport_piobuf, which was over-written in chip init.

Signed-off-by: Bryan O'Sullivan <bryan.osullivan@qlogic.com>

diff --git a/drivers/infiniband/hw/ipath/ipath_init_chip.c b/drivers/infiniband/hw/ipath/ipath_init_chip.c
--- a/drivers/infiniband/hw/ipath/ipath_init_chip.c	Fri Aug 25 11:19:44 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_init_chip.c	Fri Aug 25 11:19:44 2006 -0700
@@ -691,7 +691,7 @@ int ipath_init_chip(struct ipath_devdata
 	dd->ipath_pioavregs = ALIGN(val, sizeof(u64) * BITS_PER_BYTE / 2)
 		/ (sizeof(u64) * BITS_PER_BYTE / 2);
 	if (ipath_kpiobufs == 0) {
-		/* not set by user, or set explictly to default  */
+		/* not set by user (this is default) */
 		if ((dd->ipath_piobcnt2k + dd->ipath_piobcnt4k) > 128)
 			kpiobufs = 32;
 		else
@@ -950,6 +950,7 @@ static int ipath_set_kpiobufs(const char
 			dd->ipath_piobcnt2k + dd->ipath_piobcnt4k - val;
 	}
 
+	ipath_kpiobufs = val;
 	ret = 0;
 bail:
 	spin_unlock_irqrestore(&ipath_devs_lock, flags);
