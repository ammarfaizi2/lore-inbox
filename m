Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267464AbUHJPVO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267464AbUHJPVO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 11:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264915AbUHJPUa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 11:20:30 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:58355 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S267469AbUHJPTi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 11:19:38 -0400
Message-ID: <4118E78F.8070301@comcast.net>
Date: Tue, 10 Aug 2004 11:19:43 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jakob Oestergaard <jakob@unthought.net>
CC: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] Bug zapper?  :)
References: <4117D98C.2030203@comcast.net> <200408100042.37159.vda@port.imtp.ilyichevsk.odessa.ua> <41180443.9030900@comcast.net> <20040810083553.GB27443@unthought.net>
In-Reply-To: <20040810083553.GB27443@unthought.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Jakob Oestergaard wrote:
> On Mon, Aug 09, 2004 at 07:09:55PM -0400, John Richard Moser wrote:
> ...
> 
>>Now, we could try another approach at this, below.
>>
>>/* get_food(char **a)
>>* Gets the current food.
>>*
>>* INPUT:
>>*  - char **a
>>*    Pointer to a pointer for the outputted food.
>>* OUTPUT:
>>*  - Return
>>*    none.
>>*  - *a
>>*    Set to a copy of the current food.
>>* PROCESS:
>>*  - Set '*a' to a newly allocated block of memory containing a copy
>>*    of the current food (global_food)
>>* STATE CHANGE:
>>*  none.
>>*/
> 
> ...
> 
> There's just more to it than this.
> 
> Even in the almost "self explanatory" example you gave, even with your
> suggested style of commenting, there are still problems:
> 
> Your comments do not describe who's responsible for allocating/freeing
> which memory areas the various pointers point at.
> 

Then my comment above is bad.  Should add that it frees the old block.

> Your get_food() function will cause a write at address 0 if malloc()
> fails.
> 

My code is bad probably.  I should return if malloc() fails.

> So, you have provided some good examples that no particular commenting
> style is going to solve the common problems that all larger C software
> projects face to some extent (memory management and error handling).
> 

Memory managment is annoying.  I'm working on a reference counting 
scheme on the side; but that's a fair bit of overhead.  I've never been 
able to argue that reference counting is less overhead than manual mm; 
but I've also never been able to argue that trying to guess if you can 
free memory based on your program's internal state is less overhead than 
reference counting.

There's places where this is inappropriate, and places where it's 
appropriate.  Inside the kernel, though, I can't imagine where it'd be 
appropriate.   . . . yeh this is a bad idea, isn't it?  :p


> ...
> 
>>These comment blocks are *MUCH* more verbose.
> 
> 
> Agreed  :)
> 
> 
>>They describe the process 
>>loosely, but do give enough information to allow understanding without 
>>questions.
> 
> 
> That's where I disagree.
> 
> They do provide an illusion of knowledge though (for example, you did
> not mention the built-in segfault mechanism, that was a hidden feature).
> 

The function isn't made to segfault; segfaulting is what happens when 
you screw up your code.  :)

I guess it should describe INPUT, OUTPUT, PROCESS, STATE CHANGE, and 
ERRORS :/

> 
>>The large amount of extra commentary is worth it, IMHO.
> 
> 
> Comments are good.  Frequent comments are very good - if they are
> correct and actually helpful.
> 
> I view it this way; if code is not commented, the only explanation is
> that the author didn't feel it was worth commenting.  Code that is not
> worth even a comment, should be removed from whatever project it is in,
> to be replaced by something actually worth commenting.   (no, I'm not
> bashing any particular part of the Linux kernel or anything like that -
> this is my personal view for projects that I'm involved in).
> 
> However; comments are NOT a substitute for all the other aspects
> required for good and reliable code.
> 

Readable.  Don't guess what the code does.

> Comments are one little part of the larger puzzle.  Ignoring their
> importance is inexcusable - but they are not the magic silver bullet all
> by themselves either.
> 

Of course not.  The goal I was aiming for was to create an extremely 
structured documentation scheme in the hopes that it would provide a 
great deal of ease in understanding what a function does.  "if you don't 
understand what it does, don't fuck with my code"

> 
> My 0.02 Euro
>  (as someone working on another large project that actually needs
>   to run reliably)
> 

-- 
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

