Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262368AbTGAOrA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 10:47:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262367AbTGAOrA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 10:47:00 -0400
Received: from mrburns.nildram.co.uk ([195.112.4.54]:1542 "EHLO
	mrburns.nildram.co.uk") by vger.kernel.org with ESMTP
	id S262368AbTGAOq7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 10:46:59 -0400
Date: Tue, 1 Jul 2003 16:01:21 +0100
From: Joe Thornber <thornber@sistina.com>
To: Joe Thornber <thornber@sistina.com>
Cc: Linux Mailing List <linux-kernel@vger.kernel.org>, dm-devel@sistina.com
Subject: [RFC 1/3] dm: fix memory leak
Message-ID: <20030701150121.GB1596@fib011235813.fsnet.co.uk>
References: <20030701145812.GA1596@fib011235813.fsnet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030701145812.GA1596@fib011235813.fsnet.co.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix memory leak.
--- diff/drivers/md/dm-ioctl.c	2003-06-30 10:07:33.000000000 +0100
+++ source/drivers/md/dm-ioctl.c	2003-06-30 11:39:38.000000000 +0100
@@ -238,6 +238,7 @@
 	list_del(&hc->name_list);
 	unregister_with_devfs(hc);
 	dm_put(hc->md);
+	free_cell(hc);
 }
 
 void dm_hash_remove_all(void)
