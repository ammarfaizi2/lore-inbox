Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276153AbRI1Qcs>; Fri, 28 Sep 2001 12:32:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276155AbRI1Qci>; Fri, 28 Sep 2001 12:32:38 -0400
Received: from [195.223.140.107] ([195.223.140.107]:65524 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S276153AbRI1QcU>;
	Fri, 28 Sep 2001 12:32:20 -0400
Date: Fri, 28 Sep 2001 18:32:44 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: kuznet@ms2.inr.ac.ru
Cc: mingo@elte.hu, torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        alan@lxorguk.ukuu.org.uk, bcrl@redhat.com
Subject: Re: [patch] softirq performance fixes, cleanups, 2.4.10.
Message-ID: <20010928183244.K24922@athlon.random>
In-Reply-To: <Pine.LNX.4.33.0109261729570.5644-200000@localhost.localdomain> <200109281618.UAA04122@ms2.inr.ac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200109281618.UAA04122@ms2.inr.ac.ru>; from kuznet@ms2.inr.ac.ru on Fri, Sep 28, 2001 at 08:18:20PM +0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2001 at 08:18:20PM +0400, kuznet@ms2.inr.ac.ru wrote:
> Hello!
> 
> >  - removed 'mask' handling from do_softirq() - it's unnecessery due to the
> >    restarts. this further simplifies the code.
> 
> Ingo, but this means that only the first softirq is handled.
> "mask" implements round-robin and this is necessary.

he's allowing to repeat the loop more than once to hide it, to do the
"mask" with repetition correctly we'd need a per-softirq counter, not
just a bitmask so it wouldn't be handy to allocate on the stack, but
it's nothing unfixable.

However I also preferred the previous behaviour, I think it was much
nicer for general purpose (non specweb99 gigabit like scenarios).

> >  - '[ksoftirqd_CPU0]' is confusing on UP systems, changed it to
> >    '[ksoftirqd]' instead.
> 
> It is useless to argue about preferences, but universal naming scheme
> looks as less confusing yet. :-)

Agreed.

> Generally, I dislike this patch. It is utterly ugly.

I also dislike it overall but I can see why it improves performance, and
the deschedule thing makes sense for the flooding case.

I would be very confortable in only merging the deschedule part and this
is why I asked Ingo if he could measure the difference.

Andrea
