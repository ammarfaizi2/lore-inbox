Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317054AbSFWQLk>; Sun, 23 Jun 2002 12:11:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317056AbSFWQLj>; Sun, 23 Jun 2002 12:11:39 -0400
Received: from mail.storm.ca ([209.87.239.66]:14290 "EHLO mail.storm.ca")
	by vger.kernel.org with ESMTP id <S317054AbSFWQLi>;
	Sun, 23 Jun 2002 12:11:38 -0400
Message-ID: <3D15E629.1706DE98@storm.ca>
Date: Sun, 23 Jun 2002 11:15:53 -0400
From: Sandy Harris <pashley@storm.ca>
Organization: Flashman's Dragoons
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux, the microkernel (was Re: latest linus-2.5 BK broken)
References: <E17LUyA-0001wU-00@starship> <200206220107.g5M17AXp028825@sleipnir.valparaiso.cl> <20020621182337.T23670@work.bitmover.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy wrote:

> The interesting thing is to look at the ways you'd deal with a 1024 processors
> and then work backwards to see how you scale it down to 1.  There is NO WAY
> to scale a fine grain threaded system which works on a 1024 system down to
> a 1 CPU system, those are profoundly different.
> 
> I think you could take the OS cluster idea and scale it up as well as down.
> Scaling down is really important, Linux works well in the embedded space,
> that is probably the greatest financial success story that Linux has, let's
> not screw it up.

Assuming we can get 4-way right, methinks Larry's ideas are likely to be a
whole lot easier way to handle a 32 or 64-way box than trying to re-design
the kernel sufficiently to do that well without destroying anything
important in the 1<= nCPU <= 4 case. Especially so because 16 to 64-way 
clusters are common as dirt, and we can borrow tested tools. Anything that
works on a 16-box Beowulf ought to adapt nicely to a 64-way box with 16
of Larry's OSlets.

However, it is a lot harder to see that Larry's stuff is the right way
to deal with a 1024-CPU system. At that point, you've got perhaps 256
4-way groups running OSlets. How does communication overhead scale, and
do we have reason to suppose it is tolerable at 1024? 

Also, it isn't as clear that clustering experience applies. Are clusters
that size built hierachically? Is a 1024-CPU Beowulf practical, and if so
do you build it as a Beowulf of 32 32-CPU Beowulfs? Is something analogous
required in the OSlet approach? would it work?
