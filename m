Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265872AbTAXXwS>; Fri, 24 Jan 2003 18:52:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265880AbTAXXwS>; Fri, 24 Jan 2003 18:52:18 -0500
Received: from sccrmhc02.attbi.com ([204.127.202.62]:19196 "EHLO
	sccrmhc02.attbi.com") by vger.kernel.org with ESMTP
	id <S265872AbTAXXwQ>; Fri, 24 Jan 2003 18:52:16 -0500
Message-ID: <3E31D94E.8090302@kegel.com>
Date: Fri, 24 Jan 2003 16:24:46 -0800
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/4.0 (compatible; MSIE 5.5; Windows 98)
X-Accept-Language: de-de, en
MIME-Version: 1.0
To: Mark Hahn <hahn@physics.mcmaster.ca>
CC: linux-kernel@vger.kernel.org
Subject: Re: debate on 700 threads vs asynchronous code
References: <Pine.LNX.4.44.0301241840450.11758-100000@coffee.psychology.mcmaster.ca>
In-Reply-To: <Pine.LNX.4.44.0301241840450.11758-100000@coffee.psychology.mcmaster.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Hahn wrote:
>>>>>does epoll provide a thunk (callback and state variable) as well as the 
>>>>>IO completion status?
>>>>
>>>>No.  It provides an event record containing a user-defined state pointer
>>>>plus the IO readiness status change (different from IO completion status).
>>>>But that's what you need; you can do the call yourself.
>>>
>>>well, that means another syscall, which makes a footprint claim kind of moot,
>>>no?
>>
>>What syscall?  You call sys_epoll once for every thousand events or so,
>>then you call your handler, which does a write or whatever.  No
>>extra syscall.
> 
> before a client can be sent the next chunk, the IO status of the last 
> chunk must be tested.  with the simple blocking, thread-per-client approach,
> this happens automaticaly (write returns the number of bytes written).
> 
> with epoll, don't you have to do a syscall to query the status of 
> the just-completed IO?

Nope.  Just go ahead and write.  (Same as with poll(), except that
with epoll, you only get notified once.)  Any errors are reported
immediately by write(), so there's no more status to get.
- Dan


-- 
Dan Kegel
http://www.kegel.com
http://counter.li.org/cgi-bin/runscript/display-person.cgi?user=78045

