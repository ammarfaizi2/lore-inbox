Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270065AbTGMBhM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 21:37:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270066AbTGMBhM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 21:37:12 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:22418 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S270065AbTGMBhL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 21:37:11 -0400
X-AuthUser: davidel@xmailserver.org
Date: Sat, 12 Jul 2003 18:44:28 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: Jamie Lokier <jamie@shareable.org>
cc: Miguel Freitas <miguel@cetuc.puc-rio.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] SCHED_SOFTRR linux scheduler policy ...
In-Reply-To: <20030712185157.GC10450@mail.jlokier.co.uk>
Message-ID: <Pine.LNX.4.55.0307121806560.4720@bigblue.dev.mcafeelabs.com>
References: <1058017391.1197.24.camel@mf> <Pine.LNX.4.55.0307120735540.4351@bigblue.dev.mcafeelabs.com>
 <20030712154942.GB9547@mail.jlokier.co.uk> <Pine.LNX.4.55.0307120845470.4351@bigblue.dev.mcafeelabs.com>
 <20030712162029.GE9547@mail.jlokier.co.uk> <1058028064.1196.111.camel@mf>
 <20030712185157.GC10450@mail.jlokier.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Jul 2003, Jamie Lokier wrote:

> Miguel Freitas wrote:
> > > I'm wondering what happens if the tasks are both good, early to bed
> > > without a fuss.  Neither runs their entire timeslice.
> > >
> > > Or to illustrate: say xine uses 10% of my CPU.  What happens when I
> > > open 11 xine windows?
> >
> > well of course 110% is more than what you have of resources and xine
> > would have to drop frames to keep it up... :)
>
> That's fine.  The problem is, does this completely starve the other
> tasks such as kswapd, ksoftirqd, bash etc.?
>
> The real problem is can a user accidentally or malicious lock up a box
> using SCHED_SOFTRR (when xmms, xine, GNU software radio and modem are
> all using it :), and also what about multi-user boxes, can two users
> accidentally break it.
>
> Perhaps there should be a _global_ maximum amount of CPU used in
> SCHED_SOFTRR beyond which SCHED_SOFTRR tasks get downgraded.

You need per-user policies to achieve fairness, the global allocation
won't work. You need global fairness towards tasks != SOFTRR *and* local
fairness towards tasks == SOFTRR. If you limit globally the maximum time
that SOFTRR tasks can suck, you'll achieve global fairness. But you do not
prevent a single user to suck most of this slice by creating many SOFTRR
tasks (or exploits). I can easily fix this if someone will show real
interest in the thing. Since it has been a while that I was not
looking at the scheduler, yesterday I googled a little bit and I saw
that there are a few issues where you do not need SOFTRR to completely
starve other tasks though (the irman thingy for example). IMHO these
should be discussed before going in 2.6, to either fix them or publicly
recognize them as "Not A Bug".



- Davide

