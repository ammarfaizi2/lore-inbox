Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262577AbTDKX1E (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 19:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262587AbTDKX0R (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 19:26:17 -0400
Received: from fw-az.mvista.com ([65.200.49.158]:507 "EHLO
	zipcode.az.mvista.com") by vger.kernel.org with ESMTP
	id S262563AbTDKXYq (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 11 Apr 2003 19:24:46 -0400
Message-ID: <3E9751A0.20902@mvista.com>
Date: Fri, 11 Apr 2003 16:37:04 -0700
From: Steven Dake <sdake@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Andrew Morton <akpm@digeo.com>, kpfleming@cox.net,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       message-bus-list@redhat.com
Subject: Re: [ANNOUNCE] udev 0.1 release
References: <20030411172011.GA1821@kroah.com> <200304111746.h3BHk9hd001736@81-2-122-30.bradfords.org.uk> <20030411182313.GG25862@wind.cocodriloo.com> <3E970A00.2050204@cox.net> <3E9725C5.3090503@mvista.com> <20030411150933.43fd9a84.akpm@digeo.com> <20030411230111.GF3786@kroah.com>
In-Reply-To: <20030411230111.GF3786@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Greg KH wrote:

>On Fri, Apr 11, 2003 at 03:09:33PM -0700, Andrew Morton wrote:
>  
>
>>Steven Dake <sdake@mvista.com> wrote:
>>    
>>
>>>A much better solution could be had by select()ing on a filehandle 
>>>indicating when a new hotswap event is ready to be processed.  No races, 
>>>no security issues, no performance issues.
>>>      
>>>
>>I must say that I've always felt this to be a better approach than the
>>/sbin/hotplug callout.
>>
>>Apart from the performance issue, it means that the kernel can buffer the
>>"insertion" events which happen at boot-time discovery until the userspace
>>handler attaches itself.
>>    
>>
>
>But how many events to we buffer?  When do we start to throw them away?
>Fun policy decisions that we don't have to worry about in the current
>scheme.
>  
>
There are all kinds of policy decisions about how many of something is 
in the kernel...  For example, file descriptors, selectable file 
descriptors, etc.

It would be simple to determine how many events should be saved by even 
the most complex application or event counts could be configurable.  The 
issue of dropping events only matters for startup, since anything later 
is likely not to have as many new devices as a startup sequence might...

>Also, what's the format of the kernel->user interface.  Today with
>/sbin/hotplug it's a very simple, and easily changed interaction.  Using
>a event reading mechanism lends itself to binary interfaces, which have
>to be kept in sync with user code very tightly.
>  
>
Binary is fine by me.  Ascii *also* has to be kept in sync, even if its 
more readable, its just as much an interface as binary.

>And yes, we could use ascii in the event list, but then again, a
>userspace version of /sbin/hotplug that writes events to a pipe that is
>read from a daemon enables the same thing to happen :)
>  
>
still a new process is spawned per event which is what we should want to 
avoid.

>thanks,
>
>greg k-h
>
>
>
>  
>

