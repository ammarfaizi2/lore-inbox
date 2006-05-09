Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932421AbWEIM0Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932421AbWEIM0Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 08:26:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932479AbWEIM0Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 08:26:16 -0400
Received: from mtagate2.uk.ibm.com ([195.212.29.135]:15677 "EHLO
	mtagate2.uk.ibm.com") by vger.kernel.org with ESMTP id S932421AbWEIM0P
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 08:26:15 -0400
Message-ID: <44608C90.30909@de.ibm.com>
Date: Tue, 09 May 2006 14:35:28 +0200
From: Heiko J Schick <schihei@de.ibm.com>
Organization: IBM Deutschland Entwicklung GmbH
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Roland Dreier <rdreier@cisco.com>
CC: linux-kernel@vger.kernel.org, openib-general@openib.org,
       linuxppc-dev@ozlabs.org, Christoph Raisch <RAISCH@de.ibm.com>,
       Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>, Marcus Eder <MEDER@de.ibm.com>
Subject: Re: [openib-general] [PATCH 07/16] ehca: interrupt handling routines
References: <4450A196.2050901@de.ibm.com> <adaejz9o4vh.fsf@cisco.com>	<445B4DA9.9040601@de.ibm.com> <adafyjomsrd.fsf@cisco.com>
In-Reply-To: <adafyjomsrd.fsf@cisco.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier wrote:
>     Heiko> Originaly, we had the same idea as you mentioned, that it
>     Heiko> would be better to do this in the higher levels. The point
>     Heiko> is that we can't see so far any simple posibility how this
>     Heiko> can done in the OpenIB stack, the TCP/IP network layer or
>     Heiko> somewhere in the Linux kernel.
> 
>     Heiko> For example: For IPoIB we get the best throughput when we
>     Heiko> do the CQ callbacks on different CPUs and not to stay on
>     Heiko> the same CPU.
> 
> So why not do it in IPoIB then?  This approach is not optimal
> globally.  For example, uverbs event dispatch is just going to queue
> an event and wake up the process waiting for events, and doing this on
> some random CPU not related to the where the process will run is
> clearly the worst possible way to dispatch the event.

Yes, I agree. It would not be an optimal solution, because other upper
level protocols (e.g. SDP, SRP, etc.) or userspace verbs would not be
affected by this changes. Nevertheless, how can an improved "scaling"
or "SMP" version of IPoIB look like. How could it be implemented?

>     Heiko> In other papers and slides (see [1]) you can see similar
>     Heiko> approaches.
> 
>     Heiko> [1]: Speeding up Networking, Van Jacobson and Bob
>     Heiko> Felderman,
>     Heiko> http://www.lemis.com/grog/Documentation/vj/lca06vj.pdf

> I think you've misunderstood this paper.  It's about maximizing CPU
> locality and pushing processing directly into the consumer.  In the
> context of slide 9, what you've done is sort of like adding another
> control loop inside the kernel, since you dispatch from interrupt
> handler to driver thread to final consumer.  So I would argue that
> your approach is exactly the opposite of what VJ is advocating.

Sorry, my idea was not to use the *.pdf file how it should be
implemented. I only wanted to show that other people are also thinking
about how TCP/IP performance could be increased and where the bottlenecks
(e.g. SOFTIRQs) are. :)

Regards,
	Heiko
