Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964929AbVLOLK4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964929AbVLOLK4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 06:10:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965058AbVLOLK4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 06:10:56 -0500
Received: from embla.aitel.hist.no ([158.38.50.22]:59796 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S964929AbVLOLK4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 06:10:56 -0500
Message-ID: <43A1501F.5070803@aitel.hist.no>
Date: Thu, 15 Dec 2005 12:14:39 +0100
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Al Boldi <a1426z@gawab.com>
CC: Nick Piggin <nickpiggin@yahoo.com.au>,
       Arjan van de Ven <arjan@infradead.org>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux in a binary world... a doomsday scenario
References: <200512150013.29549.a1426z@gawab.com> <200512150749.29064.a1426z@gawab.com> <43A0FE13.8010303@yahoo.com.au> <200512151131.39216.a1426z@gawab.com>
In-Reply-To: <200512151131.39216.a1426z@gawab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Boldi wrote:

>Nick Piggin wrote:
>  
>
>>Al Boldi wrote:
>>    
>>
>>>Arjan van de Ven wrote:
>>>      
>>>
>>>>a stable api/abi for the linux kernel would take at least 2 years to
>>>>develop. The current API is not designed for stable-ness, a stable API
>>>>needs stricter separation between the layers and more opaque pointers
>>>>etc etc.
>>>>        
>>>>
>>>True.  But it would be time well spent.
>>>      
>>>
>>Who's time would be well spent?
>>
>>Not mine because I don't want a stable API. Not mine because I
>>don't use binary drivers and I don't care to encourage them.
>>[that is, unless you manage to convince me below ;)]
>>    
>>
>
>The fact that somebody may take advantage of a stable API should not lead us 
>to reject the idea per se.
>  
>
It is all about advantages and disadvantages.
Disadvantages of a stable API:
* It encourages binary-only drivers, while we prefer source drivers.
   Changing the API often and without warning is one way of
   hampering binary-only driver development without harming
   open-source drivers.
* A stable API isn't really possible.  There will be revisions due
   to new compilers, new processors, new needs.  So the only
   question is how often do we change.  Hanging onto an obsolete
   API too long will hamper _kernel_ development and performance.
   Example: smp changed a lot of things.  The old idea
   that cli/sti was a way of implementing a critical section had to go.

To argue for a stable API then, you need to come up
with advantages, and they have to outweigh the disadvantages too.

Do a stable API save us work?  No, because whoever changes the API
also fixes all in-kernel users of said API. Some API changes, like
using more or less register parameters, don't even need to fix API users
as the compiler does it all.

Outside users we don't care about at all, because they are all welcome
to get their driver in. (Assuming it is useful and the code quality is 
good...)

>>Anyone else is free to fork the kernel and develop their own
>>stable API for it.
>>    
>>
>
>That would be sad.
>
>The objective of a stable API would be to aid the collective effort and not 
>to divide it.
>  
>
Forks are not a problem. Anything useful in a fork will usually
be merged back sooner or later.  And think about the
"normal" development process:  If I were to write a driver,
I would get the kernel source, make my driver, then submit it.
In the meantime, I effectively have my own short-lived fork.

>>>>There is a price you pay for having such a rigid scheme (it arguably has
>>>>advantages too, those are mostly relevant in a closed source system tho)
>>>>is that it's a lot harder to implement improvements.
>>>>        
>>>>
>>>This is a common misconception.  What is true is that a closed system is
>>>forced to implement a stable api by nature.  In an OpenSource system you
>>>can just hack around, which may seem to speed your development cycle
>>>when in fact it inhibits it.
>>>      
>>>
>>How? I'm quite willing to listen, but throwing around words like 'guided
>>development' and 'scalability' doesn't do anything. How does the lack of a
>>stable API inhibit my kernel development work, exactly?
>>    
>>
>
>If you are working alone a stable API would be overkill.  But GNU/Linux is a 
>collective effort, where stability is paramount to aid scalability.
>  
>
This doesn't actually hold when the source is available for all
to get and update.  The source API doesn't change so often,
so it is time enough to develop a source driver without spending
all the time on adapting to the source API.  Once you get the driver
in, you no longer have to keep up. 

The binary api can change several times with every revision, with no
impact on open-source developers. So, no need to stabilize it.
Specs already says that a driver has to be compiled for the kernel
it is used with - a binary driver working with two releases (even
concecutive releases) are pure luck. So a binary vendor has to
at least compile for every release (and every supported platform).
If the source api changes too, then there is some programming
to do as well.  Both of these have a price, and there is the hope
that more will see the light - that they can support linux fully without
these costs by going open source.

>>
>>I've got a fairly good idea of what work I'm doing, and what I'm planning
>>to do, long term goals, projects, etc. What would be the key differences
>>with "non-GNU/OpenSource" development that would make you say they are not
>>unguided by nature?
>>    
>>
>
>The same goes for OpenSource in general, but GNU/OpenSource has a larger 
>community and therefore is in greater need of a stable API.
>  
>
A large community may find some kind of stability useful, the
line does not have to be drawn at the binary api level though.
The source API is much more stable than the binary API.  And
source changes is usually only withing some subsytem.
I.e. a change in the pci driver API don't affect filesystem drivers
and so on.

>  
>
>>> A stable API contributes to a guided
>>>development that is scalable.  Scalability is what leads you to new
>>>heights, or else could you imagine how ugly it would be to send this
>>>message using asm?
>>>      
>>>
>>Let's not bother with bad analogies and stick to facts. Do you know how
>>many people work on the Linux kernel? And how rapidly the source tree
>>changes? Estimates of how many bugs we have? Comparitive numbers from
>>projects with stable APIs? That would be very interesting.
>>    
>>
>
>You got me here!  It's really common sense as in:
>stability breeds scalability, and instability breeds chaos.
>  
>
This saying doesn't necessarily apply to an API in a open-source
project.  Especially not when talking about an internal API.
The kernel has an external binary API that is stable, it is
the syscall interface.

>Arjan van de Ven wrote:
>  
>
>>I think Linux proves you wrong (and a bit of a troll to be honest ;)
>>    
>>
>
>No troll! Just being IMHO. I hope that's OK?
>
>Of course, if your aim is not to be scalable then please ignore this message 
>as it will not have any meaning.
>  
>
Another option is that your assumption about "stability as a requirement
for scalability" is wrong at least in case of the kernel.  The kernel
development scales very well so far.  I can't see any delays caused by
developers trying to keep up with a change in binary APIs.  Well,
except a handful of closed source vendors, but that is more or less
intentional.  If they get tired, they can hand in their source.

Helge Hafting
