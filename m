Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261214AbVBCWSp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261214AbVBCWSp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 17:18:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263261AbVBCWP0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 17:15:26 -0500
Received: from sd291.sivit.org ([194.146.225.122]:63406 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S262578AbVBCWBI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 17:01:08 -0500
Date: Thu, 3 Feb 2005 23:00:59 +0100
From: Stelian Pop <stelian@popies.net>
To: lm@bitmover.com, "H. Peter Anvin" <hpa@zytor.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] Linux Kernel Subversion Howto
Message-ID: <20050203220059.GD5028@deep-space-9.dsnet>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>, lm@bitmover.com,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
References: <20050202155403.GE3117@crusoe.alcove-fr> <200502030028.j130SNU9004640@terminus.zytor.com> <20050203033459.GA29409@bitmover.com> <20050203193220.GB29712@sd291.sivit.org> <20050203202049.GC20389@bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050203202049.GC20389@bitmover.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 03, 2005 at 12:20:49PM -0800, Larry McVoy wrote:

> > As Peter said, once every 6 hours is fine. Or even more often, what
> > the heck, as I said in a previous post I don't think an incremental
> > export is that much costly. It could be done at the same time as
> > the -bkX patches...
> 
> I'll see what I can do.

Thanks.

> > Speaking from the out-BK point of view, what would really be nice
> > is better granularity in the CVS export (a 1-1 changeset to CVS commit
> > mapping). I know this involves playing with CVS branches and could
> > be a bit tricky but should be doable.
> 
> I have two problems with this request:

I really don't want to start a new BK flamewar. You asked what could
you do and I said what would be nice to have. End of story.

>     - The idea that the granularity in CVS is unreasonable is pure

I didn't say it was unreasonable, I said it could be better.

>       nonesense.  Here's the data as of this email:
> 
> 		CVS		BitKeeper [*]
> 	Deltas	235,956		280,212

Indeed, for now the differences are rather small. But with more and
more BK trees and more merges between them the proportion will raise.

If Andrew were to start using BK today we could immediately lose
(on the CVS side) a big part of the history.

>     - It is not at all an easy thing to do in CVS, we looked at it and 
>       guessed it is about 3 man months of work.

I may be stupid, but I did write several months ago a bitkeeper to
prcs conversion tool, and this followed BK branches. It's a 269 lines 
python script including documentation. I can send you that if you like.

The script does basically:
	for each bk changeset {
		get cset parent, merge parent, tags, comment, date
		prcs checkout -r bktoprcsbranch(cset) parent
		for each bk changeset rename {
			prcs rename 
		}
		bk export changeset
		if merge parent {
			prcs merge with merge parent
		}
		if cset ends in .1 {
			prcs create branch
		}
		prcs checkin bktoprcsbranch(cset)
		if bk has tag {
			prcs tag
		}
	}

	with bktoprcsbranch(cset) returning the bk 'branch', 
	1 for the 'trunk' and x.y.z for a x.y.z.t revision.

It is a bit difficult to get it right wrt renames, deletes etc, and
it can take quite a while to execute, but 3 man month work is a bit
extreme.

> So let's see what's reasonable.  In order for you to get the last 16%
> of the granularity, which you need because you want to compete with us,
> you'd like us to do another 3 man months of work. What would you say i> you
> were me in this situation? 

I thought the competition was between the tools not the data inside...
Why is that every time someone wants the full history of the kernel
you think it wants to compete with you ? That history is not even a
secret, everybody can get it from BK/web or by running the free
edition of BK (if allowed).

Stelian.
-- 
Stelian Pop <stelian@popies.net>
