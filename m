Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277230AbRKABLo>; Wed, 31 Oct 2001 20:11:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277262AbRKABLZ>; Wed, 31 Oct 2001 20:11:25 -0500
Received: from zeus.kernel.org ([204.152.189.113]:11749 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S277230AbRKABLS>;
	Wed, 31 Oct 2001 20:11:18 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Andrea Arcangeli <andrea@suse.de>, Ben Smith <ben@google.com>
Subject: Re: Google's mm problem - not reproduced on 2.4.13
Date: Thu, 1 Nov 2001 01:19:15 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org, Rik van Riel <riel@conectiva.com.br>
In-Reply-To: <E15yzlQ-00021P-00@starship.berlin> <E15z28m-0000vb-00@starship.berlin> <20011031214540.D1291@athlon.random>
In-Reply-To: <20011031214540.D1291@athlon.random>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E15z5Zm-000067-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On October 31, 2001 09:45 pm, Andrea Arcangeli wrote:
> On Wed, Oct 31, 2001 at 09:39:12PM +0100, Daniel Phillips wrote:
> > On October 31, 2001 07:06 pm, Daniel Phillips wrote:
> > > I just tried your test program with 2.4.13, 2 Gig, and it ran without 
> > > problems.  Could you try that over there and see if you get the same 
result?
> > > If it does run, the next move would be to check with 3.5 Gig.
> > 
> > Ben reports that his test with 2 Gig memory runs fine, as it does for me, 
but 
> > that it locks up tight with 3.5 Gig, requiring power cycle.  Since I only 
> > have 2 Gig here I can't reproduce that (yet).
> 
> are you sure it isn't an oom condition.

The way the test code works is, it keeps mlocking more blocks of memory until 
one of the mlocks fails, and then it does the rest of its work with that many 
blocks of memory.  It's hard to see how we could get a legitimate oom with 
that strategy.

> can you reproduce on
> 2.4.14pre5aa1? mainline (at least before pre6) could deadlock with too
> much mlocked memory.

OK, he tried it with pre5aa1:

ben> My test application gets killed (I believe by the oom handler). dmesg
ben> complains about a lot of 0-order allocation failures. For this test,
ben> I'm running with 2.4.14pre5aa1, 3.5gb of RAM, 2 PIII 1Ghz.

*Just in case* it's oom-related I've asked Ben to try it with one less than 
the maximum number of memory blocks he can allocate.

If it does turn out to be oom, it's still a bug, right?

--
Daniel
