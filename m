Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261378AbVBROgT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261378AbVBROgT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 09:36:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261377AbVBROgT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 09:36:19 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:23950 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261208AbVBROgI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 09:36:08 -0500
Date: Fri, 18 Feb 2005 15:36:04 +0100
From: Jens Axboe <axboe@suse.de>
To: Philip R Auld <pauld@egenera.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bio refcount problem
Message-ID: <20050218143603.GA16511@suse.de>
References: <20050218125414.GA14362@vienna.egenera.com> <20050218135931.GG4056@suse.de> <20050218142607.GB14362@vienna.egenera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050218142607.GB14362@vienna.egenera.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18 2005, Philip R Auld wrote:
> Hi,
> 
> Rumor has it that on Fri, Feb 18, 2005 at 02:59:32PM +0100 Jens Axboe said:
> > On Fri, Feb 18 2005, Philip R Auld wrote:
> 
> ...
> > > Or make all users of submit_bio take and release and extra reference
> > > like submit_bh.
> > 
> > The queue lock is still held at that point, so the driver hasn't had a
> > chance to process the request yet.
> 
> Interesting. This is not a theoretical problem though. I've got traces of 
> the oops showing the bio getting freed before the bio_sync(bio) test. 
> When you say driver here what level do you mean? scsi_request_fn at 
> least drops the queue lock. 

But it must be holding the lock to retrieve the request in question, so
there should be no opening for a completion race there.

> What if it's merged instead of added directly? That could also get to
> the same place.

Same deal - if the request is already seen by the driver, merging is not
allowed. If not, then the same rules apply.

> The end_io callback _is_ getting called before __make_request 
> does its "if(bio_sync(bio))" test. 

Sounds strange, it sounds like a driver issue. If you have time, please
do poke some more at this. I'll try to be responsive, but I'm busy with
other things atm. Are you using a vanilla kernel?

-- 
Jens Axboe

