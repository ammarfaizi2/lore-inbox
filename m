Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751447AbWIMLBT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751447AbWIMLBT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 07:01:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751453AbWIMLBS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 07:01:18 -0400
Received: from brick.kernel.dk ([62.242.22.158]:11623 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1751447AbWIMLBS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 07:01:18 -0400
Date: Wed, 13 Sep 2006 12:59:32 +0200
From: Jens Axboe <axboe@kernel.dk>
To: Al Boldi <a1426z@gawab.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: What's in linux-2.6-block.git
Message-ID: <20060913105932.GA4792@kernel.dk>
References: <200609131359.04972.a1426z@gawab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200609131359.04972.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13 2006, Al Boldi wrote:
> Jens Axboe  wrote:
> > This lists the main features of the 'block' branch, which is bound for
> > Linus when 2.6.19 opens:
> >
> > - Splitting of request->flags into two parts:
> >         - cmd type
> >         - modified flags
> >   Right now it's a bit of a mess, splitting this up invites a cleaner
> >   usage and also enables us to implement generic "messages" passed on
> >   the regular queue for the device.
> >
> > - Abstract out the request back merging and put it into the core io
> >   scheduler layer. Cleans up all the io schedulers, and noop gets
> >   merging for "free".
> >
> > - Abstract out the rbtree sorting. Gets rid of duplicated code in
> >   as/cfq/deadline.
> >
> > - General shrinkage of the request structure.
> >
> > - Killing dynamic rq private structures in deadline/as/cfq. This should
> >   speed up the io path somewhat, as we avoid allocating several
> >   structures (struct request + scheduler private request) for each io
> >   request.
> >
> > - meta data io logging for blktrace.
> >
> > - CFQ improvements.
> >
> > - Make the block layer configurable through Kconfig (David Howells).
> >
> > - Lots of cleanups.
> 
> Does it also address the strange "max_sectors_kb<>192 causes a 50%-slowdown" 
> problem?

(remember to cc me/others when replying, I can easily miss lkml
messages for several days otherwise).

It does not, the investigation of that is still pending I'm afraid. The
data is really puzzling, I'm inclined to think it's drive related. Are
you reproducing it just one box/drive, or on several?

-- 
Jens Axboe

