Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750704AbWDSD1E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750704AbWDSD1E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 23:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750722AbWDSD1E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 23:27:04 -0400
Received: from everest.sosdg.org ([66.93.203.161]:41457 "EHLO mail.sosdg.org")
	by vger.kernel.org with ESMTP id S1750704AbWDSD1D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 23:27:03 -0400
Date: Tue, 18 Apr 2006 23:27:02 -0400
From: Coywolf Qi Hunt <qiyong@freeforge.net>
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [patch] cleanup: use blk_queue_stopped
Message-ID: <20060419032702.GA6369@everest.sosdg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: coywolf@mail.sosdg.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This cleanup the source to use blk_queue_stopped.

Signed-off-by: Coywolf Qi Hunt <qiyong@freeforge.net>
---

diff --git a/block/ll_rw_blk.c b/block/ll_rw_blk.c
index e112d1a..1755c05 100644
--- a/block/ll_rw_blk.c
+++ b/block/ll_rw_blk.c
@@ -1554,7 +1554,7 @@ void blk_plug_device(request_queue_t *q)
 	 * don't plug a stopped queue, it must be paired with blk_start_queue()
 	 * which will restart the queueing
 	 */
-	if (test_bit(QUEUE_FLAG_STOPPED, &q->queue_flags))
+	if (blk_queue_stopped(q))
 		return;
 
 	if (!test_and_set_bit(QUEUE_FLAG_PLUGGED, &q->queue_flags)) {
@@ -1587,7 +1587,7 @@ EXPORT_SYMBOL(blk_remove_plug);
  */
 void __generic_unplug_device(request_queue_t *q)
 {
-	if (unlikely(test_bit(QUEUE_FLAG_STOPPED, &q->queue_flags)))
+	if (unlikely(blk_queue_stopped(q)))
 		return;
 
 	if (!blk_remove_plug(q))
