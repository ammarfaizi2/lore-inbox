Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964912AbWD0EBU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964912AbWD0EBU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 00:01:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932415AbWD0EBU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 00:01:20 -0400
Received: from mta4.srv.hcvlny.cv.net ([167.206.4.199]:23024 "EHLO
	mta4.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S932413AbWD0EBT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 00:01:19 -0400
Date: Thu, 27 Apr 2006 00:00:43 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
Subject: Re: [Patch 5/8] taskstats interface
In-reply-to: <44501A97.2060104@engr.sgi.com>
To: Jay Lan <jlan@engr.sgi.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       LSE <lse-tech@lists.sourceforge.net>
Message-id: <445041EB.7080205@watson.ibm.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
References: <444991EF.3080708@watson.ibm.com> <444996FB.8000103@watson.ibm.com>
 <44501A97.2060104@engr.sgi.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jay Lan wrote:

>Hi Shailabh,
>
>Thanks for your effort in taskstats interface! Really appreciated!
>I think this interface can offer a good foundation for other packages
>to build on.
>
>Here are a few more comments:
>
>1) You mentioned the "version number within the (taskstats)
>    structure" in taskstats.txt and a few other places, but i do not see
>    that field defined in struct taskstats in taskstats.h?
>  
>
Missed out on that. Need to add it back in.

>2) In taskstats.txt "Extending taskstats" section, you mentioned two
>    ways to extend the interface. The second method looks like a method
>    to encoureage other package developers to create their own interface
>   (ie, not taskstats) based on generic netlink to avoid reading large
>number
>    of fields not interested to other particular applications? I will be
>fine
>    with this as long as it is understood and agreed.
>  
>
Yes, the second method is for other packages, which have very little in 
common with the struct
taskstats to extend the stats returned (using netlink attribs to extend 
rather than extending the structure).

>    Alternatively, you may have considered the pros and cons of #ifdef
>    fields specific to only one accounting package in the struct taskstats.
>    If you do, care to share your thoughts? 
>
I'd rather avoid doing an #ifdef'ed definition of the fields based on 
configuration of one or the other
accounting package...it'll add complexity for userspace parsing of the 
structure.

Its quite acceptable to have the fields have zero as content if the 
corresponding package isn't configured.


>Specific payload information
>    can be carried in the version field. I am sure the version number of
>struct
>    taskstats does not need 64 bits. With the version number and payload
>    info, application can surely interpret the taskstats data correctly.  
>  
>
By "payload info" you mean some sort of bitmask (or encoding) which 
specifies which fields are present
or absent ? I suppose that could be done but it adds unnecessary 
complexity ? e.g once delay accounting is there,
all six to eight fields corresponding to it will be present...I don't 
see much value in further being able to configure
cpu delays, mem delays etc. separately. Is that different for CSA ?


>3) In taskstats.txt "Usage" section, you mentioned "... in the Advanced
>    Usage section below...", but that section does not exist.
>  
>
Thanks for pointing it out. Should replace it with "per-tgid stats section".

>4) In do_exit() routine, you do:
>+ taskstats_exit_alloc(&tidstats, &tgidstats);
>
>    The tidstats and tgidstats are checked in taskstats_exit_send() in
>    taskstats.c for allocation failure, but a lot has been processed before
>    the check. The allocation failure happens when system is stressed in
>    memory. I  think we want to do the check earlier?
>  
>
Since accounting is non-critical, I didn't see the need for doing the 
check earlier if we're not going to do
anything about it. The first use of the allocated structure is in the 
taskstats_exit_send() where filling of the
stats is not done if allocation failed. What would you suggest we do, on 
allocation failure, if the check is
performed immediately after the alloc ?

--Shailabh

>   
>Regards,
> - jay
>
>  
>

