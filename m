Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264893AbUFAFvW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264893AbUFAFvW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 01:51:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264894AbUFAFvW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 01:51:22 -0400
Received: from holomorphy.com ([207.189.100.168]:10638 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264893AbUFAFvV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 01:51:21 -0400
Date: Mon, 31 May 2004 22:51:18 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: suparna@in.ibm.com, linux-aio@kvack.org
Subject: [1/2] use aio workqueue in fs/aio.c
Message-ID: <20040601055118.GF2093@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, suparna@in.ibm.com,
	linux-aio@kvack.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Minor aio correction split off from suparna's patches:

Use the dedicated aio workqueue, not keventd, in order to isolate the
rest of the system from aio's demands.

Index: suparna-2.6.7-rc2/fs/aio.c
===================================================================
--- suparna-2.6.7-rc2.orig/fs/aio.c	2004-05-29 23:26:10.000000000 -0700
+++ suparna-2.6.7-rc2/fs/aio.c	2004-05-31 22:06:35.788770000 -0700
@@ -608,7 +608,7 @@
 		spin_lock_irqsave(&ctx->ctx_lock, flags);
 		list_add_tail(&iocb->ki_run_list, &ctx->run_list);
 		spin_unlock_irqrestore(&ctx->ctx_lock, flags);
-		schedule_work(&ctx->wq);
+		queue_work(aio_wq, &ctx->wq);
 	}
 }
 
