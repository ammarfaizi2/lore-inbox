Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751197AbWDEVcj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197AbWDEVcj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 17:32:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751202AbWDEVcj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 17:32:39 -0400
Received: from smtp110.mail.mud.yahoo.com ([209.191.85.220]:42834 "HELO
	smtp110.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751197AbWDEVci (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 17:32:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=CKslInaUyAyFWJIL+RrOb8dmtPbgdVBMKr7/cPGVjeI7QisqvZ0QGhaDhcYe8xaGA7pY+Yo35RFHUYEN93YrMj6/5pwNscpzAQ338CoFo76UfV1zssg590vvTBQ9Resa6otyEXuDg+leQC6GlBMVnDhasDREhconrYiaSVMO3A4=  ;
Message-ID: <44338CAE.6060206@yahoo.com.au>
Date: Wed, 05 Apr 2006 19:23:58 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: David Howells <dhowells@redhat.com>
CC: torvalds@osdl.org, akpm@osdl.org, keyrings@linux-nfs.org,
       linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] Keys: Improve usage of memory barriers and remove IRQ
 disablement
References: <4432515F.4030108@yahoo.com.au>  <20060404095529.31311.3892.stgit@warthog.cambridge.redhat.com> <29064.1144226770@warthog.cambridge.redhat.com>
In-Reply-To: <29064.1144226770@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells wrote:
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> | 	int atomic_inc_and_test(atomic_t *v);
> | 	int atomic_dec_and_test(atomic_t *v);
> | 
> | These two routines increment and decrement by 1, respectively, the
> | given atomic counter.  They return a boolean indicating whether the
> | resulting counter value was zero or not.
> | 
> | It requires explicit memory barrier semantics around the operation as
> | above.
> 
> Note the last paragraph.  "It requires" should be "They require", but the
> sense would seem to be obvious.  However, it's not clear on a second reading
> as to whether this is an instruction to the _caller_ or an instruction to the
> arch _implementer_.
> 

Yes, I remember Dave M clarified this sometime ago (on lkml I guess). It
is a little confusing, but I think the wording is for the implementer's
point of view. Dave will pull me up if I'm wrong...

> I suppose from reading the abstract at the top:
> 
> | This document is intended to serve as a guide to Linux port maintainers on
> | how to implement atomic counter, bitops, and spinlock interfaces properly.
> 
> that it is meant to be read by the implementor and not the user/caller, in which
> case, Nick is correct.
> 
> It seems I need to adjust my memory barrier doc, and perhaps I should adjust
> atomic_ops.txt too to make it clearer.
> 

I think that would be good. atomic_ops.txt is very useful for API users
as well, so if it can be made more general without becoming ambiguous,
I'm sure that would be appreciated.

Thanks,
Nick

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
