Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750731AbWHTKp2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750731AbWHTKp2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 06:45:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750733AbWHTKp2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 06:45:28 -0400
Received: from filfla-vlan276.msk.corbina.net ([213.234.233.49]:3552 "EHLO
	screens.ru") by vger.kernel.org with ESMTP id S1750731AbWHTKp1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 06:45:27 -0400
Date: Sun, 20 Aug 2006 19:09:29 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Jens Axboe <axboe@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] sys_ioprio_set: minor do_each_thread+break fix
Message-ID: <20060820150929.GA1577@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From include/linux/sched.h:
	/*
	 * Careful: do_each_thread/while_each_thread is a double loop so
	 *          'break' will not work as expected - use goto instead.
	 */

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.18-rc4/fs/ioprio.c~2_break	2006-07-16 01:53:08.000000000 +0400
+++ 2.6.18-rc4/fs/ioprio.c	2006-08-20 18:57:38.000000000 +0400
@@ -111,9 +111,9 @@ asmlinkage long sys_ioprio_set(int which
 					continue;
 				ret = set_task_ioprio(p, ioprio);
 				if (ret)
-					break;
+					goto free_uid;
 			} while_each_thread(g, p);
-
+free_uid:
 			if (who)
 				free_uid(user);
 			break;

