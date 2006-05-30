Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932448AbWE3URn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932448AbWE3URn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 16:17:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932458AbWE3URn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 16:17:43 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:58888 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932448AbWE3URm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 16:17:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=hg/EDOQ1dnr3wtBwxj1Bd5qgpTtA+tkx/U9p3+nWagEu5cyWjKvLMrWl2yIIzbpqjbB3Q+qvmCvEc55HzAxcx0O/ekFgp7/wi8cVgXccz1GcDiHttjxAmBR6xhbfAb5mfiRhvAqwuvNEF1GraTP3toWcJlQym0e2Td9IvGL4o0I=
Date: Wed, 31 May 2006 00:18:17 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] blktrace_api.h: endian annotations
Message-ID: <20060530201817.GC7267@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 include/linux/blktrace_api.h |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/include/linux/blktrace_api.h
+++ b/include/linux/blktrace_api.h
@@ -89,13 +89,13 @@ struct blk_io_trace {
 
 /*
  * The remap event
  */
 struct blk_io_trace_remap {
-	u32 device;
+	__be32 device;
 	u32 __pad;
-	u64 sector;
+	__be64 sector;
 };
 
 enum {
 	Blktrace_setup = 1,
 	Blktrace_running,
@@ -223,11 +223,11 @@ static inline void blk_add_trace_generic
  **/
 static inline void blk_add_trace_pdu_int(struct request_queue *q, u32 what,
 					 struct bio *bio, unsigned int pdu)
 {
 	struct blk_trace *bt = q->blk_trace;
-	u64 rpdu = cpu_to_be64(pdu);
+	__be64 rpdu = cpu_to_be64(pdu);
 
 	if (likely(!bt))
 		return;
 
 	if (bio)

