Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131116AbQLJXLJ>; Sun, 10 Dec 2000 18:11:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131138AbQLJXLA>; Sun, 10 Dec 2000 18:11:00 -0500
Received: from zero.tech9.net ([209.61.188.187]:22788 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S131116AbQLJXKw>;
	Sun, 10 Dec 2000 18:10:52 -0500
Date: Sun, 10 Dec 2000 17:40:26 -0500 (EST)
From: "Robert M. Love" <rml@tech9.net>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] Matrox DRM (mga_dma.c) tq fix Was: Re: Compile Failure:
 mga_dma.o on 2.4.0-test12-pre8
In-Reply-To: <Pine.LNX.4.30.0012101501160.17790-100000@phantasy.awol.org>
Message-ID: <Pine.LNX.4.30.0012101737480.18138-100000@phantasy.awol.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


i previously reported a problem with mga_dma.c not compiling due to the
new schedule task queue updates. below is a patch to use the new task
queue system.

-- 
Robert M. Love
rml@ufl.edu
rml@tech9.net

--- linux/drivers/char/drm/mga_dma.c~   Sun Dec 10 17:35:17 2000
+++ linux/drivers/char/drm/mga_dma.c    Sun Dec 10 17:35:37 2000
@@ -818,7 +818,7 @@
        dev->dma->next_buffer = NULL;
        dev->dma->next_queue  = NULL;
        dev->dma->this_buffer = NULL;
-       dev->tq.next          = NULL;
+       INIT_LIST_HEAD(&dev->tq.list);
        dev->tq.sync          = 0;
        dev->tq.routine       = mga_dma_task_queue;
        dev->tq.data          = dev;

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
