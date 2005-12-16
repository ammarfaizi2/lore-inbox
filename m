Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932550AbVLPXmE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932550AbVLPXmE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 18:42:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932564AbVLPXmE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 18:42:04 -0500
Received: from smtp104.plus.mail.mud.yahoo.com ([68.142.206.237]:61812 "HELO
	smtp104.plus.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932550AbVLPXmB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 18:42:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=XpA7xnFX6GEaAMyJoQu1lxhCyg830OpD6UF5WbmdbbjMoj19WJAxuoaCi0G8zrMN2xaa2tXCDnXDtq61yWpoWIFduFpq7BJLtZSiEzkSmmSvr/rz/Zy+1eBEAZaT7atbflbiQTBxVBJu0OG00k33X5QixjM/ioORB/FOT1X9q7s=  ;
Message-ID: <43A350C0.8030805@yahoo.com.au>
Date: Sat, 17 Dec 2005 10:41:52 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: David Howells <dhowells@redhat.com>
CC: torvalds@osdl.org, akpm@osdl.org, hch@infradead.org, arjan@infradead.org,
       matthew@wil.cx, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
References: <43A2BE49.4000102@yahoo.com.au>  <43A08D50.30707@yahoo.com.au> <439FFF63.6020105@yahoo.com.au> <439F6EAB.6030903@yahoo.com.au> <439E122E.3080902@yahoo.com.au> <dhowells1134431145@warthog.cambridge.redhat.com> <22479.1134467689@warthog.cambridge.redhat.com> <13613.1134557656@warthog.cambridge.redhat.com> <15157.1134560767@warthog.cambridge.redhat.com> <12832.1134734438@warthog.cambridge.redhat.com> <20220.1134748431@warthog.cambridge.redhat.com>
In-Reply-To: <20220.1134748431@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells wrote:

>>It is not even clear that any ll/sc based architectures would need to override
>>an atomic_cmpxchg variant at all because you can assume an unlocked fastpath
> 
> 
> That's irrelevant. Any arch that has LL/SC almost certainly emulates CMPXCHG
> with LL/SC.
> 

It is not irrelevant because many architectures that would care are ll/sc
based and many others have a native cmpxchg ie. cmpxchg wouldn't be a bad
choice for default.

> 
>>and not do the additional initial load to prime the cmpxchg.
> 
> 
> Two points:
> 
>  (1) LL/SC does not require an additional initial load.
> 

?? I was only talking about cmpxchg

>  (2) CMPXCHG does an implicit load; how else can it compare?
> 

Read Russell's posts. He points out that most usages of cmpxchg
will require an additional load compared with an llsc in order to
find the value to work on.

cmpxchg(lock, UNLOCKED, LOCKED)

does not (although it may still require an extra branch).

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
