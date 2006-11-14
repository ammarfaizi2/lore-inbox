Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965997AbWKNVUY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965997AbWKNVUY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 16:20:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966366AbWKNVUX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 16:20:23 -0500
Received: from calculon.skynet.ie ([193.1.99.88]:25487 "EHLO
	calculon.skynet.ie") by vger.kernel.org with ESMTP id S965997AbWKNVT7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 16:19:59 -0500
Date: Tue, 14 Nov 2006 21:19:57 +0000 (GMT)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet.skynet.ie
To: Andrew Morton <akpm@osdl.org>
Cc: Hugh Dickins <hugh@veritas.com>, "Martin J. Bligh" <mbligh@mbligh.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Boot failure with ext2 and initrds
In-Reply-To: <20061114113120.d4c22b02.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0611142119370.17440@skynet.skynet.ie>
References: <20061114014125.dd315fff.akpm@osdl.org> <20061114184919.GA16020@skynet.ie>
 <Pine.LNX.4.64.0611141858210.11956@blonde.wat.veritas.com>
 <20061114113120.d4c22b02.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Nov 2006, Andrew Morton wrote:

> On Tue, 14 Nov 2006 19:11:22 +0000 (GMT)
> Hugh Dickins <hugh@veritas.com> wrote:
>
>> On Tue, 14 Nov 2006, Mel Gorman wrote:
>>> 2.6.19-rc5-mm2
>>>
>>> Am seeing errors with systems using ext2. First machine is a plan old x86
>>> using initramfs. Console output looks like;
>>> ...
>>> Configuring network interfaces...BUG: soft lockup detected on CPU#3!
>>> ...
>>>  [<c01b3b80>] ext2_try_to_allocate+0xdb/0x152
>>>  [<c01b3e72>] ext2_try_to_allocate_with_rsv+0x4b/0x1b2
>>>
>>> I've not investigated yet what patches might be at fault.
>>
>> I expect you'll find it's
>> ext2-reservations-bring-ext2-reservations-code-in-line-with-latest-ext3.patch
>> which gets stuck in a loop there for me too: back it out and all seems fine.
>>
>> It's not obvious which part of the patch is to blame: mostly it's
>> cleanup, but a few variables do change size: I'm currently narrowing
>> down to where a fix is needed.
>>
>
> Doing s/-Wall/-W/ tends to shake out bugs in this stuff.
>
> The below might help.
>

It worked for me on the two problem machines. Thanks
