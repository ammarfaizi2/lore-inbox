Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266578AbSLPKCV>; Mon, 16 Dec 2002 05:02:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266487AbSLPKBo>; Mon, 16 Dec 2002 05:01:44 -0500
Received: from cmailg4.svr.pol.co.uk ([195.92.195.174]:26127 "EHLO
	cmailg4.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S266578AbSLPKAQ>; Mon, 16 Dec 2002 05:00:16 -0500
Date: Mon, 16 Dec 2002 10:08:21 +0000
To: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 4/19
Message-ID: <20021216100821.GE7407@reti>
References: <20021211121749.GA20782@reti> <Pine.LNX.4.44.0212151649180.2445-100000@home.transmeta.com> <20021216100457.GA7407@reti>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021216100457.GA7407@reti>
User-Agent: Mutt/1.4i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No need to validate the parameters if we are doing a
REMOVE_ALL command.
--- diff/drivers/md/dm-ioctl.c	2002-12-11 11:50:25.000000000 +0000
+++ source/drivers/md/dm-ioctl.c	2002-12-16 09:40:39.000000000 +0000
@@ -986,6 +986,10 @@
 
 static int validate_params(uint cmd, struct dm_ioctl *param)
 {
+	/* Ignores parameters */
+	if (cmd == DM_REMOVE_ALL_CMD)
+		return 0;
+
 	/* Unless creating, either name of uuid but not both */
 	if (cmd != DM_DEV_CREATE_CMD) {
 		if ((!*param->uuid && !*param->name) ||
