Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751313AbWGWXfD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751313AbWGWXfD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jul 2006 19:35:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751317AbWGWXfD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jul 2006 19:35:03 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:56529 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S1751313AbWGWXfB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jul 2006 19:35:01 -0400
Message-ID: <44C3F99B.9000307@namesys.com>
Date: Sun, 23 Jul 2006 16:35:07 -0600
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Mahoney <jeffm@suse.com>
CC: Jeff Garzik <jeff@garzik.org>, Theodore Tso <tytso@mit.edu>,
       LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org
 regarding reiser4 inclusion
References: <44C12F0A.1010008@namesys.com> <20060722130219.GB7321@thunk.org> <44C26F65.4000103@namesys.com> <44C28A8F.1050408@garzik.org> <44C32348.8020704@namesys.com> <44C3E041.1020909@suse.com> <44C3E6EE.8080607@namesys.com> <44C404C9.6050409@suse.com>
In-Reply-To: <44C404C9.6050409@suse.com>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Mahoney wrote:

>
>
> Anyone up for it? :) There are changes I'd like to see in reiser3,
> particularly ones that address the severe problems observed in David
> Chinner's high bandwidth file system talk this year at OLS. Specifically,
> it ended up making very little progress and spending the majority of the
> time in the journal when the workload is streaming data at the disk at a
> very high rate on a very large file system. Yes, that is certainly XFS's
> sweet spot, but barely making progress at all is a bit more severe than
> "poor performance." Perhaps mkreiserfs should be a bit saner about
> choosing
> journal sizes, since a 32 MB journal is not a good fit for all cases.
> Also,
> I'd like to see the usage of the BKL gone as it severely limits
> performance
> when more than one thread is writing to the file system, or even another
> reiserfs file system. It's not entirely low hanging fruit since the nested
> cases need to be audited, but it shouldn't be too hard to eliminate the
> inter-filesystem lock contention by replacing the BKL with a per-sb mutex.

Getting rid of the BKL is a huge task that was done in V4 for a reason. 
You are talking about 6+ man-months, and years of shake-out to fully
debug.  Actually, it is a tribute to Zam's skill that V4's locking got
debugged so fast: I gave him the task knowing it was going to be the
hardest code to debug, and he did it very well.

These things you discuss, except for the journal size, are not things to
fix in a stable branch.

My apologies that I thought this was a new bug.  Let us be glad that a
user gave us enough detail we saw it.

> I have some more things, but I have nowhere near the time to do them,
> and other file systems will perform fine.
>
>
>
