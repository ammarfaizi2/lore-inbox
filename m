Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262368AbSI3Ott>; Mon, 30 Sep 2002 10:49:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262380AbSI3Ott>; Mon, 30 Sep 2002 10:49:49 -0400
Received: from 12-237-170-171.client.attbi.com ([12.237.170.171]:74 "EHLO
	wf-rch.cirr.com") by vger.kernel.org with ESMTP id <S262368AbSI3Otr>;
	Mon, 30 Sep 2002 10:49:47 -0400
Message-ID: <3D9865B5.7020006@acm.org>
Date: Mon, 30 Sep 2002 09:54:45 -0500
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Buddy Lumpkin <b.lumpkin@attbi.com>
CC: "'Bill Davidsen'" <davidsen@tmr.com>,
       "'Peter Waechtler'" <pwaechtler@mac.com>,
       "'Larry McVoy'" <lm@bitmover.com>, linux-kernel@vger.kernel.org,
       "'ingo Molnar'" <mingo@redhat.com>
Subject: Re: [ANNOUNCE] Native POSIX Thread Library 0.1
References: <000001c2680f$a13af930$0472e50c@peecee>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Buddy Lumpkin wrote:

>Sun introduced a new thread library in Solaris 8 that is 1:1, but it did
>not replace the default N:M version, you have to link against
>/usr/lib/lwp.
>
>http://supportforum.sun.com/freesolaris/techfaqs.html?techfaqs_2957
>http://www.itworld.com/AppDev/1170/swol-1218-insidesolaris/
>
>I was at a USENIX BOF on threads in Boston year before last and Bill
>Lewis was ranting about how the N:M model sucks. Christopher Provenzano
>was right there and didn't seem to add any feelings one way or the
>other.
>
>Regards,
>
>--Buddy
>
I heard this a while ago, and talked with someone I knew who had inside 
information about this.  According to that person, Sun will be switching 
the default threads library to 1:1 (It looks like from the document 
referenced below it is Solaris 9).  In various benchmarks, sometimes M:N 
won, and sometimes 1:1 won, so performance was a wash.  The main problem 
was that they could never get certain things to work "just right" under 
an M:N model, the complexity of M:N was just too high to be able to get 
it working 100% correctly.  He didn't have specific details, though.

Having implemented a threads package with prority inheritance, I expect 
that doing that with an M:N thread model will be extremely complex. 
 With activations is possible, but that doesn't mean it's easy.  It's 
hard enough with a 1:1 model.  A scheduler with good "global" properties 
(for example, a scheduler that guaranteed time share to classes of 
threads that occur in different processes) would be difficult to 
implement properly, too.

Complexity is the enemy of reliability.  Even if the M:N model could get 
slightly better performance, it's going to be very hard to make it work 
100% correctly.  I personally think the NPT is going in the right 
direction on this one.

-Corey

>
>-----Original Message-----
>From: linux-kernel-owner@vger.kernel.org
>[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Bill Davidsen
>Sent: Monday, September 23, 2002 12:15 PM
>To: Peter Waechtler
>Cc: Larry McVoy; linux-kernel@vger.kernel.org; ingo Molnar
>Subject: Re: [ANNOUNCE] Native POSIX Thread Library 0.1
>
>On Mon, 23 Sep 2002, Peter Waechtler wrote:
>
>  
>
>>Am Montag den, 23. September 2002, um 12:05, schrieb Bill Davidsen:
>>
>>    
>>
>>>On Sun, 22 Sep 2002, Larry McVoy wrote:
>>>
>>>      
>>>
>>>>On Sun, Sep 22, 2002 at 08:55:39PM +0200, Peter Waechtler wrote:
>>>>        
>>>>
>>>>>AIX and Irix deploy M:N - I guess for a good reason: it's more
>>>>>flexible and combine both approaches with easy runtime tuning if
>>>>>the app happens to run on SMP (the uncommon case).
>>>>>          
>>>>>
>>>>No, AIX and IRIX do it that way because their processes are so
>>>>        
>>>>
>bloated
>  
>
>>>>that it would be unthinkable to do a 1:1 model.
>>>>        
>>>>
>>>And BSD? And Solaris?
>>>      
>>>
>>Don't know. I don't have access to all those Unices. I could try
>>    
>>
>FreeBSD.
>
>At your convenience.
> 
>  
>
>>According to http://www.kegel.com/c10k.html  Sun is moving to 1:1
>>and FreeBSD still believes in M:N
>>    
>>
>
>Sun is total news to me, "moving to" may be in Solaris 9, Sol8 seems to
>still be N:M. BSD is as I thought.
>  
>
>>MacOSX 10.1 does not support PROCESS_SHARED locks, tried that 5
>>    
>>
>minutes 
>  
>
>>ago.
>>    
>>
>
>Thank you for the effort. Hum, that's a bit of a surprise, at least to
>me. 
>
>  
>



