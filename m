Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264053AbTKDK2a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Nov 2003 05:28:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264054AbTKDK2a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Nov 2003 05:28:30 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:36736
	"EHLO x30.random") by vger.kernel.org with ESMTP id S264053AbTKDK23
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Nov 2003 05:28:29 -0500
Date: Tue, 4 Nov 2003 11:28:16 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Jamie Clark <jamie@metaparadigm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.23pre6aa3 scsi oops
Message-ID: <20031104102816.GB2984@x30.random>
References: <3FA713B9.3040405@metaparadigm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FA713B9.3040405@metaparadigm.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 04, 2003 at 10:49:29AM +0800, Jamie Clark wrote:
> Hi,
> 
> Consistent oops with 2.4.23pre6aa3 after 3-4 hours running bonnie on 
> ext3 fs through qla2300 HBA. (w SMP, HIGHMEM) The test machine was 
> completely wedged so I ended up transcribing the oops from the vga 
> console. No typos I think.

I need to release an update that has a chance to fix it. Jens identified
problem in his last_merge scsi patch so I will back it out.

you can try to backout it by yourself in the meantime, it's called
\*elevator-merge-fast-path\* . or you can disable it with this patch:

--- xx/drivers/block/elevator.c.~1~	2003-10-17 21:49:49.000000000 +0200
+++ xx/drivers/block/elevator.c	2003-11-04 11:27:13.000000000 +0100
@@ -77,6 +77,7 @@ inline int bh_rq_in_between(struct buffe
 static int rq_mergeable(struct request *req, struct buffer_head *bh,
 			request_queue_t *q, int rw, int count, int max_sectors)
 {
+	return 0;
 	if (q->head_active && !q->plugged) {
 		struct request *next;
 		next = blkdev_entry_next_request(&q->queue_head);

Hope this helps.
