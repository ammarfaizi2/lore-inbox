Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263001AbUKYHF1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263001AbUKYHF1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Nov 2004 02:05:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263005AbUKYHBG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Nov 2004 02:01:06 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:30109 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262999AbUKYG7s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Nov 2004 01:59:48 -0500
Date: Thu, 25 Nov 2004 07:58:36 +0100
From: Jens Axboe <axboe@suse.de>
To: Greg KH <greg@kroah.com>
Cc: Maneesh Soni <maneesh@in.ibm.com>,
       "Christopher S. Aker" <caker@theshore.net>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc2-bk7 - kernel BUG at fs/sysfs/file.c:87!
Message-ID: <20041125065836.GB10233@suse.de>
References: <002c01c4d25b$3e8b9b10$0201a8c0@hawk> <20041124204138.GA2543@in.ibm.com> <20041124211800.GQ13847@suse.de> <20041124213231.GA3132@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041124213231.GA3132@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24 2004, Greg KH wrote:
> On Wed, Nov 24, 2004 at 10:18:00PM +0100, Jens Axboe wrote:
> > On Wed, Nov 24 2004, Maneesh Soni wrote:
> > > On Wed, Nov 24, 2004 at 07:26:43PM +0000, Christopher S. Aker wrote:
> > > > Doing "cat /sys/block/sda/queue/iosched/show_status" produces the following BUG:
> > > > 
> > > > ------------[ cut here ]------------
> > > > kernel BUG at fs/sysfs/file.c:87!
> > > 
> > > I think you are using cfq io scheduler. show_status is from cfq_ioched. Looks 
> > > like return value freom cfq_status_show() is going beyond one page. 
> > > read/write buffer for sysfs text attribute files is limited to one page. 
> > 
> > Yeah, with many processes that is easy to hit. I dunno how to fix it
> > yet, is it possible to combine sysfs with the seq stuff? The file should
> > just be deleted, though.
> 
> sysfs files should have only 1 value per file.  You really have a single
> value that is bigger than a page size?  :)

It's pi with a lot of decimals :)

I know, it's a debug entry to be able to watch what is going on inside
the scheduler. Everything doesn't fit nicely into a one-value-per-file
system.

-- 
Jens Axboe

