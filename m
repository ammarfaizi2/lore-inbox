Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932111AbWBFSpQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932111AbWBFSpQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 13:45:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932146AbWBFSpQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 13:45:16 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:18156 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932111AbWBFSpN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 13:45:13 -0500
Date: Mon, 6 Feb 2006 19:43:30 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@suse.de>
Cc: Christoph Lameter <clameter@engr.sgi.com>, Paul Jackson <pj@sgi.com>,
       akpm@osdl.org, dgc@sgi.com, steiner@sgi.com, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] cpuset memory spread basic implementation
Message-ID: <20060206184330.GA22275@elte.hu>
References: <20060204071910.10021.8437.sendpatchset@jackhammer.engr.sgi.com> <200602061811.49113.ak@suse.de> <Pine.LNX.4.62.0602061017510.16829@schroedinger.engr.sgi.com> <200602061936.27322.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602061936.27322.ak@suse.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.2
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.2 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.6 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andi Kleen <ak@suse.de> wrote:

> > > If you have a much worse worst case NUMA factor it might be different,
> > > but even there it would be a good idea to at least spread it out
> > > to nearby nodes.
> > 
> > I dont understand you here. What would be the benefit of selecting more 
> > distant memory over local? I can only imagine that this would be 
> > beneficial if we know that the data would be used later by other 
> > processes.
> 
> The benefit would be to not fill up the local node as quickly when you 
> do something IO (or dcache intensive).  And on contrary when you do 
> something local memory intensive on that node then you won't need to 
> throw away all the IO caches if they are already spread out.
> 
> The kernel uses of these cached objects are not really _that_ latency 
> sensitive and not that frequent so it makes sense to spread it out a 
> bit to nearby nodes.

I'm not sure i agree. If a cache isnt that important, then there wont be 
that much of them (hence they cannot interact with user pages that 
much), and it wont be used that frequently -> the VM will discard it 
faster. If there's tons of dentries and inodes and pagecache around, 
then there must be a reason it's around: it was actively used. In that 
case we should spread them out only if we know in advance that their use 
is global, not local - and we should default to local.

	Ingo
