Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbTIXEIE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 00:08:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261380AbTIXEIE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 00:08:04 -0400
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:34580 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S261151AbTIXEIB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 00:08:01 -0400
Date: Wed, 24 Sep 2003 00:06:16 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Andrea Arcangeli <andrea@suse.de>
cc: Larry McVoy <lm@work.bitmover.com>, Larry McVoy <lm@bitmover.com>,
       <andrea@kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Matthew Wilcox <willy@debian.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
Subject: Re: log-buf-len dynamic
In-Reply-To: <20030924034612.GQ16314@velociraptor.random>
Message-ID: <Pine.LNX.4.44.0309232356060.17335-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Sep 2003, Andrea Arcangeli wrote:
> On Tue, Sep 23, 2003 at 08:16:02PM -0700, Larry McVoy wrote:
> > Yeah.  I'm using the Linux VM.  And it _still_ isn't up to what I managed
> > to accomplish in SunOS.  Wake up, dude.  You aren't the first one to
> 
> I heard arguments like yours for years and years from tons of different
> people, 7 years ago I heard the very same again and again about linux
> at large compared to other operative systems (way before I was using
> linux myself).

And you know what?  Larry is right that the Linux VM still
lacks a number of things, like being robust under heavy
overload situations, etc...

Yes, the Linux VM is fast, but that isn't much good if you
can drive it into a death spiral with a single load spike.

> Personally I don't believe you. I'm not saying the vm is too complex,
> but it's heavily dominatd by details, it's simply not possible to
> unique describe the vm in terms of algorithms like most parers do, and I
> believe what we have in linux (mainline 2.4.23pre5 and 2.6 [modulo
> rmap]) is very optimal.

You'll want to catch up to the 1990's some day.  Maybe even
to the current decade.  For example, it's pretty much proven
that lru-like algorithms (like in 2.4-rmap) are suboptimal,
while the use-once stuff in 2.4 mainline and 2.6 is only
metastable, meaning that it doesn't recover from load spikes
except through some combination of clever tricks and sheer
luck, that works only under some loads.

Likewise, the way we write out dirty pages on page replacement
just can't scale to huge amounts of memory, because it'd take
minutes to write out all of the pages on the inactive list. The
non-blocking VM stuff akpm implemented for 2.6 should alleviate
that on medium sized systems, but on truly huge systems we'll
need a page laundering strategy that also improves CPU efficiency
when faced with dozens of gigabytes of inactive pages.

I'll happily concede that you are the absolute champion when it
comes to tuning the VM to get the best possible benchmark numbers,
but that is just not the same as trying to deal with all the corner
cases people run into in real life.

Larry really does have a point.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

