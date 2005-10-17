Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932216AbVJQJKx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932216AbVJQJKx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 05:10:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932220AbVJQJKx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 05:10:53 -0400
Received: from gw1.cosmosbay.com ([62.23.185.226]:64739 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S932216AbVJQJKw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 05:10:52 -0400
Message-ID: <43536A6C.102@cosmosbay.com>
Date: Mon, 17 Oct 2005 11:10:04 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: dipankar@in.ibm.com
CC: Jean Delvare <khali@linux-fr.org>, torvalds@osdl.org,
       Serge Belyshev <belyshev@depni.sinp.msu.ru>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Manfred Spraul <manfred@colorfullife.com>
Subject: Re: VFS: file-max limit 50044 reached
References: <Pine.LNX.4.64.0510161912050.23590@g5.osdl.org> <JTFDVq8K.1129537967.5390760.khali@localhost> <20051017084609.GA6257@in.ibm.com>
In-Reply-To: <20051017084609.GA6257@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [172.16.8.80]); Mon, 17 Oct 2005 11:10:05 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dipankar Sarma a écrit :
> On Mon, Oct 17, 2005 at 10:32:47AM +0200, Jean Delvare wrote:
> 
>>>In fact, in that path you could even do a full "rcu_process_callbacks()".
>>>After all, this is not that different from signal handling.
>>>
>>>Gaah. I had really hoped to release 2.6.14 tomorrow. It's been a week
>>>since -rc4.
>>
>>Isn't reverting the original change an option? 2.6.13 was working OK if
>>I'm not mistaken.
> 
> 
> IMO, putting the file accounting in slab ctor/dtors is not very
> reliable because it depends on slab not getting fragmented.
> Batched freeing in RCU is just an extreme case of it. We needed
> to fix file counting anyway.
> 
> Thanks
> Dipankar

But isnt this file counting a small problem ?

This small program can eat all available memory.

Fixing the 'file count' wont fix the real problem : Batch freeing is good but 
should be limited so that not more than *billions* of file struct are queued 
for deletion.

Dont take me wrong : I really *need* the file RCU stuff added in 2.6.14.

I believe we can find a solution, even if it might delay 2.6.14 because Linus 
would have to release a rc5

Eric
