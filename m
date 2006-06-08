Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964886AbWFHPpe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964886AbWFHPpe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 11:45:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964887AbWFHPpe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 11:45:34 -0400
Received: from mta4.srv.hcvlny.cv.net ([167.206.4.199]:64962 "EHLO
	mta4.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S964886AbWFHPpd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 11:45:33 -0400
Date: Thu, 08 Jun 2006 11:45:24 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
Subject: Re: taskstats interface for accounting
In-reply-to: <44876510.1050808@engr.sgi.com>
To: Jay Lan <jlan@engr.sgi.com>
Cc: Balbir Singh <balbir@in.ibm.com>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, csturtiv@sgi.com,
       jamal <hadi@cyberus.ca>
Message-id: <44884614.5020904@watson.ibm.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
References: <44863376.5020701@sgi.com> <44864030.6010906@watson.ibm.com>
 <44876510.1050808@engr.sgi.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jay Lan wrote:

>Shailabh Nagar wrote:
>  
>
>>Jay Lan wrote:
>>
>>    
>>
>>>Hi Balbir and Shailabh,
>>>
>>>I finally have time to think about implementation details of CSA over
>>>taskstats interface. I took another look at the taskstats interface
>>>proposal and was a little bit nervous
>>>
<snip>

>>>Another thing i overlooked when i did the review was that taskstats
>>>interface is designed to provide _BOTH_ per task _AND_ per thread
>>>accounting data EVERY TIME a task exists. A thread is an aggregate
>>>of (per-pid) tasks. Since this type of aggregation is not used in
>>>CSA, half of data traffic would be useless. Can we add a way to
>>>configure to not send per-thread data to the socket?
>>>      
>>>
>>I don't see why not. We could extend the command set to set tgid
>>sending on/off.
>>    
>>
>
>This would be great!
>
>But, we can have a number of applications listening on the socket. We
>surely do not want applications to send conflicting commands to the kernel.
>Maybe we can make it a /etc/sysconfig option.
>  
>
Yup...allowing non-privileged apps to set the param is not desirable.
I think by setting the GENL_ADMIN_PERM flag on the configure operation 
being added, we should
be able to limit this command to privileged users.
If thats not the case, we can go with some sysfs option.

Doing the config through the command interface, using a new CONFIG or 
SET type command (just like the GET
command would keep it kind of unified and also be along the lines
of how Jamal had described the interface be used.

--Shailabh


