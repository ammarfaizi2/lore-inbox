Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317874AbSHLL3W>; Mon, 12 Aug 2002 07:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317876AbSHLL3V>; Mon, 12 Aug 2002 07:29:21 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:48905 "HELO holly.csn.ul.ie")
	by vger.kernel.org with SMTP id <S317874AbSHLL3V>;
	Mon, 12 Aug 2002 07:29:21 -0400
Date: Mon, 12 Aug 2002 12:33:03 +0100 (IST)
From: Mel <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: Bernd Eckenfels <ecki-news2002-08@lina.inka.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] VM Regress - A VM regression and test tool
In-Reply-To: <E17e4C2-0005yH-00@sites.inka.de>
Message-ID: <Pine.LNX.4.44.0208121209530.16360-100000@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Aug 2002, Bernd Eckenfels wrote:

> This sounds more like a micro benchmark tool, which is a good start, but the
> real problem with VM optimizations is, that they have to take into account
> real world load and especially user experience.
>

The tool is a micro test and benchmark tool, true. It is known and noted
in the documentation that this won't take overall system performance into
account. Fortunatly there is a number of existing userland tools out there
like lmbench that provide that type of information and there is a number
of subjective reports available from users regarding interactivity.

> applications like "connected to gui". This feature would need a test then,
> which is no usual micro benchmark.
>

That type of information is different to what VM Regress aims to provide.
VM Regress is aimed at providing performance and test data on individual
parts of the VM.

> hot code path, but it does not help much the developers in the problem of
> simulating workload and measuring the interactive and real throughput.
>
> But perhaps you can take this into account?
>

I have taken it into account and decided after some thought that overall
performance and throughput is not the place for a micro tool like VM
Regress and more the domain of a userland test suite.

I am more interested in answering questions like

o Does subsystem X still work after changes made to it?
o How well does subsystem X perform?
o How long does it take to find pages to swap out?
o How much overhead is introduced by feature Y?
o What does my process space look like after vmscan does it's work?

For example, in time, it'll be able to tell exactly how well rmap is
performing and compare it to a VM without rmap in terms of "how long it
took to find a page to replace" and "what did the address space look like
after kswapd worked". I should be able to show that rmap kept the correct
pages in memory for instance where as an overall benchmarking tool is
going to tell me nothing new. Used in combination with a profiling tool
like oprofile, I should be able to get very specific performance data that
I suspect will be useful to developers and to a much lesser extent, users.

I am making a persumption that if it can be shown that each individual
component is working and performs well, then overall performance should
improve.

-- 
Mel Gorman
MSc Student, University of Limerick
http://www.csn.ul.ie/~mel

