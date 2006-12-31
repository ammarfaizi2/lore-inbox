Return-Path: <linux-kernel-owner+w=401wt.eu-S933033AbWLaG1N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933033AbWLaG1N (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 01:27:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933034AbWLaG1N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 01:27:13 -0500
Received: from gatekeeper.ncic.ac.cn ([159.226.41.188]:54565 "HELO ncic.ac.cn"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933033AbWLaG1M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 01:27:12 -0500
X-Greylist: delayed 1392 seconds by postgrey-1.27 at vger.kernel.org; Sun, 31 Dec 2006 01:27:01 EST
Message-ID: <459752B6.1020904@ncic.ac.cn>
Date: Sun, 31 Dec 2006 14:03:34 +0800
From: yc_zhou <yc_zhou@ncic.ac.cn>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
MIME-Version: 1.0
To: axboe@kernel.dk, linux-kernel@vger.kernel.org, axboe@suse.de
Subject: [PATCH  2.6.19] Adding branch to remove possible unnecessary inst
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Function blk_queue_bounce_limit using dma flag to determine whether
assigned a certain value for member of request_queue_t. But the
assignment is unconditionally after the flag is set. It introduce
possible unnecessary instructions.


Signed-Off-By: Yingchao Zhou <yc_zhou@ncic.ac.cn>

---
--- linux-2.6.19/block/ll_rw_blk.c.orig 2006-12-31 13:35:22.307742904 +0800
+++ linux-2.6.19/block/ll_rw_blk.c 2006-12-31 13:34:05.032490528 +0800
@@ -606,11 +606,13 @@ void blk_queue_bounce_limit(request_queu
know of a way to test this here. */
if (bounce_pfn < (min_t(u64,0xffffffff,BLK_BOUNCE_HIGH) >> PAGE_SHIFT))
dma = 1;
- q->bounce_pfn = max_low_pfn;
+ else
+ q->bounce_pfn = max_low_pfn;
#else
if (bounce_pfn < blk_max_low_pfn)
dma = 1;
- q->bounce_pfn = bounce_pfn;
+ else
+ q->bounce_pfn = bounce_pfn;
#endif
if (dma) {
init_emergency_isa_pool();

