Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292265AbSBYUJo>; Mon, 25 Feb 2002 15:09:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288801AbSBYUHl>; Mon, 25 Feb 2002 15:07:41 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:62729 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S288748AbSBYUGj>;
	Mon, 25 Feb 2002 15:06:39 -0500
Message-ID: <3C7A98FF.3E92DC8C@zip.com.au>
Date: Mon, 25 Feb 2002 12:05:19 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-rc2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Steve Lord <lord@sgi.com>
CC: Jens Axboe <axboe@suse.de>, Andi Kleen <ak@suse.de>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] only irq-safe atomic ops
In-Reply-To: <3C7A939D.FCAE9096@zip.com.au>,
		<1014449389.1003.149.camel@phantasy.suse.lists.linux.kernel>
		<3C774AC8.5E0848A2@zip.com.au.suse.lists.linux.kernel>
		<3C77F503.1060005@sgi.com.suse.lists.linux.kernel>
		<p73y9hjq5mw.fsf@oldwotan.suse.de> <3C78045C.668AB945@zip.com.au>
		<3C780702.9060109@sgi.com> <3C780CDA.FEAF9CB4@zip.com.au>
		<3C781362.7070103@sgi.com> <3C781909.F69D8791@zip.com.au>
		<3C7A35FF.5040508@sgi.com> <20020225131218.GO11837@suse.de>
		<3C7A398A.1060300@sgi.com>  <3C7A939D.FCAE9096@zip.com.au> <1014666322.9227.368.camel@jen.americas.sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve Lord wrote:
> 
> On Mon, 2002-02-25 at 13:42, Andrew Morton wrote:
> > Stephen Lord wrote:
> > >
> > > Yep, bio just made it easier to get larger requests.
> > >
> >
> > Which promptly go kersplat when you feed them into
> > submit_bio():
> >
> >      BUG_ON(bio_sectors(bio) > q->max_sectors);
> >
> > Given that I'm hand-rolling a monster bio, I need to know
> > when to wrap it up and send it off, to avoid creating a bio
> > which is larger than the target device will accept.  I'm currently
> > using the below patch.   Am I right that this is missing API
> > functionality, or did I miss something?
> >
> 
> I don't run into that one, but probably because I limit xfs to
> use BIO_MAX_SECTORS, take a look at ll_rw_kio to see how that
> splits things up. This of course does not take into account
> any further restriction in an underlying queue.

Ah, yes.  I looked at that, and promptly ignored it :)

Too small, too hard-wired.  If the underlying device can
cope with megabyte requests, why restrict it to 64k?  Let's
push the envelope a bit, rather than creating more must-fixes
for 2.7.x.

-
