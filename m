Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261210AbUKIDrY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261210AbUKIDrY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 22:47:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261229AbUKIDqL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 22:46:11 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:940 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S261210AbUKIDp7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 22:45:59 -0500
Subject: PATCH (Trivial): Fix dm_io.c oops in low memory conditions.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>, Linus Torvalds <torvalds@osdl.org>
Content-Type: text/plain
Message-Id: <1099971769.10988.6.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Tue, 09 Nov 2004 14:44:45 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

If you call drivers/md/dm-io.c:resize_pool on an empty pool and
mempool_create is unable to make the pool, the condition is not handled
correctly, resulting in an oops in mempool_destroy.

Please apply.

Regards,

Nigel

diff -ruN 900-dm-low-memory-fix-old/drivers/md/dm-io.c 900-dm-low-memory-fix-new/drivers/md/dm-io.c
--- 900-dm-low-memory-fix-old/drivers/md/dm-io.c	2004-11-09 14:35:09.234557768 +1100
+++ 900-dm-low-memory-fix-new/drivers/md/dm-io.c	2004-11-09 13:34:36.000000000 +1100
@@ -265,7 +265,7 @@
 		/* create new pool */
 		_io_pool = mempool_create(new_ios, alloc_io, free_io, NULL);
 		if (!_io_pool)
-			r = -ENOMEM;
+			return -ENOMEM;
 
 		r = bio_set_init(&_bios, "dm-io", 512, 1);
 		if (r) {

-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

You see, at just the right time, when we were still powerless, Christ
died for the ungodly.		-- Romans 5:6

