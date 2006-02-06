Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750848AbWBFKY4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750848AbWBFKY4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 05:24:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751020AbWBFKY4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 05:24:56 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:63455 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750845AbWBFKYz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 05:24:55 -0500
Date: Mon, 6 Feb 2006 11:23:37 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@suse.de>
Cc: Paul Jackson <pj@sgi.com>, akpm@osdl.org, dgc@sgi.com, steiner@sgi.com,
       Simon.Derr@bull.net, linux-kernel@vger.kernel.org, clameter@sgi.com
Subject: Re: [PATCH 1/5] cpuset memory spread basic implementation
Message-ID: <20060206102337.GA3359@elte.hu>
References: <20060204071910.10021.8437.sendpatchset@jackhammer.engr.sgi.com> <200602061109.45788.ak@suse.de> <20060206101156.GA1761@elte.hu> <200602061116.44040.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602061116.44040.ak@suse.de>
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

> On Monday 06 February 2006 11:11, Ingo Molnar wrote:
> > 
> > * Andi Kleen <ak@suse.de> wrote:
> > 
> > > Of course there might be some corner cases where using local memory 
> > > for caching is still better (like mmap file IO), but my guess is that 
> > > it isn't a good default.
> > 
> > /tmp is almost certainly one where local memory is better.
> 
> Not sure. What happens if someone writes a 1GB /tmp file on a 1GB 
> node?

well, if the pagecache is filled on a node above a certain ratio then 
one would have to spread it out forcibly. But otherwise, try to keep 
things as local as possible, because that will perform best. This is 
different from the case Paul's patch is addressing: workloads which are 
known to be global (and hence spreading out is the best-performing 
allocation).

(for which problem i suggested a per-mount/directory/file 
locality-of-reference attribute in another post.)

	Ingo
