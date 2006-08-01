Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751219AbWHADin@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751219AbWHADin (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 23:38:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751231AbWHADim
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 23:38:42 -0400
Received: from 63-162-81-179.lisco.net ([63.162.81.179]:15889 "EHLO
	grunt.slaphack.com") by vger.kernel.org with ESMTP id S1751219AbWHADim
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 23:38:42 -0400
Message-ID: <44CECCBB.3080408@slaphack.com>
Date: Mon, 31 Jul 2006 22:38:35 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: Theodore Tso <tytso@mit.edu>, David Masover <ninja@slaphack.com>,
       Nate Diller <nate.diller@gmail.com>,
       David Lang <dlang@digitalinsight.com>,
       Adrian Ulrich <reiser4@blinkenlights.ch>,
       "Horst H. von Brand" <vonbrand@inf.utfsm.cl>, ipso@snappymail.ca,
       reiser@namesys.com, lkml@lpbproductions.com, jeff@garzik.org,
       linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: Solaris ZFS on Linux [Was: Re: the " 'official' point of view"
 expressed by kernelnewbies.org regarding reiser4 inclusion]
References: <200607311918.k6VJIqTN011066@laptop13.inf.utfsm.cl> <20060731225734.ecf5eb4d.reiser4@blinkenlights.ch> <44CE7C31.5090402@gmx.de> <5c49b0ed0607311621i54f1c46fh9137f8955c9ea4be@mail.gmail.com> <Pine.LNX.4.63.0607311621360.14674@qynat.qvtvafvgr.pbz> <5c49b0ed0607311650j4b86d0c3h853578f58db16140@mail.gmail.com> <Pine.LNX.4.63.0607311651410.14674@qynat.qvtvafvgr.pbz> <5c49b0ed0607311705t1eb8fc6bs9a68a43059bfa91a@mail.gmail.com> <20060801010215.GA24946@merlin.emma.line.org> <44CEAEF4.9070100@slaphack.com> <20060801030005.GA1987@thunk.org>
In-Reply-To: <20060801030005.GA1987@thunk.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Tso wrote:
> On Mon, Jul 31, 2006 at 08:31:32PM -0500, David Masover wrote:
>> So you use a repacker.  Nice thing about a repacker is, everyone has 
>> downtime.  Better to plan to be a little sluggish when you'll have 
>> 1/10th or 1/50th of the users than be MUCH slower all the time.
> 
> Actually, that's a problem with log-structured filesystems in general.
> There are quite a few real-life workloads where you *don't* have
> downtime.  The thing is, in a global economy, you move from the
> London/European stock exchanges, to the New York/US exchanges, to the
> Asian exchanges, with little to no downtime available.

Such systems must have redundancy, however.  And if you have 2-3 servers 
hot in case one of them goes down, I can see switching between which is 
more active, and which is repacking.

This repacker is online, hence a filesystem being repacked would have to 
be less active, not necessarily down.  So repack the backup server, then 
make the backup server the active one and repack the main server.  If 
the main server goes down while the backup is repacking, kill the repack 
process.

I actually have a problem imagining a system where you don't have enough 
spare capacity (disk, CPU, spare servers) to run a repacker every now 
and then, but which also must have 100% uptime.  What happens when a 
disk goes bad?  Or when power to half the country goes out?  Or...  You 
get the idea.

> In addition,
> people have been getting more sophisticated with workload
> consolidation tricks so that you use your "downtime" for other
> applications (either to service other parts of the world, or to do
> daily summaries, 3-d frame rendering at animation companies, etc.)  So
> the assumption that there will always be time to run the repacker is a
> dangerous one.

3D frame rendering in particular doesn't require much disk use, does it? 
  Daily summaries, I guess, depends on what kind of summaries they are. 
  And anyway, those applications are making the same dangerous assumption.

And anyway, I suspect the repacker will work best once a week or so, but 
no one knows yet, as they haven't written it yet.

> The problem is that many benchmarks (such as taring and untaring the
> kernel sources in reiser4 sort order) are overly simplistic, in that
> they don't really reflect how people use the filesystem in real life.

That's true.  I'd also like to see lots more benchmarks.

> If the benchmark doesn't take into account the need for
> repacker, or if the repacker is disabled or fails to run during the
> benchmark, the filesystem are in effect "cheating" on the benchmark
> because there is critical work which is necessary for the long-term
> health of the filesystem which is getting deferred until after the
> benchmark has finished measuring the performance of the system under
> test.

In this case, the only fair test would be to run the benchmark 24/7 for 
a week, and run the repacker on a weekend.  Or however you're planning 
to do it.  It wouldn't be fair to run a 10-minute or 1-hour benchmark 
and then immediately run the repacker.

But I'd also like to see more here, especially about fragmentation.  If 
the repacker will cost money, the system should be reasonably good at 
avoiding fragmentation.  I'm wondering if I should run a benchmark on my 
systems -- they're over a year old, and while they aren't under 
particularly heavy load, they should be getting somewhat fragmented by now.
