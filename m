Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261919AbTEVPFw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 11:05:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261928AbTEVPFw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 11:05:52 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:59066 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261919AbTEVPFv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 11:05:51 -0400
Date: Thu, 22 May 2003 17:18:56 +0200
From: Jens Axboe <axboe@suse.de>
To: Mathew Spencer <Matthew.Spencer@eu.sony.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Fwd: blk_congestion_wait() with linux-2.5.68]
Message-ID: <20030522151856.GJ812@suse.de>
References: <1053617008.8679.280.camel@jeckle>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1053617008.8679.280.camel@jeckle>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 22 2003, Mathew Spencer wrote:
> I have been using 2.4.19 successfully for a while now with an PCI IDE
> disk drive with no problems whatsoever.  I recently upgraded to 2.5.68
> (so that I could use the most recent ieee1394 drivers) and also to start
> experimenting with the new version of the kernel and since then I am
> having problems formatting the hard disk.
> 
> When I run mke2fs, it manages to write out the first 12 or 13 blocks
> successfully, but then the code gets stuck continually calling
> blk_congestion_wait() from balance_dirty_pages().
> 
> This is the only time that I see this problem.  If the disk is already
> formatted, then mounting/reading/writing to the disk happens without any
> problems at all.
> 
> Is anyone out there aware of this problem?

Any messages in dmesg? It sounds like io to the drive stops completely,
and that is why you see mke2fs being stuck in blk_congestion_wait
(mke2fs eats most of the requests, the queue gets marked congested). If
io isn't progressing, then the queue won't have the congestion flag
cleared again.

You need to give a lot more hardware details, see REPORTING-BUGS

-- 
Jens Axboe

