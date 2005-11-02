Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932680AbVKBJLG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932680AbVKBJLG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 04:11:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932683AbVKBJLG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 04:11:06 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:56075 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932680AbVKBJLF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 04:11:05 -0500
Date: Wed, 2 Nov 2005 10:10:59 +0100
From: Adrian Bunk <bunk@stusta.de>
To: petero2@telia.com
Cc: linux-kernel@vger.kernel.org, packet-writing@suse.com, ace@staticwave.ca
Subject: [2.6 patch] drivers/block/pktcdvd.c: remove write-only variable in pkt_iosched_process_queue()
Message-ID: <20051102091059.GF8009@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Found this on Coverty's linux bug database (http://linuxbugsdb.coverity.com).

The function pkt_iosched_process_queue makes a call to bdev_get_queue and stores the result but never uses it, so
it looks like it can be safely removed. 

From: Gabriel A. Devenyi <ace@staticwave.ca>

Signed-off-by: Gabriel A. Devenyi <ace@staticwave.ca>
Signed-off-by: Adrian Bunk <bunk@stusta.de>

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

