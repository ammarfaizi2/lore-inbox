Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277258AbRJDWnM>; Thu, 4 Oct 2001 18:43:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277259AbRJDWnC>; Thu, 4 Oct 2001 18:43:02 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:1285 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S277258AbRJDWmu>; Thu, 4 Oct 2001 18:42:50 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Context switch times
Date: Thu, 4 Oct 2001 22:42:37 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <9piokt$8v9$1@penguin.transmeta.com>
In-Reply-To: <E15pFor-0004sC-00@fenrus.demon.nl> <200110042139.f94Ld5r09675@vindaloo.ras.ucalgary.ca> <20011004.145239.62666846.davem@redhat.com> <20011004175526.C18528@redhat.com>
X-Trace: palladium.transmeta.com 1002235377 31098 127.0.0.1 (4 Oct 2001 22:42:57 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 4 Oct 2001 22:42:57 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20011004175526.C18528@redhat.com>,
Benjamin LaHaise  <bcrl@redhat.com> wrote:
>On Thu, Oct 04, 2001 at 02:52:39PM -0700, David S. Miller wrote:
>> So the FPU hit is only before/after the runs, not during each and
>> every iteration.
>
>Right.  Plus, the original mail mentioned that it was hitting all 8 
>CPUs, which is a pretty good example of braindead scheduler behaviour.

Careful.

That's not actually true (the braindead part, that i).

We went through this with Ingo and Larry McVoy, and the sad fact is that
to get the best numbers for lmbench, you simply have to do the wrong
thing. 

Could we try to hit just two? Probably, but it doesn't really matter,
though: to make the lmbench scheduler benchmark go at full speed, you
want to limit it to _one_ CPU, which is not sensible in real-life
situations.  The amount of concurrency in the context switching
benchmark is pretty small, and does not make up for bouncing the locks
etc between CPU's. 

However, that lack of concurrency in lmbench is totally due to the
artificial nature of the benchmark, and the bigger-footprint scheduling
stuff (that isn't reported very much in the summary) are more realistic.

So 2.4.x took the (painful) road of saying that we care less about that
particular benchmark than about some other more realistic loads. 

		Linus
