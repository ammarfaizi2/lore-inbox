Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932347AbWDKIdE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932347AbWDKIdE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 04:33:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932357AbWDKIdE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 04:33:04 -0400
Received: from ishtar.tlinx.org ([64.81.245.74]:46814 "EHLO ishtar.tlinx.org")
	by vger.kernel.org with ESMTP id S932347AbWDKIdC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 04:33:02 -0400
Message-ID: <443B69BE.6060601@tlinx.org>
Date: Tue, 11 Apr 2006 01:33:02 -0700
From: Linda Walsh <lkml@tlinx.org>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Charles Shannon Hendrix <shannon@widomaker.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: OOM kills if swappiness set to 0, swap storms otherwise
References: <1143510828.1792.353.camel@mindpipe> <20060327195905.7f666cb5.akpm@osdl.org> <20060405144716.GA10353@widomaker.com>
In-Reply-To: <20060405144716.GA10353@widomaker.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Charles Shannon Hendrix wrote:
> Mon, 27 Mar 2006 @ 19:59 -0800, Andrew Morton said:
>
>   
>> Much porkiness.
>>
>> /proc/meminfo is very useful for obtaining a top-level view of where all
>> the memory's gone to.  I'd tentatively say that your options are to put up
>> with the swapping or find a new mail client.
>>     
>
> I use mutt for my email, and I have the same issue on a 1GB system.
>
> I really wish we could put an upper limit on what file cache can use.
>   
----
    Hmmm, not to be contrary, but I have a 1GB system that refuses to swap
during large file i/o operations.  For the first time in a *long* time,
I read someone's suggestion to increase swappiness -- I did, to 75 or 80,
(I've booted since then, so it's back to 60 and no swap usage) and some of
the programs that rarely run actually swapped.  It was great!  I finally had
more memory for file i/o operations.

    Maybe you are telling the system to "feel free" to use swap by having a
large swap file?  I have a 256Mb swap partition near the front of the disk
where I/O is fastest, but it usually remains untouched, but that also means
I can only overcommit used memory by 25% (1Gphys, 256M swap).  I don't know
what the OOM "looks like" when it runs.  I had a buggy perlapp, once, that
tried to consume infinite memory, but I think it segfaulted before the OOM
could act.

    Maybe if you don't want linux to swap as much, it might swap less if 
you give
it less to swap with?  I know it sounds simplistic, but I've run with 
smallish
swap files ever since I got up to 1GB of main memory.  The only reason I 
have one
at all is I presumed that infrequently used functions, like dhcp (only 
used when
friends are over) would be shuffled out -- but it isn't unless I increase
swappiness.
> I shouldn't be suffering from swap storms.
>   
I agree.  Try getting rid of your swap file entirely -- your system will 
still
run unless you are overloading memory, but you have a Gig.  How much do you
need to keep in memory?  Sure, if/when I get a 4-way CPU (I have a 2-cpu 
setup now),
I might go up to 4G, but I might be running multiple virtual machines too!
> For example, my normal working set of programs eats about 250MB of memory. If
> I also start a job running to something like tag some mp3s, copy a CD, or just
> process a lot of files, it only takes a few minutes before performance becomes
> unacceptable.  
>   
---
    You might try the "cfq" block i/o algorithm.  Then you can
ionice down the disk priority of background processes (though you need
to be root to reduce ionice levels at this point, unlike cpu nice).
> If you are doing some work where you switch among several applications
> frequently, the pigginess of file cache becomes a serious problem.
>   
---
    Never a problem.  I don't allocate enough swap for it to be a 
problem I'm
guessing. Programs stay in memory and blocks get forced out to disk more
frequently.

Linda
