Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750964AbVJIVzR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750964AbVJIVzR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Oct 2005 17:55:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751024AbVJIVzQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Oct 2005 17:55:16 -0400
Received: from pne-smtpout2-sn2.hy.skanova.net ([81.228.8.164]:37872 "EHLO
	pne-smtpout2-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S1750964AbVJIVzP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Oct 2005 17:55:15 -0400
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>
Subject: Re: [2.6.13] pktcdvd: IO-errors
References: <Pine.LNX.4.60.0509242057001.4899@poirot.grange>
	<m3slvtzf72.fsf@telia.com>
	<Pine.LNX.4.60.0509252026290.3089@poirot.grange>
	<m34q873ccc.fsf@telia.com>
	<Pine.LNX.4.60.0509262122450.4031@poirot.grange>
	<m3slvr1ugx.fsf@telia.com>
	<Pine.LNX.4.60.0509262358020.6722@poirot.grange>
	<m3hdc4ucrt.fsf@telia.com>
	<Pine.LNX.4.60.0509292116260.11615@poirot.grange>
	<m3k6gw86f0.fsf@telia.com>
	<Pine.LNX.4.60.0510092304550.14767@poirot.grange>
From: Peter Osterlund <petero2@telia.com>
Date: 09 Oct 2005 23:54:59 +0200
In-Reply-To: <Pine.LNX.4.60.0510092304550.14767@poirot.grange>
Message-ID: <m3psqewe30.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guennadi Liakhovetski <g.liakhovetski@gmx.de> writes:

> On Sun, 2 Oct 2005, Peter Osterlund wrote:
> 
> > OK, in that case this patch for 2.6.12 should work as well, because
> > all it does compared to the previous patch is to remove the now unused
> > high_prio_read variables. Can you confirm that it works?
> 
> Yes, it does.

In that case, this patch should also work. Does it?

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index d4b9c17..cb6bda9 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -538,7 +538,7 @@ static void pkt_iosched_process_queue(st
 			spin_unlock(&pd->iosched.lock);
 			if (bio && (bio->bi_sector == pd->iosched.last_write))
 				need_write_seek = 0;
-			if (need_write_seek && reads_queued) {
+			if (!writes_queued && reads_queued) {
 				if (atomic_read(&pd->cdrw.pending_bios) > 0) {
 					VPRINTK("pktcdvd: write, waiting\n");
 					break;

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
