Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267491AbTAXBcP>; Thu, 23 Jan 2003 20:32:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267493AbTAXBcP>; Thu, 23 Jan 2003 20:32:15 -0500
Received: from sccrmhc02.attbi.com ([204.127.202.62]:11950 "EHLO
	sccrmhc02.attbi.com") by vger.kernel.org with ESMTP
	id <S267491AbTAXBcO>; Thu, 23 Jan 2003 20:32:14 -0500
Message-ID: <3E309F22.5010102@kegel.com>
Date: Thu, 23 Jan 2003 18:04:18 -0800
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/4.0 (compatible; MSIE 5.5; Windows 98)
X-Accept-Language: de-de, en
MIME-Version: 1.0
To: Mark Hahn <hahn@physics.mcmaster.ca>, linux-kernel@vger.kernel.org
Subject: Re: debate on 700 threads vs asynchronous code
References: <Pine.LNX.4.44.0301232028480.980-100000@coffee.psychology.mcmaster.ca>
In-Reply-To: <Pine.LNX.4.44.0301232028480.980-100000@coffee.psychology.mcmaster.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Hahn wrote:
>>Nonblocking I/O is totally the way to go if you have full control over your
>>source code and want the maximal performance in userspace.  The best way
> 
> why do you think it's better for user-space?  I was trying to explain
> it to someone this afternoon, and we couldn't find any reason for 
> threads/blocking to be slow.  IO-completion wakes up the thread, which
> goes through the scheduler right back to the user's stack-frame,
> even providing the io-completion status.  no large cache footprint 
> anywhere (at least with a lightweight thread library), no multiplexing
> like for select/poll, etc.

I suspect the thread *does* have a larger cache footprint,
since in nonblocking I/O, session state is stored more compactly.
Also, the threaded approach involves lots more context switches.

> does epoll provide a thunk (callback and state variable) as well as the 
> IO completion status?

No.  It provides an event record containing a user-defined state pointer
plus the IO readiness status change (different from IO completion status).
But that's what you need; you can do the call yourself.

>>See http://www.kegel.com/c10k.html for an overview of the issue and some links.
> 
> 
> it's a great resource, except that for 700 clients, the difference
> between select, poll, epoll, aio are pretty moot.  no?

Depends on how close to maximal performance you need, and whether
you might later need to scale to more clients.

The average server is so lightly loaded, it really doesn't matter which approach you use.
- Dan


-- 
Dan Kegel
http://www.kegel.com
http://counter.li.org/cgi-bin/runscript/display-person.cgi?user=78045

