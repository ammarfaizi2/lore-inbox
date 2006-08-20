Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750934AbWHTQpF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750934AbWHTQpF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 12:45:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750900AbWHTQpE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 12:45:04 -0400
Received: from filfla-vlan276.msk.corbina.net ([213.234.233.49]:63369 "EHLO
	screens.ru") by vger.kernel.org with ESMTP id S1750933AbWHTQpD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 12:45:03 -0400
Date: Mon, 21 Aug 2006 01:09:03 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Jens Axboe <axboe@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] cfq_cic_link: fix? usage of wrong cfq_io_context
Message-ID: <20060820210903.GA6123@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Obviously, cfq_cic_link() shouldn't free a just allocated cfq_io_context ?

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.18-rc4/block/cfq-iosched.c~7_set	2006-08-20 21:23:25.000000000 +0400
+++ 2.6.18-rc4/block/cfq-iosched.c	2006-08-21 00:53:27.000000000 +0400
@@ -1561,7 +1561,7 @@ restart:
 		/* ->key must be copied to avoid race with cfq_exit_queue() */
 		k = __cic->key;
 		if (unlikely(!k)) {
-			cfq_drop_dead_cic(ioc, cic);
+			cfq_drop_dead_cic(ioc, __cic);
 			goto restart;
 		}
 

