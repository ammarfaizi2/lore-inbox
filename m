Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261581AbSLSNO4>; Thu, 19 Dec 2002 08:14:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262789AbSLSNO4>; Thu, 19 Dec 2002 08:14:56 -0500
Received: from etpmod.phys.tue.nl ([131.155.111.35]:5965 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S261581AbSLSNOz>; Thu, 19 Dec 2002 08:14:55 -0500
Date: Thu, 19 Dec 2002 14:22:36 +0100 (CET)
From: bart@etpmod.phys.tue.nl
Reply-To: bart@etpmod.phys.tue.nl
Subject: Re: Intel P6 vs P7 system call performance
To: torvalds@transmeta.com
Cc: lk@tantalophile.demon.co.uk, hpa@transmeta.com, terje.eggestad@scali.com,
       drepper@redhat.com, matti.aarnio@zmailer.org, hugh@veritas.com,
       davej@codemonkey.org.uk, mingo@elte.hu, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
Message-Id: <20021219132239.4650B51F88@gum12.etpnet.phys.tue.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 Dec, Linus Torvalds wrote:
> 
> On Wed, 18 Dec 2002, Jamie Lokier wrote:
>> 
>> That said, you always need the page at 0xfffe0000 mapped anyway, so
>> that sysexit can jump to a fixed address (which is fastest).
> 
> Yes. This is important. There _needs_ to be some fixed address at least as 
> far as the kernel is concerned (it might move around between reboots or 
> something like that, but it needs to be something the kernel knows about 
> intimately and doesn't need lots of dynamic lookup).
> 
> However, there's another issue, namely process startup cost. I personally 
> want it to be as light as at all possible. I hate doing an "strace" on 
> user processes and seeing tons and tons of crapola showing up. Just for 

So why not map the magic page at 0xffffe000 at some other address as
well? 

Static binaries can just directly jump/call into the magic page.

Shared binaries do somekind of mmap("/proc/self/mem") magic to put a
copy of the page at an address that is convenient for them. Shared
binaries have to do a lot of mmap-ing anyway, so the overhead should be
negligible.




-- 
Bart Hartgers - TUE Eindhoven 
http://plasimo.phys.tue.nl/bart/contact.html
