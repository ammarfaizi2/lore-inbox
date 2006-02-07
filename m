Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030195AbWBGWOp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030195AbWBGWOp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 17:14:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965161AbWBGWOo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 17:14:44 -0500
Received: from smtp.osdl.org ([65.172.181.4]:23184 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965037AbWBGWOo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 17:14:44 -0500
Date: Tue, 7 Feb 2006 14:15:25 -0800
From: Andrew Morton <akpm@osdl.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: npiggin@suse.de, mingo@elte.hu, rostedt@goodmis.org,
       pwil3058@bigpond.net.au, suresh.b.siddha@intel.com,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [rfc][patch] sched: remove smpnice
Message-Id: <20060207141525.19d2b1be.akpm@osdl.org>
In-Reply-To: <200602080157.07823.kernel@kolivas.org>
References: <20060207142828.GA20930@wotan.suse.de>
	<200602080157.07823.kernel@kolivas.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas <kernel@kolivas.org> wrote:
>
> On Wednesday 08 February 2006 01:28, Nick Piggin wrote:
> > I'd like to get some comments on removing smpnice for 2.6.16. I don't
> > think the code is quite ready, which is why I asked for Peter's additions
> > to also be merged before I acked it (although it turned out that it still
> > isn't quite ready with his additions either).
> >
> > Basically I have had similar observations to Suresh in that it does not
> > play nicely with the rest of the balancing infrastructure (and raised
> > similar concerns in my review).
> >
> > The samples (group of 4) I got for "maximum recorded imbalance" on a 2x2
> >
> > SMP+HT Xeon are as follows:
> >            | Following boot | hackbench 20        | hackbench 40
> >
> > -----------+----------------+---------------------+---------------------
> > 2.6.16-rc2 | 30,37,100,112  | 5600,5530,6020,6090 | 6390,7090,8760,8470
> > +nosmpnice |  3, 2,  4,  2  |   28, 150, 294, 132 |  348, 348, 294, 347
> >
> > Hackbench raw performance is down around 15% with smpnice (but that in
> > itself isn't a huge deal because it is just a benchmark). However, the
> > samples show that the imbalance passed into move_tasks is increased by
> > about a factor of 10-30. I think this would also go some way to
> > explaining latency blips turning up in the balancing code (though I
> > haven't actually measured that).
> >
> > We'll probably have to revert this in the SUSE kernel.
> >
> > The other option for 2.6.16 would be to fast track Peter's stuff, which
> > I could put some time into... but that seems a bit risky at this stage
> > of the game.
> >
> > I'd like to hear any other suggestions though. Patch included to aid
> > discussion at this stage, rather than to encourage any rash decisions.
> 
> I see the demonstrable imbalance but I was wondering if there is there a real 
> world benchmark that is currently affected?
> 

Well was any real-world workload (or benchmark) improved by the smpnice
change?

Because if we have one workload which slowed and and none which sped up,
it's a pretty easy decision..
