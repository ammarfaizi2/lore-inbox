Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267471AbTAXBOj>; Thu, 23 Jan 2003 20:14:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267478AbTAXBOj>; Thu, 23 Jan 2003 20:14:39 -0500
Received: from sccrmhc02.attbi.com ([204.127.202.62]:44518 "EHLO
	sccrmhc02.attbi.com") by vger.kernel.org with ESMTP
	id <S267471AbTAXBOh>; Thu, 23 Jan 2003 20:14:37 -0500
Message-ID: <3E309B01.8070101@kegel.com>
Date: Thu, 23 Jan 2003 17:46:41 -0800
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/4.0 (compatible; MSIE 5.5; Windows 98)
X-Accept-Language: de-de, en
MIME-Version: 1.0
To: "Lee Chin" <leechin@mail.com>, linux-kernel@vger.kernel.org
Subject: Re: debate on 700 threads vs asynchronous code
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Chin <leechin@mail.com> wrote:
> Larry McVoy wrote:
>> > Now, to cater to 700 clients, I can
>> > a) launch 700 threads that each block on I/O to disk and to the client (in 
>> > reading and writing on the socket) 
>> > OR
>> > b) Write an asycnhrounous system with only 2 or three threads where I manage the
>> > connections and stack (via setcontext swapcontext etc), which is 
>> > programatically a little harder 
>> > Which way will yeild me better performance, considerng both approaches are
>> > implemented optimally?
>> 
>> If this is a serious question, an async system will by definition do better.
>> You have either 700 stacks screwing up the data cache or 2-3 stacks nicely
>> fitting in the data cache.  Ditto for instruction cache, etc.
 >
> Thanks for the rpely... my question was more so, with setcontext and swapcontext, I
> will still be messing with the data cache right?  
> 
> In otherwords, as long as I have an async system with out setcontext, I know I am
> good... but with it, havent I degraded to a threaded environment?

I suspect Linux's implementation of asynch I/O isn't able to handle sockets yet.
Thus the choice is between nonblocking I/O and blocking I/O.

Nonblocking I/O is totally the way to go if you have full control over your
source code and want the maximal performance in userspace.  The best way
to get good performance with nonblocking I/O in Linux is to use the sys_epoll
system call; it's part of the 2.5 kernel, but a backport to 2.4 is available.

See http://www.kegel.com/c10k.html for an overview of the issue and some links.
- Dan

-- 
Dan Kegel
http://www.kegel.com
http://counter.li.org/cgi-bin/runscript/display-person.cgi?user=78045

