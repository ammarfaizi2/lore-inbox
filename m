Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750733AbVJRNtA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750733AbVJRNtA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 09:49:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750744AbVJRNtA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 09:49:00 -0400
Received: from mail4.hitachi.co.jp ([133.145.228.5]:31660 "EHLO
	mail4.hitachi.co.jp") by vger.kernel.org with ESMTP
	id S1750733AbVJRNs7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 09:48:59 -0400
Date: Tue, 18 Oct 2005 22:47:22 +0900 (JST)
Message-Id: <20051018.224722.126577332.noboru.obata.ar@hitachi.com>
To: lkml@oxley.org
Cc: pavel@ucw.cz, hyoshiok@miraclelinux.com, linux-kernel@vger.kernel.org
Subject: Re: Linux Kernel Dump Summit 2005
From: OBATA Noboru <noboru.obata.ar@hitachi.com>
In-Reply-To: <200510121002.59098.lkml@oxley.org>
References: <200510121002.59098.lkml@oxley.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Oct 2005, Felix Oxley wrote:
> 
> On Wednesday 12 October 2005 09:28, OBATA Noboru wrote:
> 
> >    CMD     | NET TIME (in seconds)          | OUTPUT SIZE (in bytes)
> >   ---------+--------------------------------+------------------------
> >    cp      |  35.94 (usr 0.23, sys 14.16)   | 2,121,438,352 (100.0%)
> >    lzf     |  54.30 (usr 35.04, sys 13.10)  | 1,959,473,330 ( 92.3%)
> >    gzip -1 | 200.36 (usr 186.84, sys 11.73) | 1,938,686,487 ( 91.3%)
> >   ---------+--------------------------------+------------------------
> >
> > Although it is too early to say lzf's compress ratio is good
> > enough, its compression speed is impressive indeed.  
> 
> As you say, the speed of lzf relative to gzip is impressive.
> 
> However if the properties of the kernel dump mean that it is not suitable for 
> compression then surely it is not efficient to spend any time on it.

Sorry, my last result was misleading.  The dumpfile used above
was the one which showed the _worst_ compression ratio.  So it
does not necessarily mean that kernel dump is not suitable for
compression.

I will retest with the normal dumpfiles.

> >And the
> > result also suggests that it is too early to give up the idea of
> > full dump with compression.
> 
> Are you sure? :-)
> If we are talking about systems with 32GB of memory then we must be taking 
> about organisations who can afford an extra 100GB of disk space just for 
> keeping their kernel dump files. 
> 
> I would expect that speed of recovery would always be the primary concern.
> Would you agree?

Well, it should depend on a user.  It seems to be a trade off
between resource-for-dump and problem-traceability.

I have a bitter experience in analyzing a partial dump.  The
dump completely lacks the PTE pages of user processes and I had
to give up analysis then.  A partial dump has a risk of failure
in analysis.

So what I'd suggest is that the level of partial dump should be
tunable by a user, when implemented as a kdump functionality.
Then, a user who want faster recovery or has a limited storage
may choose a partial dump, and a careful user who has plenty of
storage may choose a full dump.

By the way, if the speed of recovery is _really_ the primary
concern for a user, I'd suggest the user to form a cluster to
continue operation by failover.  (Then the crashed node should
have enough time to generate a full dump.)

Regards,

-- 
OBATA Noboru (noboru.obata.ar@hitachi.com)

