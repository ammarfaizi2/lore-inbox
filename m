Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262296AbVFLMPK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262296AbVFLMPK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 08:15:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262324AbVFLMPJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 08:15:09 -0400
Received: from smtp208.mail.sc5.yahoo.com ([216.136.130.116]:9808 "HELO
	smtp208.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262296AbVFLMPD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 08:15:03 -0400
Message-ID: <42AC273B.60808@yahoo.com.au>
Date: Sun, 12 Jun 2005 22:14:51 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Willy Tarreau <willy@w.ods.org>
CC: Mikael Pettersson <mikpe@csd.uu.se>, marcelo.tosatti@cyclades.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.4.31 7/9] gcc4: fix const function warnings
References: <200506121121.j5CBLGd4019750@harpo.it.uu.se> <20050612115019.GJ28759@alpha.home.local>
In-Reply-To: <20050612115019.GJ28759@alpha.home.local>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau wrote:
> Hi Mikael,
> 
> But I don't see how it can be useful in asm code like below, since the
> compiler cannot evaluate it at compile time :
> 
> 
>>-static __inline__ __const__ __u32 ___arch__swab32(__u32 x)
>>+static __inline__ __attribute_const__ __u32 ___arch__swab32(__u32 x)
>> {
>> #ifdef CONFIG_X86_BSWAP
>> 	__asm__("bswap %0" : "=r" (x) : "0" (x));
> 
> 
> Am I missing something, or could we simply remove the __const__ every
> time the function only uses asm ?
> 

const functions are those that don't have side effects and depend
only on their argument list. So such functions can be CSE'ed or
reordered.

If it makes sense to use on any inline function, then I think it
makes sense if they're only using asm. Actually I would have thought
it would *only* help inline functions using asm, because gcc may
not know that such asm is 'const'.

But that's not to say they should be removed just because they
can't help gcc - it may be instructive to the programmer, or more
robust when making modifications to the code (eg. uninlining).

Send instant messages to your online friends http://au.messenger.yahoo.com 
