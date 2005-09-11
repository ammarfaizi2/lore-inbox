Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964928AbVIKQq0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964928AbVIKQq0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 12:46:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964938AbVIKQqZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 12:46:25 -0400
Received: from pne-smtpout2-sn2.hy.skanova.net ([81.228.8.164]:30618 "EHLO
	pne-smtpout2-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S964928AbVIKQqZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 12:46:25 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] Use kcalloc and kzalloc in pktcdvd
References: <m3irx7v9nq.fsf@telia.com> <m3ek7vv9lr.fsf@telia.com>
	<m3acijv9ix.fsf_-_@telia.com>
From: Peter Osterlund <petero2@telia.com>
Date: 11 Sep 2005 18:46:12 +0200
In-Reply-To: <m3acijv9ix.fsf_-_@telia.com>
Message-ID: <m364t7v9gr.fsf_-_@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use kcalloc and kzalloc in pktcdvd.

Signed-off-by: Peter Osterlund <petero2@telia.com>
---

 drivers/block/pktcdvd.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -112,10 +112,9 @@ static struct bio *pkt_bio_alloc(int nr_
 		goto no_bio;
 	bio_init(bio);
 
-	bvl = kmalloc(nr_iovecs * sizeof(struct bio_vec), GFP_KERNEL);
+	bvl = kcalloc(nr_iovecs, sizeof(struct bio_vec), GFP_KERNEL);
 	if (!bvl)
 		goto no_bvl;
-	memset(bvl, 0, nr_iovecs * sizeof(struct bio_vec));
 
 	bio->bi_max_vecs = nr_iovecs;
 	bio->bi_io_vec = bvl;
@@ -137,10 +136,9 @@ static struct packet_data *pkt_alloc_pac
 	int i;
 	struct packet_data *pkt;
 
-	pkt = kmalloc(sizeof(struct packet_data), GFP_KERNEL);
+	pkt = kzalloc(sizeof(struct packet_data), GFP_KERNEL);
 	if (!pkt)
 		goto no_pkt;
-	memset(pkt, 0, sizeof(struct packet_data));
 
 	pkt->w_bio = pkt_bio_alloc(PACKET_MAX_SIZE);
 	if (!pkt->w_bio)
@@ -2492,10 +2490,9 @@ static int pkt_setup_dev(struct pkt_ctrl
 		return -EBUSY;
 	}
 
-	pd = kmalloc(sizeof(struct pktcdvd_device), GFP_KERNEL);
+	pd = kzalloc(sizeof(struct pktcdvd_device), GFP_KERNEL);
 	if (!pd)
 		return ret;
-	memset(pd, 0, sizeof(struct pktcdvd_device));
 
 	pd->rb_pool = mempool_create(PKT_RB_POOL_SIZE, pkt_rb_alloc, pkt_rb_free, NULL);
 	if (!pd->rb_pool)

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
