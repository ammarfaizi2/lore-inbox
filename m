Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275373AbRIZRpB>; Wed, 26 Sep 2001 13:45:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275378AbRIZRol>; Wed, 26 Sep 2001 13:44:41 -0400
Received: from chiara.elte.hu ([157.181.150.200]:8972 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S275377AbRIZRoj>;
	Wed, 26 Sep 2001 13:44:39 -0400
Date: Wed, 26 Sep 2001 19:42:42 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: "David S. Miller" <davem@redhat.com>
Cc: <gerrit@us.ibm.com>, <riel@conectiva.com.br>, <marcelo@conectiva.com.br>,
        Andrea Arcangeli <andrea@suse.de>,
        Linus Torvalds <torvalds@transmeta.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Locking comment on shrink_caches() 
In-Reply-To: <20010925.152655.85393753.davem@redhat.com>
Message-ID: <Pine.LNX.4.33.0109261937430.6377-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 25 Sep 2001, David S. Miller wrote:

>    I'm very curious as to what workloads are showing pagecache_lock as
>    a bottleneck.  We haven't noticed this particular bottleneck in most
>    of the workloads we are running.  Is there a good workload that shows
>    this type of load?
>
> Again, I defer to Ingo for specifics, but essentially something
> like specweb99 where the whole dataset fits in memory.

it was SPECweb99 tests done in 32 GB RAM, 8 CPUs, where the pagecache was
nearly 30 GB big. We saw visible pagecache_lock contention on such
systems. Due to TUX's use of zerocopy, page lookups happen at a much
larger frequency and they are not intermixed with memory copies - in
contrast with workloads like dbench.

	Ingo

