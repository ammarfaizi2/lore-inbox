Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265682AbSKASTD>; Fri, 1 Nov 2002 13:19:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265686AbSKASTD>; Fri, 1 Nov 2002 13:19:03 -0500
Received: from rwcrmhc52.attbi.com ([216.148.227.88]:8893 "EHLO
	rwcrmhc52.attbi.com") by vger.kernel.org with ESMTP
	id <S265682AbSKASTC>; Fri, 1 Nov 2002 13:19:02 -0500
Message-ID: <3DC2CADA.2000508@kegel.com>
Date: Fri, 01 Nov 2002 10:41:30 -0800
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: de-de, en
MIME-Version: 1.0
To: Davide Libenzi <davidel@xmailserver.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-aio@kvack.org, lse-tech@lists.sourceforge.net
Subject: Re: and nicer too - Re: [PATCH] epoll more scalable than poll
References: <Pine.LNX.4.44.0211010940010.1715-100000@blue1.dev.mcafeelabs.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:
> On Fri, 1 Nov 2002, Dan Kegel wrote:
> 
>>Davide Libenzi wrote:
>>
>>>>Do you avoid the cost of epoll_ctl() per new fd?
>>>
>>>Jamie, the cost of epoll_ctl(2) is minimal/zero compared with the average
>>>life of a connection.
>>
>>Depends on the workload.  Where I work, the http client I'm writing
>>has to perform extremely well even on 1 byte files with HTTP 1.0.
>>Minimizing system calls is suprisingly important - even
>>a gettimeofday hurts.
> 
> Dan, is it _one_ gettimeofday() or a gettimeofday() inside a loop ?
> gettimeofday() is of the order of few microseconds ... and If your clients
> works with anything alse than a loopback, few microseconds shouldn't weigh
> in much compared to connect/send/recv/close on a network connection. It is
> not much the fact that you transfer one byte, it's the whole TCP handshake
> cost that weighs in.

The scenario is: we're doing load testing of http products,
and for various reasons, we want line-rate traffic with
the smallest possible message size.  i.e. we want the
maximum number of HTTP requests/responses per second.
Hence the 1 byte payloads.   A single system call on the
slowish embedded processor I'm using has a suprisingly large
impact on the number of http gets per second I can do.
A 1% increase in speed is worth it for me!

So please do try to reduce the number of syscalls needed
to handle very short TCP sessions, if possible.

- Dan


