Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317468AbSGJCTf>; Tue, 9 Jul 2002 22:19:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317470AbSGJCTe>; Tue, 9 Jul 2002 22:19:34 -0400
Received: from serenity.mcc.ac.uk ([130.88.200.93]:57362 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S317468AbSGJCTd>; Tue, 9 Jul 2002 22:19:33 -0400
Date: Wed, 10 Jul 2002 03:22:08 +0100
From: John Levon <movement@marcelothewonderpenguin.com>
To: Karim Yaghmour <karim@opersys.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, Andrew Morton <akpm@zip.com.au>,
       Andrea Arcangeli <andrea@suse.de>, Rik van Riel <riel@conectiva.com.br>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>,
       "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       linux-kernel@vger.kernel.org, Richard Moore <richardj_moore@uk.ibm.com>,
       bob <bob@watson.ibm.com>
Subject: Re: Enhanced profiling support (was Re: vm lock contention reduction)
Message-ID: <20020710022208.GA56823@compsoc.man.ac.uk>
References: <Pine.LNX.4.44.0207081039390.2921-100000@home.transmeta.com> <3D29DCBC.5ADB7BE8@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D29DCBC.5ADB7BE8@opersys.com>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Boards of Canada - Geogaddi
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 08, 2002 at 02:41:00PM -0400, Karim Yaghmour wrote:

> dentry + offset: on a 32bit machine, this is 8 bytes total per event being
> profiled. This is a lot of information if you are trying you have a high
> volume throughput.

I haven't found that to be significant in profiling overhead, mainly
because the hash table removes some of the "sting" of high sampling
rates (and the interrupt handler dwarfs all other aspects). The
situation is probably different for more general tracing purposes, but
I'm dubious as to the utility of a general tracing mechanism.

(besides, a profile buffer needs a sample context value too, for things
like CPU number and perfctr event number).

> You can almost always skip the dentry since you know scheduling
> changes and since you can catch a system-state snapshot at the begining of
> the profiling. After that, the eip is sufficient and can easily be correlated
> to a meaningfull entry in a file in user-space.

But as I point out in my other post, dentry-offset alone is not as
useful as it could be...

I just don't see a really good reason to introduce insidious tracing
throughout. Both tracing and profiling are ugly ugly things to be doing
by their very nature, and I'd much prefer to keep such intrusions to a
bare minimum.

The entry.S examine-the-registers approach is simple enough, but it's
not much more tasteful than sys_call_table hackery IMHO

regards
john

-- 
"I know I believe in nothing but it is my nothing"
	- Manic Street Preachers
