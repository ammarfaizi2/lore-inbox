Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266042AbSLSTWK>; Thu, 19 Dec 2002 14:22:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266043AbSLSTWK>; Thu, 19 Dec 2002 14:22:10 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:55051 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266042AbSLSTWJ>; Thu, 19 Dec 2002 14:22:09 -0500
Message-ID: <3E021E2E.2090503@transmeta.com>
Date: Thu, 19 Dec 2002 11:29:50 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021119
X-Accept-Language: en, sv
MIME-Version: 1.0
To: bart@etpmod.phys.tue.nl
CC: torvalds@transmeta.com, lk@tantalophile.demon.co.uk,
       terje.eggestad@scali.com, drepper@redhat.com, matti.aarnio@zmailer.org,
       hugh@veritas.com, davej@codemonkey.org.uk, mingo@elte.hu,
       linux-kernel@vger.kernel.org
Subject: Re: Intel P6 vs P7 system call performance
References: <20021219132239.4650B51F88@gum12.etpnet.phys.tue.nl>
In-Reply-To: <20021219132239.4650B51F88@gum12.etpnet.phys.tue.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bart@etpmod.phys.tue.nl wrote:
> On 18 Dec, Linus Torvalds wrote:
> 
>>On Wed, 18 Dec 2002, Jamie Lokier wrote:
>>
>>>That said, you always need the page at 0xfffe0000 mapped anyway, so
>>>that sysexit can jump to a fixed address (which is fastest).
>>
>>Yes. This is important. There _needs_ to be some fixed address at least as 
>>far as the kernel is concerned (it might move around between reboots or 
>>something like that, but it needs to be something the kernel knows about 
>>intimately and doesn't need lots of dynamic lookup).
>>
>>However, there's another issue, namely process startup cost. I personally 
>>want it to be as light as at all possible. I hate doing an "strace" on 
>>user processes and seeing tons and tons of crapola showing up. Just for 
> 
> So why not map the magic page at 0xffffe000 at some other address as
> well? 
> 
> Static binaries can just directly jump/call into the magic page.
> 
> Shared binaries do somekind of mmap("/proc/self/mem") magic to put a
> copy of the page at an address that is convenient for them. Shared
> binaries have to do a lot of mmap-ing anyway, so the overhead should be
> negligible.
> 

That would require /proc to be mounted for all shared binaries to work.
 That is tantamount to killing chroot().

Perhaps it could be done with mremap(), but I would assume that would
entail a special case in the mremap() code.

A special system call would be a bit gross, but it's better than a total
hack.

	-hpa


