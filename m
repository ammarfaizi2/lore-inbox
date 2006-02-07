Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965034AbWBGNAb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965034AbWBGNAb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 08:00:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965065AbWBGNAb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 08:00:31 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:18615 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S965034AbWBGNAa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 08:00:30 -0500
Date: Tue, 7 Feb 2006 13:58:45 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@suse.de>
Cc: steiner@sgi.com, Paul Jackson <pj@sgi.com>, clameter@engr.sgi.com,
       akpm@osdl.org, dgc@sgi.com, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] cpuset memory spread basic implementation
Message-ID: <20060207125845.GB634@elte.hu>
References: <20060204071910.10021.8437.sendpatchset@jackhammer.engr.sgi.com> <200602071314.34879.ak@suse.de> <20060207123001.GA634@elte.hu> <200602071343.59384.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602071343.59384.ak@suse.de>
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

> On Tuesday 07 February 2006 13:30, Ingo Molnar wrote:
> 
> > you are a bit biased towards low-latency NUMA setups i guess (read: 
> > Opterons) :-) 
> 
> Well they are the vast majority of NUMA systems Linux runs on.
>
> And there are more than just Opterons, e.g. IBM Summit. And even the 
> majority of Altixes are not _that_ big.
> 
> Of course we need to deal somehow with the big systems, but for the 
> good defaults the smaller systems are more important.

i'm not sure i understand your point. You said that for small systems 
with a low NUMA factor it doesnt really matter where the pagecache is 
placed. I mostly agree with that. And since placement makes no 
difference there, we can freely shape things for the systems where it 
does make a difference. It will probably make a small win on smaller 
systems too, as a bonus. Ok?

> Big systems tend to have capable administrators who are willing to 
> tweak them. But that's rarely the case with the small systems. So I 
> think as long as the big system can be somehow made to work with 
> special configuration and ignoring corner cases that's fine. But for 
> the low NUMA systems it should perform as well as possibly out of the 
> box.

i also mentioned software-based clusters in the previous mail, so it's 
not only about big systems. Caching attributes are very much relevant 
there. Tightly integrated clusters can be considered NUMA systems with a 
NUMA factor of 1000 or so (or worse).

> > Obviously with a low NUMA factor, we dont have to deal  
> > with memory access assymetries all that much.
> 
> That is why I proposed "nearby policy". It can turn a system with a 
> large NUMA factor into a system with a small NUMA factor.

well, would the "nearby policy" make a difference on the small systems?  
Small systems (to me) are just a flat and symmetric hierarchy of nodes - 
the next step from SMP. So there's really just two distances: local to 
the node, and one level of 'alien'. Or do you include systems in this 
category that have bigger assymetries?

	Ingo
