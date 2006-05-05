Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751543AbWEENF3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751543AbWEENF3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 09:05:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751542AbWEENF3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 09:05:29 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:40056 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751101AbWEENF2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 09:05:28 -0400
Message-ID: <445B4DA9.9040601@de.ibm.com>
Date: Fri, 05 May 2006 15:05:45 +0200
From: Heiko J Schick <schihei@de.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roland Dreier <rdreier@cisco.com>
CC: openib-general@openib.org, Christoph Raisch <RAISCH@de.ibm.com>,
       Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>, Marcus Eder <MEDER@de.ibm.com>,
       linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: Re: [openib-general] [PATCH 07/16] ehca: interrupt handling routines
References: <4450A196.2050901@de.ibm.com> <adaejz9o4vh.fsf@cisco.com>
In-Reply-To: <adaejz9o4vh.fsf@cisco.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Roland,

Roland Dreier wrote:
> It seems that you are deferring completion event dispatch into threads
> spread across all the CPUs.  This seems like a very strange thing to
> me -- you are adding latency and possibly causing cacheline pingpong.
> 
> It may help throughput in some cases to spread the work across
> multiple CPUs but it seems strange to me to do this in the low-level
> driver.  My intuition would be that it would be better to do this in
> the higher levels, and leave open the possibility for protocols that
> want the lowest possible latency to be called directly from the
> interrupt handler.

We've implemented this "spread CQ callbacks across multiple CPUs"
functionality to get better throughput on a SMP system, as you have
seen.

Originaly, we had the same idea as you mentioned, that it would be better
to do this in the higher levels. The point is that we can't see so far
any simple posibility how this can done in the OpenIB stack, the TCP/IP
network layer or somewhere in the Linux kernel.

For example:
For IPoIB we get the best throughput when we do the CQ callbacks on
different CPUs and not to stay on the same CPU.

In other papers and slides (see [1]) you can see similar approaches.

I think such one implementation or functionality could require more
or less a non-trivial changes. This could be also releated to other
I/O traffic.

[1]:  Speeding up Networking, Van Jacobson and Bob Felderman,
       http://www.lemis.com/grog/Documentation/vj/lca06vj.pdf

Regards,
	Heiko

