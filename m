Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312498AbSFXLKE>; Mon, 24 Jun 2002 07:10:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312558AbSFXLKD>; Mon, 24 Jun 2002 07:10:03 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:14196 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S312498AbSFXLKC>; Mon, 24 Jun 2002 07:10:02 -0400
To: Sandy Harris <pashley@storm.ca>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux, the microkernel (was Re: latest linus-2.5 BK broken)
References: <E17LUyA-0001wU-00@starship>
	<200206220107.g5M17AXp028825@sleipnir.valparaiso.cl>
	<20020621182337.T23670@work.bitmover.com> <3D15E629.1706DE98@storm.ca>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 24 Jun 2002 04:59:43 -0600
In-Reply-To: <3D15E629.1706DE98@storm.ca>
Message-ID: <m13cvdrlgg.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sandy Harris <pashley@storm.ca> writes:

> Larry McVoy wrote:
> 
> > The interesting thing is to look at the ways you'd deal with a 1024 processors
> 
> > and then work backwards to see how you scale it down to 1.  There is NO WAY
> > to scale a fine grain threaded system which works on a 1024 system down to
> > a 1 CPU system, those are profoundly different.
> > 
> > I think you could take the OS cluster idea and scale it up as well as down.
> > Scaling down is really important, Linux works well in the embedded space,
> > that is probably the greatest financial success story that Linux has, let's
> > not screw it up.
> 
> Assuming we can get 4-way right, methinks Larry's ideas are likely to be a
> whole lot easier way to handle a 32 or 64-way box than trying to re-design
> the kernel sufficiently to do that well without destroying anything
> important in the 1<= nCPU <= 4 case. Especially so because 16 to 64-way 
> clusters are common as dirt, and we can borrow tested tools. Anything that
> works on a 16-box Beowulf ought to adapt nicely to a 64-way box with 16
> of Larry's OSlets.

I wonder sometimes.   With a 16 way cluster practically any tool will
work and not give you problems.  I don't think many of the tools have
progressed beyond the make it work stage, and into polish yet.
 
> However, it is a lot harder to see that Larry's stuff is the right way
> to deal with a 1024-CPU system. At that point, you've got perhaps 256
> 4-way groups running OSlets. How does communication overhead scale, and
> do we have reason to suppose it is tolerable at 1024? 

The rule is to communicate as little as possible.  Because even if you
have a very low latency interconnect, with insane amounts of
bandwidth, it is needed for your application, not for cluster
management services.

> Also, it isn't as clear that clustering experience applies. Are clusters
> that size built hierachically? Is a 1024-CPU Beowulf practical, and if so
> do you build it as a Beowulf of 32 32-CPU Beowulfs? Is something analogous
> required in the OSlet approach? would it work?

A cluster with 960 compute nodes (each 2way) is being built for
Lawrence Livermore National Lab.  http://www.llnl.gov/linux/mcr/.
The insane part is the Lustre filesystem is going to be a 32 Node
cluster in and of itself.

So there will be experience out there.

Eric



