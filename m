Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262987AbUCSNdr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 08:33:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262990AbUCSNdr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 08:33:47 -0500
Received: from ns.suse.de ([195.135.220.2]:4332 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262987AbUCSNdp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 08:33:45 -0500
Subject: Re: CONFIG_PREEMPT and server workloads
From: Chris Mason <mason@suse.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: Eric St-Laurent <ericstl34@sympatico.ca>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <s5hu10laxnl.wl@alsa2.suse.de>
References: <40591EC1.1060204@geizhals.at>
	 <20040318060358.GC29530@dualathlon.random> <s5hlllycgz3.wl@alsa2.suse.de>
	 <1079665660.7609.6.camel@orbiter>  <s5hu10laxnl.wl@alsa2.suse.de>
Content-Type: text/plain
Message-Id: <1079703354.11057.116.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 19 Mar 2004 08:35:54 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-03-19 at 06:23, Takashi Iwai wrote:
> At Thu, 18 Mar 2004 22:07:41 -0500,
> Eric St-Laurent wrote:
> > 
> > On Thu, 2004-03-18 at 10:28, Takashi Iwai wrote:
> > 
> > > in my case with reiserfs, i got 0.4ms RT-latency with my test suite
> > > (with athlon 2200+).
> > > 
> > > there is another point to be fixed in the reiserfs journal
> > > transaction.  then you'll get 0.1ms RT-latency without preemption.
> > 
> > Are you talking about the following patch recently merged in Linus tree?
> > 
> > [PATCH] resierfs: scheduling latency improvements
> > http://linus.bkbits.net:8080/linux-2.5/cset@40571b49jtE7PzOtsXjBx65-GoDijg
> 
> i've tested the suse kernel, so the patch above was already in it.
> i'm not sure whether mm tree already includes the all relevant
> fixes... Chris?
> 
The whole reiserfs patcheset from -suse is now at:

ftp.suse.com/pub/people/mason/patches/data-logging/experimental/2.6.4

The mm tree does already have the most important reiserfs latency fix,
which is named reiserfs-lock-lat.  Andrew sent along to linus as well,
so it should be in mainline.

> what i wrote above about is loops in do_journal_end().  but i can't
> tell you surely unless i test the mm kernel again.
> 
The spot you found in do_journal_end still needs the cond_resched.  The
patches above don't include that one yet (I'll upload it today).

-chris


