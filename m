Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271586AbRIFRo1>; Thu, 6 Sep 2001 13:44:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271597AbRIFRoR>; Thu, 6 Sep 2001 13:44:17 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:54794 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S271594AbRIFRoE>; Thu, 6 Sep 2001 13:44:04 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Stephan von Krawczynski <skraw@ithnet.com>
Subject: Re: page_launder() on 2.4.9/10 issue
Date: Thu, 6 Sep 2001 19:51:26 +0200
X-Mailer: KMail [version 1.3.1]
Cc: riel@conectiva.com.br, jaharkes@cs.cmu.edu, marcelo@conectiva.com.br,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33L.0109060851020.31200-100000@imladris.rielhome.conectiva> <20010906122459Z16031-32383+3771@humbolt.nl.linux.org> <20010906151015.69d2afb2.skraw@ithnet.com>
In-Reply-To: <20010906151015.69d2afb2.skraw@ithnet.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010906174422Z16127-26184+6@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On September 6, 2001 03:10 pm, Stephan von Krawczynski wrote:
> > Blindly delaying all the writes in the name of better read performance isn't 
> > the right idea either.  Perhaps we should have a good think about some 
> > sensible mechanism for balancing reads against writes.
> 
> I guess I have the real-world proof for that:
> Yesterday I mastered a CD (around 700 MB) and burned it, I left the equipment
> to get some food and sleep (sometimes needed :-). During this time the machine
> acts as nfs-server and gets about 3 GB of data written to it. Coming back today
> I recognise that deleting the CD image made yesterday frees up about 500 MB of
> physical mem (free mem was very low before). It was obviously held 24 hours for
> no reason, and _not_ (as one would expect) exchanged against the nfs-data. This
> means the caches were full with _old_ data and explains why nfs performance has
> remarkably dropped since 2.2. There is too few mem around to get good
> performance (no matter if read or write). Obviously aging did not work at all,
> there was not a single hit on these (CD image) pages during 24 hours, compared
> to lots on the nfs-data. Even if the nfs-data would only have one single hit,
> the old CD image should have been removed, because it is inactive and _older_.

OK, this is not related to what we were discussing (IO latency).  It's not too
hard to fix, we just need to do a little aging whenever there are allocations,
whether or not there is memory_pressure.  I don't think it's a real problem
though, we have at least two problems we really do need to fix (oom and
high order failures).

--
Daniel
