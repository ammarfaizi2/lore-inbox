Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261193AbTKIXwd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 18:52:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261226AbTKIXwc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 18:52:32 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:29146 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261193AbTKIXw3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 18:52:29 -0500
Message-ID: <3FAED32C.3030005@watson.ibm.com>
Date: Sun, 09 Nov 2003 18:52:12 -0500
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5b) Gecko/20030829 Thunderbird/0.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
       ckrm-tech@lists.sourceforge.net
Subject: Re: [ckrm-tech] Re: [PATCH] cfq + io priorities
References: <20031108124758.GQ14728@suse.de> <3FAEB1DC.7040608@watson.ibm.com> <20031109213411.GV2831@suse.de>
In-Reply-To: <20031109213411.GV2831@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:

>On Sun, Nov 09 2003, Shailabh Nagar wrote:
>  
>
>>>A process has an assigned io nice level, anywhere from 0 to 20. Both of
>>>these end values are "special" - 0 means the process is only allowed to
>>>do io if the disk is idle, and 20 means the process io is considered
>>>realtime. Realtime IO always gets first access to the disk. 
>>>
>>>      
>>>
>>>Values from 1 to 19 assign 5-95% of disk bandwidth to that process. Any io 
>>>class is
>>>allowed to use all of disk bandwidth in absence of higher priority io.
>>>
>>>
>>>      
>>>
>>Currently, cfq is doing bandwidth allocation in terms of  number of 
>>requests, not bytes. Hence priority inversion can happen if lower 
>>priority levels submit larger requests on an average. Any plans to take 
>>request sizes into consideration  in future ? 
>>    
>>
>
>Yes that needs to be taken into account as well. I'll get another
>version out soonish that works around that too.
>
>  
>
>>Of course, request sizes alone don't determine actual disk bandwidth 
>>consumed  since their seek position also matters.
>>    
>>
>
>Yeah that's where it gets tricky. It's basically impossible to get
>absolutely right, it will always be just guidelines. I don't want to
>over complicate matters.
>  
>
Thats true. Estimating bandwidth by quantity of submitted I/O should be 
good enough. Doing too many seek
time calculations is not only complex but may be useless if the attached 
device is doing its own reordering (an increasingly likely
scenario for servers).  I guess one could do some simple accounting such 
as 1+x per request where 1 accounts for the fixed "cost"  of a request 
on I/O bandwidth and x is a request size dependent cost.  I'm looking 
forward to your next version to see what are your thoughts.

>>>About the patch: stuff like this really needs some resource management
>>>abstraction like CKRM. Right now we just look at the tgid of the
>>>process. 
>>>
>>>      
>>>
>>Now thats music to our ears :-)  Though you've complicated matters by 
>>calling the priority level a "class" ! Please consider renaming
>>class  to something else  (say priolevel ).
>>    
>>
>
>Done.
>  
>

Thanks !

>  
>
>>Thanks for separating the hashvalue as a macro. It should make it even 
>>easier to convert cfq to use a  CKRM I/O classes ' priority
>>rather than the submitting task's ioprio value.
>>    
>>
>
>Yup that was my intention, to make the transition as smooth as possible.
>  
>
I'll try and get out a CKRM variant of CFQ soon - anyway another version 
is needed to fit into the next version of  CKRM core api's that
were published on ckrm-tech in the past week
    http://sourceforge.net/mailarchive/forum.php?forum=ckrm-tech

Please consider joining the ckrm-tech mailing list 
(http://lists.sourceforge.net/lists/listinfo/ckrm-tech) and/or cc'ing it 
on CFQ changes for I/O priorities.

-- Shailabh


