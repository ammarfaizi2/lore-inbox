Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932341AbWFCAKQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932341AbWFCAKQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 20:10:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932590AbWFCAKQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 20:10:16 -0400
Received: from mail03.syd.optusnet.com.au ([211.29.132.184]:39107 "EHLO
	mail03.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932341AbWFCAKP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 20:10:15 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [patch] cfq: ioprio inherit rt class
Date: Sat, 3 Jun 2006 10:10:08 +1000
User-Agent: KMail/1.9.3
Cc: Jens Axboe <axboe@suse.de>, ck list <ck@vds.kolivas.org>
References: <200605271150.41924.kernel@kolivas.org> <20060602171215.GM4400@suse.de>
In-Reply-To: <20060602171215.GM4400@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606031010.08794.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 03 June 2006 03:12, Jens Axboe wrote:
> On Sat, May 27 2006, Con Kolivas wrote:
> > Jens, ml
> >
> > I was wondering if cfq io priorities should be explicitly set to the
> > realtime class when no io priority is specified from realtime tasks as in
> > the following patch? (rt_task() will need to be modified to suit the PI
> > changes in -mm)
>
> Not sure. RT io needs to be considered carefully, but I guess so does RT
> CPU scheduling. For now I'd prefer to play it a little safer, and only
> inheric the priority value and not the class.

The problem I envisioned with that was that realtime tasks, if they don't 
specify an io priority (as most current code doesn't), would basically get io 
priority 4 and have the same proportion as any nice 0 SCHED_NORMAL task 
whereas -nice tasks automatically are getting better io priority. How about 
givent them normal class but best priority so they are at least getting the 
same as nice -20?

-- 
-ck
