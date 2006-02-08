Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161027AbWBHGrs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161027AbWBHGrs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 01:47:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161028AbWBHGrX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 01:47:23 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:46979 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1161020AbWBHGnI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 01:43:08 -0500
Message-Id: <20060208064843.927207000@sorel.sous-sol.org>
References: <20060208064503.924238000@sorel.sous-sol.org>
Date: Tue, 07 Feb 2006 22:45:04 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org,
       James Bottomley <James.Bottomley@SteelEye.com>
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Jens Axboe <axboe@suse.de>, Pasi <pasik@iki.fi>,
       Nix <nix@esperi.org.uk>, Ariel <askernel2615@dsgml.com>,
       Jamie Heilman <jamie@audible.transient.net>,
       Chase Venters <chase.venters@clientec.com>,
       Arjan van de Ven <arjan@infradead.org>, linux-ide@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: [PATCH 01/23] SCSI: turn off ordered flush barriers
Content-Disposition: inline; filename=scsi-turn-off-ordered-flush-barriers.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

Turn off ordered flush barriers for SCSI driver, since the SCSI barrier
code has a command leak.

Signed-off-by: Jens Axboe <axboe@suse.de>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---

 drivers/scsi/scsi_lib.c |    5 -----
 1 files changed, 5 deletions(-)

Index: linux-2.6.15.3/drivers/scsi/scsi_lib.c
===================================================================
--- linux-2.6.15.3.orig/drivers/scsi/scsi_lib.c
+++ linux-2.6.15.3/drivers/scsi/scsi_lib.c
@@ -1534,11 +1534,6 @@ struct request_queue *scsi_alloc_queue(s
 	 */
 	if (shost->ordered_tag)
 		blk_queue_ordered(q, QUEUE_ORDERED_TAG);
-	else if (shost->ordered_flush) {
-		blk_queue_ordered(q, QUEUE_ORDERED_FLUSH);
-		q->prepare_flush_fn = scsi_prepare_flush_fn;
-		q->end_flush_fn = scsi_end_flush_fn;
-	}
 
 	if (!shost->use_clustering)
 		clear_bit(QUEUE_FLAG_CLUSTER, &q->queue_flags);

--
