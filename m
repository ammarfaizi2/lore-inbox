Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264446AbTKMXK4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 18:10:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264448AbTKMXK4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 18:10:56 -0500
Received: from law12-f49.law12.hotmail.com ([64.4.19.49]:21004 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S264446AbTKMXKy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 18:10:54 -0500
X-Originating-IP: [24.82.225.198]
X-Originating-Email: [justformoonie@hotmail.com]
From: "kirk bae" <justformoonie@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: So, Poll is not scalable... what to do?
Date: Thu, 13 Nov 2003 17:10:50 -0600
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <Law12-F49kTQUM6H2Ht000057a3@hotmail.com>
X-OriginalArrivalTime: 13 Nov 2003 23:10:53.0638 (UTC) FILETIME=[62F2D660:01C3AA3B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Kirk Bae wrote:
>>If poll is not scalable, which method should I use when writing 
>>multithreaded socket server?
>
>People who write multithreaded servers tend to use thread pools
>and never need to use poll().  (Well, ok, I've written multithreaded
>servers that used poll(), but the threads were there for disk I/O,
>not networking.)

By thread pool, do you mean, one thread per socket?, or a work-crew model 
where a specified number of threads handle many sockets?


>>What is the most efficient model to use?
>>
>>Is there a "standard" model to use when writing a scalable multithreaded 
>>socket serve such as "io completion ports" on windows?
>
>Depends on your definition of efficient.
>
>If by 'efficient' you mean 'runs like a bat out of hell,
>and I don't care how long it takes to write', and
>you're willing to write all the code from scratch, and
>you're handy with state machines, the right way to go is
>an edge-triggered readiness notification method (sys_epoll or kqueue,
>if available, else sigio).

My definition of "efficient" is a method that is most widely used or 
accepted for writing a robust scalable server. So I guess, "'runs like a bat 
out of hell, and I don't care how long it takes to write'" is close.

Would it be thread pool or epoll? Is it uncommon to mix these two?

Currently, I have a thread-1 calling poll, and dispatching its workload to 
thread-2 and thread-3 in blocking sockets. I dispatch the workload to worker 
threads because some of the operations take considerable time.

Is mixing threads with poll uncommon? Is this a bad design? any comments 
would be appreciated.

_________________________________________________________________
Great deals on high-speed Internet access as low as $26.95.  
https://broadband.msn.com (Prices may vary by service area.)

