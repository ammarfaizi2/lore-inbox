Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750985AbWCICit@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750985AbWCICit (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 21:38:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751102AbWCICit
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 21:38:49 -0500
Received: from smtp105.mail.mud.yahoo.com ([209.191.85.215]:34966 "HELO
	smtp105.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750985AbWCICis (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 21:38:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=vSSRO91mkpiviZWWG3cazBVumk2T0KAhxt0UiuaJBv0syVFhoZpczUnoTRSie4TT9i0OBoEH/IYasGFuR86rYW4sYbT5aWd8eo9RvSe+pYGivgtsVsCdC2+kYN06g/JZ1XJF7XhEQUq8u7OZYFwWRUstynQmAs9R02UJCIpiZPQ=  ;
Message-ID: <440F952E.90808@yahoo.com.au>
Date: Thu, 09 Mar 2006 13:38:38 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050927 Debian/1.7.8-1sarge3
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Paul Mackerras <paulus@samba.org>, akpm@osdl.org,
       linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
       mingo@redhat.com, Alan Cox <alan@redhat.com>, linuxppc64-dev@ozlabs.org
Subject: Re: [PATCH] Document Linux's memory barriers [try #2]
References: <Pine.LNX.4.64.0603081115300.32577@g5.osdl.org> <20060308184500.GA17716@devserv.devel.redhat.com> <20060308173605.GB13063@devserv.devel.redhat.com> <20060308145506.GA5095@devserv.devel.redhat.com> <31492.1141753245@warthog.cambridge.redhat.com> <29826.1141828678@warthog.cambridge.redhat.com> <9834.1141837491@warthog.cambridge.redhat.com> <11922.1141842907@warthog.cambridge.redhat.com> <14275.1141844922@warthog.cambridge.redhat.com> <19984.1141846302@warthog.cambridge.redhat.com> <17423.30789.214209.462657@cargo.ozlabs.ibm.com> <Pine.LNX.4.64.0603081652430.32577@g5.osdl.org> <17423.32792.500628.226831@cargo.ozlabs.ibm.com> <Pine.LNX.4.64.0603081716400.32577@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603081716400.32577@g5.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>
>On Thu, 9 Mar 2006, Paul Mackerras wrote:
>
>>... and x86 mmiowb is a no-op.  It's not x86 that I think is buggy.
>>
>
>x86 mmiowb would have to be a real op too if there were any multi-pathed 
>PCI buses out there for x86, methinks.
>
>Basically, the issue boils down to one thing: no "normal" barrier will 
>_ever_ show up on the bus on x86 (ie ia64, afaik). That, together with any 
>situation where there are multiple paths to one physical device means that 
>mmiowb() _has_ to be a special op, and no spinlocks etc will _ever_ do the 
>serialization you look for.
>
>Put another way: the only way to avoid mmiowb() being special is either 
>one of:
> (a) have the bus fabric itself be synchronizing
> (b) pay a huge expense on the much more critical _regular_ barriers
>
>Now, I claim that (b) is just broken. I'd rather take the hit when I need 
>to, than every time. 
>

I'm not very driver-minded; would it make sense to have io versions of
locks, which can provide critical sections for IO operations?

The number of (uncommented) memory barriers sprinkled around drivers
looks pretty scary...

--

Send instant messages to your online friends http://au.messenger.yahoo.com 
