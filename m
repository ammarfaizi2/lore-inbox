Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291290AbSBWUAX>; Sat, 23 Feb 2002 15:00:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293192AbSBWUAO>; Sat, 23 Feb 2002 15:00:14 -0500
Received: from tolkor.sgi.com ([192.48.180.13]:4555 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S291290AbSBWUAA>;
	Sat, 23 Feb 2002 15:00:00 -0500
Message-ID: <3C77F503.1060005@sgi.com>
Date: Sat, 23 Feb 2002 14:01:07 -0600
From: Stephen Lord <lord@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011226
X-Accept-Language: en-us
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>
CC: Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] only irq-safe atomic ops
In-Reply-To: <3C773C02.93C7753E@zip.com.au>,		<1014444810.1003.53.camel@phantasy> 		<3C773C02.93C7753E@zip.com.au> <1014449389.1003.149.camel@phantasy> <3C774AC8.5E0848A2@zip.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Robert Love wrote:
>
>>...
>>
>>Question: if (from below) you are going to use atomic operations, why
>>make it per-CPU at all?  Just have one counter and atomic_inc and
>>atomic_read it.  You won't need a spin lock.
>>
>
>Oh that works fine.   But then it's a global counter, so each time
>a CPU marks a page dirty, the counter needs to be pulled out of
>another CPU's cache.   Which is not a thing I *need* to do.
>
>As I said, it's a micro-issue.  But it's a requirement which 
>may pop up elsewhere.
> 
>
I can tell you that Irix has just such a global counter for the amount of
delayed allocate pages - and it gets to be a major point of cache contention
once you get to larger cpu counts. So avoiding that from the start would
be good.

Steve



