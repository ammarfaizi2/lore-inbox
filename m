Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266037AbUBJRx1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 12:53:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266030AbUBJRDm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 12:03:42 -0500
Received: from smithers.nildram.co.uk ([195.112.4.54]:50960 "EHLO
	smithers.nildram.co.uk") by vger.kernel.org with ESMTP
	id S266028AbUBJRB2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 12:01:28 -0500
Date: Tue, 10 Feb 2004 17:02:40 +0000
From: Joe Thornber <thornber@redhat.com>
To: Joe Thornber <thornber@redhat.com>
Cc: Linux Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: [Patch 9/10] dm: Remove redundant spin lock in dec_pending()
Message-ID: <20040210170240.GO27507@reti>
References: <20040210163548.GC27507@reti>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040210163548.GC27507@reti>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove redundant spin lock in dec_pending()
--- diff/drivers/md/dm.c	2004-02-10 16:11:50.000000000 +0000
+++ source/drivers/md/dm.c	2004-02-10 16:12:10.000000000 +0000
@@ -217,14 +217,8 @@
  */
 static inline void dec_pending(struct dm_io *io, int error)
 {
-	static spinlock_t _uptodate_lock = SPIN_LOCK_UNLOCKED;
-	unsigned long flags;
-
-	if (error) {
-		spin_lock_irqsave(&_uptodate_lock, flags);
+	if (error)
 		io->error = error;
-		spin_unlock_irqrestore(&_uptodate_lock, flags);
-	}
 
 	if (atomic_dec_and_test(&io->io_count)) {
 		if (atomic_dec_and_test(&io->md->pending))
