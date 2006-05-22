Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932479AbWEVGKt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932479AbWEVGKt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 02:10:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932482AbWEVGKt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 02:10:49 -0400
Received: from smtp104.mail.mud.yahoo.com ([209.191.85.214]:9144 "HELO
	smtp104.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932479AbWEVGKs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 02:10:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=VFBRwE7h7jf4vCFZVJitoSTgwDtfNitI/sLPorUGMDRWfLIKwiXFTwxhTH6QVy3QR275nAN/aFLpFAws6idg6STS+p49x1WxZZDdw9Rcp83cxFh5gDzDj6mhDoUK96nHjRSLR3bYUFlSubq1IXMYpfQ/6OHB4qzJwEWH8yFCaFs=  ;
Message-ID: <447155E5.8060406@yahoo.com.au>
Date: Mon, 22 May 2006 16:10:45 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Giridhar Pemmasani <giri@lmc.cs.sunysb.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: __vmalloc with GFP_ATOMIC causes 'sleeping from invalid context'
References: <20060522013648.6FCEAEE9EE@wolfe.lmc.cs.sunysb.edu>	<447119B3.7000506@yahoo.com.au> <20060522055852.63940EE9EE@wolfe.lmc.cs.sunysb.edu> <4471551B.1070701@yahoo.com.au>
In-Reply-To: <4471551B.1070701@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> Giridhar Pemmasani wrote:
> 
>> On Mon, 22 May 2006 11:53:55 +1000, Nick Piggin 
>> <nickpiggin@yahoo.com.au> said:
>>
>>    > Giridhar Pemmasani wrote:
>>   >> If __vmalloc is called in atomic context with GFP_ATOMIC flags,
>>   >> __get_vm_area_node is called, which calls kmalloc_node with
>>   >> GFP_KERNEL flags. This causes 'sleeping function called from
>>   >> invalid context at mm/slab.c:2729' with 2.6.16-rc4 kernel. A
>>   >> simple solution is to use
>>
>>    > I can't see what would cause this in either 2.6.16-rc4 or
>>    > 2.6.17-rc4.  What is the line?
>>
>> If someone calls __vmalloc in atomic context (with GFP_ATOMIC flags):
> 
> 
> OK I misunderstood your comment. I was looking for the caller.
> Hmm, page_alloc.c does, but I don't know that it needs to be
> atomic -- what happens if we just make that allocation GFP_KERNEL?
> 

OTOH, it doesn't seem to be particularly wrong to allow __vmalloc
GFP_ATOMIC allocations. The correct fix is to pass the gfp_mask
to kmalloc: if you're worried about breaking the API, introduce a
new __get_vm_area_node_mask() and implement __get_vm_area_node()
as a simple wrapper that passes in GFP_KERNEL.

Thanks,
Nick

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
