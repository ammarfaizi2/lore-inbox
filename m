Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263175AbTJERRL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 13:17:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263178AbTJERRL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 13:17:11 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:62990 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S263175AbTJERRI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 13:17:08 -0400
Date: Sun, 5 Oct 2003 19:26:12 +0200
To: Rik van Riel <riel@redhat.com>, David Ashley <dash@xdr.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Idea for improving linux buffer cache behaviour
Message-ID: <20031005172612.GA8432@hh.idb.hist.no>
References: <200310041534.h94FYv0X007015@xdr.com> <Pine.LNX.4.44.0310041513150.14750-100000@chimarrao.boston.redhat.com> <20031005053458.GC1205@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031005053458.GC1205@matchmail.com>
User-Agent: Mutt/1.5.4i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 04, 2003 at 10:34:58PM -0700, Mike Fedyk wrote:
> On Sat, Oct 04, 2003 at 03:14:14PM -0400, Rik van Riel wrote:
> > On Sat, 4 Oct 2003, David Ashley wrote:
> > 
> > > Forgive me if this has already been thought of, or is obsolete, or is
> > > just plain a bad idea, but here it is:
> > 
> > Do you also want an answer if the kernel already does
> > exactly what you are suggesting ? ;)
> > 
> 
> Then why doesn't it work better?
> 
> > > 1) Lowest access count looked at first to toss
> > > 2) If access counts equal, throw out oldest first
> > 
> > > The net result is commonly used items you very much want to remain in
> > > cache always quickly get rated very highly as the system is used.
> > 
> > Which results in exactly the behaviour you're complaining
> > about ;))
> 
> So, you use the system, have glibc loaded, and then play a dvd, and now
> glibc needs to be re-read because it's not in cache.
> 
> Why wasn't glibc (one example) kept in cache with the streaming read from
> the dvd?

There may be many reasons here, take a look at how many times the
dvd contents were used.  You may get a surprise there.  
The number ought to be 1, right?  But the burner program may read
smaller chunks or something, causing many references to the same block.

Also, the number-of-references approach has its own problems.
Something that is used a lot for a while will stay in cache for
a long while when no longer used, taking up space.  That can be
a problem too - i.e. run some large simulation which fill up
memory for a while, and nothing else stays in cache afterwards.

Helge Hafting
