Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263300AbTJER4S (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 13:56:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263301AbTJER4S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 13:56:18 -0400
Received: from conx.aracnet.com ([216.99.200.135]:24000 "HELO cj65.in.cjcj.com")
	by vger.kernel.org with SMTP id S263300AbTJER4M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 13:56:12 -0400
Message-ID: <3F805B39.8070209@cjcj.com>
Date: Sun, 05 Oct 2003 10:56:09 -0700
From: CJ <cj@cjcj.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Idea for improving linux buffer cache behaviour
References: <200310041534.h94FYv0X007015@xdr.com> <Pine.LNX.4.44.0310041513150.14750-100000@chimarrao.boston.redhat.com> <20031005053458.GC1205@matchmail.com> <20031005172612.GA8432@hh.idb.hist.no>
In-Reply-To: <20031005172612.GA8432@hh.idb.hist.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1. A problem is o_direct is broken and/or confused with
    file systems.  There is a misguided micro-optimization
    that requires page alignment and sector alignment and
    size.  Even if broken DMA or controllers require these,
    O_DIRECT need not.  O_DIRECT is about the cache.

2. Even when O_DIRECT requires a bounce buffer, it need
    not wipe memory, it could easily confine itself to 1-4
    buffers and even support read ahead.  Then DVDs could
    be mounted O_DIRECT by default.

3. Buffer management has become a DOS on Linux leaving
    disk bound programs with the disk light off for ten
    seconds at a crack.  Writing is worst of all.



Helge Hafting wrote:

> On Sat, Oct 04, 2003 at 10:34:58PM -0700, Mike Fedyk wrote:
> 
>>On Sat, Oct 04, 2003 at 03:14:14PM -0400, Rik van Riel wrote:
>>
>>>On Sat, 4 Oct 2003, David Ashley wrote:
>>>
>>>
>>>>Forgive me if this has already been thought of, or is obsolete, or is
>>>>just plain a bad idea, but here it is:
>>>
>>>Do you also want an answer if the kernel already does
>>>exactly what you are suggesting ? ;)
>>>
>>
>>Then why doesn't it work better?
>>
>>
>>>>1) Lowest access count looked at first to toss
>>>>2) If access counts equal, throw out oldest first
>>>
>>>>The net result is commonly used items you very much want to remain in
>>>>cache always quickly get rated very highly as the system is used.
>>>
>>>Which results in exactly the behaviour you're complaining
>>>about ;))
>>
>>So, you use the system, have glibc loaded, and then play a dvd, and now
>>glibc needs to be re-read because it's not in cache.
>>
>>Why wasn't glibc (one example) kept in cache with the streaming read from
>>the dvd?
> 
> 
> There may be many reasons here, take a look at how many times the
> dvd contents were used.  You may get a surprise there.  
> The number ought to be 1, right?  But the burner program may read
> smaller chunks or something, causing many references to the same block.
> 
> Also, the number-of-references approach has its own problems.
> Something that is used a lot for a while will stay in cache for
> a long while when no longer used, taking up space.  That can be
> a problem too - i.e. run some large simulation which fill up
> memory for a while, and nothing else stays in cache afterwards.
> 
> Helge Hafting
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> .
> 

