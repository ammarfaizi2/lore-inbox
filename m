Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261811AbSI3Pev>; Mon, 30 Sep 2002 11:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262077AbSI3Peu>; Mon, 30 Sep 2002 11:34:50 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:43715 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261811AbSI3Peq>; Mon, 30 Sep 2002 11:34:46 -0400
Date: Mon, 30 Sep 2002 08:39:54 -0700
From: Patrick Mansfield <patmans@us.ibm.com>
To: Jens Axboe <axboe@suse.de>
Cc: Andrew Morton <akpm@digeo.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] deadline io scheduler
Message-ID: <20020930083954.A11960@eng2.beaverton.ibm.com>
References: <20020925172024.GH15479@suse.de> <3D92A61E.40BFF2D0@digeo.com> <20020926064455.GC12862@suse.de> <20020926065951.GD12862@suse.de> <20020926085445.A22321@eng2.beaverton.ibm.com> <20020930081522.GG27420@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20020930081522.GG27420@suse.de>; from axboe@suse.de on Mon, Sep 30, 2002 at 10:15:22AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 30, 2002 at 10:15:22AM +0200, Jens Axboe wrote:
> On Thu, Sep 26 2002, Patrick Mansfield wrote:

> > I haven't look closely at the block tagging, but for the FCP protocol,
> > there are no tags, just the type of queueing to use (task attributes)
> > - like ordered, head of queue, untagged, and some others. The tagging
> > is normally done on the adapter itself (FCP2 protocol AFAIK). Does this
> > mean block level queued tagging can't help FCP?
> 
> The generic block level tagging is nothing more than tag management. It
> can 'tag' a request (assigning it an integer tag), and later let you
> locate that request by giving it the tag.
> 
> I suspect you need none of that for FCP. Instead it looks more like you
> can set the task attributes based on the type of request itself. So you
> would currently set 'ordered' for a request with REQ_BARRIER set. And
> you could set 'head of queue' for REQ_URGENT (I'm making this one up
> :-), etc.
> 
> Do you need any request management to deal with FCP queueing? It doesn't
> sound like it.

No.

OK I understand it now - if someone wants to put barrier support in an FCP
adapter driver something like we have in scsi_populate_tag_msg() would be
useful, an inline or macro like:

static inline int scsi_is_ordered(Scsi_Cmnd *SCpnt)
{
	if (SCpnt->request->flags & REQ_BARRIER)
		return 1;
	else
		return 0;
}

-- Patrick Mansfield
