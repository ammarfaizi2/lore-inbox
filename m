Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264002AbTDJIGH (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 04:06:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264003AbTDJIGH (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 04:06:07 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:64263
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S264002AbTDJIGF (for <rfc822;linux-kernel@vger.kernel.org>); Thu, 10 Apr 2003 04:06:05 -0400
Date: Thu, 10 Apr 2003 01:16:52 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Keith Ansell <keitha@edp.fastfreenet.com>
cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       axboe@suse.de
Subject: Re: bdflush flushing memory mapped pages.
In-Reply-To: <01bc01c2ff9d$0dc1aca0$230110ac@kaws>
Message-ID: <Pine.LNX.4.10.10304100111350.12558-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Keith,

I know what you are asking for and need.
It is a requirement to be "Enterprise".
What you are seeking will take time, and effort.

I have explained successfully to Jens (block maintainer) the issues of
data integrity.  If you can prove this becomes a data integrity issue,
which I know it is for the general case, your argument will have strength.

Nothing stops "fastfreenet.com" from funding the development time.

ASS-GAS-GRASS-CASH, Linux is free but my time is not.

If you want to discuss more of this offline, I will listen and help make
the case.

Cheers,

Andre Hedrick
LAD Storage Consulting Group


On Thu, 10 Apr 2003, Keith Ansell wrote:

> Thank you for your prompt replies.
> 
> I realise that Linux conforms to the letter of the specification, but maybe
> not the spirit of the it.
> 
> I am porting a Database solution to Linux from Unix SVR4, Sco OpenServer and
> AIX, where all write required memory mapped files are flushed to disk with
> the system flusher, my users have large systems (some in excess of 600
> concurrent connections) flushing memory mapped files is a big part of are
> systems performance.  This ensures that in the event of a catastrophic
> system failure the customers vitual business data has been written to disk .
> 
> Keith Ansell
> 
> 
> 
> 
> 
> 
> ----- Original Message -----
> From: "Andrew Morton" <akpm@digeo.com>
> To: "Andre Hedrick" <andre@linux-ide.org>
> Cc: <keitha@edp.fastfreenet.com>; <linux-kernel@vger.kernel.org>;
> <axboe@suse.de>
> Sent: Wednesday, April 09, 2003 10:27 AM
> Subject: Re: bdflush flushing memory mapped pages.
> 
> 
> > Andre Hedrick <andre@linux-ide.org> wrote:
> > >
> > >
> > > Funny you mention this point!
> > >
> > > I just spent 30-45 minutes on the phone talking to Jens about this very
> > > issue.  Jens states he can map the model in to 2.5. and will give it a
> > > fling in a bit.  This issue is a must; however, I had given up on the
> idea
> > > until 2.7.  However, the issues he and I addressed, in combination to
> your
> > > request jive in sync.
> >
> > noooo.....   This isn't going to happen.  There are many reasons.
> >
> > Firstly, how can bdflush even know what pages to write?  The dirtiness of
> > these pages is recorded *only* in some processor's hardware pte cache
> and/or
> > the software pagetables.  Someone needs to go tell all the CPUs to
> writeback
> > their pte caches into the pagetables and then someone needs to walk the
> > pagetables propagating the pte dirty bit into the pageframes before we can
> > even start the I/O.
> >
> > That's what msync does, in filemap_sync().
> >
> >
> > And even if bdflush did this automagically, it's the wrong thing to do
> > because the application could very well be repeatedly dirtying the pages.
> > Very probably.  So we've just gone and done a ton of pointless I/O, over
> and
> > over.
> >
> > You can view MAP_SHARED as an IPC mechanism which uses the filesystem
> > namespace for naming.  No way do these people want bdflush pointlessly
> > hammering the disk.
> >
> > You can also view MAP_SHARED as a (strange) way of writing files out.  If
> you
> > want to do that then fine, but you need to tell the kernel when you've
> > finished, just like write() does.   You do that with msync.
> >
> >
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
> 

