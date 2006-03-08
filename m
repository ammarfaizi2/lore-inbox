Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964826AbWCHA1O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964826AbWCHA1O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 19:27:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964835AbWCHA1N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 19:27:13 -0500
Received: from sabe.cs.wisc.edu ([128.105.6.20]:19623 "EHLO sabe.cs.wisc.edu")
	by vger.kernel.org with ESMTP id S964826AbWCHA1N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 19:27:13 -0500
Subject: [PATCH] update max_sectors documentation
From: Mike Christie <michaelc@cs.wisc.edu>
To: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Tue, 07 Mar 2006 18:27:01 -0600
Message-Id: <1141777621.5594.3.camel@max>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,

I was looking over Kai's scsi command size email and was going to try
and add it to some block docs and noticed I did not send the update to
the max_sectors biodoc.txt. Sorry about that. Here is the patch against
2.6.16-rc5.

The max_sectors has been split into max_hw_sectors and max_sectors for some
time. A patch to have blk_queue_max_sectors enforce this was sent by
me and it broke IDE. This patch updates the documentation.


--- linux-2.6.16-rc5/Documentation/block/biodoc.txt	2006-02-26 23:09:35.000000000 -0600
+++ linux-2.6.16-rc5.work/Documentation/block/biodoc.txt	2006-03-07 18:10:57.000000000 -0600
@@ -132,8 +132,18 @@ Some new queue property settings:
 		limit. No highmem default.
 
 	blk_queue_max_sectors(q, max_sectors)
-		Maximum size request you can handle in units of 512 byte
-		sectors. 255 default.
+		Sets two variables that limit the size of the request.
+
+		- The request queue's max_sectors, which is a soft size in
+		in units of 512 byte sectors, and could be dynamically varied
+		by the core kernel.
+
+		- The request queue's max_hw_sectors, which is a hard limit
+		and reflects the maximum size request a driver can handle
+		in units of 512 byte sectors.
+
+		The default for both max_sectors and max_hw_sectors is
+		255. The upper limit of max_sectors is 1024.
 
 	blk_queue_max_phys_segments(q, max_segments)
 		Maximum physical segments you can handle in a request. 128


