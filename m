Return-Path: <linux-kernel-owner+w=401wt.eu-S932085AbWLLG4s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932085AbWLLG4s (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 01:56:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932086AbWLLG4s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 01:56:48 -0500
Received: from sp604001mt.neufgp.fr ([84.96.92.60]:52667 "EHLO Smtp.neuf.fr"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932085AbWLLG4r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 01:56:47 -0500
Date: Tue, 12 Dec 2006 07:56:35 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
Subject: Re: [PATCH] Introduce jiffies_32 and related compare functions
In-reply-to: <20061211.202735.104033567.davem@davemloft.net>
To: David Miller <davem@davemloft.net>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Message-id: <457E52A3.6060503@cosmosbay.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 8BIT
References: <457E2642.2000103@cosmosbay.com>
 <20061211.195737.71090466.davem@davemloft.net>
 <457E2B73.9040307@cosmosbay.com>
 <20061211.202735.104033567.davem@davemloft.net>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Miller a écrit :
> From: Eric Dumazet <dada1@cosmosbay.com>
> Date: Tue, 12 Dec 2006 05:09:23 +0100
> 
>> We definitly *like* being able to use bigger timeouts on 64bits platforms.
>>
>> Not that they are mandatory since the same application should run fine on 
>> 32bits kernel. But as the standard type for 'tick timestamps' is 'unsigned 
>> long', a change would be invasive.
>>
>> Maybe some applications are now relying on being able to
>> sleep()/select()/poll() for periods > 30 days and only run on 64
>> bits kernels.
> 
> I think one possible target would be struct timer, at least
> in theory.
> 
> There is also a line of reasoning that says that on 64-bit
> platforms we have some flexibility to set HZ very large, if
> we wanted to at some point, and going to 32-bit jiffies
> storage for some things may eliminate that kind of flexibility.
>

Yes good point, and my understanding is that we go for a tickless kernel in 
2.6.21, or so.
I wonder if virtual HZ wont be sticked to a low value.

I suspect in the case HZ raises, we switch some/most uses of jiffies_32 to 
another  variable (xtime_32 or whatever), but keep the storage on 32bits...

But keeping 64bits values 'just because hardware allows us this kind of 
expenditure' seems not reasonable to me, but lazy...

Eric

