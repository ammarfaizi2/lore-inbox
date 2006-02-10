Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751052AbWBJEHG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751052AbWBJEHG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 23:07:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751054AbWBJEHG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 23:07:06 -0500
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:26472 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1751052AbWBJEHE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 23:07:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=mMjFQTh+WxddfIGsDXqzkGZDaFulVMEfJAFhARw2QMyJLxjDcudQ/dPoxxReMzg9r0Ex0zKbneSx1t5gnpK1ZMuABgE0afsToOrwD+4S5sIOGqBd3wAkLs/eVv6pyBZMeZUzEPPFnflJgz6lTJ6c/+INePVWeJQxK3SgapRJUUo=  ;
Message-ID: <43EC1164.4000605@yahoo.com.au>
Date: Fri, 10 Feb 2006 15:07:00 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: Andrew Morton <akpm@osdl.org>, linux-mm@kvack.org, ck@vds.kolivas.org,
       pj@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Implement Swap Prefetching v23
References: <200602101355.41421.kernel@kolivas.org> <20060209192556.2629e36b.akpm@osdl.org> <200602101449.59486.kernel@kolivas.org>
In-Reply-To: <200602101449.59486.kernel@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> On Friday 10 February 2006 14:25, Andrew Morton wrote:
> 
>>Con Kolivas <kernel@kolivas.org> wrote:
>>
>>>Here's a respin with Nick's suggestions and a modification to not cost us
>>>extra slab on non-numa.
>>
>>v23?  I'm sure we can do better than that.
> 
> 
> :D
> 
> 
>>>This patch implements swap prefetching when the vm is relatively idle and
>>>there is free ram available.
>>
>>I think "free ram available" is the critical thing here.  If it doesn't
>>evict anyhing else then OK, it basically uses unutilised disk bandwidth for
>>free.
>>
>>But where does it put the pages?  If it was really "free", they'd go onto
>>the tail of the inactive list.
> 
> 
> It puts them in swapcache. This seems to work nicely as a nowhere-land place 
> where they don't have much affect on anything until we need them or need more 
> ram. This has worked well, but I'm open to other suggestions.
> 

Well they go on the head of the inactive list and will kick out file
backed pagecache. Which was my concern about reducing the usefulness
of useful swapping on desktop systems.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
