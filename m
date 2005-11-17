Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750819AbVKQNfU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750819AbVKQNfU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 08:35:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750820AbVKQNfT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 08:35:19 -0500
Received: from mail3.netbeat.de ([193.254.185.27]:51688 "HELO mail3.netbeat.de")
	by vger.kernel.org with SMTP id S1750819AbVKQNfT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 08:35:19 -0500
Subject: [PATCH linux-2.6-14-mm2] block: problem unloading I/O-Scheduler
	Module
From: Dirk Henning Gerdes <mail@dirk-gerdes.de>
To: Tejun Heo <htejun@gmail.com>, Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4357B10E.7010608@gmail.com>
References: <20051019123429.450E4424@htj.dyndns.org>
	 <20051019123429.D377069C@htj.dyndns.org> <20051020112109.GC2811@suse.de>
	 <20051020135124.GB26004@htj.dyndns.org> <20051020141104.GQ2811@suse.de>
	 <4357AB3F.1050004@gmail.com> <20051020144108.GR2811@suse.de>
	 <4357B10E.7010608@gmail.com>
Content-Type: text/plain
Date: Thu, 17 Nov 2005 14:34:24 +0100
Message-Id: <1132234464.4856.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If you have compiled an I/O-Scheduler as module you cannot unload it,
because of a memory-error.

Signed-off-by: Dirk Gerdes mail@dirk-gerdes.de

--- linux-2.6.14-mm2-pagecache/block/elevator.c	2005-11-17
12:37:10.000000000 +0100
+++ linux-2.6.14-mm2-pagecache_fix/block/elevator.c	2005-11-17
14:05:41.000000000 +0100
@@ -656,7 +656,7 @@
 		struct io_context *ioc = p->io_context;
 		struct cfq_io_context *cic;
 
-		if (ioc->cic_root.rb_node != NULL) {
+		if (ioc != NULL && ioc->cic_root.rb_node != NULL) {
 			cic = rb_entry(rb_first(&ioc->cic_root), struct cfq_io_context,
rb_node);
 			cic->exit(ioc);
 			cic->dtor(ioc);


