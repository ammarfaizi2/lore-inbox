Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965045AbWBGMbo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965045AbWBGMbo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 07:31:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965060AbWBGMbn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 07:31:43 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:44973 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S965045AbWBGMbn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 07:31:43 -0500
Date: Tue, 7 Feb 2006 13:30:01 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@suse.de>
Cc: Paul Jackson <pj@sgi.com>, clameter@engr.sgi.com, akpm@osdl.org,
       dgc@sgi.com, steiner@sgi.com, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] cpuset memory spread basic implementation
Message-ID: <20060207123001.GA634@elte.hu>
References: <20060204071910.10021.8437.sendpatchset@jackhammer.engr.sgi.com> <200602071031.40346.ak@suse.de> <20060207115307.GA25110@elte.hu> <200602071314.34879.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602071314.34879.ak@suse.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andi Kleen <ak@suse.de> wrote:

> I still don't really think it will make much difference if the file 
> cache is local or global. Compare to disk IO it is still infinitely 
> faster, so a relatively small slowdown from going off node is not that 
> big an issue.

well, maybe the SGI folks can give us some numbers?

> > another thing: on NUMA, are the pagecache portions of readonly files 
> > (such as /usr binaries, etc.) duplicated across nodes in current 
> > kernels, or is it still random which node gets it? 
> 
> Random.
> 
> > This too could be an  
> > EA caching attribute: whether to create per-node caches for file 
> > content.
> 
> There were (ugly) patches floating around for text duplication, but 
> iirc the benchmarkers were still trying to figure out if it's even a 
> good idea. My guess it is not because CPUs tend to have very 
> aggressive prefetching for code streams which can deal with latency 
> well.

you are a bit biased towards low-latency NUMA setups i guess (read: 
Opterons) :-) Obviously with a low NUMA factor, we dont have to deal 
with memory access assymetries all that much.

But i think we should expand our file caching architecture into those 
caching details nevertheless: it's directly applicable to software 
driven clusters as well. There pagecache replication on nodes is a must, 
and obviously there it makes a big difference whether files are cached 
locally or remotely.

	Ingo
