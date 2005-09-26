Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751613AbVIZIPQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751613AbVIZIPQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 04:15:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751617AbVIZIPQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 04:15:16 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:34851
	"EHLO x30.random") by vger.kernel.org with ESMTP id S1751613AbVIZIPP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 04:15:15 -0400
Date: Mon, 26 Sep 2005 10:14:51 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Dave Kleikamp <shaggy@austin.ibm.com>
Cc: Valdis.Kletnieks@vt.edu, Con Kolivas <kernel@kolivas.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc2-mm1 - ext3 wedging up
Message-ID: <20050926081451.GA2785@x30.random>
References: <200509221959.j8MJxJsY010193@turing-police.cc.vt.edu> <200509231036.16921.kernel@kolivas.org> <200509230720.j8N7KYGX023826@turing-police.cc.vt.edu> <20050923153158.GA4548@x30.random> <1127509047.8880.4.camel@kleikamp.austin.ibm.com> <1127509155.8875.6.camel@kleikamp.austin.ibm.com> <1127511979.8875.11.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1127511979.8875.11.camel@kleikamp.austin.ibm.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2005 at 04:46:19PM -0500, Dave Kleikamp wrote:
> On Fri, 2005-09-23 at 15:59 -0500, Dave Kleikamp wrote:
> > On Fri, 2005-09-23 at 15:57 -0500, Dave Kleikamp wrote:
> > > On Fri, 2005-09-23 at 17:31 +0200, Andrea Arcangeli wrote:
> > > > Hello,
> > > > 
> > > > Can you try this updated patch? I believe the blk_congestion_wait is
> > > > just wrong there, since there may be just one page being flushed. That
> > > > sounds like a longstanding bug except it normally wouldn't trigger
> > > > because the dirty levels never goes down near zero during heavy writes.
> > > 
> > > fsx is now stuck in a loop somewhere, using 100% cpu.
> > 
> > I hit send a little early.  It eventually responded to a ^C.  I'll try
> > to get some more info.
> 
> I'd guess that it's spinning in balance_dirty_pages.
> /proc/<pid>/future_dirty is 25650 for fsx.  It appears that

Ok the good news is that this isn't a bug in the basic algorithm, but
just in the implementation of it.

> nr_reclaimable is not going to zero for some reason.

Exactly, the !nr_reclaimable check is what I thought would have
prevented an infinite loop to trigger...

Unfortunately I couldn't reproduce on my laptop, I was working from the
laptop the whole last week (I even did a presentation with this patch
applied ;), I'll try to reprouce with fsx now.

Thanks for the help!
