Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263007AbVBCUWK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263007AbVBCUWK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 15:22:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263773AbVBCUWJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 15:22:09 -0500
Received: from ipcop.bitmover.com ([192.132.92.15]:16288 "EHLO
	postbox.bitmover.com") by vger.kernel.org with ESMTP
	id S263007AbVBCUVB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 15:21:01 -0500
Date: Thu, 3 Feb 2005 12:20:49 -0800
To: Stelian Pop <stelian@popies.net>, "H. Peter Anvin" <hpa@zytor.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] Linux Kernel Subversion Howto
Message-ID: <20050203202049.GC20389@bitmover.com>
Mail-Followup-To: lm@bitmover.com, Stelian Pop <stelian@popies.net>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
References: <20050202155403.GE3117@crusoe.alcove-fr> <200502030028.j130SNU9004640@terminus.zytor.com> <20050203033459.GA29409@bitmover.com> <20050203193220.GB29712@sd291.sivit.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050203193220.GB29712@sd291.sivit.org>
User-Agent: Mutt/1.5.6+20040907i
From: lm@bitmover.com (Larry McVoy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> As Peter said, once every 6 hours is fine. Or even more often, what
> the heck, as I said in a previous post I don't think an incremental
> export is that much costly. It could be done at the same time as
> the -bkX patches...

I'll see what I can do.

> Speaking from the out-BK point of view, what would really be nice
> is better granularity in the CVS export (a 1-1 changeset to CVS commit
> mapping). I know this involves playing with CVS branches and could
> be a bit tricky but should be doable.

I have two problems with this request:

    - The idea that the granularity in CVS is unreasonable is pure
      nonesense.  Here's the data as of this email:

		CVS		BitKeeper [*]
	Deltas	235,956		280,212

    - It is not at all an easy thing to do in CVS, we looked at it and 
      guessed it is about 3 man months of work.

So let's see what's reasonable.  In order for you to get the last 16%
of the granularity, which you need because you want to compete with us,
you'd like us to do another 3 man months of work.  What would you say if
you were me in this situation?

--lm

[*]  Commands used to generate the above data:

BK:
	bk -r prs -hnd:I: | wc -l

CVS:	
	#!/usr/bin/perl -w

	open(F, "find linux-2.5 -name '*,v' |");
	$files = $revs = 0;
	while (<F>) {
		chop;
		open(F2, $_);
		$head = <F2>;
		close(F2);
		unless ($head =~ /head\s+1\.(\d+)/) {
			warn "\n$_ is junk\n";
			next;
		}
		$files++;
		$revs += $1;
		print STDERR "files=$files revs=$revs\r";
	}
	print "\n\nfiles=$files revs=$revs\n";

