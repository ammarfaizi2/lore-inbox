Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262510AbSJVMzp>; Tue, 22 Oct 2002 08:55:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262512AbSJVMzp>; Tue, 22 Oct 2002 08:55:45 -0400
Received: from 12-237-170-171.client.attbi.com ([12.237.170.171]:19727 "EHLO
	wf-rch.cirr.com") by vger.kernel.org with ESMTP id <S262510AbSJVMzo>;
	Tue, 22 Oct 2002 08:55:44 -0400
Message-ID: <3DB54C53.9010603@mvista.com>
Date: Tue, 22 Oct 2002 08:02:11 -0500
From: Corey Minyard <cminyard@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: John Levon <levon@movementarian.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] NMI request/release
References: <3DB4AABF.9020400@mvista.com> <20021022021005.GA39792@compsoc.man.ac.uk> <3DB4B8A7.5060807@mvista.com> <20021022025346.GC41678@compsoc.man.ac.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Levon wrote:

>On Mon, Oct 21, 2002 at 09:32:07PM -0500, Corey Minyard wrote:
>
>>This is an NMI, does it really matter?
>>    
>>
>Yes. Both for oprofile and the NMI watchdog (which was firing awfully
>often last time I checked). The handler needs to be as streamlined as
>possible.
>
Ok.  I'd be inclined to leave the high-usage things where they are, 
although it would be nice to be able to make the NMI watchdog a module. 
 oprofile should probably stay where it is.  Do you have an alternate 
implementation that would be more efficient?

>>dev_name could be removed, although it would be nice for reporting 
>>later.
>>    
>>
>Reporting what ? from where ?
>
Registered NMI users in procfs.

>>>Couldn't you modify the notifier code to do the xchg()s (though that's
>>>not available on all CPU types ...)
>>>
>>I don't understand.  The xchg()s are for atomicity between the 
>>request/release code and the NMI handler.  How could the notifier code 
>>do it?
>>    
>>
>You are using the xchg()s in an attempt to thread onto/off the list
>safely no ?
>
Yes.  But I don't understand why they would be used in the notifier code.

>>>>+#define HAVE_NMI_HANDLER	1
>>>>        
>>>>
>>This is so the user code can know if it's available or not.
>>    
>>
>If we had that for every API or API change, the kernel would be mostly
>HAVE_*. It's either available or it's not. If you're maintaining an
>external module, then autoconf or similar is the proper way to check for
>its existence.
>
I'm not worried about kernel versions so much as processor capability. 
 Some processors may not have NMIs, or may not be capable of doing this. 
 A few of these exist (like __HAVE_ARCH_CMPXCHG).  The name's probably 
bad, maybe it should be "__HAVE_ARCH_NMI_HANDLER"?

>>If the rcu code can handle this, I could use it, but I have not looked 
>>to see if it can.
>>    
>>
>If it's possible (and I have no idea, not having looked at RCU at all)
>it seems the right way.
>
I looked, and the rcu code relys on turning off interrupts to avoid 
preemption.  So it won't work.

Thanks again,

-Corey

