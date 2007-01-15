Return-Path: <linux-kernel-owner+w=401wt.eu-S1751365AbXAOTMU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751365AbXAOTMU (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 14:12:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751371AbXAOTMU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 14:12:20 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:51481 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751369AbXAOTMT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 14:12:19 -0500
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: V4L-DVB Maintainers <v4l-dvb-maintainer@linuxtv.org>,
       Gerd Hoffmann <kraxel@novell.com>, Gerds Hoffmann <kraxel@suse.de>,
       Andrew Morton <akpm@osdl.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 7/9] V4L/DVB (5069): Fix bttv and friends on 64bit machines
	with lots of memory
Date: Mon, 15 Jan 2007 16:37:06 -0200
Message-id: <20070115183706.PS6698000007@infradead.org>
In-Reply-To: <20070115183647.PS0588920000@infradead.org>
References: <20070115183647.PS0588920000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0-1mdv2007.0 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Gerd Hoffmann <kraxel@novell.com>

We have a DMA32 zone now, lets use it to make sure the card
can reach the memory we have allocated for the video frame
buffers.

Signed-off-by: Gerds Hoffmann <kraxel@suse.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/video/video-buf.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/media/video/video-buf.c b/drivers/media/video/video-buf.c
index f429f49..635d102 100644
--- a/drivers/media/video/video-buf.c
+++ b/drivers/media/video/video-buf.c
@@ -1229,7 +1229,7 @@ videobuf_vm_nopage(struct vm_area_struct
 		vaddr,vma->vm_start,vma->vm_end);
 	if (vaddr > vma->vm_end)
 		return NOPAGE_SIGBUS;
-	page = alloc_page(GFP_USER);
+	page = alloc_page(GFP_USER | __GFP_DMA32);
 	if (!page)
 		return NOPAGE_OOM;
 	clear_user_page(page_address(page), vaddr, page);

