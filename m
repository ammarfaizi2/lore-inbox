Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262042AbTE2Jn3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 05:43:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262058AbTE2Jn3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 05:43:29 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:11716 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262042AbTE2Jn2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 05:43:28 -0400
Date: Thu, 29 May 2003 11:56:47 +0200
From: Jens Axboe <axboe@suse.de>
To: Ian Molton <spyro@f2s.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CRASH 2.5.70
Message-ID: <20030529095647.GE845@suse.de>
References: <20030528234422.6173b72e.spyro@f2s.com> <20030528234915.70c9191c.spyro@f2s.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030528234915.70c9191c.spyro@f2s.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 28 2003, Ian Molton wrote:
> On Wed, 28 May 2003 23:44:22 +0100
> Ian Molton <spyro@f2s.com> wrote:
> 
> > I dont overclock this box, and it ran 2.4.<n> stably for months.
> > 
> > AthlonXP1800 on an Asus A7M266 with 256MB DDR memory.
> 
> addendum: ext3 filesystem on WD 120GB disc with 8M cache.

Does this make any difference...?

--- drivers/block/deadline-iosched.c~	2003-05-28 10:46:38.678240272 +0200
+++ drivers/block/deadline-iosched.c	2003-05-28 10:43:13.994356952 +0200
@@ -121,6 +121,15 @@
 		__deadline_del_drq_hash(drq);
 }
 
+static void
+deadline_remove_merge_hints(request_queue_t *q, struct deadline_rq *drq)
+{
+	deadline_del_drq_hash(drq);
+
+	if (q->last_merge == &drq->request->queuelist)
+		q->last_merge = NULL;
+}
+
 static inline void
 deadline_add_drq_hash(struct deadline_data *dd, struct deadline_rq *drq)
 {
@@ -310,7 +319,7 @@
 		struct deadline_data *dd = q->elevator.elevator_data;
 
 		list_del_init(&drq->fifo);
-		deadline_del_drq_hash(drq);
+		deadline_remove_merge_hints(q, drq);
 		deadline_del_drq_rb(dd, drq);
 	}
 }

-- 
Jens Axboe

