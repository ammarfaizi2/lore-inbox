Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264944AbTGBKw0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 06:52:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264047AbTGBKtW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 06:49:22 -0400
Received: from smithers.nildram.co.uk ([195.112.4.34]:2064 "EHLO
	smithers.nildram.co.uk") by vger.kernel.org with ESMTP
	id S264928AbTGBKq2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 06:46:28 -0400
Date: Wed, 2 Jul 2003 12:00:16 +0100
From: Joe Thornber <thornber@sistina.com>
To: dm-devel@sistina.com
Cc: Kevin Corry <kevcorry@us.ibm.com>,
       Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [dm-devel] Re: [RFC 3/3] dm: v4 ioctl interface
Message-ID: <20030702110016.GD6243@fib011235813.fsnet.co.uk>
References: <20030701145812.GA1596@fib011235813.fsnet.co.uk> <20030701150246.GD1596@fib011235813.fsnet.co.uk> <200307011505.07184.kevcorry@us.ibm.com> <20030702085951.GB410@fib011235813.fsnet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030702085951.GB410@fib011235813.fsnet.co.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Move unregister_with_devfs() to before the rename.
--- diff/drivers/md/dm-ioctl-v4.c	2003-07-02 11:35:31.000000000 +0100
+++ source/drivers/md/dm-ioctl-v4.c	2003-07-02 11:34:24.000000000 +0100
@@ -301,13 +301,14 @@
 	/*
 	 * rename and move the name cell.
 	 */
+	unregister_with_devfs(hc);
+
 	list_del(&hc->name_list);
 	old_name = hc->name;
 	hc->name = new_name;
 	list_add(&hc->name_list, _name_buckets + hash_str(new_name));
 
 	/* rename the device node in devfs */
-	unregister_with_devfs(hc);
 	register_with_devfs(hc);
 
 	up_write(&_hash_lock);
