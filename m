Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262768AbTJJJHl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 05:07:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262772AbTJJJHl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 05:07:41 -0400
Received: from holomorphy.com ([66.224.33.161]:2177 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262768AbTJJJHk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 05:07:40 -0400
Date: Fri, 10 Oct 2003 02:09:42 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: YoshiyaETO <eto@soft.fujitsu.com>
Cc: Stuart Longland <stuartl@longlandclan.hopto.org>,
       linux-kernel@vger.kernel.org,
       Stephan von Krawczynski <skraw@ithnet.com>, lgb@lgb.hu,
       Fabian.Frederick@prov-liege.be
Subject: Re: 2.7 thoughts
Message-ID: <20031010090942.GC700@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	YoshiyaETO <eto@soft.fujitsu.com>,
	Stuart Longland <stuartl@longlandclan.hopto.org>,
	linux-kernel@vger.kernel.org,
	Stephan von Krawczynski <skraw@ithnet.com>, lgb@lgb.hu,
	Fabian.Frederick@prov-liege.be
References: <D9B4591FDBACD411B01E00508BB33C1B01F13BCE@mesadm.epl.prov-liege.be> <20031009115809.GE8370@vega.digitel2002.hu> <20031009165723.43ae9cb5.skraw@ithnet.com> <3F864F82.4050509@longlandclan.hopto.org> <20031010063039.GA700@holomorphy.com> <047b01c38f00$60b34840$6a647c0a@eto> <20031010074030.GB700@holomorphy.com> <04d501c38f0b$2864c210$6a647c0a@eto>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04d501c38f0b$2864c210$6a647c0a@eto>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, I wrote:
>> I don't see any reason to connect it with the notion of a node.

On Fri, Oct 10, 2003 at 05:47:37PM +0900, YoshiyaETO wrote:
>     If the word "Node" is not so appropriate, I will use "Unit".
> And I also make it simple, "Unit" will have CPUs and/or Memory.
> On the other hand IO-Unit will have IOs.

Well, that's precisely what I was saying was unnecessary. The VM
mechanics are orthogonal to the rest, so there's no reason to tie
their handling together. The coincidence that they appear bundled
on one system or another is irrelevant.


At some point in the past, I wrote:
> > The main points of contention would appear to be cooperative vs.
> > forcible (where I believe cooperative is acknowledged as the only

On Fri, Oct 10, 2003 at 05:47:37PM +0900, YoshiyaETO wrote:
>     I could not understand what is forcible.
> Everything should be cooperative, I think.

"Forcible" would be "the kernel receives a magic interrupt, and in
some mailbox the interrupt handler discovers the memory has either
already disappeared or will disappear in some amount of time regardless
of whether the kernel is prepared to handle its removal." The
distinction is meaningless for the case of onlining. The case of
offlining (perhaps by some deadline) is widely considered infeasible,
but there are some environments that could consider it desirable.

The bit that was actually expected to spark debate was the ZONE_HIGHMEM
notion purported to be a desirable method for resolving the conflict
between pinned/wired kernel allocations and cooperative offlining by
restricting pinned/wired kernel allocations to some fixed physical
arena. The two issues mentioned above are in reality non-issues.


-- wli
