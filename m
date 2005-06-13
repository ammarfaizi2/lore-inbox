Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261276AbVFMUNp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261276AbVFMUNp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 16:13:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261266AbVFMULl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 16:11:41 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:22204 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261255AbVFMUK2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 16:10:28 -0400
Date: Mon, 13 Jun 2005 13:10:46 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Karim Yaghmour <karim@opersys.com>
Cc: Andrea Arcangeli <andrea@suse.de>, Bill Huey <bhuey@lnxw.com>,
       Lee Revell <rlrevell@joe-job.com>, Tim Bird <tim.bird@am.sony.com>,
       linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@elte.hu,
       pmarques@grupopie.com, bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au,
       ak@muc.de, sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org
Subject: Re: Attempted summary of "RT patch acceptance" thread
Message-ID: <20050613201046.GE1305@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20050610230836.GD21618@nietzsche.lynx.com> <20050610232955.GH6564@g5.random> <20050611014133.GO1300@us.ibm.com> <20050611155459.GB5796@g5.random> <20050611210417.GC1299@us.ibm.com> <42AB7857.1090907@opersys.com> <20050612214519.GB1340@us.ibm.com> <42ACE2D3.9080106@opersys.com> <20050613144022.GA1305@us.ibm.com> <42ADE334.4030002@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42ADE334.4030002@opersys.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2005 at 03:49:08PM -0400, Karim Yaghmour wrote:
> 
> Paul E. McKenney wrote:
> > OK...  Then the idea is to dynamically redirect the symbolic link
> > to include/linux-srt or include/linux-srt that you mentioned in your
> > previous email, or is the symlink serving some other purpose?
> 
> What I'm suggesting is that rt patches shouldn't touch the existing
> codebase. Instead, functionality having to do with rt should be
> integrated in separate directories, and depending the way you
> configure the kernel, include/linux would point to either
> include/linux-srt or include/linux-hrt, much like include/asm
> points to one of inclux/asm-*.

I would guess that the end result would be a mixed strategy, where some
things (e.g., the existing CONFIG_PREEMPT) are intermingled with the
rest of the Linux code based, while other things (e.g., nanokernel
implementations) are in separate directories.  But this is quickly
getting -way- outside of my area.

So I must leave this aspect of the discussion to others.

> > So your focus is on system calls that can have totally separate
> > realtime and non-realtime implementations?  Or am I missing some
> > trick here?
> 
> There's no trick. It's just a layout thing. Hope the above
> explains what I'm trying to say.

OK.  However, should the discussion get to the point where something
like RTAI-Fusion has realtime versions of system calls that have
globally-visible side-effects (such as I/O, networking, IPC, ...),
then the issue of how to get the non-realtime and the realtime variants
to play nicely with each other will arise.

It may well be that system calls containing such side-effects need to be
Linux-only, or maybe someone will come up with the necessary tricks to
make it all work nicely.  Not particularly worried about it myself --
yet, anyway.  There are plenty of things to worry about before we get
to that point!

> > How are you and Kristian looking to benchmark/compare the various
> > combinations you call out above?  Seems like one would have to look
> > at more than straight scheduling/interrupt latency to make a reasonable
> > comparison.
> 
> I'm not sure that benchmarking would be relevant. This is just a
> integration/layout/configuration/build suggestion. I don't think
> that this organization will change anything to the benchmark
> results.

Sorry, side issue.

I was responding to your list of combinations of CONFIG_PREEMPT_RT, Adeos,
and Fusion, assuming (probably incorrectly) that you and Kristian were
looking to compare all the possible combinations.  If my assumption is
incorrect, then my question was irrelevant, and I apologize for the noise.

						Thanx, Paul
