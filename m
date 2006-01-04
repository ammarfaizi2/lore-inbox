Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751508AbWADAoM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751508AbWADAoM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 19:44:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751509AbWADAoL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 19:44:11 -0500
Received: from smtp.osdl.org ([65.172.181.4]:27847 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751508AbWADAoK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 19:44:10 -0500
Date: Tue, 3 Jan 2006 16:43:51 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: [PATCH] Fix the zone reclaim code in 2.6.15
Message-Id: <20060103164351.658a75c7.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.62.0601031556120.23039@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.62.0601031457300.22676@schroedinger.engr.sgi.com>
	<20060103152923.2f5bbfe9.akpm@osdl.org>
	<Pine.LNX.4.62.0601031556120.23039@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <clameter@engr.sgi.com> wrote:
>
> On Tue, 3 Jan 2006, Andrew Morton wrote:
> 
> > Christoph Lameter <clameter@engr.sgi.com> wrote:
> > >
> > > Some bits for zone reclaim exists in 2.6.15 but they are not usable.
> > >  This patch fixes them up, removes unused code and makes zone reclaim usable.
> > >
> > 
> > You know that there are over 100 mm/ patches in -mm.  If Linus applies this
> > patch, it will cause extensive wreckage.  And this patch doesn't vaguely
> > apply to the mm/ patches which I have queued.  So it's basically useless.
> > 
> > Please try to play along.
> 
> Well, this is one case where there is crap in Linus tree that needs to be 
> fixed. Its an urgent issue. And the existing patches in mm do not fix 
> this issue but remove the code altogether. When I asked you to remove 
> these patches, you got mad at me for some reason.

The code in Linus's tree is dead and is unused.

> > yes, it's awkward that there's such a large backlog in that area.  We just
> > need to be patient and extra careful.
> 
> So you are saying we need to remove this feature and then add it back in 
> later?

Yes.  It's cleaner to remove all the dead stuff and to then reintroduce the
new feature as a clean, standalone thing.  So we can see its effects ore
clearly.

Also, what happens if for some reason we later want to revert your patch? 
Such a reversion would reintroduce all the old dead stuff!

Patches should each do a single thing.

> This means another 2 and 3 release cycles with this severe unfixed 
> problem?

There's plenty of time to get this into 2.6.16.

Your changelog didn't describe this as a "severe" problem.  Things have
been like this for quite some time, haven't they?

And we shouldn't be merging new, untested things ahead of work which has
had considerable amounts of testing.
