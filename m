Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261842AbUBWIMM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 03:12:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261841AbUBWIMM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 03:12:12 -0500
Received: from mail-03.iinet.net.au ([203.59.3.35]:38549 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261839AbUBWIMH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 03:12:07 -0500
Message-ID: <4039B4E6.3050801@cyberone.com.au>
Date: Mon, 23 Feb 2004 19:08:06 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.3-mm3
References: <20040222172200.1d6bdfae.akpm@osdl.org>	<40395ACE.4030203@cyberone.com.au> <20040222175507.558a5b3d.akpm@osdl.org> <40396ACD.7090109@cyberone.com.au> <40396DA7.70200@cyberone.com.au>
In-Reply-To: <40396DA7.70200@cyberone.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Nick Piggin wrote:

>
>
> Nick Piggin wrote:
>
>>
>> Lowmem pagecache vs highmem pagecache should be balanced correctly?
>> I think it is with your other patches.
>>
>> Lowmem pagecache vs slab should be balanced correctly with my patch.
>>
>> Therefore highmem vs slab will be balanced correctly.
>>
>> Is that a good proof?
>>
>>
>
> Well no, because you can construct a similar "proof" for your
> patch because I assume balancing between zones is a two way
> operation :P. Actually, lowmem pressure does not assert highmem
> pressure which is the point where your balancing fails.
>
>

Humph. OK you're right. The above is of course right when all
else is equal, however slab can only be allocated from lowmem
while pagecache can come from anywhere.

So if you have 500MB of slab and 100MB of cache in lowmem, but
10000MB cache in highmem, lowmem pressure should be shrinking
more cache than slab.

Nick

