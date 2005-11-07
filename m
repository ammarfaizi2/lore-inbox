Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965129AbVKGVTi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965129AbVKGVTi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 16:19:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965116AbVKGVTh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 16:19:37 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:16644 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S965099AbVKGVTL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 16:19:11 -0500
Date: Mon, 7 Nov 2005 22:19:10 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: petero2@telia.com, linux-kernel@vger.kernel.org, packet-writing@suse.com,
       ace@staticwave.ca
Subject: [2.6 patch] drivers/block/pktcdvd.c: remove write-only variable in pkt_iosched_process_queue()
Message-ID: <20051107211910.GF3847@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Found this on Coverty's linux bug database (http://linuxbugsdb.coverity.com).

The function pkt_iosched_process_queue makes a call to bdev_get_queue and stores the result but never uses it, so
it looks like it can be safely removed. 

this patch was already ACK'ed by Peter Osterlund.



From: Gabriel A. Devenyi <ace@staticwave.ca>

Signed-off-by: Gabriel A. Devenyi <ace@staticwave.ca>
Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 2 Nov 2005

--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -501,14 +501,11 @@ static void pkt_queue_bio(struct pktcdvd
  */
 static void pkt_iosched_process_queue(struct pktcdvd_device *pd)
 {
-	request_queue_t *q;
 
 	if (atomic_read(&pd->iosched.attention) == 0)
 		return;
 	atomic_set(&pd->iosched.attention, 0);
 
-	q = bdev_get_queue(pd->bdev);
-
 	for (;;) {
 		struct bio *bio;
 		int reads_queued, writes_queued;

