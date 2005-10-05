Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932558AbVJEHMa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932558AbVJEHMa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 03:12:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932560AbVJEHMa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 03:12:30 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:40322 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932558AbVJEHMa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 03:12:30 -0400
Date: Wed, 5 Oct 2005 03:12:08 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
To: Thomas Gleixner <tglx@linutronix.de>
cc: Mark Knecht <markknecht@gmail.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc3-rt2
In-Reply-To: <1128458707.13057.68.camel@tglx.tec.linutronix.de>
Message-ID: <Pine.LNX.4.58.0510050255410.20622@localhost.localdomain>
References: <20051004084405.GA24296@elte.hu> <43427AD9.9060104@cybsft.com> 
 <20051004130009.GB31466@elte.hu>  <5bdc1c8b0510040944q233f14e6g17d53963a4496c1f@mail.gmail.com>
  <5bdc1c8b0510041111n188b8e14lf5a1398406d30ec4@mail.gmail.com> 
 <1128450029.13057.60.camel@tglx.tec.linutronix.de> 
 <5bdc1c8b0510041158m3620f5dcy2dafda545ad3cd5e@mail.gmail.com>
 <1128458707.13057.68.camel@tglx.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


First, Please don't send to my kihontech.com account.  That's my email
that my customers use and I would really like to keep the spam noise down
an that account.  Thanks!

On Tue, 4 Oct 2005, Thomas Gleixner wrote:

> On Tue, 2005-10-04 at 11:58 -0700, Mark Knecht wrote:
> > > I guess its related to the priority leak I'm tracking down right now.
> > > Can you please set following config options and check if you get a bug
> > > similar to this ?
> > >
> > > BUG: init/1: leaked RT prio 98 (116)?
> > >
> > > Steven, it goes away when deadlock detection is enabled. Any pointers
>
> Thats actually a red hering caused by asymetric accounting which only
> happens when
>
> CONFIG_DEBUG_PREEMPT=y
> and
> # CONFIG_RT_DEADLOCK_DETECT is not set
>

Yep, I was going let you know but it seems you already figured it out :-)
The CONFIG_RT_DEADLOCK_DETECT turns on the trace_lock which makes all
locks run serially.  Without CONFIG_RT_DEADLOCK_DETECT, the importance of
the pi_lock of the task is greater.  So If something was changed that
didn't properly lock the pi_lock, then there could be problems with the
locking.

So looking at the patch you sent, are you saying that the leak was a false
positive?

I'm just starting to look at -rt7, and will be testing it today.

-- Steve

