Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313184AbSDQIYi>; Wed, 17 Apr 2002 04:24:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313610AbSDQIYe>; Wed, 17 Apr 2002 04:24:34 -0400
Received: from hera.cwi.nl ([192.16.191.8]:49873 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S313184AbSDQIYe>;
	Wed, 17 Apr 2002 04:24:34 -0400
From: Andries.Brouwer@cwi.nl
Date: Wed, 17 Apr 2002 10:24:29 +0200 (MEST)
Message-Id: <UTC200204170824.g3H8OTZ28753.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, rusty@rustcorp.com.au
Subject: Re: [PATCH] setup_per_cpu_areas in 2.5.8pre3
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    > Now that I am writing anyway, one of the changes I needed
    > to compile 2.5.8pre3 is the following.

    Yeah, better patch below

Good.

    > Of course the real fix is to remove the #ifdef's,
    > maybe using a weak symbol instead, or some other construction
    > that defines an empty default that can be replaced by an actual
    > routine.

    Not unless you make it as readable as the current code.  Having magic
    appearing functions sounds cool, but beware that the cure might be
    worse than the disease.

But maybe I do not think that the current code is very readable.
Probably because just before fixing this compilation problem I had
to fix a different one where atomic_dec_and_lock was undefined,
and one finds a forest of #ifdef's in spinlock.h.

#ifdef's are evil. You have one, and there are two possible sources.
Easy and readable. You have two, and there are four. Already a small
effort to check that indeed all four combinations are OK. That was
what went wrong in the setup_per_cpu_areas case. You have three and
it is almost certain that someone forgets to check all possible
eight cases.

#ifdef's hide source from the compiler, so that when stuff compiles
for the developer it need not compile for the next person who comes
along. We have a kernel compilation project because of that.

So, if we can replace a certain type of #ifdef use by a different
formal construction, where all source is seen by the compiler,
that might well be progress.

Andries
