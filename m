Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132862AbRDDR34>; Wed, 4 Apr 2001 13:29:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132864AbRDDR3r>; Wed, 4 Apr 2001 13:29:47 -0400
Received: from gateway.sequent.com ([192.148.1.10]:52743 "EHLO
	gateway.sequent.com") by vger.kernel.org with ESMTP
	id <S132862AbRDDR3i>; Wed, 4 Apr 2001 13:29:38 -0400
Date: Wed, 4 Apr 2001 10:27:21 -0700
From: Mike Kravetz <mkravetz@sequent.com>
To: Fabio Riccardi <fabio@chromium.com>
Cc: Ingo Molnar <mingo@elte.hu>, frankeh@us.ibm.com,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: a quest for a better scheduler
Message-ID: <20010404102721.B1118@w-mikek2.sequent.com>
In-Reply-To: <20010403121308.A1054@w-mikek2.sequent.com> <Pine.LNX.4.30.0104032024290.9285-100000@elte.hu> <20010403154314.E1054@w-mikek2.sequent.com> <3ACA683A.89D24DED@chromium.com> <20010403194700.A1024@w-mikek2.sequent.com> <3ACAA164.BDFF9B4C@chromium.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3ACAA164.BDFF9B4C@chromium.com>; from fabio@chromium.com on Tue, Apr 03, 2001 at 09:21:57PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 03, 2001 at 09:21:57PM -0700, Fabio Riccardi wrote:
> I was actually suspecting that the extra lines in your patch were there for a
> reason :)
> 
> A few questions:
> 
> What is the real impact of a (slight) change in scheduling semantics?
> 
> Under which situation one should notice a difference?

I assume your questions are directed at the difference between local
and global scheduling decisions.  As with most things the impact of
these differences depends on workload.  Most multi-queue scheduler
implementations make local scheduling decisions and depend on load
balancing for system wide fairness.  Schedulers which make global
decisions handle load balancing via their global policy.

The HP multi-queue implementation you are using performs no load
balancing.  Therefore, in a worst case situation you could have
low priority tasks sharing one CPU while high priority tasks are
sharing another.  To be fair, I have talked to the HP people and
this scheduler was never intended to be a general purpose solution.
Therefore, it makes little sense to comment its merits as such.

> As you state in your papers the global decision comes with a cost,
> is it worth it?

My primary motivation for attempting to perform the same global
decisions as the current scheduler was so that meaningful comparisons
could be made.  Also, by using the same global decision policy I
was able to avoid the issue of load balancing.  In most multi-queue
implementations, load balancing algorithms take considerable effort
to get working in a reasonable well performing manner.

> 
> Could you make a port of your thing on recent kernels?

There is a 2.4.2 patch on the web page.  I'll put out a 2.4.3 patch
as soon as I get some time.

-- 
Mike Kravetz                                 mkravetz@sequent.com
IBM Linux Technology Center
