Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262109AbSI3QCr>; Mon, 30 Sep 2002 12:02:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262117AbSI3QCr>; Mon, 30 Sep 2002 12:02:47 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:1517 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S262109AbSI3QCq>;
	Mon, 30 Sep 2002 12:02:46 -0400
Date: Mon, 30 Sep 2002 18:08:00 +0200
From: Jens Axboe <axboe@suse.de>
To: Patrick Mansfield <patmans@us.ibm.com>
Cc: Andrew Morton <akpm@digeo.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] deadline io scheduler
Message-ID: <20020930160800.GH3867@suse.de>
References: <20020925172024.GH15479@suse.de> <3D92A61E.40BFF2D0@digeo.com> <20020926064455.GC12862@suse.de> <20020926065951.GD12862@suse.de> <20020926085445.A22321@eng2.beaverton.ibm.com> <20020930081522.GG27420@suse.de> <20020930083954.A11960@eng2.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020930083954.A11960@eng2.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 30 2002, Patrick Mansfield wrote:
> On Mon, Sep 30, 2002 at 10:15:22AM +0200, Jens Axboe wrote:
> > On Thu, Sep 26 2002, Patrick Mansfield wrote:
> 
> > > I haven't look closely at the block tagging, but for the FCP protocol,
> > > there are no tags, just the type of queueing to use (task attributes)
> > > - like ordered, head of queue, untagged, and some others. The tagging
> > > is normally done on the adapter itself (FCP2 protocol AFAIK). Does this
> > > mean block level queued tagging can't help FCP?
> > 
> > The generic block level tagging is nothing more than tag management. It
> > can 'tag' a request (assigning it an integer tag), and later let you
> > locate that request by giving it the tag.
> > 
> > I suspect you need none of that for FCP. Instead it looks more like you
> > can set the task attributes based on the type of request itself. So you
> > would currently set 'ordered' for a request with REQ_BARRIER set. And
> > you could set 'head of queue' for REQ_URGENT (I'm making this one up
> > :-), etc.
> > 
> > Do you need any request management to deal with FCP queueing? It doesn't
> > sound like it.
> 
> No.
> 
> OK I understand it now - if someone wants to put barrier support in an FCP
> adapter driver something like we have in scsi_populate_tag_msg() would be
> useful, an inline or macro like:
> 
> static inline int scsi_is_ordered(Scsi_Cmnd *SCpnt)
> {
> 	if (SCpnt->request->flags & REQ_BARRIER)
> 		return 1;
> 	else
> 		return 0;
> }

Exactly

-- 
Jens Axboe

