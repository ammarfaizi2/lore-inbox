Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262907AbUCRTtA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 14:49:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262903AbUCRTsv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 14:48:51 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:45751 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262907AbUCRTrr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 14:47:47 -0500
Date: Thu, 18 Mar 2004 20:47:46 +0100
From: Jens Axboe <axboe@suse.de>
To: Peter Zaitsev <peter@mysql.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: True  fsync() in Linux (on IDE)
Message-ID: <20040318194745.GA2314@suse.de>
References: <1079572101.2748.711.camel@abyss.local> <20040318064757.GA1072@suse.de> <1079639060.3102.282.camel@abyss.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1079639060.3102.282.camel@abyss.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18 2004, Peter Zaitsev wrote:
> On Wed, 2004-03-17 at 22:47, Jens Axboe wrote:
> 
> > > There is solution just to disable drive write cache, but it seems to
> > > slowdown performance way to much.
> > 
> > Chris and I have working real fsync() with the barrier patches. I'll
> > clean it up and post a patch for vanilla 2.6.5-rc today.
> 
> Good to hear. How is it going to work from user point of view ? 
> Just fsync working back again or there would be some special handling.

It's just going to work :)

> Also. What is about  fsync() in 2.6 nowadays ?
> 
> I've done some tests on 3WARE RAID array and it looks like  it is
> different compared to 2.4 I've been testing previously. 
> 
> I have the simple test which has single page writes to the file followed
> by fsync().   First run give you the case when file grows with each
> write, second when you're writing to existing file space.
> 
> The results I have on 2.4 is something like  40 sec per 1000 fsyncs for 
> new file, and 0.6 sec for existing file.
> 
> With 2.6.3 I have  both existing file and new file to complete in less
> than 1 second. 

I believe some missed set_page_writeback() calls caused fsync() to never
really wait on anything, pretty broken... IIRC, it's fixed in latest
-mm, or maybe it's just pending for next release.

-- 
Jens Axboe

