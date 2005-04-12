Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262417AbVDLNC2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262417AbVDLNC2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 09:02:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262420AbVDLNB1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 09:01:27 -0400
Received: from smtp209.mail.sc5.yahoo.com ([216.136.130.117]:6744 "HELO
	smtp209.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262417AbVDLMut (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 08:50:49 -0400
Message-ID: <425BC421.9010302@yahoo.com.au>
Date: Tue, 12 Apr 2005 22:50:41 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Jens Axboe <axboe@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Subject: [patch 6/9] blk: unplug later
References: <425BC262.1070500@yahoo.com.au>
In-Reply-To: <425BC262.1070500@yahoo.com.au>
Content-Type: multipart/mixed;
 boundary="------------020707010400020204020209"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020707010400020204020209
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

6/9

-- 
SUSE Labs, Novell Inc.

--------------020707010400020204020209
Content-Type: text/plain;
 name="blk-unplug-later.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="blk-unplug-later.patch"

get_request_wait needn't unplug the device immediately.

Signed-off-by: Nick Piggin <nickpiggin@yahoo.com.au>

Index: linux-2.6/drivers/block/ll_rw_blk.c
===================================================================
--- linux-2.6.orig/drivers/block/ll_rw_blk.c	2005-04-12 22:26:13.000000000 +1000
+++ linux-2.6/drivers/block/ll_rw_blk.c	2005-04-12 22:26:14.000000000 +1000
@@ -1955,7 +1955,6 @@ static struct request *get_request_wait(
 	DEFINE_WAIT(wait);
 	struct request *rq;
 
-	generic_unplug_device(q);
 	do {
 		struct request_list *rl = &q->rq;
 
@@ -1967,6 +1966,7 @@ static struct request *get_request_wait(
 		if (!rq) {
 			struct io_context *ioc;
 
+			generic_unplug_device(q);
 			io_schedule();
 
 			/*

--------------020707010400020204020209--

