Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750788AbWCZAc4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750788AbWCZAc4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 19:32:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751370AbWCZAc4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 19:32:56 -0500
Received: from smtp105.mail.mud.yahoo.com ([209.191.85.215]:23956 "HELO
	smtp105.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750788AbWCZAc4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 19:32:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=2awIY9YBVipWYN0ac82q2N0o4mnKZCz4MgwklouIU6udhGkKnmghM2p0XZy+H+8RaAoDHqWP+DcIdllmAgCTgUsToCmAD5TFbVCj8tGOy/uKgmKhF6m9Gzr5Wcy9ZeUo7bZsmld175lIeZ6lCFJTTKvy5n/1XvUnfqWbpYYBbmQ=  ;
Message-ID: <4425E12F.5020407@yahoo.com.au>
Date: Sun, 26 Mar 2006 10:32:47 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: rgetz@blackfin.uclinux.org, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: RFC: Non Power of 2 memory allocator
References: <6.1.1.1.0.20060325090152.01ec63f0@ptg1.spd.analog.com> <p73mzfepkad.fsf@verdi.suse.de> <Pine.LNX.4.61.0603251745500.8348@goblin.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.61.0603251745500.8348@goblin.wat.veritas.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:
> On Sat, 25 Mar 2006, Andi Kleen wrote:
> 
>>Robin Getz <rgetz@blackfin.uclinux.org> writes:
>>
>>
>>>The  buddy system allocates things in power of 2 pages sizes (4k, 8k,
>>>16k, 32k, 64k, 128k, 256k, 512k, 1024k), which works fine on most
>>>systems, but an embedded system, which is running without a MMU (
>>>Memory Management Unit) - RAM is precious, and when you only need
>>>129k for an application, you don't want to allocate a power of 2,
>>>which gives you 256k -  an extra 127k, which can't be used by
>>>anything else.
>>
>>In 2.4 I solved this problem at some point by just returning
>>the excess pages to the buddy allocator. There was even
>>a nice function to do this (alloc_exact)
>>
>>That won't work for slab, but does for __get_free_pages() which
>>is better for large allocations anyways. slab imho doesn't make
>>sense for allocation anywhere bigger PAGE_SIZE/2. At some
>>point in 2.6 there was trouble with "compound pages" but I think
>>that has been resolved. 
>>
>>Just implementing alloc_exact again would be the simplest solution
>>for your problem.
> 
> 
> Nick has put a split_page function into the 2.6.16-git mm/page_alloc.c,
> which I believe is supposed to be a helper in this kind of operation.
> You'd best take a look at where and how it's used.  Perhaps Andi's
> alloc_exact should be reimplemented in terms of it.
> 

Indeed. nommu already uses the slab allocator for user allocations.
I guess the problem is that slab probably doesn't do this exact
allocation thing either.

I'd like to see nommu move over to using something like Andi's
alloc_exact (away from slab), because that's how the normal
kernel does it.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
