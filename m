Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266695AbUAWVhQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 16:37:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266696AbUAWVhQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 16:37:16 -0500
Received: from mail1.nmu.edu ([198.110.192.44]:1541 "EHLO mail1.nmu.edu")
	by vger.kernel.org with ESMTP id S266695AbUAWVhL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 16:37:11 -0500
Message-ID: <40119EC6.9010803@nmu.edu>
Date: Fri, 23 Jan 2004 17:23:02 -0500
From: Randy Appleton <rappleto@nmu.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <piggin@cyberone.com.au>
CC: Bill Davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org
Subject: Re: Unneeded Code Found??
References: <3FFF3931.4030202@nmu.edu> <4006B998.5040403@tmr.com> <400B2BCF.7090003@nmu.edu> <400B7100.7090600@cyberone.com.au>
In-Reply-To: <400B7100.7090600@cyberone.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:

>>> Randy Appleton wrote:
>>>
>>>> I think I have found some useless code in the Linux kernel
>>>> in the block request functions.
>>>>                                                                                         
>>>>
>>>> I have modified the __make_request function in ll_rw_blk.c.
>>>> Now every request for a block off the hard drive is logged.
>>>>                                                                                         
>>>>
>>>> The function __make_request has code to attempt to merge the current
>>>> block request with some contigious existing request for better
>>>> performance. This merge function keeps a one-entry cache pointing 
>>>> to the
>>>> last block request made.  An attempt is made to merge the current
>>>> request with the last request, and if that is not possible then
>>>> a search of the whole queue is done, looking at merger possibililites.
>>>>                                                                                         
>>>>
>>>> Looking at the data from my logs, I notice that over 50% of all 
>>>> requests
>>>> can be merged.  However, a merge only ever happens between the
>>>> current request and the previous one.  It never happens between the
>>>> current request and any other request that might be in the queue (for
>>>> more than 50,000 requests examined).
>>>>                                                                                         
>>>>
>>>> This is true for several test runs, including "daily usage" and doing
>>>> two kernel compiles at the same time.  I have only tested on a
>>>> single-CPU machine.
>>>>
>> Does anyone know that this code is actualy useful?  Has anyone ever 
>> seen it actually do a merge of consecutive
>> data accesses for requests that were not issued themselves 
>> consequtively?
>>
> Yes it gets used.
>
> I think its a lot more common with direct io and when you have lots of
> processes.

I'm not arguing, but how do you know this?  I'm trying to convince 
myself that the code is used, and at least on my system
a few days of general use, followed by heavy parallel compiles, doesn't 
use the code even once.

I have not tested direct I/O.  Otherwise it looks unused.

