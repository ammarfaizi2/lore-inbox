Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265697AbUEZNMc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265697AbUEZNMc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 09:12:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265679AbUEZNJj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 09:09:39 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:39942 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S265607AbUEZND4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 09:03:56 -0400
Message-ID: <40B49640.40207@aitel.hist.no>
Date: Wed, 26 May 2004 15:06:08 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040509)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: John Bradford <john@grabjohn.com>
CC: orders@nodivisions.com, linux-kernel@vger.kernel.org
Subject: Re: why swap at all?
References: <40B43B5F.8070208@nodivisions.com> <40B45CB7.6010407@aitel.hist.no> <200405260940.i4Q9eJdS000767@81-2-122-30.bradfords.org.uk>
In-Reply-To: <200405260940.i4Q9eJdS000767@81-2-122-30.bradfords.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Bradford wrote:

>Quote from Helge Hafting <helgehaf@aitel.hist.no>:
>  
>
>>Anthony DiSante wrote:
>>
>>    
>>
>>>As a general question about ram/swap and relating to some of the 
>>>issues in this thread:
>>>
>>>    ~500 megs cached yet 2.6.5 goes into swap hell
>>>
>>>Consider this: I have a desktop system with 256MB ram, so I make a 
>>>256MB swap partition.  So I have 512MB "memory" and if some process 
>>>wants more, too bad, there is no more.
>>>
>>>Now I buy another 256MB of ram, so I have 512MB of real memory.  Why 
>>>not just disable my swap completely now?  I won't have increased my 
>>>memory's size at all, but won't I have increased its performance lots? 
>>>      
>>>
>>This is correct. You now have 512M of fast memory instead of
>>256M fast memory and 256M "slow" memory. You don't _need_ to have additional
>>swap, but it is usually a good idea.  If you keep your 256M of swap, 
>>then you now
>>have 512M fast memory + 256M slow memory for a total of 768M.  This is 
>>even better.
>>    
>>
>
>I strongly disagree on the last point.  It may be better, but it may also
>be a lot worse.  Too much swap can be a bad thing - see my example in another
>post about run-away processes on remote machines.
>  
>
Well, way too much swap is of course not good.  A swap that is half
the size of memory isn't that bad - at any time, at least two thirds of
what you want in memory is bound to be there. 10x as much swap as memory
might be bad though.

>>Please note that  your machine _will_ do one kind of swapping even if you
>>don't configure any swap: Executable files are a kind of swap-files,
>>if memory pressure happens then (part of) your programs will be evicted
>>from memory _because_ they can be reloaded from their executables.
>>
>>This cause the same sort of performance degradations as swapping to
>>a swap partition.  Actually, it is worse because swapping to a swap 
>>partition
>>allows swapping out little-used writeable memory before discarding
>>program code that might see more use.  So if swapping happens, then
>>you're better off with a swap partition because then it is the least used
>>stuff that goes first. Without a swap partition, the least used program code
>>goes, but it may or may not be the least used memory overall.
>>    
>>
>
>Again, the user _may_ be better off swapping to a swap partition rather than
>having executable code paged out, but this is not necessarily true in all
>circumstances.
>  
>
The problem is that swapping happens.  A small swap (no more than
the amount you accept being swapped out) ensures that the
paging code can select the best page for eviction, rather than
being forced to evict code.

If you worry about runaway processes and/or troublesome users,
use ulimit.

Helge Hafting

