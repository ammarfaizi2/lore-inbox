Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263875AbTGBKtE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 06:49:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264934AbTGBKqJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 06:46:09 -0400
Received: from mrburns.nildram.co.uk ([195.112.4.54]:38149 "EHLO
	mrburns.nildram.co.uk") by vger.kernel.org with ESMTP
	id S264928AbTGBKpa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 06:45:30 -0400
Date: Wed, 2 Jul 2003 11:59:54 +0100
From: Joe Thornber <thornber@sistina.com>
To: dm-devel@sistina.com
Cc: Kevin Corry <kevcorry@us.ibm.com>,
       Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [dm-devel] Re: [RFC 3/3] dm: v4 ioctl interface
Message-ID: <20030702105954.GC6243@fib011235813.fsnet.co.uk>
References: <20030701145812.GA1596@fib011235813.fsnet.co.uk> <20030701150246.GD1596@fib011235813.fsnet.co.uk> <200307011505.07184.kevcorry@us.ibm.com> <20030702085951.GB410@fib011235813.fsnet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030702085951.GB410@fib011235813.fsnet.co.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If dm_add_wait_queue() fails we need to set TASK_RUNNING.
--- diff/drivers/md/dm-ioctl-v4.c	2003-07-02 11:32:42.000000000 +0100
+++ source/drivers/md/dm-ioctl-v4.c	2003-07-02 11:32:23.000000000 +0100
@@ -719,6 +719,7 @@
 		schedule();
 		dm_remove_wait_queue(md, &wq);
 	}
+ 	set_current_state(TASK_RUNNING);
 
 	/*
 	 * The userland program is going to want to know what
