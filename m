Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261825AbVBTMfh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261825AbVBTMfh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Feb 2005 07:35:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261826AbVBTMfh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Feb 2005 07:35:37 -0500
Received: from smtp207.mail.sc5.yahoo.com ([216.136.129.97]:65379 "HELO
	smtp207.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261825AbVBTMf1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Feb 2005 07:35:27 -0500
Message-ID: <4218840D.6030203@yahoo.com.au>
Date: Sun, 20 Feb 2005 23:35:25 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: "David S. Miller" <davem@davemloft.net>, benh@kernel.crashing.org,
       torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] page table iterators
References: <4214A1EC.4070102@yahoo.com.au> <4214A437.8050900@yahoo.com.au> <20050217194336.GA8314@wotan.suse.de> <1108680578.5665.14.camel@gaston> <20050217230342.GA3115@wotan.suse.de> <20050217153031.011f873f.davem@davemloft.net> <20050217235719.GB31591@wotan.suse.de>
In-Reply-To: <20050217235719.GB31591@wotan.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Thu, Feb 17, 2005 at 03:30:31PM -0800, David S. Miller wrote:
> 
>>On Fri, 18 Feb 2005 00:03:42 +0100
>>Andi Kleen <ak@suse.de> wrote:
>>
>>
>>>And to be honest we only have about 6 or 7 of these walkers
>>>in the whole kernel. And 90% of them are in memory.c
>>>While doing 4level I think I changed all of them around several
>>>times and it wasn't that big an issue.  So it's not that we
>>>have a big pressing problem here... 
>>
>>It's super error prone.  A regression added by your edit of these
> 
> 
> Actually it was in Nick's code (PUD layer ;-).  But I won't argue
> that my code didn't have bugs too...
> 
> 

I won't look back to see where the error came from :) But
yeah it is equally (if not more) likely to have come from
me. And it probably did happen because all the code is
slightly different and hard to understand.

>>walkers for the 4level changes was only discovered and fixed
>>yesterday by the ppc folks.
>>
>>I absolutely support any change which consolidates these things.
> 
> 
> The problem is just that these walker macros when they
> do all the lazy walking stuff will be quite complicated.
> And I don't really want another uaccess.h-like macro mess.
> 
> Yes currently they look simple, but that will change.
> 

But even in that case, it will still be better to have the
extra complexity once in the macro rather than throughout mm/

> Open coding is probably the smaller evil.
> 
> And they're really not changed that often.
> 

It is not so much a matter of changing, so much as having 10
slightly different implementations.

I think it should be easier to go from the iterators patch to
perhaps more complex iterators, or some open coding, etc etc.
rather than try to put a big complex pt walker on top of these
10 different open coded implementations.

But perhaps I'm missing something you're not - I'd need to see
the lazy walking code I guess.

Nick

