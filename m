Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264547AbTIDDEM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 23:04:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264549AbTIDDEL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 23:04:11 -0400
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:45009 "EHLO
	mail-in-03.arcor-online.net") by vger.kernel.org with ESMTP
	id S264547AbTIDDEC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 23:04:02 -0400
From: Daniel Phillips <phillips@arcor.de>
To: Steven Cole <elenstev@mesatop.com>
Subject: Re: Scaling noise
Date: Thu, 4 Sep 2003 05:07:41 +0200
User-Agent: KMail/1.5.3
Cc: Antonio Vargas <wind@cocodriloo.com>, Larry McVoy <lm@bitmover.com>,
       CaT <cat@zip.com.au>, Anton Blanchard <anton@samba.org>,
       linux-kernel@vger.kernel.org
References: <20030903040327.GA10257@work.bitmover.com> <200309040350.31949.phillips@arcor.de> <1062641965.3483.78.camel@spc>
In-Reply-To: <1062641965.3483.78.camel@spc>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309040507.41464.phillips@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 04 September 2003 04:19, Steven Cole wrote:
> On Wed, 2003-09-03 at 19:50, Daniel Phillips wrote:
> > There was a time when SMP locking overhead actually cost something in the
> > high single digits on Linux, on certain loads.  Today, you'd have to work
> > at it to find a real load where the 2.5/6 kernel spends more than 1% of
> > its time in locking overhead, even on a large SMP machine (sample size of
> > one: I asked Bill Irwin how his 32 node Numa cluster is running these
> > days).  This blows the ccCluster idea out of the water, sorry.  The only
> > way ccCluster gets to live is if SMP locking is pathetic and it's not.
>
> I would never call the SMP locking pathetic, but it could be improved.
> Looking at Figure 6 (Star-CD, 1-64 processors on Altix) and Figure 7
> (Gaussian 1-32 processors on Altix) on page 13 of "Linux Scalability for
> Large NUMA Systems", available for download here:
> http://archive.linuxsymposium.org/ols2003/Proceedings/
> it appears that for those applications, the curves begin to flatten
> rather alarmingly.  This may have little to do with locking overhead.

2.4.17 is getting a little old, don't you think?  This is the thing that 
changed most in 2.4 -> 2.6, and indeed, much of the work was in locking.

> One possible benefit of using ccClusters would be to stay on that lower
> part of the curve for the nodes, using  perhaps 16 CPUs in a node.  That
> way, a 256 CPU (e.g. Altix 3000) system might perform better than if a
> single kernel were to be used.  I say might.  It's likely that only
> empirical data will tell the tale for sure.

Right, and we do not see SGI contributing patches for partitioning their 256 
CPU boxes.  That's all the empirical data I need at this point.

They surely do partition them, but not at the Linux OS level.

> > As for Karim's work, it's a quintessentially flashy trick to make two UP
> > kernels run on a dual processor.  It's worth doing, but not because it
> > blazes the way forward for ccClusters.  It can be the basis for hot
> > kernel swap: migrate all the processes to one of the two CPUs, load and
> > start a new kernel on the other one, migrate all processes to it, and let
> > the new kernel restart the first processor, which is now idle.
>
> Thank you for that very succinct summary of my rather long-winded
> exposition on that subject which I posted here:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=105214105131450&w=2

I swear I made the above up on the spot, just now :-)

> Quite a bit of the complexity which I mentioned, if it were necessary at
> all, could go into user space helper processes which get spawned for the
> kernel going away, and before init for the on-coming kernel. Also, my
> comment about not being able to shoe-horn two kernels in at once for
> 32-bit arches may have been addressed by Ingo's 4G/4G split.

I don't see what you're worried about, they are separate kernels and you get 
two instances of whatever split you want. 

Regards,

Daniel

