Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262213AbUCHJI4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 04:08:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262298AbUCHJI4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 04:08:56 -0500
Received: from [139.30.44.16] ([139.30.44.16]:12725 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S262213AbUCHJIx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 04:08:53 -0500
Date: Mon, 8 Mar 2004 10:08:48 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Arthur Corliss <corliss@digitalmages.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: 2.6.x BSD Process Accounting w/High UID
In-Reply-To: <Pine.LNX.4.58.0403071535290.1733@bifrost.nevaeh-linux.org>
Message-ID: <Pine.LNX.4.53.0403080921420.6609@gockel.physik3.uni-rostock.de>
References: <Pine.LNX.4.44.0403041451360.20043-100000@chimarrao.boston.redhat.com>
 <Pine.LNX.4.58.0403041103500.24930@bifrost.nevaeh-linux.org>
 <Pine.LNX.4.53.0403042242190.29818@gockel.physik3.uni-rostock.de>
 <Pine.LNX.4.58.0403041324330.20616@bifrost.nevaeh-linux.org>
 <Pine.LNX.4.53.0403071820190.32060@gockel.physik3.uni-rostock.de>
 <Pine.LNX.4.58.0403071535290.1733@bifrost.nevaeh-linux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Cc: trimmed]

On Sun, 7 Mar 2004, Arthur Corliss wrote:

> On Sun, 7 Mar 2004, Tim Schmielau wrote:
> 
> > But the current tools are only broken for the few people using high UIDs
> > (and generally on 64 bit archs, but that's a different story).
> 
> This is broken on x86 as well.  I guess I still have to question the logic of
> logging bad data, even if you think the data is infrequent at best.

Seems like I didn't get your point. What is broken on x86 other than high 
UIDs?

> > We shouldn't require people to recompile their userspace tools in the
> > middle of a stable kernel series. (OK, 2.6 has just started, but we don't
> > want to offend people upgrading from 2.4, either.)
> 
> I can understand this argument, and I would certainly agree for things that
> are commonly used.  But given the state of the BSD accounting tools (a package
> that hasn't had a public update since 1998, and which has non-high uid broken
> bits in it as well) I would hazard a guess that the impacted users is going to
> be minimal, at best.

In which way are the BSD accounting tools broken? I'm unfamiliar with 
them, but this might indeed allow us to estimate the user base.

> > How about the patch below? It requires a change to userspace tools if you
> > want to use high uids, but it dosn't break binary compatibility. It even
> > allows userspace to check whether high UIDs are supported, and allows
> > future incompatible format changes to be detected.
> 
> I like it, and the addition of ac_version is a great idea.  I might alter the
> comment about 64-bit machines in acct.c, though.  32-bit UIDs affects 32-bit
> machines as well.

The chunk with the 64-bit comment actually is independent of the high UID
problem. It's there to prevent logging of wromng data on 64-bit arches, 
and is completely optimized away by the compiler on 32 bit ones.
I could as well separate it into a different patch.

I'll do a new version of the patch anyways, as I missed to change another 
comment.

> > Well, they are not totally meaningless since we clip at the maximum
> > representable value instead of wrapping around.
> 
> :-P I don't look at this any different than the byte-clipping we're doing with
> UIDs.  If we're logging data that's wrong, then you can't do accurate
> accounting, period.

Yes, but how often do your users use more that 49 days of cputime?

I'll wait a bit to see whether my other posting generates any feedback.

Tim
