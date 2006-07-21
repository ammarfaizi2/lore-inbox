Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161057AbWGULbY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161057AbWGULbY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 07:31:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161058AbWGULbY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 07:31:24 -0400
Received: from outmx020.isp.belgacom.be ([195.238.4.201]:27297 "EHLO
	outmx020.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S1161057AbWGULbY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 07:31:24 -0400
Date: Fri, 21 Jul 2006 13:32:10 +0200
To: linux-kernel@vger.kernel.org
Cc: axboe@suse.de
Subject: [PATCH] block: Conversions from kmalloc+memset to k(z|c)alloc
Message-ID: <20060721113210.GB11822@issaris.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
From: takis@issaris.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Panagiotis Issaris <takis@issaris.org>

block: Conversions from kmalloc+memset to kzalloc

Signed-off-by: Panagiotis Issaris <takis@issaris.org>
---
 block/cfq-iosched.c |    4 +---
 block/elevator.c    |    3 +--
 block/scsi_ioctl.c  |    4 +---
 3 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/block/cfq-iosched.c b/block/cfq-iosched.c
index 102ebc2..d3d095f 100644
--- a/block/cfq-iosched.c
+++ b/block/cfq-iosched.c
@@ -2231,12 +2231,10 @@ static void *cfq_init_queue(request_queu
 	struct cfq_data *cfqd;
 	int i;
 
-	cfqd = kmalloc(sizeof(*cfqd), GFP_KERNEL);
+	cfqd = kzalloc(sizeof(*cfqd), GFP_KERNEL);
 	if (!cfqd)
 		return NULL;
 
-	memset(cfqd, 0, sizeof(*cfqd));
-
 	for (i = 0; i < CFQ_PRIO_LISTS; i++)
 		INIT_LIST_HEAD(&cfqd->rr_list[i]);
 
diff --git a/block/elevator.c b/block/elevator.c
index bc7baee..e51febf 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -153,9 +153,8 @@ static struct kobj_type elv_ktype;
 
 static elevator_t *elevator_alloc(struct elevator_type *e)
 {
-	elevator_t *eq = kmalloc(sizeof(elevator_t), GFP_KERNEL);
+	elevator_t *eq = kzalloc(sizeof(elevator_t), GFP_KERNEL);
 	if (eq) {
-		memset(eq, 0, sizeof(*eq));
 		eq->ops = &e->ops;
 		eq->elevator_type = e;
 		kobject_init(&eq->kobj);
diff --git a/block/scsi_ioctl.c b/block/scsi_ioctl.c
index b33eda2..f6a8bea 100644
--- a/block/scsi_ioctl.c
+++ b/block/scsi_ioctl.c
@@ -409,11 +409,9 @@ int sg_scsi_ioctl(struct file *file, str
 
 	bytes = max(in_len, out_len);
 	if (bytes) {
-		buffer = kmalloc(bytes, q->bounce_gfp | GFP_USER| __GFP_NOWARN);
+		buffer = kzalloc(bytes, q->bounce_gfp | GFP_USER| __GFP_NOWARN);
 		if (!buffer)
 			return -ENOMEM;
-
-		memset(buffer, 0, bytes);
 	}
 
 	rq = blk_get_request(q, in_len ? WRITE : READ, __GFP_WAIT);
-- 
1.4.2.rc1.ge7a0-dirty

