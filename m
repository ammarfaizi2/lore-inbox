Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261544AbSJGQsY>; Mon, 7 Oct 2002 12:48:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262526AbSJGQsY>; Mon, 7 Oct 2002 12:48:24 -0400
Received: from ophelia.ess.nec.de ([193.141.139.8]:28667 "EHLO
	ophelia.ess.nec.de") by vger.kernel.org with ESMTP
	id <S261544AbSJGQsX> convert rfc822-to-8bit; Mon, 7 Oct 2002 12:48:23 -0400
Content-Type: text/plain; charset=US-ASCII
From: Erich Focht <efocht@ess.nec.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>
Subject: Re: [RFC] NUMA schedulers benchmark results
Date: Mon, 7 Oct 2002 18:52:54 +0200
User-Agent: KMail/1.4.1
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>
References: <200210061851.45401.efocht@ess.nec.de> <1315762666.1033927133@[10.10.2.3]>
In-Reply-To: <1315762666.1033927133@[10.10.2.3]>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210071852.54859.efocht@ess.nec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 07 October 2002 02:58, Martin J. Bligh wrote:
> > As I'm rewriting the node affine scheduler to be more modular, I'll
> > redo the tests for cases D, E, F on top of 2.5.X kernels soon.
>
> It's really hard to see anything comparing 2.4 vs 2.5 results,
> so when you have results for everything across the same kernel,
> it'll be a lot easier to decipher ...

The user times are really comparable. And total user time, too. I'm
taking the node affine patches to 2.5.39 and will rerun them ASAP.

> For the record, I really don't care whose code gets accepted, I'm
> just interested in having a scheduler that works well for me ;-)

I was running several of these to see which features help and to try
to understand where the advantage comes from. In the output tables
you can see where the job has spentits time and on which node it started.
You can also recognize from the user time how well a job ran. Alone on
it's node: 27s, away from it's memory: 36s (or so), sharing the node
with others: 27-32s, running on wrong node with others: up to 43s. And
seeing these you can understand how well a feature works or how much
you miss another feature. It wasn't my plan to advertise the node
affine scheduler, it just has most of the features.

> However, I think it would be a good idea to run some other benchmarks
> on these, that are a little more general ... dbench, kernel compile,
> sdet, whatever, as *well* as your own benchmark ... I think we're
> working on that.
Yes, great!

> So lower numbers are better, right? So Michael's stuff seems to
> work fine at the higher end, but poorly at the lower end - I think
> this may be due to a bug he found on Friday, if that gets fixed, it
> might make a difference.

OK, but how about the node-wise selection and balancing? Then we get
the approaches closer...

> I'll run your tests on the NUMA-Q comparing 2.5.40 vs Michael's stuff.
> If you send me a cleaned up version (ie without the ia64 stuff in
> generic code) of your stuff against 2.5.40 (or ideally 2.5.40-mm2),
> I'll run that too ... (if you're putting the latencies into arch code,
> you can set i386 (well NUMA-Q) for 20:1 if you think that'll help).

Is in preparation. First step: pooling scheduler without multi-level
support but node-wise initial balancing.

> PS. the wierd "this one was run without hackbench" thing makes the
> results even harder to read ...
Sorry about that. Didn't have a newer measurement.

> PPS. Does Kimio's discontigmem patch work for you on 2.5?
Yes. We're trying to get that stuff in but David's away from his email
for a while as you know.

Regards,
Erich

