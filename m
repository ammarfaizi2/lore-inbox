Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261582AbUE0GUK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261582AbUE0GUK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 02:20:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbUE0GUK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 02:20:10 -0400
Received: from ipcop.bitmover.com ([192.132.92.15]:15017 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S261582AbUE0GUD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 02:20:03 -0400
Date: Wed, 26 May 2004 23:20:02 -0700
From: Larry McVoy <lm@bitmover.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFD] Explicitly documenting patch submission
Message-ID: <20040527062002.GA20872@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just read the whole thread and I can't help but wonder if you aren't
trying to solve the 5% problem while avoiding the 95% problem.  Right now,
because of how patches are fanned in through maintainers, lots and lots
of patches are going into the SCM system (BK and/or CVS since that is
derived from BK) as authored by a handful of people.  Just go look at
the stats: http://linux.bkbits.net:8080/linux-2.5/stats?nav=index.html
As productive as Andrew is I find it difficult to believe he has
personally authored more than 5000 patches.  He hasn't, he doesn't
pretend to have done so but we are not getting the authorship right.

Solve that problem and you are lightyears closer to having an audit trail.
You currently aren't recording the original author and you are trying
to record all the people who touched the patch along the way.  If you
can't get the easy part right what makes you think you are going to get
the hard part right?

Before the obligatory BK flames start up, note this is a problem that
you would have with any SCM system.  The problem has nothing to do with
which SCM system you use, it has to do with recording authorship.

I think it's great that you are looking for a better audit trail but
I think it is strange that you are trying to get a perfect audit trail
when you don't even have the basics in place.  What was it that you said,
"Perfect is the enemy of good", right?  In my opinion the 99% part of
the problem space is who wrote the patch, not who passed it on.  If, and
that's a big if, you get to the point where you have proper authorship
recorded and then you still want to record the path it took, that's a
different matter.  The way you are going about it I think you may end
up with nothing by trying to be so perfect.  If I'm wrong, what's wrong
with fixing things so that you get the authorship right and then extend
to get the full path right?

This leaves aside the issue that patches can get applied multiple times
(and do all the time, I think we've counted thousands or tens of thousands
of this in the kernel history).

For what it is worth, we've actually thought through what you are trying
to do long ago and calculated the amount of metadata you'd end up carrying
around and found it to be way way way way too large for an SCM system to
justify.  It's unlikely we'd ever want full audit trails in BK because
patches tend to flow through multiple trees and get merged with other 
patches, etc.  The thing we found useful was who wrote the patch and in
what context.

We did change BK a few revs back to record both the importer and the
patch author when people use your import scripts (bk import -temail)
so we have a 2 deep audit trail already.  More than that seems like
overkill.

The more I think about it the more I wonder what problem it is you are 
trying to solve with the A->B->C->D->Linus audit trail.  Legally, the
issue is going to be with A more than anyone else.  What am I missing?
-- 
---
Larry McVoy                lm at bitmover.com           http://www.bitkeeper.com
