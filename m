Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964855AbVHaRLX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964855AbVHaRLX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 13:11:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964886AbVHaRLX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 13:11:23 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:61872 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S964853AbVHaRLW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 13:11:22 -0400
Date: Wed, 31 Aug 2005 19:11:25 +0200
From: Jens Axboe <axboe@suse.de>
To: jmerkey <jmerkey@utah-nac.org>
Cc: Holger Kiehl <Holger.Kiehl@dwd.de>, Vojtech Pavlik <vojtech@suse.cz>,
       linux-raid <linux-raid@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Where is the performance bottleneck?
Message-ID: <20050831171124.GH4018@suse.de>
References: <Pine.LNX.4.61.0508291811480.24072@diagnostix.dwd.de> <20050829202529.GA32214@midnight.suse.cz> <Pine.LNX.4.61.0508301919250.25574@diagnostix.dwd.de> <20050831071126.GA7502@midnight.ucw.cz> <20050831072644.GF4018@suse.de> <Pine.LNX.4.61.0508311029170.16574@diagnostix.dwd.de> <20050831120714.GT4018@suse.de> <Pine.LNX.4.61.0508311339140.16574@diagnostix.dwd.de> <20050831162053.GG4018@suse.de> <4315C9EB.2030506@utah-nac.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4315C9EB.2030506@utah-nac.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31 2005, jmerkey wrote:
> 
> 
> I have seen an 80GB/sec limitation in the kernel unless this value is 
> changed in the SCSI I/O layer
> for 3Ware and other controllers during testing of 2.6.X series kernels.
> 
> Change these values in include/linux/blkdev.h and performance goes from 
> 80MB/S to over 670MB/S on the 3Ware controller.
> 
> 
> //#define BLKDEV_MIN_RQ    4
> //#define BLKDEV_MAX_RQ    128    /* Default maximum */
> #define BLKDEV_MIN_RQ    4096
> #define BLKDEV_MAX_RQ    8192    /* Default maximum */

That's insane, you just wasted 1MiB of preallocated requests on each
queue in the system!

Please just do

# echo 512 > /sys/block/dev/queue/nr_requests

after boot for each device you want to increase the queue size too. 512
should be enough with the 3ware.

-- 
Jens Axboe

