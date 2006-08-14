Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932396AbWHNRnF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932396AbWHNRnF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 13:43:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932392AbWHNRnE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 13:43:04 -0400
Received: from palrel11.hp.com ([156.153.255.246]:37089 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S932321AbWHNRnC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 13:43:02 -0400
Message-ID: <44E0B61F.3000706@hp.com>
Date: Mon, 14 Aug 2006 10:42:55 -0700
From: Rick Jones <rick.jones2@hp.com>
User-Agent: Mozilla/5.0 (X11; U; HP-UX 9000/785; en-US; rv:1.7.13) Gecko/20060601
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: Keith Owens <kaos@ocs.com.au>, David Miller <davem@davemloft.net>,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [PATCH 1/1] network memory allocator.
References: <20060814110359.GA27704@2ka.mipt.ru>	<9286.1155557268@ocs10w.ocs.com.au> <20060814122049.GC18321@2ka.mipt.ru>
In-Reply-To: <20060814122049.GC18321@2ka.mipt.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Polyakov wrote:
> On Mon, Aug 14, 2006 at 10:07:48PM +1000, Keith Owens (kaos@ocs.com.au) wrote:
> 
>>Evgeniy Polyakov (on Mon, 14 Aug 2006 15:04:03 +0400) wrote:
>>
>>>Network tree allocator can be used to allocate memory for all network
>>>operations from any context....
>>>...
>>>Design of allocator allows to map all node's pages into userspace thus
>>>allows to have true zero-copy support for both sending and receiving
>>>dataflows.
>>
>>Is that true for architectures with virtually indexed caches?  How do
>>you avoid the cache aliasing problems?
> 
> 
> Pages are preallocated and stolen from main memory allocator, what is
> the problem with that caches? Userspace can provide enough offset so
> that pages would not create aliases - it is usuall mmap.

That may depend heavily on the architecture.  PA-RISC has the concept of 
spaceid's, and bits from the spaceid can be included in the hash along 
with bits from the offset.  So, it is not possible to simply match the 
offset, one has to make sure that hash bits from the spaceid hash the 
same as well.

Now, PA-RISC CPUs have the ability to disable spaceid hashing, and it is 
entirely possible that the PA-RISC linux port does that, but I thought I 
would mention it as an example.  I'm sure the "official" PA-RISC linux 
folks can expand on that much much better than I can.

rick jones
