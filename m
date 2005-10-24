Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751150AbVJXQoL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751150AbVJXQoL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 12:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751151AbVJXQoK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 12:44:10 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:25293 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S1751150AbVJXQoJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 12:44:09 -0400
Message-ID: <435D0F45.90906@hp.com>
Date: Mon, 24 Oct 2005 12:43:49 -0400
From: Mark Seger <Mark.Seger@hp.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: [Fwd: Re: Patch for inconsistent recording of block device statistics]
Content-Type: multipart/mixed;
 boundary="------------030405030006090005080208"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030405030006090005080208
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch was discussed back in march, and I still haven't seen it show 
up in the source pool.  I was wondering if it just feel through the 
cracks or if it was planned for a specific future release.  If the 
attached doesn't provide enough context for you to remember what this is 
all about, just let me know...
-mark


--------------030405030006090005080208
Content-Type: message/rfc822;
 name="Re: Patch for inconsistent recording of block device statistics"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Re: Patch for inconsistent recording of block device statistics"

Return-Path: <axboe@suse.de>
Received: from palrel12.hp.com (palrel12.hp.com [15.81.176.20])
	by seeaxp.eng.lkg.hp.com (8.12.10/8.12.10/V4.0) with ESMTP id j2N9JowF355154
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <Seger@cag.lkg.hp.com>; Wed, 23 Mar 2005 04:19:50 -0500 (EST)
Received: from zmamail01.zma.compaq.com (zmamail01.nz-tay.cpqcorp.net [161.114.72.101])
	by palrel12.hp.com (Postfix) with ESMTP id 8F248408B4C
	for <Seger@cag.lkg.hp.com>; Wed, 23 Mar 2005 01:19:49 -0800 (PST)
Received: from ccerelrim03.cce.hp.com (ccerelrim03.cce.hp.com [161.114.21.24])
	by zmamail01.zma.compaq.com (Postfix) with ESMTP id 7D54016EC2
	for <Seger@cag.lkg.hp.com>; Wed, 23 Mar 2005 04:19:48 -0500 (EST)
Received: from ccerelrim03.cce.hp.com (localhost [127.0.0.1])
	by receive-from-antispam-filter (Postfix) with SMTP id 2271A32E74
	for <Seger@cag.lkg.hp.com>; Wed, 23 Mar 2005 03:19:42 -0600 (CST)
Received: from virtualhost.dk (ns.virtualhost.dk [195.184.98.160])
	by ccerelrim03.cce.hp.com (Postfix) with ESMTP id 8F24F32E32
	for <Mark.Seger@hp.com>; Wed, 23 Mar 2005 03:19:26 -0600 (CST)
Received: from [62.242.22.158] (helo=router.home.kernel.dk)
	by virtualhost.dk with esmtp (Exim 3.36 #1)
	id 1DE21G-0005gQ-00; Wed, 23 Mar 2005 10:19:18 +0100
Received: from wiggum.home.kernel.dk ([192.168.0.27])
	by router.suse.de with esmtp (Exim 4.22)
	id 1DE21E-0000Dp-Sb; Wed, 23 Mar 2005 10:19:16 +0100
Received: from axboe by wiggum.home.kernel.dk with local (Exim 4.44)
	id 1DE21E-0008JT-Nk; Wed, 23 Mar 2005 10:19:16 +0100
Date: Wed, 23 Mar 2005 10:19:16 +0100
From: Jens Axboe <axboe@suse.de>
To: Mark Seger <Mark.Seger@hp.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Patch for inconsistent recording of block device statistics
Message-ID: <20050323091916.GO24105@suse.de>
References: <42409313.1010308@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42409313.1010308@hp.com>
X-PMX-Version: 5.0.0.131485, Antispam-Engine: 2.0.3.0, Antispam-Data: 2005.3.23.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	seeaxp.eng.lkg.hp.com
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00 autolearn=ham 
	version=3.0.2

On Tue, Mar 22 2005, Mark Seger wrote:
> The read/write statistics for both sectors and merges are calculated at 
> the time requests first enter the request queue but the remainder of the 
> statistics, such as the number of read/writes are calculated at the time 
> the I/O completes.  As a result, one cannot accurately determine the 
> data rates read or written at the actual time the I/O is performed.  
> This behavior is masked with smaller queue sizes but is very real and 
> was very noticeable with earlier 2.6 kenels using the cfq scheduler 
> which had a default queue size of 8192 where the time difference between 
> these sets of counters could exceed 10 seconds for large file writes and 
> small monitoring intervals such as 1 second.  In that environment, one 
> would see extremely high bursts of I/O, sometimes exceeding 500 or even 
> 1000 MB/sec for the first second or two and then drop to 0 for a long 
> time while the 'number of operations' counters accurately reflect what 
> is really happening.
> 
> The attached patch fixes this problem by simply accumulating the 
> read/write sector/merge data in temporary variables stored in the 
> request queue entry, and when the I/O completes copies those values to 
> the disk statistics block.

I don't like this patch, it adds 4 * sizeof(unsigned long) to struct
request when it can be solved without adding anything. The idea is
sound, though, the current way the stats are done isn't very
interesting.

How about accounting merges the way we currently do it, since that piece
of the stats _is_ interesting at queueing time. And then account
completion in __end_that_request_first(). Untested patch attached.

===== drivers/block/ll_rw_blk.c 1.287 vs edited =====
--- 1.287/drivers/block/ll_rw_blk.c	2005-03-11 21:32:27 +01:00
+++ edited/drivers/block/ll_rw_blk.c	2005-03-23 10:10:39 +01:00
@@ -2294,16 +2293,12 @@
 	if (!blk_fs_request(rq) || !rq->rq_disk)
 		return;
 
-	if (rw == READ) {
-		__disk_stat_add(rq->rq_disk, read_sectors, nr_sectors);
-		if (!new_io)
+	if (!new_io) {
+		if (rw == READ)
 			__disk_stat_inc(rq->rq_disk, read_merges);
-	} else if (rw == WRITE) {
-		__disk_stat_add(rq->rq_disk, write_sectors, nr_sectors);
-		if (!new_io)
+		else
 			__disk_stat_inc(rq->rq_disk, write_merges);
-	}
-	if (new_io) {
+	} else {
 		disk_round_stats(rq->rq_disk);
 		rq->rq_disk->in_flight++;
 	}
@@ -3063,6 +3069,13 @@
 				(unsigned long long)req->sector);
 	}
 
+	if (blk_fs_request(req)) {
+		if (rq_data_dir(req) == READ)
+			__disk_stat_add(req->rq_disk, read_sectors, nr_bytes >> 9);
+		else
+			__disk_stat_add(req->rq_disk, write_sectors, nr_bytes >> 9);
+	}
+
 	total_bytes = bio_nbytes = 0;
 	while ((bio = req->bio) != NULL) {
 		int nbytes;

-- 
Jens Axboe

--------------030405030006090005080208--

