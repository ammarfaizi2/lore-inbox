Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261651AbTDQPIb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 11:08:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261672AbTDQPIb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 11:08:31 -0400
Received: from watch.techsource.com ([209.208.48.130]:13015 "EHLO
	techsource.com") by vger.kernel.org with ESMTP id S261651AbTDQPI3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 11:08:29 -0400
Message-ID: <3E9EC71B.5000901@techsource.com>
Date: Thu, 17 Apr 2003 11:24:11 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matt Mackall <mpm@selenic.com>
CC: Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] only use 48-bit lba when necessary
References: <200304041203_MC3-1-3302-C615@compuserve.com> <20030417142020.GB23277@waste.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Matt Mackall wrote:

>  
>
>> Yes, but:
>>
>>   if (expr1 && expr2)
>>      var = true;
>>   else
>>      var = false;
>>
>>is usually better turned into something that avoids jumps
>>when it's safe to evaluate both parts unconditionally:
>>
>>   var = (expr1 != 0) & (expr2 != 0);
>>
>>or (if you can stand it):
>>
>>   var = !!expr1 & !!expr2;
>>    
>>
>
>Such ugly transformations are a job for compiler writers and may
>occassionally be acceptable in some critical paths. The IO path, which
>is literally dozens of function calls deep from read()/write() to
>driver methods, does not qualify.
>

What's ugly about them?  If I were a compiler developer, I would look 
for "!!" (which I'm sure many compilers do) and deal with it properly. 
 I have seen, however, that gcc produces the same machine code for { if 
(x) {} } as for { if (x != 0) {} }.  Additionally, I would put "!!" in C 
programming books so that people understand what it means when they come 
across it.  In my mind, it's the "make-it-a-bool" operator.

I certainly don't advocate optimizations that completely obfuscate the 
meaning of the code, but for ones which are relatively innocuous and 
make sense, why not?  When not to do that is when you know what the 
compiler is going to do with it.  If you can add more characters so that 
it makes it more understandable without impacting what the compiler 
produces, then by all means, do it.  Another way to "add more characters 
to make it readable without impacting code size" is to add comments.  :) 
 Not to say that I'm any saint in that area.

But I do appreciate it when people take the time to write good, 
explanatory comments.  I'm not saying that you should comment every line 
(do you comment your comments? :), but putting something before the 
function which explans it is always a good thing, IMHO.  Even when faced 
with the most readable code, I have some sort of mental block.  I like 
it when I get to read long english textual descriptions of the POINT 
behind a function before I read the code so I have an abstract framework 
into which I fit the details.  I have a love-hate relationship with details.

Also, It seems that not all compilers perform these "obvious" 
optimizations.  But if any of the gcc contributors are watching some of 
the recent lkml discussions, I have faith that they'll add some of those 
optimizations.

Anyhow, I have no emotional attachment to my opinions about comments.  I 
do it my way, you do it yours.  I see the merit in all sides of it.  The 
only problem is that if I have trouble reading your code, I will feel 
less inclined to read it.  Oh well.



