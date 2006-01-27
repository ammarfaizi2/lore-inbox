Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932499AbWA0Tw1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932499AbWA0Tw1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 14:52:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932501AbWA0Tw1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 14:52:27 -0500
Received: from ns1.siteground.net ([207.218.208.2]:35755 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S932500AbWA0TwZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 14:52:25 -0500
Date: Fri, 27 Jan 2006 11:52:27 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: Andrew Morton <akpm@osdl.org>, davem@davemloft.net,
       linux-kernel@vger.kernel.org, shai@scalex86.org, netdev@vger.kernel.org,
       pravins@calsoftinc.com
Subject: Re: [patch 3/4] net: Percpufy frequently used variables -- proto.sockets_allocated
Message-ID: <20060127195227.GA3565@localhost.localdomain>
References: <20060126185649.GB3651@localhost.localdomain> <20060126190357.GE3651@localhost.localdomain> <43D9DFA1.9070802@cosmosbay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43D9DFA1.9070802@cosmosbay.com>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2006 at 09:53:53AM +0100, Eric Dumazet wrote:
> Ravikiran G Thirumalai a écrit :
> >Change the atomic_t sockets_allocated member of struct proto to a 
> >per-cpu counter.
> >
> >Signed-off-by: Pravin B. Shelar <pravins@calsoftinc.com>
> >Signed-off-by: Ravikiran Thirumalai <kiran@scalex86.org>
> >Signed-off-by: Shai Fultheim <shai@scalex86.org>
> >
> Hi Ravikiran
> 
> If I correctly read this patch, I think there is a scalability problem.
> 
> On a big SMP machine, read_sockets_allocated() is going to be a real killer.
> 
> Say we have 128 Opterons CPUS in a box.

read_sockets_allocated is being invoked when when /proc/net/protocols is read,
which can be assumed as not frequent.  
At sk_stream_mem_schedule(), read_sockets_allocated() is invoked only 
certain conditions, under memory pressure -- on a large CPU count machine, 
you'd have large memory, and I don't think read_sockets_allocated would get 
called often.  It did not atleast on our 8cpu/16G box.  So this should be OK 
I think.

There're no 128 CPU Opteron boxes yet afaik ;).

Thanks,
Kiran
