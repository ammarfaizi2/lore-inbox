Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261869AbTEQWex (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 May 2003 18:34:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261871AbTEQWex
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 May 2003 18:34:53 -0400
Received: from h68-147-142-75.cg.shawcable.net ([68.147.142.75]:24558 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id S261869AbTEQWew (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 May 2003 18:34:52 -0400
Date: Sat, 17 May 2003 16:47:33 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Jens Axboe <axboe@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] laptop mode, #2
Message-ID: <20030517164733.B10850@schatzie.adilger.int>
Mail-Followup-To: Jens Axboe <axboe@suse.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20030516113309.GY812@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030516113309.GY812@suse.de>; from axboe@suse.de on Fri, May 16, 2003 at 01:33:09PM +0200
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May 16, 2003  13:33 +0200, Jens Axboe wrote:
> +	if (block_dump)
> +		printk("%s: %s block %lu/%u on %s\n", current->comm, rw == WRITE ? "WRITE" : "READ", bh->b_rsector, count, kdevname(bh->b_rdev));

This should be changed to KERN_DEBUG or similar, since if you are logging
kernel messages to disk you get stuck in an infinite loop with block_dump:

kjournald: WRITE block 67416/8 on 03:05
kjournald: WRITE block 67424/8 on 03:05
kjournald: WRITE block 67432/8 on 03:05
kjournald: WRITE block 548144/8 on 03:05
kjournald: WRITE block 67440/8 on 03:05
kjournald: WRITE block 67448/8 on 03:05
kjournald: WRITE block 67456/8 on 03:05
:
:

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

