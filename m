Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932335AbVK2Siv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932335AbVK2Siv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 13:38:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932342AbVK2Siu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 13:38:50 -0500
Received: from cantor2.suse.de ([195.135.220.15]:2736 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932335AbVK2Siu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 13:38:50 -0500
Date: Tue, 29 Nov 2005 19:38:48 +0100
From: Andi Kleen <ak@suse.de>
To: John Reiser <jreiser@BitWagon.com>
Cc: Andi Kleen <ak@suse.de>, Stephane Eranian <eranian@hpl.hp.com>,
       Ray Bryant <raybry@mpdtxmail.amd.com>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org, perfctr-devel@lists.sourceforge.net
Subject: Re: [Perfctr-devel] Re: Enabling RDPMC in user space by default
Message-ID: <20051129183848.GO19515@wotan.suse.de>
References: <20051129151515.GG19515@wotan.suse.de> <200511291056.32455.raybry@mpdtxmail.amd.com> <20051129180903.GB6611@frankl.hpl.hp.com> <20051129181344.GN19515@wotan.suse.de> <438C9E1B.8040204@BitWagon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <438C9E1B.8040204@BitWagon.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2005 at 10:29:47AM -0800, John Reiser wrote:
> Andi Kleen wrote:
> > I think it's also a useful convention - RDTSC is becomming more and more
> > useless and you cannot expect user applications who just want to
> > measure some cycles to rely on ever changing instable or non existing
> > performance counter APIs.
> 
> Users are even more unhappy with ever-changing ABIs -- such as the
> kernel taking away RDTSC.

Nobody is talking about taking it away. But it's becomming
more and more useless because there are many situations
where it does unexpected things.

(it's not synchronized over CPUs,
on modern Intel CPUs it always measures the fastest P state even
though you might be running slower, on other CPUs when
you want to measure time it actually changes with P states etc.etc.) 

The performance counter has a much clearer defintion - it's always
cycles are executed by the CPU and it doesn't even pretend
to be a usable timer.
> 
> RDTSC+perfctr [Pettersson] still is the fastest way for user-mode code
> to count something that is highly correlated with both "billable"
> CPU time and "code quality" for a fixed task.  With a little care

Actually it's wrong - at least on Intel CPUs RDPMC is faster
than RDTSC because it doesn't synchronize.

> RDTSC is close enough to monotonic that I find it very useful.

You tested on a very limited set of platforms and setups then.
So far you were either lucky or just didn't notice the problems yet.

About the only reasonable usage was for custom hacks to measure
cycles, but with all the ongoing changes in its definition
I believe these users will be happier with rdpmc 0 once
it's enabled (and oprofile and other users be taught 
to keep their fingers away) 

People who use it for timing, not measurement, directly are just wrong and 
misguided.

-Andi
