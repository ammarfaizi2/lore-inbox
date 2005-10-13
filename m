Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751551AbVJMN1c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751551AbVJMN1c (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 09:27:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751568AbVJMN1c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 09:27:32 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:13959 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751550AbVJMN1b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 09:27:31 -0400
Message-ID: <434E60B6.7030803@us.ibm.com>
Date: Thu, 13 Oct 2005 09:27:18 -0400
From: Janak Desai <janak@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.3) Gecko/20040910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wright <chrisw@osdl.org>
CC: Jamie Lokier <jamie@shareable.org>, viro@ZenIV.linux.org.uk,
       nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] New System call unshare (try 2)
References: <Pine.WNT.4.63.0510121201540.1316@IBM-AIP3070F3AM> <20051012171914.GA8622@mail.shareable.org> <20051013101347.GN5856@shell0.pdx.osdl.net>
In-Reply-To: <20051013101347.GN5856@shell0.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright wrote:
> * Jamie Lokier (jamie@shareable.org) wrote:
> 
>>Janak Desai wrote:
>>
>>>	Don't allow sighand unsharing if not unsharing vm
>>
>>Why not?  It's permitted to clone with unshared sighand and shared vm,
>>and it's useful too.
> 
> 
> I think that one's just backwards.  Although I do question how useful it
> is to unshare sighand.  Sharing vm is pretty intimate ;-)
> 
> 
>>It's the combination shared sighand + unshared vm which is not
>>allowed by clone - so I think that's what you should refuse.
>>
>>
>>>	Don't allow vm unsharing if task cloned with CLONE_THREAD
>>
>>It would be better to do what clone does, and say "don't allow sighand
>>unsharing if task cloned with CLONE_THREAD".  This is because
>>CLONE_THREAD tasks must have shared signals.
> 
> 
> Yes, I agree.
> 
> 
>>In combination with the rule above for sighand (my rule, not yours),
>>that implies "don't allow vm unsharing.." as a consequence.
>>
>>
>>>	Don't allow vm unsharing if the task is performing async io
>>
>>Why not?
>>
>>Async ios are tied to an mm (see lookup_ioctx in fs/aio.c), which may
>>be shared among tasks.  I see no reason why the async ios can't
>>continue and be waited in on in other tasks that may be using the old mm.
> 
> 
> My concern was the case where there are no other tasks.  But I don't
> think that's an issue other than having the aio effect of setting up
> aio then exiting.
> 
> thanks,
> -chris
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 

Thanks Chris and Jamie. I understand the issues that you raised and
agree with your change recommendations. I will make the necessary
changes, test aio and unsharing of signal handlers (while keeping
shared vm) and post the updated patch by tomorrow.

-Janak

