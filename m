Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750905AbWCQSsB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750905AbWCQSsB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 13:48:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751049AbWCQSsB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 13:48:01 -0500
Received: from stargate.chelsio.com ([12.22.49.110]:49239 "EHLO
	sg2.chelsio.com") by vger.kernel.org with ESMTP id S1750898AbWCQSsA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 13:48:00 -0500
Message-ID: <441B03FA.9020004@chelsio.com>
Date: Fri, 17 Mar 2006 10:46:18 -0800
From: Scott Bardone <sbardone@chelsio.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hans-Peter Jansen <hpj@urpla.net>
CC: Jeff Garzik <jgarzik@pobox.com>, Adrian Bunk <bunk@stusta.de>,
       maintainers@chelsio.com, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: drivers/net/chelsio/sge.c: two array overflows
References: <20060311013720.GG21864@stusta.de> <4415C87B.90107@chelsio.com> <441A011A.6010705@pobox.com> <200603171319.20935.hpj@urpla.net>
In-Reply-To: <200603171319.20935.hpj@urpla.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 17 Mar 2006 18:46:46.0415 (UTC) FILETIME=[2474C1F0:01C649F3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Pete,

This is correct, the array should contain 3 elements. The bug was we were 
accessing a 4th element ([3]) which did not exist. We should be modifying the 
last element ([2]) instead.

-Scott

Hans-Peter Jansen wrote:
> [from the nitpick department..]
> 
> Hi Jeff, hi Scott,
> 
> Adrian wrote:
> 
>>The Coverity checker spotted the following two array overflows in 
>>drivers/net/chelsio/sge.c (in both cases, the arrays contain 3 
>>elements):
> 
> 
> Am Freitag, 17. März 2006 01:21 schrieb Jeff Garzik:
> 
>>Scott Bardone wrote:
>>
>>>Adrian,
>>>
>>>This is a bug. The array should contain 2 elements.
>>>
>>>Attached is a patch which fixes it.
>>>Thanks.
>>>
>>>Signed-off-by: Scott Bardone <sbardone@chelsio.com>
>>
>>applied.  please avoid attachments and use a proper patch description
>>in the future.  I had to hand-edit and hand-apply your patch.
> 
> 
> where you wrote in kernel tree commit 
> 347a444e687b5f8cf0f6485704db1c6024d3:
> This is a bug. The array should contain 2 elements.  Here is the fix.
> 
> If I'm not completely off the track, you both committed a description 
> off by one error: since the patch doesn't change the array size, it's 
> presumely¹ still 3 elements, where index 2 references the last one.
> 
> Here's hopefully a better patch description:
> Fixed off by one thinko in stats accounting, spotted by Coverity 
> checker, notified by Adrian "The Cleanman" Bunk.
> 
> SCR,
> Pete
> 
> ¹) otherwise, it's still off by one..
