Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261243AbUBZUmm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 15:42:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261256AbUBZUmm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 15:42:42 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:54915 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261243AbUBZUmk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 15:42:40 -0500
Message-ID: <403E5A31.5020900@watson.ibm.com>
Date: Thu, 26 Feb 2004 15:42:25 -0500
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5b) Gecko/20030829 Thunderbird/0.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mike Fedyk <mfedyk@matchmail.com>
CC: Peter Williams <peterw@aurema.com>, Timothy Miller <miller@techsource.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] O(1) Entitlement Based Scheduler
References: <Pine.GSO.4.03.10402260834530.27582-100000@swag.sw.oz.au> <403D3E47.4080501@techsource.com> <403D576A.6030900@aurema.com> <403D5D32.4010007@matchmail.com> <403D71AB.9060609@aurema.com> <403D73B4.4060600@matchmail.com> <403E47C4.4080104@watson.ibm.com> <403E4D1B.9060503@matchmail.com>
In-Reply-To: <403E4D1B.9060503@matchmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk wrote:

> Shailabh Nagar wrote:
>
>>>> Mike Fedyk wrote:
>>>>
>>>>> Better would be to have the kernel tell the daemon whenever a 
>>>>> process in exec-ed, and you have simplicity in the kernel, and 
>>>>> policy in user space.
>>>>
>>
>>
>>
>> As it turns out, one can still use a fairly simple in-kernel module 
>> which provides a *mechanism* for effectively changing a process' 
>> entitlement while retaining the policy component in userland.
>
>
> How much code could be removed if CKRM triggered a userspace process 
> to perform the operations required?


In CKRM, the code to perform classification is an optional  kernel 
module. So size isn't really an issue in terms of impact to core kernel 
code.

Our prototype version of the classification engine, RBCE, is about 2700 
lines without any effort being put into reducing its size etc. If that 
were to be completely pared down to only provide events to userspace, it 
would come down by quite a bit (can't say exactly how much but atleast 
50% is a safe bet).

I think the more important question is performance impact - what do you 
give up in terms of efficiency and granularity of control by going to 
userspace vs what you gain in reduced kernel pathlength. Empirically, we 
found RBCE was quite efficient  but no quantitative analysis was done.

-- Shailabh







