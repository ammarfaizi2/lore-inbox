Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932072AbVLPByf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932072AbVLPByf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 20:54:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932073AbVLPByf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 20:54:35 -0500
Received: from smtp107.plus.mail.mud.yahoo.com ([68.142.206.240]:54657 "HELO
	smtp107.plus.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932072AbVLPBye (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 20:54:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=ce6q4IDyOpA2ENzQDK0SEXWanJywcoxre3G2dlFPBul5dgjHaAd2nzT3dTkIL6x+bnP5Fx/Nqi4it95YlDTyw9/2cwLqQcMtgIiImAvEebLhDl+LHZsDFNsx5s3r6vFwS7MLveqpiOI/QprtFcfDtFpXnKObveoz2IpMt0QSmRk=  ;
Message-ID: <43A21E55.3060907@yahoo.com.au>
Date: Fri, 16 Dec 2005 12:54:29 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: David Howells <dhowells@redhat.com>
CC: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, cfriesen@nortel.com,
       torvalds@osdl.org, hch@infradead.org, matthew@wil.cx,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
References: <1134560671.2894.30.camel@laptopd505.fenrus.org>  <439EDC3D.5040808@nortel.com> <1134479118.11732.14.camel@localhost.localdomain> <dhowells1134431145@warthog.cambridge.redhat.com> <3874.1134480759@warthog.cambridge.redhat.com> <15167.1134488373@warthog.cambridge.redhat.com> <1134490205.11732.97.camel@localhost.localdomain> <1134556187.2894.7.camel@laptopd505.fenrus.org> <1134558188.25663.5.camel@localhost.localdomain> <1134558507.2894.22.camel@laptopd505.fenrus.org> <1134559470.25663.22.camel@localhost.localdomain> <20051214033536.05183668.akpm@osdl.org> <15412.1134561432@warthog.cambridge.redhat.com>
In-Reply-To: <15412.1134561432@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells wrote:
> Arjan van de Ven <arjan@infradead.org> wrote:
> 
> 
>>> given that
>>>mutex_down() is slightly more costly than current down(), and mutex_up() is
>>>appreciably more costly than current up()?
>>
>>that's an implementation flaw in the current implementation that is not
>>needed by any means and that Ingo has fixed in his version of this
> 
> 
> As do I. I wrote it yesterday with Ingo looking over my shoulder, as it were,
> but I haven't released it yet.
> 
> What I provided was a base implementation that anything can use provided it
> has an atomic op capable of exchanging between two states, and I suspect
> everything that can do multiprocessing has - if you can do spinlocks, then you
> can do this. I ALSO provided a mechanism by which it could be overridden if
> there's something better available on that arch.
> 
> As I see it there are four classes of arch:
> 
>  (0) Those that have no atomic ops at all - in which case xchg is trivially
>      implemented by disabling interrupts, and spinlocks must be null because
>      they can't be implemented.
> 
>  (1) Those that only have a limited exchange functionality. Several archs do
>      fall into this category: arm, frv, mn10300, 68000, i386.
> 
>  (2) Those that have CMPXCHG or equivalent: 68020, i486+, x86_64, ia64, sparc.
> 
>  (3) Those that have LL/SC or equivalent: mips (some), alpha, powerpc, arm6.
> 

cmpxchg is basically exactly equivalent to a store-conditional, so 2 and 3
are the same level.

I don't know why you don't implement a "good" default implementation with
atomic_cmpxchg.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
