Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266953AbSLQTgU>; Tue, 17 Dec 2002 14:36:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266969AbSLQTgT>; Tue, 17 Dec 2002 14:36:19 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:42247 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266953AbSLQTgR>; Tue, 17 Dec 2002 14:36:17 -0500
Message-ID: <3DFF7E7D.1080900@transmeta.com>
Date: Tue, 17 Dec 2002 11:43:57 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021119
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Ulrich Drepper <drepper@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Matti Aarnio <matti.aarnio@zmailer.org>,
       Hugh Dickins <hugh@veritas.com>, Dave Jones <davej@codemonkey.org.uk>,
       Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Intel P6 vs P7 system call performance
References: <Pine.LNX.4.44.0212171132530.1095-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0212171132530.1095-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> The thing is, gettimeofday() isn't _that_ special. It's just not worth a
> vsyscall of it's own, I feel. Where do you stop? Do we do getpid() too?
> Just because we can?
>

getpid() could be implemented in userspace, but not via vsyscalls
(instead it could be passed in the ELF data area at process start.)

"Because we can and it's relatively easy" is a pretty good argument in
my opinion.

> This is especially true since the people who _really_ might care about
> gettimeofday() are exactly the people who wouldn't be able to use the fast
> user-space-only version.
> 
> How much do you think gettimeofday() really matters on a desktop? Sure, X
> apps do gettimeofday() calls, but they do a whole lot more of _other_
> calls, and gettimeofday() is really far far down in the noise for them.
> The people who really call for gettimeofday() as a performance thing seem
> to be database people who want it as a timestamp. But those are the same
> people who also want NUMA machines which don't necessarily have
> synchronized clocks.
> 

I think this is really an overstatement.  Timestamping etc. (and heck,
even databases) are actually perfectly usable even on smaller machines
these days.  Sure, DB vendors like to boast of their 128-way NUMA
machines, but I suspect the bulk of them run on single- and
dual-processor machines (by count, not necessarily by data volume.)

	-hpa


