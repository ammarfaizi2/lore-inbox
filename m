Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262936AbUCRUay (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 15:30:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262931AbUCRUax
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 15:30:53 -0500
Received: from ns.suse.de ([195.135.220.2]:62168 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262922AbUCRUav (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 15:30:51 -0500
Subject: Re: True  fsync() in Linux (on IDE)
From: Chris Mason <mason@suse.com>
To: Peter Zaitsev <peter@mysql.com>
Cc: Jens Axboe <axboe@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1079641026.2447.327.camel@abyss.local>
References: <1079572101.2748.711.camel@abyss.local>
	 <20040318064757.GA1072@suse.de> <1079639060.3102.282.camel@abyss.local>
	 <20040318194745.GA2314@suse.de>  <1079640699.11062.1.camel@watt.suse.com>
	 <1079641026.2447.327.camel@abyss.local>
Content-Type: text/plain
Message-Id: <1079642001.11057.7.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 18 Mar 2004 15:33:21 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-03-18 at 15:17, Peter Zaitsev wrote:
> On Thu, 2004-03-18 at 12:11, Chris Mason wrote:
> 
> > > I believe some missed set_page_writeback() calls caused fsync() to never
> > > really wait on anything, pretty broken... IIRC, it's fixed in latest
> > > -mm, or maybe it's just pending for next release.
> > 
> > This should have only been broken in -mm.  Which kernels exactly are you
> > comparing?  Maybe the 3ware array defaults to different writecache
> > settings under 2.6?
> 
> I'm trying RH AS 3.0  kernel, however I have the same behavior on my 
> SuSE 8.2 workstation. 
> 
Some suse 8.2 kernels had write barriers for IDE, some did not.  If
you're running any kind of recent suse kernel, you're doing cache
flushes on fsync with ext3.

Not sure if RH has ever carried the patches or not.  Easy enough to test
for on suse, just look for blk_queue_ordered in the System.map.

> I use 2.6.3 kernel for tests now (It is not the latest I know) 
> EXT3 file system.
> 
> 3WARE has writeback cache setting in both cases. 

Then it sounds like your 2.4 is doing flushes.  I'd expect this test to
run very quickly without them.

-chris


