Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131830AbRCXVr5>; Sat, 24 Mar 2001 16:47:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131831AbRCXVrr>; Sat, 24 Mar 2001 16:47:47 -0500
Received: from mozart.stat.wisc.edu ([128.105.5.24]:49929 "EHLO
	mozart.stat.wisc.edu") by vger.kernel.org with ESMTP
	id <S131830AbRCXVrd>; Sat, 24 Mar 2001 16:47:33 -0500
To: "Zack Weinberg" <zackw@stanford.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.2 fails to merge mmap areas, 700% slowdown.
In-Reply-To: <20010323201122.Y699@stanford.edu>
From: buhr@stat.wisc.edu (Kevin Buhr)
In-Reply-To: "Zack Weinberg"'s message of "Fri, 23 Mar 2001 20:11:22 -0800"
Date: 24 Mar 2001 15:46:51 -0600
Message-ID: <vbavgoyvnzo.fsf@mozart.stat.wisc.edu>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Zack Weinberg" <zackw@stanford.edu> writes:
> 
> Let me inject some information about what gcc's doing in each version.

Thanks...  very useful information.

> 2.95.3 allocates its memory via a bunch of 'obstacks' which,
> underneath, get memory from malloc, and therefore brk(2).  I'm very
> surprised to see it had ~250 vmas; it should be more like 10.

You are correct.  My "maps" numbers for 2.96 and 3.0 are correct (at
least within an order of magnitude), but I must have plucked the
number for 2.95.3 out of thin air---there are only ~10 maps, as you
predict.

> In conclusion, I think that GCC's allocator still makes a good case
> for merging vmas.

Maybe.  It looks like the performance drop is quite sharp as a
function of vma count.  In another note to the list, I observed no
system time change (not even a half a second) using GCC 3.0 on my
gtk-- test case between 2.4.2 and 2.4.3-pre7, even though the vma
count dropped from ~200 to ~15.  On the other hand, 2.96 dropped from
>3000 to ~10 and dropped from a system time of 2m13s to a system time
of 41sec (in line with the 3.0 and 2.95.3 system times).

Given your data, it'll really depend on where the performance hit is
taken.  If it's taken at 4000 vmas, then it'll take a 500 meg arena
under 3.0 before the patch makes a difference.  It it's taken at 1000
vmas, then we'll see it around 125 megs, and it'll really make a big
difference in some of the test cases people are talking about.

Kevin <buhr@stat.wisc.edu>
