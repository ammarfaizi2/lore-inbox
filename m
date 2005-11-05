Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751400AbVKEBS1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751400AbVKEBS1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 20:18:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbVKEBS1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 20:18:27 -0500
Received: from xproxy.gmail.com ([66.249.82.203]:44529 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751400AbVKEBS0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 20:18:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=kQKFWGcrm569x1riOCOLpVMeGBMh/NxJKrz9RJhBY0zQd1EVWpDC2c59O0eZGhoirKTn0EvuWJzKWgXnbM4VVhTrzQ1A9tf8icieNDhsWOgj6mGaoxsSbuBHKVyB4w72MgGvE9O8U0NWbMGuICtj/aKNFz9KbfQWoqXIbG/G9Cw=
Message-ID: <436C0859.6050806@gmail.com>
Date: Sat, 05 Nov 2005 10:18:17 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: ntl@pobox.com, viro@ftp.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] big reader semaphore take#2
References: <20051028104437.GA17461@htj.dyndns.org> <436B79BA.6070300@gmail.com> <436BF961.9070402@yahoo.com.au>
In-Reply-To: <436BF961.9070402@yahoo.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> Tejun Heo wrote:
> 
>> Tejun Heo wrote:
>>
>>>  Hello guys,
>>>
>>> This is the second take of brsem (big reader semaphore).
>>>
>>> Nick, unfortunately, simple array of rwsem's does not work as lock
>>> holders are not pinned down to cpus and may release locks on other
>>> cpus.
>>>
> 
> [...]
> 
>>
>> (Nick, what do you think about the new implementation?)
>>
> 
> As I said, I think I'd prefer to see an implementation that returns
> a token from down_read to be used in up_read (ie. the slot # of the
> counter which has been downed).
> 

Oh... I read your response but thought that was only response to 'that 
wouldn't work' part.

> This obviously no longer makes it a drop in replacement for an rwsem.
> But could such a beast ever be considered so? Would that make your
> VFS patches really ugly?

I think Al Viro is on that now.

> The upshot of that would be that you could build the whole thing
> from rwsem infrastructure and have basically zero other locking
> mechanisms or complexity that you don't want in a synchronisation
> primitive.
> 

To certain extent, I do agree with you - it's safer/simpler..., but on 
the other hand, new brsem isn't that more complex and would perform 
almost identically without extra semantical baggage.  So, I thought it 
might be worth a bit more effort.

Hmm... So, array of rwsem's, it should be.

Thanks.

-- 
tejun
