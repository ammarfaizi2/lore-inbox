Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751257AbWCaHyc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257AbWCaHyc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 02:54:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbWCaHyb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 02:54:31 -0500
Received: from smtp104.mail.mud.yahoo.com ([209.191.85.214]:41399 "HELO
	smtp104.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751256AbWCaHyb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 02:54:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=36hsQa/KBXFFmOn9G/fetuREcOOOTPQ+M9ZRqtl3DYTqYuHBVvCVqdSKolfAi2YzqtGIRZ25rmG9Gx8oHyNykFEoDyXBZxKf1XAoRUBCYy7JxIxgoIYDd3xvRPCapUZaaxFc91VpxYkdunNlmehEYpBTyrd/RWZWmouXPiPH+r8=  ;
Message-ID: <442CAC11.4070803@yahoo.com.au>
Date: Fri, 31 Mar 2006 14:12:01 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Lameter <clameter@sgi.com>
CC: Zoltan Menyhart <Zoltan.Menyhart@bull.net>,
       "Boehm, Hans" <hans.boehm@hp.com>,
       "Grundler, Grant G" <grant.grundler@hp.com>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: Synchronizing Bit operations V2
References: <Pine.LNX.4.64.0603301300430.1014@schroedinger.engr.sgi.com> <Pine.LNX.4.64.0603301615540.2023@schroedinger.engr.sgi.com> <442C7B51.1060203@yahoo.com.au> <Pine.LNX.4.64.0603301921550.3145@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0603301921550.3145@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> On Fri, 31 Mar 2006, Nick Piggin wrote:
> 
> 
>>This has acquire and release, instead of the generic kernel
>>memory barriers rmb and wmb. As such, I don't think it would
>>get merged.
> 
> 
> Right. From the earlier conversation I had the impression that this is 
> what you wanted.
>  

Perhaps it is the best way to go, but you need to fix ia64's
current problems first. Again -- you don't plan to audit and
convert _all_ current users in one go do you?

> 
>>>Note that the current semantics for bitops IA64 are broken. Both
>>>smp_mb__after/before_clear_bit are now set to full memory barriers
>>>to compensate which may affect performance.
>>
>>I think you should fight the fights you can win and get a 90%
>>solution ;) at any rate you do need to fix the existing routines
>>unless you plan to audit all callers...
>>
>>First, fix up ia64 in 2.6-head, this means fixing test_and_set_bit
>>and friends, smp_mb__*_clear_bit, and all the atomic operations that
>>both modify and return a value.
>>
>>Then add test_and_set_bit_lock / clear_bit_unlock, and apply them
>>to a couple of critical places like page lock and buffer lock.
>>
>>Is this being planned?
> 
> 
> That sounds like a long and tedious route to draw out the pain for a 
> couple of years and add loads of additional macro definitions all over the 
> header files. I'd really like a solution that allows a gradual 
> simplification of the macros and that has clear semantics.
> 

Why? Yours is the long drawn out plan.

You acknowledge that you have to fix ia64 to match current semantics
first, right?

Now people seem to be worried about the performance impact that will
have, so I simply suggest that adding two or three new macros for the
important cases to give you a 90% solution.

You would then be free to discuss and design a 95% solution ;)

> So far it seems that I have not even been able to find the definitions for 
> the proper behavior of memory barriers.

I think Documentation/atomic_ops.txt isn't bad. smp_mb__* really
is a smp_mb, which can be optimised sometimes.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
