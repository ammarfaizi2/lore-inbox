Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281463AbRKHFF5>; Thu, 8 Nov 2001 00:05:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281469AbRKHFFr>; Thu, 8 Nov 2001 00:05:47 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:25351 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S281470AbRKHFFg>; Thu, 8 Nov 2001 00:05:36 -0500
Message-ID: <3BEA116A.646B9159@zip.com.au>
Date: Wed, 07 Nov 2001 21:00:26 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Fedyk <mfedyk@matchmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Memory accounting problem in 2.4.13, 2.4.14pre, and possibly 2.4.14
In-Reply-To: <20011106140335.A13678@mikef-linux.matchmail.com> <3BE9E9A7.6F90C4DB@zip.com.au>,
		<3BE9E9A7.6F90C4DB@zip.com.au> <20011107182442.B467@mikef-linux.matchmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk wrote:
> 
> >
> 
> I am running unpatched 2.4.14 now.
> 
> Do you still want me to try this patch now that you know I have been able to
> see the problem with 2.2.14+ext3?
> 

It's OK - I can reproduce it easily anyway.

There are two things here.  Recent -ac kernels had a merge
bug down in the /proc code which caused `Cached:' to go
negative.  It was recently fixed.

And quite independently, current ext3 for Linus kernels now has a
bug which causes the `buffermem_pages' number to get too large.
This has the exact same effect: `Cached:' goes negative. 

The buffermem_pages counter is purely for reporting - no VM decisions
are based on its value.  But if it worries you, just remove line 1933 of fs/jbd/transaction.c.
