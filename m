Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932334AbWDBPlw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932334AbWDBPlw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 11:41:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751221AbWDBPlw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 11:41:52 -0400
Received: from noname.neutralserver.com ([70.84.186.210]:14695 "EHLO
	noname.neutralserver.com") by vger.kernel.org with ESMTP
	id S1750819AbWDBPlv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 11:41:51 -0400
Date: Sun, 2 Apr 2006 18:43:10 +0300
From: Dan Aloni <da-x@monatomic.org>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Cc: Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH] sata_mv: properly print HC registers
Message-ID: <20060402154310.GA20270@localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - noname.neutralserver.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - monatomic.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently it crashes when trying to dump the registers. This
is an obvious one-liner fix I suppose.

Signed-off-by: Dan Aloni <da-x@monatomic.org>

---
commit 0c7dffa50cf862d70893930f8588b4e094d3d942
tree bfbbee1b59c56c9731155c6139597c65231678e3
parent f3188a4fb731b437408c747e29dde59b1d7511f8
author Dan Aloni <da-x@monatomic.org> Sun, 02 Apr 2006 18:39:31 +0300
committer Dan Aloni <da-x@monatomic.org> Sun, 02 Apr 2006 18:39:31 +0300

 drivers/scsi/sata_mv.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/scsi/sata_mv.c b/drivers/scsi/sata_mv.c
index fa901fd..6a72a23 100644
--- a/drivers/scsi/sata_mv.c
+++ b/drivers/scsi/sata_mv.c
@@ -748,7 +748,7 @@ static void mv_dump_all_regs(void __iome
 	mv_dump_mem(mmio_base+0xf00, 0x4);
 	mv_dump_mem(mmio_base+0x1d00, 0x6c);
 	for (hc = start_hc; hc < start_hc + num_hcs; hc++) {
-		hc_base = mv_hc_base(mmio_base, port >> MV_PORT_HC_SHIFT);
+		hc_base = mv_hc_base(mmio_base, hc);
 		DPRINTK("HC regs (HC %i):\n", hc);
 		mv_dump_mem(hc_base, 0x1c);
 	}


-- 
Dan Aloni, Linux specialist
XIV LTD, http://www.xivstorage.com
da-x@monatomic.org, da-x@colinux.org, da-x@gmx.net, dan@xiv.co.il
