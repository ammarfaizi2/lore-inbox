Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264396AbTFIOZn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 10:25:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264379AbTFIOYJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 10:24:09 -0400
Received: from smithers.nildram.co.uk ([195.112.4.34]:25864 "EHLO
	smithers.nildram.co.uk") by vger.kernel.org with ESMTP
	id S264393AbTFIOXg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 10:23:36 -0400
Date: Mon, 9 Jun 2003 15:37:11 +0100
From: Joe Thornber <thornber@sistina.com>
To: Joe Thornber <thornber@sistina.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 5/7] dm: Fix memory leak in dm_register_target()
Message-ID: <20030609143711.GF11331@fib011235813.fsnet.co.uk>
References: <20030609142946.GA11331@fib011235813.fsnet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030609142946.GA11331@fib011235813.fsnet.co.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix memory leak in dm_register_target.  [Patrick Caulfield]
--- diff/drivers/md/dm-target.c	2003-06-09 15:05:02.000000000 +0100
+++ source/drivers/md/dm-target.c	2003-06-09 15:05:18.000000000 +0100
@@ -109,9 +109,10 @@
 		return -ENOMEM;
 
 	down_write(&_lock);
-	if (__find_target_type(t->name))
+	if (__find_target_type(t->name)) {
+		kfree(ti);
 		rv = -EEXIST;
-	else
+	} else
 		list_add(&ti->list, &_targets);
 
 	up_write(&_lock);
