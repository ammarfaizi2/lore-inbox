Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264923AbTGBKqW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 06:46:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264928AbTGBKqT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 06:46:19 -0400
Received: from mrburns.nildram.co.uk ([195.112.4.54]:11525 "EHLO
	mrburns.nildram.co.uk") by vger.kernel.org with ESMTP
	id S264923AbTGBKop (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 06:44:45 -0400
Date: Wed, 2 Jul 2003 11:59:10 +0100
From: Joe Thornber <thornber@sistina.com>
To: dm-devel@sistina.com
Cc: Kevin Corry <kevcorry@us.ibm.com>,
       Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [dm-devel] Re: [RFC 3/3] dm: v4 ioctl interface
Message-ID: <20030702105910.GA6243@fib011235813.fsnet.co.uk>
References: <20030701145812.GA1596@fib011235813.fsnet.co.uk> <20030701150246.GD1596@fib011235813.fsnet.co.uk> <200307011505.07184.kevcorry@us.ibm.com> <20030702085951.GB410@fib011235813.fsnet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030702085951.GB410@fib011235813.fsnet.co.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Clear the read-only flag if the table is not read only.
--- diff/drivers/md/dm-ioctl-v4.c	2003-07-01 15:36:42.000000000 +0100
+++ source/drivers/md/dm-ioctl-v4.c	2003-07-02 11:27:50.000000000 +0100
@@ -650,7 +650,9 @@
 			return r;
 		}
 
-		if (!(dm_table_get_mode(new_map) & FMODE_WRITE))
+		if (dm_table_get_mode(new_map) & FMODE_WRITE)
+			set_disk_ro(dm_disk(md), 0);
+		else
 			set_disk_ro(dm_disk(md), 1);
 
 		dm_table_put(new_map);
