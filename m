Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750797AbWBFIxM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750797AbWBFIxM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 03:53:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750735AbWBFIxM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 03:53:12 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:32233 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750797AbWBFIxK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 03:53:10 -0500
Date: Mon, 6 Feb 2006 09:51:55 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Paul Jackson <pj@sgi.com>
Cc: akpm@osdl.org, dgc@sgi.com, steiner@sgi.com, Simon.Derr@bull.net,
       ak@suse.de, linux-kernel@vger.kernel.org, clameter@sgi.com
Subject: Re: [PATCH 1/5] cpuset memory spread basic implementation
Message-ID: <20060206085155.GA9436@elte.hu>
References: <20060204154944.36387a86.akpm@osdl.org> <20060205203358.1fdcea43.akpm@osdl.org> <20060205215052.c5ab1651.pj@sgi.com> <20060205220204.194ba477.akpm@osdl.org> <20060206061743.GA14679@elte.hu> <20060205232253.ddbf02d7.pj@sgi.com> <20060206074334.GA28035@elte.hu> <20060206001959.394b33bc.pj@sgi.com> <20060206082258.GA1991@elte.hu> <20060206004720.0374b820.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060206004720.0374b820.pj@sgi.com>
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


* Paul Jackson <pj@sgi.com> wrote:

> Ingo asked:
> > so in practice, the memory spreading is in fact a global setting, used
> > by all cpusets that matter? 
> 
> I don't know if that is true or not.
> 
> I'll have to ask my field engineers, who actually have experience
> with a variety of customer workloads.
> 
> ... well, I do have partial knowledge of this.
> 
> When I was coding this, I suggested that instead of picking some of the
> slab caches to memory spread, we pick them all, as that would be easier
> to code.
> 
> That suggestion was shot down by others more experienced within SGI, 
> as some slab caches hold what is essentially per-thread data, that is 
> fairly hot in the thread context that allocated it.  Spreading that 
> data would quite predictably increase cross-node bus traffic, which is 
> bad.

yes, but still that is a global attribute: we know that those slabs are 
fundamentally per-thread. They wont ever be non-per-thread. So the 
decision could be made via a per-slab attribute, that is picked by 
kernel developers (initially you). The pagecache would be spread-out if
this .config option is specified. This makes it a much cleaner static
'kernel fairness policy' thing, instead of a fuzzier userspace thing. 

	Ingo
