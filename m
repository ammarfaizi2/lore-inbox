Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318202AbSIFJM3>; Fri, 6 Sep 2002 05:12:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318290AbSIFJM3>; Fri, 6 Sep 2002 05:12:29 -0400
Received: from smtp02.uc3m.es ([163.117.136.122]:33288 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S318202AbSIFJM2>;
	Fri, 6 Sep 2002 05:12:28 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200209060917.g869H5c08220@oboe.it.uc3m.es>
Subject: Re: (fwd) Re: [RFC] mount flag "direct"
In-Reply-To: <5.1.0.14.2.20020906100358.03ed0bf0@pop.cus.cam.ac.uk> from Anton
 Altaparmakov at "Sep 6, 2002 10:08:47 am"
To: Anton Altaparmakov <aia21@cantab.net>
Date: Fri, 6 Sep 2002 11:17:05 +0200 (MET DST)
Cc: "Peter T. Breuer" <ptb@it.uc3m.es>, Daniel Phillips <phillips@arcor.de>,
       Alexander Viro <viro@math.psu.edu>,
       Xavier Bestel <xavier.bestel@free.fr>, david.lang@digitalinsight.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Anton Altaparmakov wrote:"
> At 09:57 06/09/02, Peter T. Breuer wrote:
> >"Anton Altaparmakov wrote:"
> >I've had a look now. I concur that e2fs at least is full of assumptions
> >that it has various different sorts of metadata in memory at all times.
> >I can't rewrite that, or even add a "warning will robinson" callback to
> >vfs, as I intended. What I can do, I think, is ..
> 
> Oh, you saw the light. (-: I can assure you that most file systems make 

The question is if they do it in a way I can read. If I can read it, I
can fix it. There was too much noise inside e2fs to see a point or points
of intercept. So the intercept has to be higher, and ..

> direct_IO, I plan to keep all metadata caching in place, just stop caching 
> the actual file data. That should give maximum performance I think.

But not correct behaviour wrt metadata in a shared disk fs. And your
calculation of "maximum performance" is off. Look, you seem to forget
this:

   suppose that I make the FS twice as slow as before by meddling with
   it to make it sharable

   then I simply share it among 4 nodes to get a two times _speed up_
   overall.

That's the basic idea. Details left to reader.

I.e. I don't care if it gets slower. We are talking thousands of nodes
here. Only the detail of the topology is affected by the real numbers.

> >.. simply do a dput of the fs root directory from time to time, from
> >vfs - whenever I think it is appropriate. As far as I can see from my
> >quick look that may cause the dcache path off that to be GC'ed. And
> >that may be enough to do a few experiments for O_DIRDIRECT.
> 
> What does "GC" mean?

Garbage collection. I assume that either there is a point at which the
dcache is swept or as I free a dentry from the cache its dependents
are swept. I don't know which. Feel free to enlighten me. My question
is simply "is doing a dput of the base directory dentry on the FS
enough to clear the dcache for that FS"?

Peter
